$(document).ready(function() {
    // Cuando se hace clic en el botón Ver
    $('.btnVerUsuario').click(function() {
        var idPrestamo = $(this).attr('data-id');

        // Realizar petición AJAX
        $.ajax({
            url: "ajax/devoluciones.ajax.php",
            method: "POST",
            data: {
                idPrestamo: idPrestamo
            },
            dataType: "json",
            success: function(respuesta) {
                if(respuesta && respuesta.length > 0) {
                    var datosPrestamo = respuesta[0];

                    // Imagen y datos básicos del usuario
                    $('#userImage').attr('src', datosPrestamo.foto ? datosPrestamo.foto : 'vistas/img/usuarios/default/anonymous.png');
                    $('#userName').text(datosPrestamo.nombre + ' ' + datosPrestamo.apellido);
                    $('#userRol').text(datosPrestamo.nombre_rol || 'No especificado');
                    $('#userName').text(datosPrestamo.nombre_usuario + ' ' + datosPrestamo.apellido_usuario);
                    $('#userRol').text(datosPrestamo.nombre_rol || 'No especificado'); // Updated to use nombre_rol

                    // Información del préstamo
                    $('#prestamoIdentificacion').text(datosPrestamo.numero_documento || 'No disponible');
                    $('#prestamoNombre').text(datosPrestamo.nombre_usuario || 'No disponible');
                    $('#prestamoApellido').text(datosPrestamo.apellido_usuario || 'No disponible');
                    $('#prestamoTelefono').text(datosPrestamo.telefono || 'No disponible');
                    $('#prestamoFicha').text(datosPrestamo.ficha_codigo || 'No asignada');
                    $('#prestamoTipo').text(datosPrestamo.tipo_prestamo || 'No especificado');
                    $('#prestamoFechaInicio').text(datosPrestamo.fecha_inicio || 'No especificada');
                    $('#prestamoFechaFin').text(datosPrestamo.fecha_fin || 'No especificada');
                    $('#prestamoEstado').text(datosPrestamo.estado_prestamo || 'No especificado');

                    // Información de los equipos en una tabla
                    var equiposTableHtml = `
                        <table class="table table-bordered table-striped dt-responsive tablaDevolucionesEquipos" width="100%">
                            <thead>
                                <tr>
                                    <th>Categoría</th>
                                    <th>Marca</th>
                                    <th>Placa</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                    `;

                    respuesta.forEach(function(equipo) {
                        equiposTableHtml += `
                            <tr>
                                <td>${equipo.categoria_nombre || 'No disponible'}</td>
                                <td>${equipo.marca_equipo || 'No disponible'}</td> 
                                <td>${equipo.placa_equipo || 'No disponible'}</td>
                                <td class="equipo-buttons-container">`;

                        // Lógica para mostrar los botones de devolución según el tipo de préstamo
                        if (datosPrestamo.tipo_prestamo === 'Inmediato') {
                            equiposTableHtml += `
                                <button type="button" class="btn btn-success btn-sm btn-devolver-equipo mr-1" data-prestamo-id="${datosPrestamo.id_prestamo}" data-equipo-id="${equipo.equipo_id}" data-estado="buen_estado">
                                    <i class="fas fa-check-circle"></i> B. Estado
                                </button>
                                <button type="button" class="btn btn-danger btn-sm btn-devolver-equipo" data-prestamo-id="${datosPrestamo.id_prestamo}" data-equipo-id="${equipo.equipo_id}" data-estado="mal_estado">
                                    <i class="fas fa-times-circle"></i> M. Estado
                                </button>
                            `;
                        } else if (datosPrestamo.tipo_prestamo === 'Reservado') {
                            equiposTableHtml += `
                                <button type="button" class="btn btn-info btn-sm btn-devolver-equipo" data-prestamo-id="${datosPrestamo.id_prestamo}" data-equipo-id="${equipo.equipo_id}" data-estado="devuelto">
                                    <i class="fas fa-undo-alt"></i> Devolver
                                </button>
                                <button type="button" class="btn btn-danger btn-sm btn-devolver-equipo" data-prestamo-id="${datosPrestamo.id_prestamo}" data-equipo-id="${equipo.equipo_id}" data-estado="robado">
                                    <i class="fas fa-times-circle"></i> Robado
                                </button>
                            `;
                        }
                        equiposTableHtml += `</td></tr>`;
                    });

                    equiposTableHtml += `
                            </tbody>
                        </table>
                    `;
                    
                    $('#equiposListContainer').html(equiposTableHtml);
                    $('#modalVerDetallesPrestamo').modal('show');

                } else {
                    alert("No se encontraron datos de equipos para este préstamo.");
                    $('#equiposListContainer').html('<p>No hay equipos asociados a este préstamo.</p>');
                }
            },
            error: function(xhr, status, error) {
                console.error("Error en la petición AJAX:", error);
                alert("Error al cargar los datos del préstamo");
            }
        });
    });

    // Delegación de eventos para los botones de devolución
    $(document).on('click', '.equipo-buttons-container .btn-devolver-equipo', function() {
        var prestamoId = $(this).attr('data-prestamo-id');
        var equipoId = $(this).attr('data-equipo-id');
        var estado = $(this).attr('data-estado');
        var $buttonPressed = $(this);

        console.log("Botón de devolución clickeado - Préstamo:", prestamoId, "Equipo:", equipoId, "Estado:", estado);

        // 1. Caso para "Mal Estado" (abre modal)
        if (estado === 'mal_estado') {
            $('#malEstadoPrestamoId').val(prestamoId);
            $('#malEstadoEquipoId').val(equipoId);
            $('#modalMalEstado').modal('show');
        } 
        // 2. Caso para "Devolver" (Reservado -> Mantenimiento)
        else if (estado === 'devuelto') {
            $.ajax({
                url: "ajax/devoluciones.ajax.php", 
                method: "POST",
                data: {
                    accion: "marcarMantenimientoDetalle", 
                    idPrestamo: prestamoId,
                    idEquipo: equipoId
                },
                dataType: "json",
                success: function(respuesta) {
                    if (respuesta && respuesta.success) { 
                        Swal.fire({
                            icon: "success",
                            title: respuesta.title || "¡Acción completada!",
                            text: respuesta.message,
                            showConfirmButton: false,
                            timer: 2000
                        }).then(() => {
                            $buttonPressed.closest('tr').fadeOut(500, function() {
                                $(this).remove();
                                if ($('#equiposListContainer tbody tr').length === 0) {
                                    $('#equiposListContainer').html('<p class="text-center">Todos los equipos de este préstamo han sido procesados.</p>');
                                    if (respuesta.status === "ok_prestamo_actualizado") {
                                        $('#modalVerDetallesPrestamo').modal('hide');
                                        if (typeof tablaDevoluciones !== 'undefined') {
                                            tablaDevoluciones.ajax.reload();
                                        } else {
                                            window.location.reload(); 
                                        }
                                    }
                                }
                            });
                        });
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "Error al marcar para mantenimiento",
                            text: (respuesta && respuesta.message) || "Hubo un problema al procesar la solicitud."
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error en la petición AJAX:", error);
                    Swal.fire({
                        icon: "error",
                        title: "Error de comunicación",
                        text: "No se pudo comunicar con el servidor."
                    });
                }
            });
        }
        // 3. Caso para "Buen Estado" (Inmediato -> Disponible)
        else if (estado === 'buen_estado') {
            $.ajax({
                url: "ajax/devoluciones.ajax.php",
                method: "POST",
                data: {
                    accion: "marcarBuenEstado",
                    idPrestamo: prestamoId,
                    idEquipo: equipoId
                },
                dataType: "json",
                success: function(respuesta) {
                    if (respuesta && respuesta.success) {
                        Swal.fire({
                            icon: "success",
                            title: "¡Equipo devuelto!",
                            text: respuesta.message,
                            showConfirmButton: false,
                            timer: 2000
                        }).then(() => {
                            $buttonPressed.closest('tr').fadeOut(500, function() {
                                $(this).remove();
                                if ($('#equiposListContainer tbody tr').length === 0) {
                                    $('#equiposListContainer').html('<p class="text-center">Todos los equipos de este préstamo han sido procesados.</p>');
                                    if (respuesta.status === "ok_prestamo_actualizado") {
                                        $('#modalVerDetallesPrestamo').modal('hide');
                                        if (typeof tablaDevoluciones !== 'undefined') {
                                            tablaDevoluciones.ajax.reload();
                                        } else {
                                            window.location.reload();
                                        }
                                    }
                                }
                            });
                        });
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "Error al devolver equipo",
                            text: (respuesta && respuesta.message) || "Hubo un problema al procesar la solicitud."
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error en la petición AJAX:", error);
                    Swal.fire({
                        icon: "error",
                        title: "Error de comunicación",
                        text: "No se pudo comunicar con el servidor."
                    });
                }
            });
        }
        // 4. Caso para "Robado"
        else if (estado === 'robado') {
            $.ajax({
                url: "ajax/devoluciones.ajax.php",
                method: "POST",
                data: {
                    accion: "marcarEquipoRobado",
                    idPrestamo: prestamoId,
                    idEquipo: equipoId
                },
                dataType: "json",
                success: function(respuesta) {
                    if (respuesta && respuesta.success) {
                        Swal.fire({
                            icon: "success",
                            title: respuesta.title || "¡Acción completada!",
                            text: respuesta.message,
                            showConfirmButton: false,
                            timer: 2000
                        }).then(() => {
                            $buttonPressed.closest('tr').fadeOut(500, function() {
                                $(this).remove();
                                if ($('#equiposListContainer tbody tr').length === 0) {
                                    $('#equiposListContainer').html('<p class="text-center">Todos los equipos de este préstamo han sido procesados.</p>');
                                    if (respuesta.status === "ok_prestamo_actualizado") {
                                        $('#modalVerDetallesPrestamo').modal('hide');
                                        if (typeof tablaDevoluciones !== 'undefined') {
                                            tablaDevoluciones.ajax.reload();
                                        } else {
                                            window.location.reload();
                                        }
                                    }
                                }
                            });
                        });
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "Error al marcar como robado",
                            text: (respuesta && respuesta.message) || "Hubo un problema al procesar la solicitud."
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error en la petición AJAX:", error);
                    Swal.fire({
                        icon: "error",
                        title: "Error de comunicación",
                        text: "No se pudo comunicar con el servidor."
                    });
                }
            });
        }
    });

    // Evento para el botón "Guardar Motivo y Enviar a Mantenimiento" (VERSIÓN MEJORADA)
    $(document).on('click', '#btnGuardarMalEstado', function() {
        var prestamoId = $('#malEstadoPrestamoId').val();
        var equipoId = $('#malEstadoEquipoId').val();
        var motivo = $('#motivoMalEstado').val().trim();
        
        // Validación del motivo
        if(motivo === '') {
            Swal.fire({
                icon: 'error',
                title: 'Campo requerido',
                text: 'Por favor describe el problema o motivo del mantenimiento',
                didOpen: () => {
                    $('#motivoMalEstado').addClass('is-invalid').focus();
                }
            });
            return;
        }

        // Mostrar indicador de carga
        const boton = $(this);
        const textoOriginal = boton.html();
        boton.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Procesando...');

        // Enviar petición AJAX
        $.ajax({
            url: "ajax/devoluciones.ajax.php",
            method: "POST",
            data: {
                accion: "marcarMantenimientoConMotivo",
                idPrestamo: prestamoId,
                idEquipo: equipoId,
                motivo: motivo
            },
            dataType: "json",
            success: function(respuesta) {
                if(respuesta && respuesta.success) {
                    // Resetear el formulario
                    $('#formMalEstado')[0].reset();
                    
                    Swal.fire({
                        icon: "success",
                        title: respuesta.status === "ok_prestamo_actualizado" 
                            ? "¡Préstamo completado!" 
                            : "¡Equipo en mantenimiento!",
                        text: respuesta.message,
                        showConfirmButton: false,
                        timer: 2000
                    }).then(() => {
                        $('#modalMalEstado').modal('hide');
                        
                        // Eliminar la fila del equipo procesado
                        const filaEquipo = $(`button[data-prestamo-id="${prestamoId}"][data-equipo-id="${equipoId}"]`).closest('tr');
                        filaEquipo.fadeOut(400, function() {
                            $(this).remove();
                            
                            // Actualizar la interfaz si no hay más equipos
                            if ($('#equiposListContainer tbody tr').length === 0) {
                                $('#equiposListContainer').html(
                                    '<div class="alert alert-info text-center">' +
                                    'Todos los equipos han sido procesados</div>'
                                );
                                
                                if (respuesta.status === "ok_prestamo_actualizado") {
                                    setTimeout(() => {
                                        $('#modalVerDetallesPrestamo').modal('hide');
                                        if (typeof tablaDevoluciones !== 'undefined') {
                                            tablaDevoluciones.ajax.reload(null, false);
                                        }
                                    }, 500);
                                }
                            }
                        });
                    });
                } else {
                    let errorMsg = "Hubo un problema al procesar la solicitud.";
                    if (respuesta && respuesta.message) {
                        errorMsg = respuesta.message;
                    } else if (!respuesta) {
                        errorMsg = "No se recibió respuesta del servidor.";
                    }
                    
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        html: `<p>${errorMsg}</p><small>Intente nuevamente o contacte al administrador</small>`,
                        confirmButtonText: "Entendido"
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error("Error en la petición AJAX:", error, xhr.responseText);
                Swal.fire({
                    icon: "error",
                    title: "Error de conexión",
                    text: "No se pudo completar la operación. Detalle: " + (xhr.responseText || error),
                    confirmButtonText: "Reintentar"
                });
            },
            complete: function() {
                boton.prop('disabled', false).html(textoOriginal);
            }
        });
    });
});

/*=============================================            
Marcar equipo como devuelto (función alternativa)
=============================================*/
$(".tablaDevoluciones tbody").on("click", ".btnMarcarDevuelto", function(){
    var idDetallePrestamo = $(this).attr("idDetallePrestamo");
    var idPrestamo = $(this).attr("idPrestamo");

    Swal.fire({
        title: '¿Está seguro de marcar este equipo como devuelto?',
        text: "¡Si no lo está puede cancelar la acción!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, marcar devuelto!',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            var datos = new FormData();
            datos.append("idDetallePrestamoMarcar", idDetallePrestamo);
            datos.append("idPrestamoMarcar", idPrestamo);

            $.ajax({
                url: "ajax/devoluciones.ajax.php",
                method: "POST",
                data: datos,
                cache: false,
                contentType: false,
                processData: false,
                dataType: "json",
                success: function(respuesta){
                    console.log("Respuesta AJAX:", respuesta);
                    if(respuesta && respuesta.status == "success_prestamo_actualizado"){
                        Swal.fire(
                            '¡Hecho!',
                            'El equipo ha sido marcado como devuelto y el préstamo ha sido actualizado.',
                            'success'
                        ).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "devoluciones";
                            }
                        });
                    } else if (respuesta && respuesta.status == "success"){
                        Swal.fire(
                            '¡Hecho!',
                            'El equipo ha sido marcado como devuelto.',
                            'success'
                        ).then((result) => {
                            if (result.isConfirmed) {
                                window.location = "devoluciones";
                            }
                        });
                    } else if (respuesta && respuesta.status == "no_change"){
                        Swal.fire(
                            'Información',
                            'No se realizaron cambios en el estado del equipo.',
                            'info'
                        );
                    } else if (respuesta && respuesta.status == "error_actualizando_prestamo"){
                        Swal.fire(
                            'Error',
                            'El equipo fue marcado como devuelto, pero hubo un error al actualizar el estado del préstamo.',
                            'error'
                        );
                    } else {
                        Swal.fire(
                            'Error',
                            (respuesta && respuesta.message) || 'Respuesta desconocida del servidor.',
                            'error'
                        );
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Error en AJAX: ", textStatus, errorThrown);
                    Swal.fire(
                        'Error de Comunicación',
                        'No se pudo conectar con el servidor: ' + textStatus,
                        'error'
                    );
                }
            });
        }
    });
});