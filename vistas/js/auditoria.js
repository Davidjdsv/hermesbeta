let tablaAuditoria;

$(document).ready(function () {
  // Inicializa la tabla con DataTables cuando el documento está listo
  tablaAuditoria = $('#tablaAuditoria').DataTable({
    // Fuente de datos vía AJAX
    ajax: {
      url: "ajax/auditoria.ajax.php", // URL del archivo PHP que devuelve los datos de auditoría
      dataSrc: "data" // Campo dentro del JSON devuelto que contiene los datos reales
    },

    // Define las columnas que se mostrarán en la tabla
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

      // Columna de foto del usuario
      {
        data: "foto",
        title: "Foto",
        render: function (data) {
          if (data && data.trim() !== "") {
            // Si hay una foto, se muestra la imagen correspondiente
            return `<img src="${data}" style="width:40px;height:40px;border-radius:50%" alt="Foto Usuario">`;
          } else {
            // Si no hay foto, se muestra una imagen por defecto
            return `<img src="vistas/img/usuarios/default/anonymous.png" style="width:40px;height:40px;border-radius:50%" alt="Sin foto">`;
          }
        }
      },

      { data: "estado", title: "Estado" },
      { data: "condicion", title: "Condición" },
      { data: "fecha_registro", title: "Fecha Registro" },

      // Columna para mostrar quién editó
      {
        data: "nombre_editor",
        title: "Editado Por",
        render: function(data) {
          // Si el campo está vacío, se muestra "Sistema"
          return data && data.trim() !== '' ? data : 'Sistema';
        }
      },

      // Campos modificados (puede venir como arreglo o cadena)
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

      // Valores anteriores antes de la modificación
      {
        data: "valor_anterior",
        title: "Valores Anteriores",
        render: function(data) {
          if (Array.isArray(data)) {
            // Si algún valor es null o vacío, se muestra un guión
            return data.map(v => v || '-').join(", ");
          }
          return data || '-';
        }
      },

      // Valores nuevos después de la modificación
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

      { data: "fecha_cambio", title: "Fecha Cambio" }, // Fecha en que se hizo el cambio
    ],

    responsive: true, // Hace la tabla adaptable a pantallas pequeñas
    dom: 'Bfrtip', // Define la posición de los botones de exportación
    buttons: ['copy', 'csv', 'excel', 'pdf', 'print'], // Botones para exportar

    // Traducción al español
    language: {
      url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
    },

    order: [[18, 'desc']], // Ordena por la columna "fecha_cambio" en orden descendente
    pageLength: 10 // Muestra 10 filas por página
  });
});

// Función auxiliar para recargar los datos de la tabla sin recargar la página
function recargarTablaAuditoria() {
  if (tablaAuditoria) {
    tablaAuditoria.ajax.reload(null, false); // false evita que se reinicie la paginación
  }
}
