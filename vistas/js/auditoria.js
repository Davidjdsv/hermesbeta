let tablaAuditoria;


$(document).ready(function() {
    tablaAuditoria = $('#tablaAuditoria').DataTable({
        ajax: {
            url: "ajax/auditoria.ajax.php",
            dataSrc: "data"
        },
        columns: [
            { data: "id_usuario", title: "ID Usuario" },
            { data: "tipo_documento", title: "Tipo Doc." },
            { data: "numero_documento", title: "Número Doc." },
            { data: "nombre", title: "Nombre" },
            { data: "apellido", title: "Apellido" },
            { data: "correo_electronico", title: "Correo" },
            { data: "nombre_usuario", title: "Usuario" },
            { data: "telefono", title: "Teléfono" },
            { data: "direccion", title: "Dirección" },
            { data: "genero", title: "Género" },
            {

                data: "foto",
                title: "Foto",
                render: function(data) {
                    if (data && data.trim() !== "") {
                        // data ya es ruta completa, úsala tal cual
                        return `<img src="${data}" style="width:40px;height:40px;border-radius:50%" alt="Foto Usuario">`;
                    } else {
                        // ruta fija a imagen por defecto
                        return `<img src="vistas/img/usuarios/default/anonymous.png" style="width:40px;height:40px;border-radius:50%" alt="Sin foto">`;
                    }
                }
            },
            { data: "estado", title: "Estado" },
            { data: "condicion", title: "Condición" },
            { data: "fecha_registro", title: "Fecha Registro" },
            {
                data: "nombre_editor",
                title: "Editado Por",
                render: function(data) {
                    return data && data.trim() !== '' ? data : 'Sistema';
                }
            },
            {
                data: "campo_modificado",
                title: "Campos Modificados",
                render: function(data) {
                    if (Array.isArray(data)) {
                        return data.join(", ");
                    }
                    return data;
                }
            },
            {
                data: "valor_anterior",
                title: "Valores Anteriores",
                render: function(data) {
                    if (Array.isArray(data)) {
                        return data.map(v => v || '-').join(", ");
                    }
                    return data || '-';
                }
            },
            {
                data: "valor_nuevo",
                title: "Valores Nuevos",
                render: function(data) {
                    if (Array.isArray(data)) {
                        return data.map(v => v || '-').join(", ");
                    }
                    return data || '-';
                }
            },
            { data: "fecha_cambio", title: "Fecha Cambio" },
        ],
        responsive: true,
        dom: 'Bfrtip',
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        language: {
            url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
        },
        order: [
            [18, 'asc']
        ], // Ordenar por fecha_cambio descendente
        pageLength: 10
    });
});

// Función para recargar tabla si necesitas
function recargarTablaAuditoria() {
    if (tablaAuditoria) {
        tablaAuditoria.ajax.reload(null, false);
    }
}