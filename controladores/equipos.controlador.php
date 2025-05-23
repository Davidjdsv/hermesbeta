<?php

class ControladorEquipos{

    static public function ctrMostrarEquipos($item, $valor)
    {
        $tabla = "equipos";
        $respuesta = ModeloEquipos::mdlMostrarEquipos($tabla, $item, $valor);
        //var_dump($respuesta[0]);
        // error_log($respuesta);
        return $respuesta;
    }

    public static function ctrAgregarEquipos(){
        if (isset($_POST["numero_serie"]) && isset($_POST["etiqueta"]) && isset($_POST["descripcion"]) && isset($_POST["ubicacion_id"]) && isset($_POST["categoria_id"]) && isset($_POST["cuentadante_id"])) {
            // Faltaban los preg match
            if (preg_match('/^[a-zA-Z0-9]+$/', $_POST["numero_serie"]) && preg_match('/^[a-zA-Z0-9]+$/', $_POST["etiqueta"]) && preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["descripcion"])) {
                // Mostrar datos antes de enviarlos al modelo
                $tabla = "equipos";
                $datos = array(
                    "numero_serie" => $_POST["numero_serie"],
                    "etiqueta" => $_POST["etiqueta"],
                    "descripcion" => $_POST["descripcion"],
                    "ubicacion_id" => $_POST["ubicacion_id"],
                    "categoria_id" => $_POST["categoria_id"],
                    "cuentadante_id" => $_POST["cuentadante_id"],
                    "id_estado" => $_POST["id_estado"]
                );

                $respuesta = ModeloEquipos::mdlAgregarEquipos($tabla, $datos);
                //var_dump($respuesta);

                if ($respuesta == "ok") {
                    echo '<script>Swal.fire({
                    icon: "success",
                    title: "¡Equipo agregado correctamente!",
                    confirmButtonText: "Cerrar"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location = "inventario";
                    }
                });</script>';
                } else {
                    echo '<script>Swal.fire({
                    icon: "error",
                    title: "¡Error al agregar el equipo!",
                    confirmButtonText: "Cerrar"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location = "inventario";
                    }
                });</script>';
                }
            } else {
                echo '<script>
                Swal.fire({
                    icon: "error",
                    title: "¡Error, carácteres ingresados no válidos!",
                    confirmButtonText: "Cerrar"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location = "inventario";
                    }
                });
                </script>';
            }
        }
    }
    // End of ctrAgregarEquipos method

    public static function ctrEditarEquipos(){
        if (isset($_POST["idEditEquipo"]) && isset($_POST["etiquetaEdit"]) && isset($_POST["descripcionEdit"]) && isset($_POST["categoriaEditId"]) && isset($_POST["estadoEdit"])) {
            if (preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["etiquetaEdit"]) &&
            preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["descripcionEdit"])){
                $tabla = "equipos";
                $datos = array(
                    "equipo_id" => $_POST["idEditEquipo"],
                    // "numeroSerieEdit" => $_POST["numeroSerieEdit"],
                    "etiquetaEdit" => $_POST["etiquetaEdit"],
                    "descripcionEdit" => $_POST["descripcionEdit"],
                    "estadoEdit" => $_POST["estadoEdit"], //SE AGREGÓ ESTADO
                    "categoriaEdit" => $_POST["categoriaEditId"]
                );
                $respuesta = ModeloEquipos::mdlEditarEquipos($tabla, $datos);
                
                if ($respuesta == "ok") {
                    echo '<script>
                        Swal.fire({
                            icon: "success",
                            title: "¡El equipo ha sido editado correctamente!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "inventario";
                            }
                        });
                    </script>';
                } else {
                    echo '<script>
                        Swal.fire({
                            icon: "error",
                            title: "¡Error al editar el equipo!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "inventario";
                            }
                        });
                    </script>';
                }
            } 
            
        }
    }

    static public function ctrMostrarDatosCuentadanteOrigen($item, $valor)
    {
        $tabla = "equipos";
        $respuesta = ModeloEquipos::mdlMostrarDatosCuentadanteOrigen($tabla, $item, $valor);
        //var_dump($respuesta);
        return $respuesta;
    }

    static public function ctrMostrarDatosCuentadanteTraspaso($item, $valor)
    {
        $tabla = "usuarios";
        $respuesta = ModeloEquipos::mdlMostrarDatosCuentadanteTraspaso($tabla, $item, $valor);
        return $respuesta;
    }

    public static function ctrMostrarUbicacion($item, $valor){
        $tabla = "equipos";
        $respuesta = ModeloEquipos::mdlMostrarUbicacion($tabla, $item, $valor);
        return $respuesta;
    }

    public static function ctrMostrarUbicacionDestino($item, $valor){
        $tabla = "equipos";
        $respuesta = ModeloEquipos::mdlMostrarUbicacionDestino($tabla, $item, $valor);
        return $respuesta;
    }

    public static function ctrRealizarTraspasoUbicacion(){
        if(isset($_POST["idTraspasoUbicacion"]) && isset($_POST["nuevaUbicacionId"])){
            $tabla = "equipos";
            $datos = array(
                "equipo_id" => $_POST["idTraspasoUbicacion"],
                "ubicacion_id" => $_POST["nuevaUbicacionId"]
            );

            $respuesta = ModeloEquipos::mdlRealizarTraspasoUbicacion($tabla, $datos);
            // var_dump($respuesta);
            error_log($respuesta);
            if($respuesta == "ok"){
                echo '<script>
                        swal.fire({
                            icon: "success",
                            title: "¡Traspaso de ubicación realizado con éxito!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "inventario";
                            }
                        });
                    </script>';
            } else {
                echo '<script>
                        swal.fire({
                            icon: "error",
                            title: "¡Traspaso de ubicación fallido!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "inventario";
                            }
                        });
                    </script>';
            }
        }
    }

    static public function ctrRealizarTraspasoCuentadante()
    {
        if (isset($_POST["idTraspasoEquipo"]) && isset($_POST["cuentadanteDestinoId"])) {
            $tabla = "equipos";
            $datos = array(
                "equipo_id" => $_POST["idTraspasoEquipo"],
                "cuentadante_id" => $_POST["cuentadanteDestinoId"],
            );

            $respuesta = ModeloEquipos::mdlRealizarTraspasoCuentadante($tabla, $datos);


            if ($respuesta == "ok") {
                echo '<script>
                        swal.fire({
                            icon: "success",
                            title: "¡Traspaso realizado con éxito!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "inventario";
                            }
                        });
                    </script>';
            } else {
                echo '<script>
                        swal.fire({
                            icon: "error",
                            title: "Algo ha fallado. No se realizaron cambios",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "inventario";
                            }
                        });
                    </script>';
            }
        }
    }
} //fin de la clase ControladorEquipos    