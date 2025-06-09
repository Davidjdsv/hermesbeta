<?php

class ControladorPrestamos {
    
    static public function ctrMostrarPrestamos() {
        $tabla = "prestamos";
        
        $respuesta = ModeloPrestamos::mdlMostrarPrestamos($tabla);
        
        return $respuesta;
    }
}

?>