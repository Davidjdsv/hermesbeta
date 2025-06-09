<?php
//condiciones para manejar las solicitudes AJAX
if ($_POST["accion"] == "prestarPrestamo") {
    require_once "../modelos/salidas.modelo.php";
    $id = $_POST["idPrestamo"];
    $respuesta = Modelosalida::mdlPrestarPrestamo($id);
    echo json_encode($respuesta);
    exit;
}

?>
