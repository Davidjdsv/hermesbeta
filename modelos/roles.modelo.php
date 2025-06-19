<?php

    require_once "conexion.php";

class ModeloRoles{

    static public function mdlCrearRol($tabla, $datos)
    {
        $stmt = Conexion::conectar()->prepare("INSERT INTO $tabla(nombre_rol, descripcion) VALUES (:nombre_rol, :descripcion)");
        $stmt->bindParam(":nombre_rol", $datos["nombre_rol"], PDO::PARAM_STR);
        $stmt->bindParam(":descripcion", $datos["descripcion"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            // Capture the error and return it for debugging
            $errorInfo = $stmt->errorInfo();
            return "error: " . $errorInfo[2];
        }
        $stmt->close();
        $stmt = null;
    }


    /*=============================================
    MOSTRAR ROLES
    ==============================================*/
    static public function mdlMostrarRoles($tabla, $item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE $item = :$item");
            $stmt->bindParam(":".$item, $valor, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        $stmt->close();
        $stmt = null;
    }

    /*=============================================
    EDITAR ROL
    ==============================================*/
    static public function mdlEditarRol($tabla, $datos)
    {
        $stmt = Conexion::conectar()->prepare("UPDATE $tabla SET nombre_rol = :nombre_rol, descripcion = :descripcion WHERE id_rol = :id_rol");
        $stmt->bindParam(":nombre_rol", $datos["nombre_rol"], PDO::PARAM_STR);
        $stmt->bindParam(":descripcion", $datos["descripcion"], PDO::PARAM_STR);
        $stmt->bindParam(":id_rol", $datos["id_rol"], PDO::PARAM_INT);

        if ($stmt->execute()) {
            return "ok";
        } else {
            // Capture the error and return it for debugging
            $errorInfo = $stmt->errorInfo();
            return "error: " . $errorInfo[2];
        }
        $stmt->close();
        $stmt = null;
    }

    /*=============================================
    CAMBIAR ESTADO ROL
    ==============================================*/
    static public function mdlCambiarEstadoRol($valorId, $valorEstado)
    {
        $stmt = Conexion::conectar()->prepare("UPDATE roles SET estado = :estado WHERE id_rol = :id_rol");
        $stmt->bindParam(":estado", $valorEstado, PDO::PARAM_STR);
        $stmt->bindParam(":id_rol", $valorId, PDO::PARAM_INT);

        if ($stmt->execute()) {
            return "ok";
        } else {
            // Capture the error and return it for debugging
            $errorInfo = $stmt->errorInfo();
            return "error: " . $errorInfo[2];
        }
        $stmt->close();
        $stmt = null;
    }

    static public function mdlEliminarRol($tabla, $idRol)
    {
        $stmt = Conexion::conectar()->prepare("DELETE FROM $tabla WHERE id_rol = :id_rol");
        $stmt->bindParam(":id_rol", $idRol, PDO::PARAM_INT);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }

    static public function mdlDesactivarUsuariosPorRol($idRol)
    {
        $stmt = Conexion::conectar()->prepare("UPDATE usuarios SET estado = 'inactivo' WHERE id_rol = :id_rol");
        $stmt->bindParam(":id_rol", $idRol, PDO::PARAM_INT);
        $stmt->execute();
        $stmt = null;
    }
}