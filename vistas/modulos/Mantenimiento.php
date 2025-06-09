<div class="content-wrapper">
  <!-- Encabezado de la pagina -->
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Mantenimiento</h1>
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
  <!-- fin de encabezado -->

  <!-- Inicio de la tabla -->
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-body">
              <table id="tblMantenimiento" class="table table-bordered table-striped">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Numero de serie</th>
                    <th>Etiqueta</th>
                    <th>Descripcion</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <?php
                  $item = null;
                  $valor = null;
                  $mantenimientos = ControladorMantenimiento::ctrMostrarMantenimientos($item, $valor);
                  // var_dump($mantenimientos);

                  // Verificar si hay resultados
                  if (!empty($mantenimientos) && is_array($mantenimientos)) {
                    foreach ($mantenimientos as $key => $value) {
                      echo '
                        <tr>
                            <td>' . $value["equipo_id"] . '</td>
                            <td>' . $value["numero_serie"] . '</td>
                            <td>' . $value["etiqueta"] . '</td>
                            <td>' . $value["descripcion"] . '</td>
                            <td>
                                <div class="btn-group">
                                    <button class="btn btn-success btn-sm btnFinalizarMantenimiento" 
                                            data-id="' . $value["Id_mantenimiento"] . '">
                                        <i class="fas fa-check"></i> Finalizar
                                    </button>
                                </div>
                            </td>
                        </tr>';
                    }
                  } else {
                    echo '<tr><td colspan="6" class="text-center">No hay equipos en mantenimiento</td></tr>';
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
  <!-- Fin de la tabla -->


  <!-- Modal Finalizar Mantenimiento -->
  <div class="modal fade" id="modalFinalizarMantenimiento">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header bg-info">
          <h5 class="modal-title text-white" id="modalFinalizarMantenimientoLabel">Detalles del Mantenimiento</h5>
          <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body p-0">
          <!-- Información del Equipo (se mantiene igual) -->
          <div class="p-3">
            <!-- ... (contenido original igual) ... -->
          </div>

          <!-- Formulario de Mantenimiento - CAMBIOS CLAVE AQUÍ -->
          <div class="p-3 bg-light">
            <h5 class="border-bottom pb-2">Estado del Mantenimiento</h5>
            <!-- Añadí id al formulario y method post -->
            <form id="formFinalizarMantenimiento" method="post">
              <!-- Campo oculto para equipoId (ESENCIAL) -->
              <input type="hidden" id="equipoId" name="equipoId">

              <!-- El resto se mantiene igual pero asegurando los name correctos -->
              <div class="form-group">
                <label>Nivel de Gravedad:</label>
                <div class="d-flex">
                  <div class="custom-control custom-radio mr-4">
                    <input type="radio" id="sinNovedad" name="gravedad" value="ninguno" class="custom-control-input">
                    <label class="custom-control-label" for="sinNovedad">Sin novedad</label>
                  </div>
                  <div class="custom-control custom-radio mr-4">
                    <input type="radio" id="problemaLeve" name="gravedad" value="leve" class="custom-control-input">
                    <label class="custom-control-label" for="problemaLeve">Problema leve</label>
                  </div>
                  <div class="custom-control custom-radio">
                    <input type="radio" id="problemaGrave" name="gravedad" value="grave" class="custom-control-input">
                    <label class="custom-control-label" for="problemaGrave">Problema grave</label>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label for="tipoMante" class="form-label">Tipo de Mantenimiento:</label>
                <select name="tipoMantenimiento" id="tipoMante" class="form-control custom-select">
                  <option value="" disabled selected>Seleccione el tipo de mantenimiento</option>
                  <option value="preventivo">Preventivo</option>
                  <option value="correctivo">Correctivo</option>
                </select>
              </div>

              <div class="form-group">
                <label for="descripcionProblema">Descripción del problema:</label>
                <textarea class="form-control" id="descripcionProblema" name="detalles" rows="3" required></textarea>
              </div>

              <div class="text-center mt-4">
                <!-- Cambiado a type="submit" para enviar el formulario -->
                <button type="submit" class="btn btn-info px-4" id="btnGuardarMantenimiento">
                  <i class="fas fa-check-circle mr-2"></i>Marcar como Finalizado
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Fin del modal -->

  <!-- Incluir el archivo JavaScript -->
  <script src="vistas/js/mantenimiento.js"></script>
</div>