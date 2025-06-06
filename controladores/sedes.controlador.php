<?php

class ControladorSedes
{
    /*=============================================
    CREAR SEDE
    ==============================================*/
    static public function ctrCrearSede()
    {
        if (isset($_POST["nombreSede"])  && isset($_POST["direccionSede"]) && isset($_POST["descripcionSede"])) {
            if (preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["nombreSede"]) &&
                preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["direccionSede"])) {

                // var_dump($_POST["nombreSede"]);
                // exit();

                $tabla = "sedes";
                $datos = array(
                    "nombre" => $_POST["nombreSede"],
                    "direccion" => $_POST["direccionSede"],
                    "descripcion" => $_POST["descripcionSede"]
                );

                $respuesta = ModeloSedes::mdlCrearSede($tabla, $datos);
                // var_dump($respuesta);
                // exit();
                // return $respuesta;

                if ($respuesta == "ok"){
                    echo '<script>
                        Swal.fire({
                            icon: "success",
                            title: "¡La sede ha sido guardada correctamente!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "sedes";
                            }
                        });
                    </script>';
                    
                }else{
                    echo '<script>
                        Swal.fire({
                            icon: "error",
                            title: "¡Error al guardar la sede!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "sedes";
                            }
                        });
                    </script>';
                }
            }else{
                echo '<script>
                    Swal.fire({
                        icon: "error",
                        title: "¡Revisar parametros!",
                        showConfirmButton: true,
                        confirmButtonText: "Cerrar"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location = "sedes";
                        }
                    });
                </script>';
            }
        }
    } // fin del método ctrCrearSede

    /*=============================================
    MOSTRAR SEDE
    =============================================*/
    static public function ctrMostrarSedes($item, $valor)
    {
        $tabla = "sedes";
        $respuesta = ModeloSedes::mdlMostrarSedes($tabla, $item, $valor);

        return $respuesta;
    }

    /*=============================================
    EDITAR SEDE
    =============================================*/
    static public function ctrEditarSede()
    {
        if (isset($_POST["nombreEditSede"]) && isset($_POST["direccionEditSede"]) && isset($_POST["descripcionEditSede"])) {
            if (preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ .,]+$/', $_POST["nombreEditSede"]) &&
                preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ .,#\-\/]+$/', $_POST["direccionEditSede"])) {

                $tabla = "sedes";
                $datos = array(
                    "id" => $_POST["idEditSede"],
                    "nombre" => $_POST["nombreEditSede"],
                    "direccion" => $_POST["direccionEditSede"],
                    "descripcion" => $_POST["descripcionEditSede"]
                );

                $respuesta = ModeloSedes::mdlEditarSede($tabla, $datos);

                if ($respuesta == "ok") {
                    echo '<script>
                        Swal.fire({
                            icon: "success",
                            title: "¡La sede ha sido editada correctamente!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "sedes";
                            }
                        });
                    </script>';
                } else {
                    echo '<script>
                        Swal.fire({
                            icon: "error",
                            title: "¡Error al editar la sede!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "sedes";
                            }
                        });
                    </script>';
                }
            } else {
                echo '<script>
                    Swal.fire({
                        icon: "error",
                        title: "¡Revisar parametros!",
                        showConfirmButton: true,
                        confirmButtonText: "Cerrar"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location = "sedes";
                        }
                    });
                </script>';
            }
        }
    } // fin del método ctrEditarSede

    
}