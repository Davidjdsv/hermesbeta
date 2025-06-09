$(document).ready(function() {
    // Función para cambiar el estado del préstamo
    window.cambiarEstado = function(boton, idPrestamo, estadoActual) {
        let nuevoEstado;
        
        // Determinar el siguiente estado
        switch(estadoActual) {
            case "En Trámite":
                nuevoEstado = "En Préstamo";
                break;
            case "En Préstamo":
                nuevoEstado = "Aprobado";
                break;
            case "Aprobado":
                nuevoEstado = "En Trámite";
                break;
            default:
                nuevoEstado = "En Trámite";
        }

        $.ajax({
            url: "ajax/prestamos.ajax.php",
            method: "POST",
            data: {
                idPrestamo: idPrestamo,
                nuevoEstado: nuevoEstado,
                accion: "cambiarEstado"
            },
            success: function(respuesta) {
                if(respuesta === "ok") {
                    // Actualizar el estado visual del botón
                    actualizarEstadoBoton(boton, nuevoEstado);
                    
                    // Actualizar el texto del estado en la tabla
                    $(boton).closest('tr').find('td:eq(5)').text(nuevoEstado);
                    
                    // Actualizar el texto y el data-estado del botón
                    $(boton).text(nuevoEstado);
                    $(boton).attr('data-estado', nuevoEstado);
                    
                    Swal.fire({
                        icon: 'success',
                        title: '¡Estado actualizado!',
                        text: 'El estado del préstamo ha sido actualizado correctamente',
                        showConfirmButton: false,
                        timer: 1500
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Hubo un error al actualizar el estado',
                        confirmButtonText: 'Cerrar'
                    });
                }
            }
        });
    }

    function actualizarEstadoBoton(boton, nuevoEstado) {
        // Remover todas las clases de estado
        $(boton).removeClass('btn-warning btn-success btn-info');
        
        // Aplicar la clase correspondiente según el nuevo estado
        switch(nuevoEstado) {
            case 'En Trámite':
                $(boton).addClass('btn-warning');
                break;
            case 'En Préstamo':
                $(boton).addClass('btn-success');
                break;
            case 'Aprobado':
                $(boton).addClass('btn-info');
                break;
        }
    }

    // Event listener para los botones de estado
    $(document).on('click', '.btnEstado', function() {
        var idPrestamo = $(this).data('id');
        var nuevoEstado = $(this).data('estado');
        cambiarEstadoPrestamo(this, idPrestamo, nuevoEstado);
    });
});