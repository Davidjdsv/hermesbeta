<?php
// Se incluye el archivo que contiene la clase de conexión a la base de datos.
require_once "Conexion.php";

class AuditoriaModelo {

    // Método estático para obtener el historial de auditoría de usuarios
    public static function mdlMostrarAuditoria() {
        try {
            // Se obtiene una instancia de la conexión a la base de datos
            $conexion = Conexion::conectar();

            // Consulta SQL para obtener los registros de auditoría con datos del usuario afectado y del editor
            $query = "
                SELECT 
                    a.id_usuario_afectado,                  -- ID del usuario al que se le hizo una modificación
                    u.tipo_documento,                       -- Tipo de documento del usuario afectado
                    u.numero_documento,                     -- Número de documento del usuario afectado
                    u.nombre,                               -- Nombre del usuario afectado
                    u.apellido,                             -- Apellido del usuario afectado
                    u.correo_electronico,                   -- Correo electrónico del usuario afectado
                    u.nombre_usuario,                       -- Nombre de usuario del usuario afectado
                    u.telefono,                             -- Teléfono del usuario afectado
                    u.direccion,                            -- Dirección del usuario afectado
                    u.genero,                               -- Género del usuario afectado
                    u.foto,                                 -- Foto del usuario afectado
                    u.estado,                               -- Estado (activo/inactivo) del usuario afectado
                    u.condicion,                            -- Condición del usuario afectado
                    u.fecha_registro,                       -- Fecha en que el usuario fue registrado
                    a.id_usuario_editor,                    -- ID del usuario que realizó la modificación
                    editor.nombre_usuario AS nombre_editor,-- Nombre de usuario del editor
                    a.campo_modificado,                     -- Campo que fue modificado
                    a.valor_anterior,                       -- Valor anterior antes de la modificación
                    a.valor_nuevo,                          -- Valor nuevo después de la modificación
                    a.fecha_cambio                          -- Fecha y hora en que se realizó la modificación
                FROM auditoria_usuarios a
                LEFT JOIN usuarios u ON a.id_usuario_afectado = u.id_usuario      -- Une con los datos del usuario afectado
                LEFT JOIN usuarios editor ON a.id_usuario_editor = editor.id_usuario -- Une con los datos del usuario que editó
                ORDER BY a.fecha_cambio DESC                                     -- Ordena los registros del más reciente al más antiguo
            ";

            // Se prepara y ejecuta la consulta
            $stmt = $conexion->prepare($query);
            $stmt->execute();

            // Se obtienen todos los resultados como un arreglo asociativo
            $resultados = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Se retorna el arreglo de resultados
            return $resultados;

        } catch (PDOException $e) {
            // En caso de error, se registra el mensaje en el log y se retorna false
            error_log("Error en mdlMostrarAuditoria: " . $e->getMessage());
            return false;
        }
    }
}
?>
