<?php

require_once "../controladores/devoluciones.controlador.php";
require_once "../modelos/devoluciones.modelo.php";

class AjaxDevoluciones {
    public $idPrestamo;
    public $idEquipo;
    public $accion;
    public $motivo; // Nueva propiedad para el motivo

    public function ajaxObtenerDatosPrestamo() {
        $item = "id_prestamo";
        $valor = $this->idPrestamo;

        // La respuesta ahora será un array de equipos si el préstamo tiene varios
        $respuesta = ControladorDevoluciones::ctrMostrarDevoluciones($item, $valor);

        echo json_encode($respuesta);
    }

    /*=============================================
    MARCAR EQUIPO EN DETALLE_PRESTAMO COMO MANTENIMIENTO
    =============================================*/
    public function ajaxMarcarMantenimientoDetalle() {
        // No se necesita pasar id_estado desde aquí, ya que se define en el controlador
        $respuestaControlador = ControladorDevoluciones::ctrMarcarMantenimientoDetalle($this->idPrestamo, $this->idEquipo);
        
        if ($respuestaControlador == "ok") {
            echo json_encode(array("success" => true, "status" => "equipo_marcado", "message" => "Equipo marcado para mantenimiento correctamente."));
        } else if ($respuestaControlador == "ok_prestamo_actualizado") {
            echo json_encode(array("success" => true, "status" => "prestamo_actualizado", "message" => "Equipo marcado y préstamo actualizado a devuelto."));
        } else if ($respuestaControlador == "no_change") {
            echo json_encode(array("success" => false, "status" => "sin_cambios", "message" => "El equipo ya estaba en el estado deseado o no se encontró."));
        } else if ($respuestaControlador == "error_actualizando_prestamo") {
            echo json_encode(array("success" => false, "status" => "error_prestamo", "message" => "Equipo marcado, pero hubo un error al actualizar el préstamo."));
        } else { // Cubre el caso 'error' del marcado inicial y cualquier otro inesperado
            echo json_encode(array("success" => false, "status" => "error_marcado", "message" => "Error al actualizar el estado del equipo."));
        }
    }

    /*=============================================
    MARCAR EQUIPO EN DETALLE_PRESTAMO COMO MANTENIMIENTO CON MOTIVO
    =============================================*/
    public function ajaxMarcarMantenimientoConMotivo() {
        $respuestaControlador = ControladorDevoluciones::ctrMarcarMantenimientoConMotivo($this->idPrestamo, $this->idEquipo, $this->motivo);
        
        // Asegurarse de que la respuesta sea consistente
        if (is_array($respuestaControlador)) {
            echo json_encode($respuestaControlador);
        } else {
            // Si el controlador devuelve un string simple, convertirlo a formato esperado
            if ($respuestaControlador == "ok") {
                echo json_encode(array(
                    "success" => true, 
                    "status" => "equipo_marcado", 
                    "message" => "Equipo enviado a mantenimiento con motivo registrado."
                ));
            } else if ($respuestaControlador == "ok_prestamo_actualizado") {
                echo json_encode(array(
                    "success" => true, 
                    "status" => "prestamo_actualizado", 
                    "message" => "Equipo en mantenimiento y préstamo actualizado a devuelto."
                ));
            } else {
                echo json_encode(array(
                    "success" => false, 
                    "status" => "error_marcado", 
                    "message" => $respuestaControlador
                ));
            }
        }
    }

    /*=============================================
    MARCAR EQUIPO EN DETALLE_PRESTAMO COMO DEVUELTO (BUEN ESTADO)
    =============================================*/
    public function ajaxMarcarDevueltoBuenEstado() {
        $respuestaControlador = ControladorDevoluciones::ctrMarcarDevueltoBuenEstado($this->idPrestamo, $this->idEquipo);
        
        if ($respuestaControlador == "ok") {
            echo json_encode(array("success" => true, "status" => "equipo_marcado", "message" => "Equipo marcado como devuelto en buen estado."));
        } else if ($respuestaControlador == "ok_prestamo_actualizado") {
            echo json_encode(array("success" => true, "status" => "prestamo_actualizado", "message" => "Equipo marcado y préstamo actualizado a devuelto."));
        } else if ($respuestaControlador == "no_change") {
            echo json_encode(array("success" => false, "status" => "sin_cambios", "message" => "El equipo ya estaba en el estado deseado o no se encontró."));
        } else {
            echo json_encode(array("success" => false, "status" => "error_marcado", "message" => "Error al actualizar el estado del equipo."));
        }
    }

    /*=============================================
    MARCAR EQUIPO COMO ROBADO (BAJA)
    =============================================*/
    public function ajaxMarcarEquipoRobado() {
        $respuestaControlador = ControladorDevoluciones::ctrMarcarEquipoRobado($this->idPrestamo, $this->idEquipo);
        
        if ($respuestaControlador == "ok") {
            echo json_encode(array("success" => true, "status" => "equipo_marcado", "message" => "Equipo marcado como robado correctamente."));
        } else if ($respuestaControlador == "ok_prestamo_actualizado") {
            echo json_encode(array("success" => true, "status" => "prestamo_actualizado", "message" => "Equipo marcado como robado y préstamo actualizado."));
        } else {
            echo json_encode(array("success" => false, "status" => "error_marcado", "message" => "Error al marcar el equipo como robado."));
        }
    }
}

// Obtener datos del préstamo
if(isset($_POST["idPrestamo"]) && !isset($_POST["accion"])) {
    $prestamo = new AjaxDevoluciones();
    $prestamo->idPrestamo = $_POST["idPrestamo"];
    $prestamo->ajaxObtenerDatosPrestamo();
}

// Marcar equipo en detalle_prestamo como Mantenimiento
if(isset($_POST["accion"]) && $_POST["accion"] === "marcarMantenimientoDetalle") {
    $devolucion = new AjaxDevoluciones();
    $devolucion->idPrestamo = $_POST["idPrestamo"];
    $devolucion->idEquipo = $_POST["idEquipo"];
    $devolucion->ajaxMarcarMantenimientoDetalle();
}

// Marcar equipo como devuelto en buen estado
if(isset($_POST["accion"]) && $_POST["accion"] === "marcarBuenEstado") {
    $devolucion = new AjaxDevoluciones();
    $devolucion->idPrestamo = $_POST["idPrestamo"];
    $devolucion->idEquipo = $_POST["idEquipo"];
    $devolucion->ajaxMarcarDevueltoBuenEstado();
}

// Marcar equipo como robado
if(isset($_POST["accion"]) && $_POST["accion"] === "marcarEquipoRobado") {
    $devolucion = new AjaxDevoluciones();
    $devolucion->idPrestamo = $_POST["idPrestamo"];
    $devolucion->idEquipo = $_POST["idEquipo"];
    $devolucion->ajaxMarcarEquipoRobado();
}

// Marcar equipo para mantenimiento con motivo
if(isset($_POST["accion"]) && $_POST["accion"] === "marcarMantenimientoConMotivo") {
    $devolucion = new AjaxDevoluciones();
    $devolucion->idPrestamo = $_POST["idPrestamo"];
    $devolucion->idEquipo = $_POST["idEquipo"];
    $devolucion->motivo = $_POST["motivo"];
    $devolucion->ajaxMarcarMantenimientoConMotivo();
}