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

    public static function ctrAgregarEquipos() {
        if (isset($_POST["numero_serie"]) && isset($_POST["etiqueta"]) && isset($_POST["descripcion"]) && isset($_POST["categoria_id"]) && isset($_POST["cuentadante_id"])) {
    
            // Validación de caracteres
            if (preg_match('/^[a-zA-Z0-9]+$/', $_POST["numero_serie"]) &&
                preg_match('/^[a-zA-Z0-9]+$/', $_POST["etiqueta"]) &&
                preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["descripcion"])) {
    
                // Definir los datos sin ubicación, cuentadante ni estado (se asignan en el modelo)
                $tabla = "equipos";
                $datos = array(
                    "numero_serie" => $_POST["numero_serie"],
                    "cuentadante_id" => $_POST["cuentadante_id"],
                    "etiqueta" => $_POST["etiqueta"],
                    "descripcion" => $_POST["descripcion"],
                    "categoria_id" => $_POST["categoria_id"] // Solo enviamos categoría, los demás valores se asignan en el modelo
                );
    
                // Insertar datos en la base de datos
                $respuesta = ModeloEquipos::mdlAgregarEquipos($tabla, $datos);
    
                if ($respuesta == "ok") {
                    echo '<script>Swal.fire({
                        icon: "success",
                        title: "¡Equipo agregado correctamente!",
                        confirmButtonText: "Ok",
                        confirmButtonColor: "#28a745"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location = "inventario";
                        }
                    });</script>';
                } else {
                    echo '<script>Swal.fire({
                        icon: "error",
                        title: "¡Error al agregar el equipo!",
                        confirmButtonText: "Cerrar",
                        confirmButtonColor: "#d84c4c"
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
                    title: "¡Error, caracteres ingresados no válidos!",
                    confirmButtonText: "Cerrar",
                    confirmButtonColor: "#d84c4c"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location = "inventario";
                    }
                });
                </script>';
            }
        }
    }

    public static function ctrEditarEquipos() {
        if (isset($_POST["idEditEquipo"]) && isset($_POST["etiquetaEdit"]) && isset($_POST["descripcionEdit"]) && 
            isset($_POST["categoriaEditId"]) && isset($_POST["estadoEdit"])) {
            
            if (preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["etiquetaEdit"]) &&
                preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["descripcionEdit"])) {
                
                $tabla = "equipos";
                $datos = array(
                    "equipo_id" => $_POST["idEditEquipo"],
                    "etiquetaEdit" => $_POST["etiquetaEdit"],
                    "descripcionEdit" => $_POST["descripcionEdit"],
                    "estadoEdit" => $_POST["estadoEdit"],
                    "categoriaEdit" => $_POST["categoriaEditId"]
                );
                $respuesta = ModeloEquipos::mdlEditarEquipos($tabla, $datos);
                
                if ($respuesta == "ok") {
                    echo '<script>
                        Swal.fire({
                            icon: "success",
                            title: "¡El equipo ha sido editado correctamente!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar",
                            confirmButtonColor: "#28a745"
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
                            confirmButtonText: "Cerrar",
                            confirmButtonColor: "#d84c4c"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "inventario";
                            }
                        });
                    </script>';
                }
            } else {
                echo '<script>
                        Swal.fire({
                            icon: "error",
                            title: "¡Error, no se aceptan caracteres especiales!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar",
                            confirmButtonColor: "#d84c4c"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "inventario";
                            }
                        });
                    </script>';
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
            // mostramos el array de datos en error_log para debug
            error_log(print_r($datos, true));            

            $respuesta = ModeloEquipos::mdlRealizarTraspasoUbicacion($tabla, $datos);
            // var_dump($respuesta);
            // error_log($respuesta);
            if($respuesta == "ok"){
                echo '<script>
                        swal.fire({
                            icon: "success",
                            title: "¡Traspaso de ubicación realizado con éxito!",
                            showConfirmButton: true,
                            confirmButtonText: "Ok",
                            confirmButtonColor: "#28a745"
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
                            confirmButtonText: "Cerrar",
                            confirmButtonColor: "#d84c4c"
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
                            confirmButtonText: "Ok",
                            confirmButtonColor: "#28a745"
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
                            confirmButtonText: "Cerrar",
                            confirmButtonColor: "#d84c4c"
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