<?php
require_once "../modelos/conexion.php";
header('Content-Type: application/json');

try {
    $conexion = Conexion::conectar();

    $query = "
        SELECT 
            a.id_usuario_afectado,
            u.tipo_documento,
            u.numero_documento,
            u.nombre,
            u.apellido,
            u.correo_electronico,
            u.nombre_usuario,
            u.telefono,
            u.direccion,
            u.genero,
            u.foto,
            u.estado,
            u.condicion,
            u.fecha_registro,
            a.id_usuario_editor,
            editor.nombre_usuario AS editor_nombre,
            a.campo_modificado,
            a.valor_anterior,
            a.valor_nuevo,
            a.fecha_cambio
        FROM auditoria_usuarios a
        LEFT JOIN usuarios u ON a.id_usuario_afectado = u.id_usuario
        LEFT JOIN usuarios editor ON a.id_usuario_editor = editor.id_usuario
        ORDER BY a.fecha_cambio DESC";

    $stmt = $conexion->prepare($query);
    $stmt->execute();

    $data = [];

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {

        // Traducción del género actual para la tabla
        switch ($row['genero']) {
            case 1: $generoTexto = 'Femenino'; break;
            case 2: $generoTexto = 'Masculino'; break;
            case 3: $generoTexto = 'No declara'; break;
            default: $generoTexto = 'Desconocido';
        }

        $campoModificado = $row['campo_modificado'];
        $valorAnterior = $row['valor_anterior'];
        $valorNuevo = $row['valor_nuevo'];

        // Detectar múltiples campos modificados
        $campos = explode(";", $campoModificado);
        $valoresAnteriores = explode(";", $valorAnterior);
        $valoresNuevos = explode(";", $valorNuevo);

        // Limpiar espacios
        $campos = array_map('trim', $campos);
        $valoresAnteriores = array_map('trim', $valoresAnteriores);
        $valoresNuevos = array_map('trim', $valoresNuevos);

        // Recorremos los campos para traducir valores si es necesario
        foreach ($campos as $index => $campo) {
            if (strtolower($campo) === 'genero') {
                // Traducir valor anterior
                switch ($valoresAnteriores[$index]) {
                    case '1': $valoresAnteriores[$index] = 'Femenino'; break;
                    case '2': $valoresAnteriores[$index] = 'Masculino'; break;
                    case '3': $valoresAnteriores[$index] = 'No declara'; break;
                    default: $valoresAnteriores[$index] = 'Desconocido';
                }

                // Traducir valor nuevo
                switch ($valoresNuevos[$index]) {
                    case '1': $valoresNuevos[$index] = 'Femenino'; break;
                    case '2': $valoresNuevos[$index] = 'Masculino'; break;
                    case '3': $valoresNuevos[$index] = 'No declara'; break;
                    default: $valoresNuevos[$index] = 'Desconocido';
                }
            }
        }

        // Convertimos los arrays en strings nuevamente
        $valorAnteriorFormateado = implode("; ", $valoresAnteriores);
        $valorNuevoFormateado = implode("; ", $valoresNuevos);
        $valor_formateado = $valorAnteriorFormateado . " → " . $valorNuevoFormateado;

        $data[] = [
            "id_usuario" => $row['id_usuario_afectado'],
            "tipo_documento" => $row['tipo_documento'],
            "numero_documento" => $row['numero_documento'],
            "nombre" => $row['nombre'],
            "apellido" => $row['apellido'],
            "correo_electronico" => $row['correo_electronico'],
            "nombre_usuario" => $row['nombre_usuario'],
            "telefono" => $row['telefono'],
            "direccion" => $row['direccion'],
            "genero" => $generoTexto,
            "foto" => $row['foto'],
            "estado" => $row['estado'],
            "condicion" => $row['condicion'],
            "fecha_registro" => $row['fecha_registro'],
            "id_usuario_editor" => $row['id_usuario_editor'],
            "nombre_editor" => !empty($row['id_usuario_editor']) ? $row['editor_nombre'] : 'Sistema',
            "campo_modificado" => $campoModificado,
            "valor_anterior" => $valorAnteriorFormateado,
            "valor_nuevo" => $valorNuevoFormateado,
            "valor_formateado" => $valor_formateado,
            "fecha_cambio" => $row['fecha_cambio']
        ];
    }

    echo json_encode(["data" => $data]);

} catch (PDOException $e) {
    echo json_encode([
        "data" => [],
        "error" => $e->getMessage()
    ]);
}