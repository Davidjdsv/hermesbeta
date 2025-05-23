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
            $respuesta = ControladorEquipos::crtMostrarEquipos($item, $valor);
            echo json_encode($respuesta);
        }

        public function ajaxGuardarSolicitud()
        {
            $datos = array(
                "idSolicitante" => $this->idSolicitante,
                "equipos" => $this->equipos,
                "fechaInicio" => $this->fechaInicio,
                "fechaFin" => $this->fechaFin,
                "observaciones" => $this->observaciones
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

if (isset($_POST["fechaInicio"]) && isset($_POST["fechaFin"])) {
    $solicitud = new AjaxSolicitudes();
    $solicitud->fechaInicio = $_POST["fechaInicio"];
    $solicitud->fechaFin = $_POST["fechaFin"];
    $solicitud->ajaxMostrarEquiposDisponible();
}

if (isset($_POST["idEquipoAgregar"])) {
    $solicitud = new AjaxSolicitudes();
    $solicitud->idEquipoAgregar = $_POST["idEquipoAgregar"];
    $solicitud->ajaxTraerEquipo();
}

if (isset($_POST["idSolicitante"]) && isset($_POST["equipos"])) {
    $solicitud = new AjaxSolicitudes();
    $solicitud->idSolicitante = $_POST["idSolicitante"];
    $solicitud->equipos = json_decode($_POST["equipos"], true);
    $solicitud->fechaInicio = $_POST["fechaInicio"];
    $solicitud->fechaFin = $_POST["fechaFin"];
    $solicitud->observaciones = $_POST["observaciones"];
    $solicitud->ajaxGuardarSolicitud();    
}

if (isset($_POST["idUsuario"])){
    $solicitud = new AjaxSolicitudes();
    $solicitud->idSolicitante = $_POST["idUsuario"];
    $solicitud->ajaxMostrarSolicitudes();
}

if (isset($_POST["idPrestamo"])){
    $solicitud = new AjaxSolicitudes();
    $solicitud->idPrestamo = $_POST["idPrestamo"];
    $solicitud->ajaxMostrarPrestamo();    
}
    
if (isset($_POST["idPrestamoDetalle"])){
    $solicitud = new AjaxSolicitudes();
    $solicitud->idPrestamo = $_POST["idPrestamoDetalle"];
    $solicitud->ajaxMostrarPrestamoDetalle();    
}


