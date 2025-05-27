<?php
require_once "../modelos/AuditoriaModelo.php";

class AuditoriaControlador {

    public static function ctrMostrarAuditoria() {
        $resultados = AuditoriaModelo::mdlMostrarAuditoria();

        if (!$resultados) {
            // Opcional: podrías registrar un error o devolver un arreglo vacío para evitar problemas en la vista
            return [];
        }

        return $resultados;
    }
}
