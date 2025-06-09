<div class="content-wrapper">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Devoluciones</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item active">inicio</li>
          </ol>
        </div>
      </div>
    </div>
  </section>

  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-body">
              <table id="tblDevoluciones" class="table table-bordered table-striped">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Identificación</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Telefono</th>
                    <th>Fecha de Inicio</th>
                    <th>Fecha de Devolución</th>
                    <th>Tipo de Préstamo</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <?php

                  $item = null;
                  $valor = null;
                  $devoluciones = ControladorDevoluciones::ctrMostrarDevoluciones($item, $valor);

                  foreach ($devoluciones as $key => $value) {
                    echo '
                    <tr>
                      <td>' . ($key + 1) . '</td>
                      <td>' . $value["numero_documento"] . '</td>
                      <td>' . $value["nombre_usuario"] . '</td>
                      <td>' . $value["apellido_usuario"] . '</td>
                      <td>' . $value["telefono"] . '</td>
                      <td>' . $value["fecha_inicio"] . '</td>
                      <td>' . $value["fecha_fin"] . '</td>
                      <td>' . $value["tipo_prestamo"] . '</td>
                      <td>
                        <div class="btn-group">';
                    // Modificamos para usar una sola modal y pasar el ID del préstamo
                    echo '<button class="btn btn-info btn-sm btnVerUsuario" data-id="' . $value["id_prestamo"] . '" data-toggle="modal" data-target="#modalVerDetallesPrestamo">
                                    <i class="fas fa-eye"></i> Ver
                                  </button>';
                    echo '</div>
                      </td>
                    </tr>';
                  }
                  ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

<!-- Modal Ver Detalles del Préstamo (Inmediatos y de Reserva) "Modal consolidada" -->
<div class="modal fade" id="modalVerDetallesPrestamo" tabindex="-1" role="dialog" aria-labelledby="modalVerUsuarioLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-info">
        <h5 class="modal-title" id="modalVerUsuarioLabel">Detalles de la Devolución</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <!-- Información del Usuario -->
          <div class="col-md-4 text-center">
            <img class="img-circle elevation-2 mb-3" id="userImage" src="vistas/img/usuarios/default/anonymous.png" alt="User Image" style="width: 120px; height: 120px;">
            <h4 id="userName">Nombre del Usuario</h4>
            <p class="text-muted" id="userRol">Rol</p>
          </div>

          <!-- Detalles del Préstamo -->
          <div class="col-md-8">
            <div class="card card-outline card-info">
              <div class="card-header">
                <h3 class="card-title">Información del Préstamo</h3>
              </div>
              <div class="card-body">
                <div class="row">
                  <div class="col-md-6">
                    <table class="table table-sm">
                      <tbody class="info-prestamo">
                        <tr>
                          <th style="width: 40%">Identificación:</th>
                          <td><span id="prestamoIdentificacion"></span></td>
                        </tr>
                        <tr>
                          <th>Nombre:</th>
                          <td><span id="prestamoNombre"></span></td>
                        </tr>
                        <tr>
                          <th>Apellido:</th>
                          <td><span id="prestamoApellido"></span></td>
                        </tr>
                        <tr>
                          <th>Teléfono:</th>
                          <td><span id="prestamoTelefono"></span></td>
                        </tr>
                        <tr>
                          <th>Ficha:</th>
                          <td><span id="prestamoFicha"></span></td>
                        </tr>
                        <tr>
                          <th>Tipo de Préstamo:</th>
                          <td><span id="prestamoTipo"></span></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div class="col-md-6">
                    <table class="table table-sm">
                      <tbody class="info-prestamo-2">
                        <tr>
                          <th style="width: 40%">Fecha de Inicio:</th>
                          <td><span id="prestamoFechaInicio"></span></td>
                        </tr>
                        <tr>
                          <th>Fecha de Devolución:</th>
                          <td><span id="prestamoFechaFin"></span></td>
                        </tr>
                        <tr>
                          <th>Estado:</th>
                          <td><span id="prestamoEstado"></span></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <!-- Detalles del Equipo -->  
          </div>
        </div>
        <div class="card card-header  card-success">
          <h3 class="card-title">Equipos en Préstamo</h3>
        </div>
        <div id="equiposListContainer">
          <!-- Aquí se cargarán los detalles de cada equipo individualmente con JavaScript -->
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal para registrar motivo de mal estado -->
<div class="modal fade" id="modalMalEstado">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h4 class="modal-title">Registrar Motivo de Mal Estado</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="formMalEstado">
          <input type="hidden" id="malEstadoPrestamoId">
          <!-- Necesitaremos el ID del equipo específico -->
          <input type="hidden" id="malEstadoEquipoId">
          <div class="form-group">
            <label for="motivoMalEstado">Describe el motivo del mal estado:</label>
            <textarea class="form-control" id="motivoMalEstado" rows="4" required></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-danger" id="btnGuardarMalEstado">Guardar Motivo y Enviar a Mantenimiento</button>
      </div>
    </div>
  </div>
</div>