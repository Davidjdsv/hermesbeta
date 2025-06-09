<?php

require_once "conexion.php";

class ModeloPrestamos {
    
    static public function mdlMostrarPrestamos($tabla) {
        $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla ORDER BY fecha_inicio DESC");
        
        $stmt->execute();
        
        return $stmt->fetchAll();
        
        $stmt = null;
    }
}

?>