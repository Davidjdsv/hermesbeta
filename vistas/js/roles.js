$(document).on("click", ".btnEditarRol", function() {
    var idRol = $(this).attr("idRol");
    var datos = new FormData();
    datos.append("idRol", idRol);
    $.ajax({
        url: "ajax/roles.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(respuesta) {
            $("#nombreEditRol").val(respuesta["nombre_rol"]);
            $("#descripcionEditRol").val(respuesta["descripcion"]);
            $("#idEditRol").val(respuesta["id_rol"]);

            if (parseInt(respuesta["id_rol"]) < 10) {
                $("#nombreEditRol").prop("disabled", true);
                $("#descripcionEditRol").prop("disabled", true);
                $("#btnModificarRol").prop("disabled", true); 
                if ($("#editRolWarning").length === 0) {
                    $("#formEditRol").prepend('<div id="editRolWarning" class="alert alert-warning mt-2">La edición de este rol está bloqueada.</div>');
                }
            } else {
                $("#nombreEditRol").prop("disabled", false);
                $("#descripcionEditRol").prop("disabled", false);
                $("#btnModificarRol").prop("disabled", false); 
                $("#editRolWarning").remove();
            }
        }
    });
});


$(document).on("click", ".btnActivarRol", function() {
    var idRolActivar = $(this).attr("idRol");
    var estadoRol = $(this).attr("estadoRol");
    var datos = new FormData();
    datos.append("idRolActivar", idRolActivar);
    datos.append("estadoRol", estadoRol);
    $.ajax({
        url: "ajax/roles.ajax.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        success: function(respuesta) {
            console.log("cambiado el estado", respuesta);
        }
    })
    if (estadoRol == "inactivo") {
        $(this).removeClass("btn-success");
        $(this).addClass("btn-danger");
        $(this).html('Inactivo');
        $(this).attr("estadoRol", "activo");
    }else {
        $(this).removeClass("btn-danger");
        $(this).addClass("btn-success");
        $(this).html('Activo');
        $(this).attr("estadoRol", "inactivo");
    }
});

$(document).on("click", ".btnEliminarRol", function() {
    var idRol = $(this).attr("idRol");
    Swal.fire({
        title: '¿Estás seguro?',
        text: "¡Esta acción no se puede deshacer!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, inhabilitar el rol',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            var datos = new FormData();
            datos.append("idRolEliminar", idRol);
            $.ajax({
                url: "ajax/roles.ajax.php",
                method: "POST",
                data: datos,
                cache: false,
                contentType: false,
                processData: false,
                success: function(respuesta) {
                    Swal.fire('Inhabilitado', 'El rol ha sido inhabilitado.', 'success').then(()=>{
                        location.reload();
                    });
                }
            });
        }
    });
});