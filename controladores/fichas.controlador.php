<?php

class ControladorFichas {

    // Método para crear una nueva ficha
    static public function ctrCrearFicha() {
        
        if (isset($_POST["codigoFicha"]) && isset($_POST["descripcionFicha"])  && isset($_POST["id_sede"]) && isset($_POST["fechaInicio"]) && isset($_POST["fechaFin"])) {
            if (preg_match('/^[a-zA-Z0-9]+$/', $_POST["codigoFicha"]) && 
                preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ \s]+$/', $_POST["descripcionFicha"])) {

                $tabla = "fichas";
                $datos = array(
                    "codigo" => $_POST["codigoFicha"],
                    "descripcion" => $_POST["descripcionFicha"],
                    "idSede" => $_POST["id_sede"],
                    "fecha_inicio" => $_POST["fechaInicio"],
                    "fecha_fin" => $_POST["fechaFin"]
                );

                $respuesta = ModeloFichas::mdlCrearFicha($tabla, $datos);

                if ($respuesta == "ok") {
                    echo '<script>
                        Swal.fire({
                            icon: "success",
                            title: "¡La ficha ha sido creada correctamente!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "fichas";
                            }
                        });                        
                    </script>';
                } else {
                    echo '<script>
                        Swal.fire({
                            icon: "error",
                            title: "¡Error al crear la ficha!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "fichas";
                            }
                        });
                    </script>';
                }
            }
        }


    }

    static public function ctrEditarFicha() {
        // Implementar la lógica para editar una ficha
        if (isset($_POST["editCodigoFicha"]) && isset($_POST["editDescripcionFicha"])  && isset($_POST["editSedeFicha"]) && isset($_POST["editFechaInicioFicha"]) && isset($_POST["editFechaFinFicha"]) && isset($_POST["idEditFicha"])) {
            
            if (preg_match('/^[0-9]+$/', $_POST["editCodigoFicha"]) && 
            preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ() .,\s]+$/', $_POST["editDescripcionFicha"])) {
                // var_dump($_POST);
                // die();

                // Validar y procesar los datos de la ficha
                $tabla = "fichas";
                $datos = array(
                    "id_ficha" => $_POST["idEditFicha"],
                    "codigo" => $_POST["editCodigoFicha"],
                    "descripcion" => $_POST["editDescripcionFicha"],
                    "idSede" => $_POST["editSedeFicha"],
                    "fecha_inicio" => $_POST["editFechaInicioFicha"],
                    "fecha_fin" => $_POST["editFechaFinFicha"]
                    
                );            

                $respuesta = ModeloFichas::mdlEditarFicha($tabla, $datos);

                if ($respuesta == "ok") {
                    echo '<script>
                        Swal.fire({
                            icon: "success",
                            title: "¡La ficha ha sido editada correctamente!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "fichas";
                            }
                        });
                    </script>';
                } else {
                    echo '<script>
                        Swal.fire({
                            icon: "error",
                            title: "¡Error al editar la ficha!",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "fichas";
                            }
                        });
                    </script>';
                }
            }
        }
    } //FIN METODO ctrEditarFicha

    // Método para leer una ficha por su ID
    public function leerFicha($id) {
        // Lógica para leer una ficha de la base de datos por su ID
    }

    // Método para actualizar una ficha existente
    public function actualizarFicha($id, $datos) {
        // Lógica para actualizar una ficha existente en la base de datos
    }

    // Método para eliminar una ficha por su ID
    public function eliminarFicha($id) {
        // Lógica para eliminar una ficha de la base de datos por su ID
    }

    // Método para listar todas las fichas
    static public function ctrMostrarFichas($item, $valor) {
        $tabla = "fichas";
        $respuesta = ModeloFichas::mdlMostrarFichas($tabla, $item, $valor);
        return $respuesta;
        
    }
}

?>