<?php


class Controladorsalidas {
    /*=============================================
    MOSTRAR DEVOLUCIONES (LISTADO)
    =============================================*/
    static public function ctrMostrarsalidas($item, $valor) {
        $tabla = "prestamos";
        $respuesta = Modelosalida::mdlMostrarsalida($tabla, $item, $valor);
        return $respuesta;

    }
}
?>