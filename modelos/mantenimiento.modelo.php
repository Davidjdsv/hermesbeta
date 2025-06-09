<?php

require_once "conexion.php";

class ModeloMantenimiento
{
    // Mostrar mantenimientos
    static public function mdlMostrarMantenimientos($tabla, $item, $valor)
    {
        try {
            if ($item == null) {
                $stmt = Conexion::conectar()->prepare(
                    "SELECT e.equipo_id, e.numero_serie, e.etiqueta, e.descripcion, 
                            m.Id_mantenimiento, m.detalles, m.gravedad
                     FROM equipos e 
                     LEFT JOIN $tabla m ON e.equipo_id = m.equipo_id 
                     WHERE e.id_estado = 4"
                );
                $stmt->execute();
                return $stmt->fetchAll();
            }
        } catch (PDOException $e) {
            return "error";
        } finally {
            $stmt = null;
        }
    }

    // Método para ingresar un nuevo mantenimiento
    static public function mdlIngresarMantenimiento($tabla, $datos){
        try 
        {
            $stmt = Conexion::conectar()->prepare(
                "INSERT INTO $tabla 
                (equipo_id, detalles, gravedad, tipo_mantenimiento) 
                VALUES 
                (:equipo_id, :detalles, :gravedad, :tipo_mantenimiento)");
            
            $stmt->bindParam(":equipo_id", $datos["equipo_id"], PDO::PARAM_INT);
            $stmt->bindParam(":detalles", $datos["detalles"], PDO::PARAM_STR);
            $stmt->bindParam(":gravedad", $datos["gravedad"], PDO::PARAM_STR);
            $stmt->bindParam(":tipo_mantenimiento", $datos["tipo_mantenimiento"], PDO::PARAM_STR);
            
            if($stmt->execute())
            {
                // Actualizar estado del equipo a "disponible" o similar
               
                if ($datos["gravedad"] == "ninguno" || $datos["gravedad"] == "leve") {
                    $stmtEstado = Conexion::conectar()->prepare(
                    "UPDATE equipos SET id_estado = 1 WHERE equipo_id = :equipo_id");
                    $stmtEstado->bindParam(":equipo_id", $datos["equipo_id"], PDO::PARAM_INT);
                    $stmtEstado->execute();
                    return "ok";
                } else {
                    $stmtEstado = Conexion::conectar()->prepare(
                        "UPDATE equipos SET id_estado = 8 WHERE equipo_id = :equipo_id");
                        $stmtEstado->bindParam(":equipo_id", $datos["equipo_id"], PDO::PARAM_INT);
                        $stmtEstado->execute();
                        return "ok";
                }
            }
        }catch (PDOException $e) {
            return "error";
        } finally {
            $stmt = null;
        }
    }

}

