<?php

    include_once "../controladores/solicitudes.controlador.php";
    include_once "../modelos/solicitudes.modelo.php";

    include_once "../controladores/equipos.controlador.php";
    include_once "../modelos/equipos.modelo.php";

    class AjaxSolicitudes
    {
        public $fechaInicio;
        public $fechaFin;
        public $idEquipoAgregar;
        public $idSolicitante;
        public $equipos;
        public $observaciones;
        public $idPrestamo;
        public $motivo;

        
        /*=============================================
            TRAER EQUIPOS DISPONIBLES
            EN EL RENGO DE FECHAS DE SOLICITUDES
        =============================================*/
        public function ajaxMostrarEquiposDisponible()
        {
            
            $valor1 = $this->fechaInicio;
            $valor2 = $this->fechaFin;
            $respuesta = ControladorSolicitudes::ctrMostrarEquiposDisponible($valor1, $valor2);
            echo json_encode($respuesta);
        }

        public function ajaxTraerEquipo()
        {
            $item = "equipo_id";
            $valor = $this->idEquipoAgregar;
            $respuesta = ControladorEquipos::ctrMostrarEquipos($item, $valor);
            echo json_encode($respuesta);
        }

         public function ajaxGuardarSolicitud()
        {
            $datos = array(
                "idSolicitante" => $this->idSolicitante,
                "equipos" => $this->equipos,
                "fechaInicio" => $this->fechaInicio,
                "fechaFin" => $this->fechaFin,
                "motivo" => $this->motivo
            );
            $respuesta = ControladorSolicitudes::ctrGuardarSolicitud($datos);
            echo json_encode($respuesta);
        }

        public function ajaxMostrarSolicitudes()
        {
            $item = "usuario_id";
            $valor = $this->idSolicitante;
            $respuesta = ControladorSolicitudes::ctrMostrarSolicitudes($item, $valor);
            echo json_encode($respuesta);
        }

        public function ajaxMostrarPrestamo(){
            $item = "id_prestamo";
            $valor = $this->idPrestamo;
            $respuesta = ControladorSolicitudes::ctrMostrarPrestamo($item, $valor);
            echo json_encode($respuesta);
        }

        public function ajaxMostrarPrestamoDetalle(){
            $item = "id_prestamo";
            $valor = $this->idPrestamo;
            $respuesta = ControladorSolicitudes::ctrMostrarPrestamoDetalle($item, $valor);
            echo json_encode($respuesta);
        }

    }// class AjaxSolicitudes

if (isset($_POST["accion"])) {

    $solicitud = new AjaxSolicitudes();

    switch ($_POST["accion"]) {

        case "guardarSolicitud":
            $solicitud->idSolicitante = $_POST["idSolicitante"];
            $solicitud->equipos = json_decode($_POST["equipos"], true);
            $solicitud->fechaInicio = $_POST["fechaInicio"];
            $solicitud->fechaFin = $_POST["fechaFin"];
            $solicitud->motivo = $_POST["motivoSolicitud"];
            $solicitud->ajaxGuardarSolicitud();
            break;

        case "mostrarEquipos":
            $solicitud->fechaInicio = $_POST["fechaInicio"];
            $solicitud->fechaFin = $_POST["fechaFin"];
            $solicitud->ajaxMostrarEquiposDisponible();
            break;

        case "traerEquipo":
            $solicitud->idEquipoAgregar = $_POST["idEquipoAgregar"];
            $solicitud->ajaxTraerEquipo();
            break;

        case "mostrarSolicitudes":
            $solicitud->idSolicitante = $_POST["idUsuario"];
            $solicitud->ajaxMostrarSolicitudes();
            break;

        case "mostrarPrestamo":
            $solicitud->idPrestamo = $_POST["idPrestamo"];
            $solicitud->ajaxMostrarPrestamo();
            break;

        case "mostrarPrestamoDetalle":
            $solicitud->idPrestamo = $_POST["idPrestamoDetalle"];
            $solicitud->ajaxMostrarPrestamoDetalle();
            break;

        default:
            echo json_encode("accion invalida");
            break;
    }

}
