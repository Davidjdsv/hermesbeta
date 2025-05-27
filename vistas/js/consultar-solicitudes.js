$(document).ready(function() {
    $('#btnBuscarUsuarioConsultar').click(function() {
        $('#resultados').fadeIn();
        $('#userinfo').fadeIn();
    });
});


$(document).on("click", "#btnBuscarUsuarioConsultar", function () {
  cedulaUsuario = $("#cedulaUsuario").val();
  //validar que el campo no esté vacío
  if (cedulaUsuario === "") {
    alert("Por favor, ingrese una cédula.");
    return;
  }
  datos = new FormData();
  datos.append("idSolicitante", cedulaUsuario);
  $.ajax({
    url: "ajax/usuarios.ajax.php",
    method: "POST",
    data: datos,
    cache: false,
    contentType: false,
    processData: false,
    dataType: "json",
    success: function (respuesta) {
      //   console.log("Usuario :",respuesta);
      if (respuesta != "error") {
        $("#userinfo").removeClass("d-none");
        $("#userId").val(respuesta["id_usuario"]);
        $("#userNames").text(respuesta["nombre"]);
        $("#userLastName").text(respuesta["apellido"]);
        $("#userAddress").text(respuesta["direccion"]);
        $("#userPhone").text(respuesta["telefono"]);
        $("#userEmail").text(respuesta["correo_electronico"]);
        $("#userRole").text(respuesta["nombre_rol"]);
      }
      let idUsuario = respuesta["id_usuario"];
      console.log("idUsuario :", idUsuario);
      datos = new FormData();
      datos.append("accion", "mostrarSolicitudes"); 
      datos.append("idUsuario", idUsuario);
      $.ajax({
        url: "ajax/solicitudes.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (prestamos) {
          console.log("Solicitudes :", prestamos);
          if (prestamos != "vacio") {
            //colocamos los datos en el datatable
            $("#tblPrestamosUsuario").DataTable().clear().destroy();
            $("#tblPrestamosUsuario").DataTable({
              data: prestamos,
              columns: [
                { data: "id_prestamo" },
                { data: "tipo_prestamo" },
                { data: "fecha_inicio" },
                { data: "fecha_fin" },
                { data: "estado_prestamo" },
                { data: "motivo" },
                //finalmente la columna de acciones
                {
                  data: null,
                  render: function (row) {
                    return (
                      '<div class="text-center"><div class="btn-group"><button class="btn btn-warning btnVerDetallePrestamo" idPrestamo="' +
                      row.id_prestamo +
                      '" data-toggle="modal" data-target="#modal-detalle" type="button"><i class="fa fa-eye"></i></button></div></div>'
                    );
                  },
                },
              ],
              language: {
                sProcessing: "Procesando...",
                sLengthMenu: "Mostrar _MENU_ registros",
                sZeroRecords: "No se encontraron resultados",
                sEmptyTable: "Ningún dato disponible en esta tabla",
                sInfo:
                  "Mostrando registros del _START_ al _END_ de un total de _TOTAL_",
                sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0",
                sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
                search: "Buscar:",
                paginate: {
                  first: "Primero",
                  last: "Último",
                  next: "Siguiente",
                  previous: "Anterior",
                },
              },
              responsive: true,
              autoWidth: false,
            });
          }
        },
      });
    },
  });
});

//para ver detalle del prestamo
$(document).on("click", ".btnVerDetallePrestamo", function () {
  let idPrestamo = $(this).attr("idPrestamo");
//   console.log("idPrestamo :", idPrestamo);
  datos = new FormData();
  datos.append("accion", "mostrarPrestamo");
  datos.append("idPrestamo", idPrestamo);
  $.ajax({
    url: "ajax/solicitudes.ajax.php",
    method: "POST",
    data: datos,
    cache: false,
    contentType: false,
    processData: false,
    dataType: "json",
    success: function (respuesta) {
    //   console.log("Prestamo :", respuesta);
      $("#numeroPrestamo").text(respuesta["id_prestamo"]);
      $("#detalleTipoPrestamo").text(respuesta["tipo_prestamo"]);
      $("#detalleFechaInicio").text(respuesta["fecha_inicio"]);
      $("#detalleFechaFin").text(respuesta["fecha_fin"]);
      $("#detalleMotivoPrestamo").text(respuesta["motivo"]);
       
      datosDetalle = new FormData();
      datosDetalle.append("accion", "mostrarPrestamoDetalle");
        datosDetalle.append("idPrestamoDetalle", respuesta["id_prestamo"]);
        $.ajax({
          url: "ajax/solicitudes.ajax.php",
          method: "POST",
          data: datosDetalle,
          cache: false,
          contentType: false,
          processData: false,
          dataType: "json",
          success: function (respuestaDetalle) {
            console.log("respuestaDetalle :",respuestaDetalle);
            //colocamos los datos en el datatable
            $("#tblDetallePrestamo").DataTable().clear().destroy();
            $("#tblDetallePrestamo").DataTable({
              data: respuestaDetalle,
              columns: [
                { data: "equipo_id" },
                { data: "categoria" },
                { data: "descripcion" },
                { data: "etiqueta" },
                { data: "numero_serie" },
                { data: "ubicacion" },
              ],
              responsive: true,
              autoWidth: false,      
              scrollX: true,        
              language: {
                sProcessing: "Procesando...",
                sLengthMenu: "Mostrar _MENU_ registros",
                sZeroRecords: "No se encontraron resultados",
                sEmptyTable: "Ningún dato disponible en esta tabla",
                sInfo:
                  "Mostrando registros del _START_ al _END_ de un total de _TOTAL_",
                sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0",
                sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
                search: "Buscar:",
                paginate: {
                  first: "Primero",
                  last: "Último",
                  next: "Siguiente",
                  previous: "Anterior",
                }

              }
            })
          }
        })
    },
  });
});
