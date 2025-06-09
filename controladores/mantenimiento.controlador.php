<?php

class ControladorMantenimiento{

	/*=============================================
		INGRESO MANTENIMIENTO
	=============================================*/

	static public function ctrIngresarMantenimiento(){
        if(isset($_POST["equipoId"], $_POST["gravedad"], $_POST["tipoMantenimiento"], $_POST["detalles"])){
            // Validar y sanitizar datos
            $datos = array(
                "equipo_id" => (int)$_POST["equipoId"],
                "gravedad" => in_array($_POST["gravedad"], ['leve', 'grave', 'ninguno']) ? $_POST["gravedad"] : 'leve',
                "tipo_mantenimiento" => $_POST["tipoMantenimiento"] === 'correctivo' ? 'correctivo' : 'preventivo',
                "detalles" => htmlspecialchars($_POST["detalles"], ENT_QUOTES, 'UTF-8')
            );
            
            $tabla = "mantenimiento";
            $respuesta = ModeloMantenimiento::mdlIngresarMantenimiento($tabla, $datos);
            
            echo $respuesta;
        } else {
            echo "error_faltan_datos";
        }
    }

	// Mostrar mantenimientos
	static public function ctrMostrarMantenimientos($item, $valor)
	{
		$tabla = "mantenimiento";
		$respuesta = ModeloMantenimiento::mdlMostrarMantenimientos($tabla, $item, $valor);
		return $respuesta;
	}
}


