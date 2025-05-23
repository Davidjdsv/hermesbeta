<?php

require_once "../controladores/usuarios.controlador.php";
require_once "../modelos/usuarios.modelo.php";

class AjaxUsuarios
{

    public $sede;
    public $idUsuario;
    public $item;

    public function ajaxFichasSede()
    {
        $item = "sede";
        $valor = $_POST["sede"];
        $respuesta = ControladorUsuarios::ctrMostrarFichasSede($item, $valor);
        echo json_encode($respuesta);
    }


    public function ajaxMostrarUsuario()
    {
        // $item = "id_usuario";
        $valor = $this->idUsuario;
        $respuesta = ControladorUsuarios::ctrMostrarUsuarios($this->item, $valor);
        echo json_encode($respuesta);
    }


}

if (isset($_POST["sede"])) {
    $fichas = new AjaxUsuarios();
    $fichas->sede = $_POST["sede"];
    $fichas->ajaxFichasSede();
}

if (isset($_POST["idUsuario"])) {
    $usuario = new AjaxUsuarios();
    $usuario->idUsuario = $_POST["idUsuario"];
    $usuario->item = "id_usuario";
    $usuario->ajaxMostrarUsuario();
} 

if (isset($_POST["idSolicitante"])) {
    $solicitante = new AjaxUsuarios();
    $solicitante->idUsuario = $_POST["idSolicitante"];
    $solicitante->item = "numero_documento";
    $solicitante->ajaxMostrarUsuario();
}
// Cambiar estado de usuario

if (isset($_POST["idUsuarioEstado"], $_POST["estado"])) {
    $id = $_POST["idUsuarioEstado"];
    $estado = $_POST["estado"];
    $respuesta = ControladorUsuarios::ctrCambiarEstadoUsuario($id, $estado);
    echo $respuesta ? 'ok' : 'error';
    exit;
}