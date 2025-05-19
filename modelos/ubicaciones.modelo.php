<?php

include_once("conexion.php");
Class ModeloUbicaciones{
    static public function mdlMostrarUbicaciones($tabla, $item, $valor){
        if($item != null){
            $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE $item = :$item");
            if($item == "ubicacion_id" || $item == "id_sede"){
                $stmt->bindParam(":".$item, $valor, PDO::PARAM_INT);
            } else {
                $stmt->bindParam(":".$item, $valor, PDO::PARAM_STR);
            }
            $stmt->execute();
            return $stmt -> fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        $stmt -> close();
        $stmt = null;
    }
}