<?php

require_once "conexion.php";

class ModeloDevoluciones
{
    static public function mdlMostrarDevoluciones($tabla, $item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare(
                "SELECT p.*, u.numero_documento, u.nombre AS nombre_usuario, u.apellido AS apellido_usuario, u.telefono, 
                        r.nombre_rol,
                        f.codigo as ficha_codigo, 
                        e.equipo_id, e.numero_serie, e.descripcion AS marca_equipo, e.etiqueta AS placa_equipo,
                        c.nombre AS categoria_nombre, 
                        e.id_estado AS estado_del_equipo,
                        dp.estado AS estado_detalle_prestamo
                 FROM $tabla p
                 JOIN usuarios u ON p.usuario_id = u.id_usuario
                 LEFT JOIN usuario_rol ur ON u.id_usuario = ur.id_usuario
                 LEFT JOIN roles r ON ur.id_rol = r.id_rol
                 LEFT JOIN aprendices_ficha af ON u.id_usuario = af.id_usuario
                 LEFT JOIN fichas f ON af.id_ficha = f.id_ficha
                 LEFT JOIN detalle_prestamo dp ON p.id_prestamo = dp.id_prestamo
                 LEFT JOIN equipos e ON dp.equipo_id = e.equipo_id
                 LEFT JOIN categorias c ON e.categoria_id = c.categoria_id
                 WHERE p.$item = :$item
                 AND p.estado_prestamo IN ('Prestado')
                 AND e.id_estado = 2" // Condición agregada aquí para filtrar equipos en estado 'Prestado'
            );

            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll();
        } else {
            // Consulta para todos los registros con JOIN
            $stmt = Conexion::conectar()->prepare(
                "SELECT p.id_prestamo, u.numero_documento, u.nombre AS nombre_usuario, u.apellido AS apellido_usuario, u.telefono,
                        r.nombre_rol, -- Añadido para obtener el nombre del rol
                        f.codigo as ficha_codigo,
                        p.fecha_inicio, p.fecha_fin, p.tipo_prestamo,
                        CASE
                            WHEN p.tipo_prestamo = 'Inmediato' THEN 'Inmediato'
                            ELSE 'Reservado'
                        END as estado_prestamo_display, -- Renombrado para evitar conflicto con p.estado_prestamo
                        p.estado_prestamo -- Se mantiene el estado_prestamo original para lógica interna si es necesario
                 FROM $tabla p
                 JOIN usuarios u ON p.usuario_id = u.id_usuario
                 LEFT JOIN usuario_rol ur ON u.id_usuario = ur.id_usuario -- JOIN para obtener el id_rol del usuario
                 LEFT JOIN roles r ON ur.id_rol = r.id_rol -- JOIN para obtener el nombre del rol
                 LEFT JOIN aprendices_ficha af ON u.id_usuario = af.id_usuario
                 LEFT JOIN fichas f ON af.id_ficha = f.id_ficha
                 WHERE p.estado_prestamo IN ('Prestado')
                 ORDER BY p.fecha_inicio DESC"
            );

            $stmt->execute();
            return $stmt->fetchAll();
        }

