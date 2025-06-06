<?php

// Requerimos los controladores y modelos necesarios para manipular los datos
require_once "../controladores/equipos.controlador.php";
require_once "../modelos/equipos.modelo.php";

class AjaxEquipos {
    
    /* ==================================================
    PROPIEDAD PÚBLICA PARA RECIBIR EL ID DEL EQUIPO
    ================================================== */
    public $idEquipo; // Esta propiedad recibe el id del equipo enviado desde el JS
    public $idEquipoTraspaso;
    public $buscarDocumentoId;
    public $idEquipoTraspasoUbicacion;
    public $nuevaUbicacionId;

    /* ==================================================
    MÉTODO PARA EDITAR EQUIPO
    ================================================== */
    public function ajaxMostrarEquipo() {
        // Definimos el campo de la tabla por el cual haremos la búsqueda
        $item = "equipo_id";
        // Asignamos el valor que viene desde el formulario (JS)
        $valor = $this -> idEquipo;

        // Llamamos al controlador para obtener los datos del equipo específico
        $respuesta = ControladorEquipos::ctrMostrarEquipos($item, $valor);
        
        // Devolvemos los datos en formato JSON para que el JS los pueda usar
        echo json_encode($respuesta);
        //error_log(print_r($respuesta, true));
    }

    public function ajaxMostrarDatosCuentadanteOrigen(){
        $item = "equipo_id";
        $valor = $this -> idEquipoTraspaso;
        $respuesta = ControladorEquipos::ctrMostrarDatosCuentadanteOrigen($item, $valor);
        echo json_encode($respuesta);
    }

    public function ajaxMostrarDatosCuentadanteTraspaso(){
        $item = "numero_documento";
        $valor = $this -> buscarDocumentoId;
        $respuesta = ControladorEquipos::ctrMostrarDatosCuentadanteTraspaso($item, $valor);
        echo json_encode($respuesta);
    }

    public function ajaxMostrarDatosUbicacion(){
        $item = "equipo_id";
        $valor = $this -> idEquipoTraspasoUbicacion;
        $respuesta = ControladorEquipos::ctrMostrarUbicacion($item, $valor);
        echo json_encode($respuesta);
    }

    // public function ajaxMostrarDatosUbicacionDestino(){
    //     $item = "ubicacion_id";
    //     $valor = $this -> nuevaUbicacionId;
    //     $respuesta = ControladorEquipos::ctrMostrarUbicacionDestino($item, $valor);
    //     // error_log(print_r($respuesta, true));
    //     echo json_encode($respuesta);
    // }
}


/* ==================================================
EJECUCIÓN DEL CÓDIGO CUANDO SE ENVÍA EL FORMULARIO
================================================== */

if (isset($_POST["idEquipoTraspasoUbicacion"])) {
    $traspaso = new AjaxEquipos();
    $traspaso -> idEquipo = $_POST["idEquipoTraspasoUbicacion"];
    $traspaso -> ajaxMostrarEquipo();
}

// if (isset($_POST["nuevaUbicacionId"])) {
//     $traspaso = new AjaxEquipos();
//     $traspaso -> nuevaUbicacionId = $_POST["nuevaUbicacionId"];
//     $traspaso -> ajaxMostrarDatosUbicacionDestino();
// }


if(isset($_POST["buscarDocumentoId"])){
    $datosCuentadante = new AjaxEquipos();
    $datosCuentadante -> buscarDocumentoId = $_POST["buscarDocumentoId"];
    $datosCuentadante -> ajaxMostrarDatosCuentadanteTraspaso();
}

if (isset($_POST["idEquipoTraspaso"])) {
    $traspaso = new AjaxEquipos();
    $traspaso -> idEquipoTraspaso = $_POST["idEquipoTraspaso"];
    $traspaso -> ajaxMostrarDatosCuentadanteOrigen();
}

// Validamos que se haya enviado el dato "idEquipo" mediante POST desde Js
if (isset($_POST["idEquipo"])) {
    // Creamos una instancia de la clase AjaxEquipos
    $editar = new AjaxEquipos();
    
    // Asignamos el id recibido desde el POST a la propiedad de la clase
    $editar -> idEquipo = $_POST["idEquipo"];
    
    // Ejecutamos el método que consultará y devolverá los datos
    $editar -> ajaxMostrarEquipo();
}


