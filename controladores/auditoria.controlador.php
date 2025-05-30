<?php
// Se incluye el archivo del modelo que contiene la lógica para obtener los datos de auditoría desde la base de datos
require_once "../modelos/auditoria.modelo.php";

class AuditoriaControlador {

    // Método estático del controlador que llama al modelo para obtener los datos de auditoría
    public static function ctrMostrarAuditoria() {
        // Se llama al método del modelo que realiza la consulta a la base de datos
        $resultados = AuditoriaModelo::mdlMostrarAuditoria();

        // Si no se obtuvieron resultados (puede ser false si hubo error en la conexión o consulta)
        if (!$resultados) {
            // Retorna un arreglo vacío como medida de seguridad para evitar errores en la vista
            return [];
        }

        // Retorna los resultados obtenidos de la base de datos
        return $resultados;
    }
}
