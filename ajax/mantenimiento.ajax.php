<?php
require_once "../controladores/mantenimiento.controlador.php";
require_once "../modelos/mantenimiento.modelo.php";

if(isset($_POST["equipoId"], $_POST["gravedad"], $_POST["tipoMantenimiento"], $_POST["detalles"])){
    $ingresarMantenimiento = new ControladorMantenimiento();
    $ingresarMantenimiento->ctrIngresarMantenimiento();
} else {
    echo "error_datos_incompletos";
}
?>