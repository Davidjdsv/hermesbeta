$(document).ready(function() {
  // Cuando se hace clic en el botón de finalizar mantenimiento
  $(".btnFinalizarMantenimiento").click(function(){
    var idMantenimiento = $(this).attr("data-id");
    var fila = $(this).closest("tr");
    var equipoId = fila.find("td:eq(0)").text(); // Asume que el ID está en la primera columna
    
    // Llenar datos en el modal
    $("#equipoId").val(equipoId); // ESENCIAL para el insert
    $("#equipoSerie").text(fila.find("td:eq(1)").text());
    $("#equipoEtiqueta").text(fila.find("td:eq(2)").text());
    $("#equipoDescripcion").text(fila.find("td:eq(3)").text());
    
    $("#modalFinalizarMantenimiento").modal("show");
  });

  // Manejar envío del formulario
  $("#formFinalizarMantenimiento").on("submit", function(e){
    e.preventDefault();
    
    var formData = new FormData(this);
    
    $.ajax({
      url: "ajax/mantenimiento.ajax.php",
      method: "POST",
      data: formData,
      processData: false,
      contentType: false,
      success: function(respuesta){
        if(respuesta == "ok"){
          Swal.fire({
            icon: "success",
            title: "¡Mantenimiento Registrado!",
            showConfirmButton: false,
            timer: 1500
          }).then(function(){
            location.reload(); // Recargar para ver los cambios
          });
        } else {
          Swal.fire("Error", "No se pudo registrar el mantenimiento", "error");
        }
      }
    });
  });
});