        // $stmt->close(); // PDOStatement::closeCursor() is called automatically when the statement is no longer referenced.
        $stmt = null;
    }


    /*=============================================
    MARCAR EQUIPO EN DETALLE_PRESTAMO COMO MANTENIMIENTO (ACTUALIZANDO ID_ESTADO)
    =============================================*/
    static public function mdlMarcarMantenimientoDetalle($datos){

        // ... existing code ...
        $stmt = Conexion::conectar()->prepare("UPDATE equipos SET id_estado = :id_estado WHERE equipo_id = :equipo_id");

        $stmt->bindParam(":id_estado", $datos["id_estado"], PDO::PARAM_INT);
        $stmt->bindParam(":equipo_id", $datos["equipo_id"], PDO::PARAM_INT);

        if($stmt->execute()){ 
            error_log("MODELO: Update ejecutado con éxito. Filas afectadas: " . $stmt->rowCount()); 
            // Verificar si realmente se afectaron filas 
            if ($stmt->rowCount() > 0) { 
                return "ok"; 
            } else { 
                error_log("MODELO: Update ejecutado pero no afectó filas. ¿Coincide equipo_id?"); 
                return "no_change"; // O algún otro indicador 
            } 
        }else{ 
            error_log("MODELO: Error en execute(): " . json_encode($stmt->errorInfo())); 
        }
        $stmt = null;

    }

    /*=============================================
    VERIFICAR SI TODOS LOS EQUIPOS DE UN PRÉSTAMO HAN SIDO DEVUELTOS (MARCADOS PARA MANTENIMIENTO)
    =============================================*/
    static public function mdlVerificarTodosEquiposDevueltos($idPrestamo){
    $stmt = Conexion::conectar()->prepare(
        "SELECT COUNT(dp.equipo_id) as total_equipos_prestamo,
                SUM(CASE WHEN e.id_estado IN (4, 7) THEN 1 ELSE 0 END) as equipos_procesados
         FROM detalle_prestamo dp
         JOIN equipos e ON dp.equipo_id = e.equipo_id
         WHERE dp.id_prestamo = :id_prestamo"
    );

    $stmt->bindParam(":id_prestamo", $idPrestamo, PDO::PARAM_INT);
    $stmt->execute();
    $resultado = $stmt->fetch(PDO::FETCH_ASSOC);

    if($resultado && $resultado["total_equipos_prestamo"] > 0 && 
       $resultado["total_equipos_prestamo"] == $resultado["equipos_procesados"]){
        return true; // Todos los equipos han sido procesados (mantenimiento o robado)
    } else {
        return false; // No todos los equipos han sido procesados
    }

    $stmt = null;
}

    /*=============================================
    ACTUALIZAR ESTADO DEL PRÉSTAMO A DEVUELTO Y REGISTRAR FECHA REAL DE DEVOLUCIÓN
    =============================================*/
    static public function mdlActualizarPrestamoDevuelto($idPrestamo){

        $stmt = Conexion::conectar()->prepare(
            "UPDATE prestamos 
             SET estado_prestamo = 'Devuelto', fecha_devolucion_real = NOW() 
             WHERE id_prestamo = :id_prestamo"
        );

        $stmt->bindParam(":id_prestamo", $idPrestamo, PDO::PARAM_INT);

        if($stmt->execute()){
            return "ok";
        } else {
            return "error";
        }

        $stmt = null;
    }

    /*============================================= 
MARCAR EQUIPO EN DETALLE_PRESTAMO COMO DEVUELTO EN BUEN ESTADO (ACTUALIZANDO ID_ESTADO)
=============================================*/
    static public function mdlMarcarDevueltoBuenEstado($datos){
        // Primero actualizar el estado del equipo en la tabla equipos
        $stmtEquipo = Conexion::conectar()->prepare(
            "UPDATE equipos SET id_estado = :id_estado 
            WHERE equipo_id = :equipo_id"
        );
        
        $stmtEquipo->bindParam(":id_estado", $datos["id_estado"], PDO::PARAM_INT);
        $stmtEquipo->bindParam(":equipo_id", $datos["equipo_id"], PDO::PARAM_INT);
        
        if($stmtEquipo->execute()){
            // Luego actualizar el estado en detalle_prestamo
            $stmtDetalle = Conexion::conectar()->prepare(
                "UPDATE detalle_prestamo SET estado = 'Devuelto', 
                fecha_actualizacion = NOW()
                WHERE id_prestamo = :id_prestamo AND equipo_id = :equipo_id"
            );
            
            $stmtDetalle->bindParam(":id_prestamo", $datos["id_prestamo"], PDO::PARAM_INT);
            $stmtDetalle->bindParam(":equipo_id", $datos["equipo_id"], PDO::PARAM_INT);
            
            if($stmtDetalle->execute()){
                return "ok";
            } else {
                return "error_actualizando_detalle";
            }
        } else {
            return "error_actualizando_equipo";
        }
        
        $stmtEquipo = null;
        $stmtDetalle = null;
    }

    /*=============================================
REGISTRAR MOTIVO DE MANTENIMIENTO (adaptado a tu estructura de tabla)
=============================================*/
    static public function mdlRegistrarMotivoMantenimiento($equipoId, $motivo) {
        try {
            // Verificar si ya existe un registro de mantenimiento para este equipo
            $stmtCheck = Conexion::conectar()->prepare(
                "SELECT Id_mantenimiento FROM mantenimiento WHERE equipo_id = :equipo_id"
            );
            $stmtCheck->bindParam(":equipo_id", $equipoId, PDO::PARAM_INT);
            $stmtCheck->execute();
            
            if($stmtCheck->rowCount() > 0) {
                // Actualizar registro existente
                $stmt = Conexion::conectar()->prepare(
                    "UPDATE mantenimiento SET detalles = :detalles WHERE equipo_id = :equipo_id"
                );
            } else {
                // Crear nuevo registro (sin especificar Id_mantenimiento ya que es AUTO_INCREMENT)
                $stmt = Conexion::conectar()->prepare(
                    "INSERT INTO mantenimiento (equipo_id, detalles) VALUES (:equipo_id, :detalles)"
                );
            }
            
            $stmt->bindParam(":equipo_id", $equipoId, PDO::PARAM_INT);
            $stmt->bindParam(":detalles", $motivo, PDO::PARAM_STR);
            
            if($stmt->execute()) {
                return "ok";
            } else {
                error_log("Error SQL: " . json_encode($stmt->errorInfo()));
                return "error";
            }
        } catch (PDOException $e) {
            error_log("Excepción en mdlRegistrarMotivoMantenimiento: " . $e->getMessage());
            return "error";
        } finally {
            $stmt = null;
            $stmtCheck = null;
        }
    }

}
