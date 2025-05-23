  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Inventario</h1>
          </div>
          <div class="col-sm-6">
            <button class="btn btn-primary float-right" data-toggle="modal" data-target="#modalRegistrarEquipo">Agregar equipo</button>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="card">
        <!-- /.card-header -->
        <div class="card-body">
          <table id="tblEquipos" class="table table-bordered table-striped table-hover">
            <thead class="bg-dark">
              <tr>
                <th>Id Equipo</th>
                <th>N# Serie</th>
                <th>Etiqueta</th>
                <th>Descripción</th>
                <th>Ubicación</th>
                <th>Categoría</th>
                <th>Cuentadante</th>
                <th>Estado</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <?php

              $item = null;
              $valor = null;
              $equipos = ControladorEquipos::ctrMostrarEquipos($item, $valor);

              foreach ($equipos as $key => $equipo) {
                echo '<tr>';
                echo '<td>' . ($key + 1) . '</td>';
                echo '<td>' . $equipo['numero_serie']    . '</td>';
                echo '<td>' . $equipo['etiqueta']        . '</td>';
                echo '<td>' . $equipo['descripcion']     . '</td>';
                echo '<td>' . $equipo['ubicacion_nombre']    . '</td>';
                echo '<td>' . $equipo['categoria_nombre']    . '</td>';
                echo '<td>' . $equipo['cuentadante_nombre']      . '</td>';
                echo '<td>' . $equipo['estado_nombre']      . '</td>';
                // Botón de acciones
                echo '<td>
                        <div class="btn-group">
                          <button title="Editar datos equipo" class="btn btn-default btn-xs btnEditarEquipo bg-warning" idEquipo="' . $equipo["equipo_id"] . '" data-toggle="modal" data-target="#modalEditarEquipo"><i class="fas fa-edit  mr-1 ml-1"></i></button>
                          <button title="Traspaso de cuentadante" class="btn btn-default btn-xs btnTraspasarEquipo ml-2 bg-success" idEquipoTraspaso="' . $equipo["equipo_id"] . '" data-toggle="modal" data-target="#modalTraspaso"><i class="fas fa-share mr-1 ml-1"></i></button>
                          <button title="Traspaso de ubicación" class="btn btn-default btn-xs btnTraspasarUbicacion ml-2 bg-info" idEquipoTraspasoUbicacion="' . $equipo["equipo_id"] . '" data-toggle="modal" data-target="#modalTraspasoUbicacion"><i class="fas fa-map-pin mr-1 ml-1"></i></button>
                        </div>
                        </td>';
                echo '</tr>';
              }
              ?>
            </tbody>
          </table>
        </div>
        <!-- /.card-body -->
      </div>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- ========== Start Section ==========
  MODAL PARA INGRESAR EQUIPO
  ========== End Section ========== -->

  <div class="modal fade" id="modalRegistrarEquipo">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-blue">
          <h4 class="modal-title">Agregar equipo</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form method="post">
            <div class="form-row">
              <div class="form-group col-lg-6">
                <label for="numeroSerie">#Número Serie</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                  </div>
                  <input type="text" class="form-control" id="numeroSerie" name="numero_serie" placeholder="Ej:00ks32.." required>
                </div>
              </div>
              <div class="form-group col-lg-6">
                <label for="etiqueta">Etiqueta</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-tag"></i></span>
                  </div>
                  <input type="text" class="form-control" id="etiqueta" name="etiqueta" placeholder="Ej:0022338..." required>
                </div>
              </div>
            </div>
            <div class="form-group col-lg-12">
              <label for="descripcion">Descripción</label>
              <textarea class="form-control" id="descripcion" name="descripcion" placeholder="Ej: El equipo se encuentra en perfecto estado..." rows="3" required></textarea>
            </div>
            <div class="form-row">
              <div class="form-group col-lg-6">
                <label for="ubicacion_id">Ubicación</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                  </div>
                  <?php
                  $item = null;
                  $valor = null;
                  $ubicaciones = ControladorUbicaciones::ctrMostrarUbicaciones($item, $valor);
                  echo '<select class="form-control" id="ubicacion_id" name="ubicacion_id" required>';
                  echo '<option value="">Seleccione una ubicación</option>';
                  foreach ($ubicaciones as $key => $ubicacion) {
                    echo '<option value="' . $ubicacion["ubicacion_id"] . '">' . $ubicacion["nombre"] . '</option>';
                  }
                  echo '</select>';
                  ?>
                </div>
              </div>
              <div class="form-group col-lg-6">
                <label for="categoria_id">Categoría</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-list-alt"></i></span>
                  </div>
                  <?php
                  $item = null;
                  $valor = null;
                  $categorias = ControladorCategorias::ctrMostrarCategorias($item, $valor);
                  echo '<select class="form-control" id="categoria_id" name="categoria_id" required>';
                  echo '<option value="">Seleccione una categoría</option>';
                  foreach ($categorias as $key => $categoria) {
                    echo '<option value="' . $categoria["categoria_id"] . '">' . $categoria["nombre"] . '</option>';
                  }
                  echo '</select>';
                  ?>
                </div>
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-lg-6">
                <label for="cuentadante_id">Cuentadante</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                  </div>
                  <?php
                  $item = null;
                  $valor = null;
                  $usuarios = ControladorUsuarios::ctrMostrarUsuarios($item, $valor);
                  echo '<select class="form-control" id="id_usuario" name="cuentadante_id" required>';
                  echo '<option value="">Seleccione una ubicación</option>';
                  foreach ($usuarios as $key => $usuario) {
                    if ($usuario["nombre_rol"] != "Aprendiz") {
                      echo '<option value="' . $usuario["id_usuario"] . '">' . $usuario["nombre"] . " " . "(" . $usuario["nombre_rol"] . ")" . '</option>';
                    }
                  }
                  echo '</select>';
                  ?>
                </div>
              </div>

              <div class="form-group col-lg-6">
                <label for="id_estado">Estado</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-info-circle"></i></span>
                  </div>
                  <?php
                  $item = null;
                  $valor = null;
                  $estados = ControladorEstados::ctrMostrarEstados($item, $valor);
                  echo '<select class="form-control" id="id_estado" name="id_estado">';
                  echo '<option value="">Seleccione un estado</option>';
                  foreach ($estados as $key => $estado) {
                    echo '<option value="' . $estado["id_estado"] . '">' . $estado["estado"] . '</option>';
                  }
                  echo '</select>';
                  ?>
                </div>
              </div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
              <button type="submit" class="btn btn-primary">Guardar</button>
            </div>
            <?php
            // $item = null; NO SON NECESARIAS YA QUE SE ESTÁ CREANDO A A PARTIR DED ALGO NUEVO
            // $valor = null;
            ControladorEquipos::ctrAgregarEquipos();
            //exit;
            ?>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- ========== Start Section ==========
  MODAL PARA EDITAR EQUIPO
  ========== End Section ========== -->

  <div class="modal fade" id="modalEditarEquipo">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-warning">
          <h4 class="modal-title">Editar equipo</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form method="post">
            <input type="hidden" id="idEditEquipo" name="idEditEquipo">
            <div class="form-row">
              <div class="form-group col-lg-6">
                <label for="numeroSerieEdit">#Número Serie</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                  </div>
                  <input type="text" class="form-control" id="numeroSerieEdit" name="numeroSerieEdit" placeholder="Ej:00ks32.." readonly>
                </div>
              </div>
              <div class="form-group col-lg-6">
                <label for="etiquetaEdit">Etiqueta</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-tag"></i></span>
                  </div>
                  <input type="text" class="form-control" id="etiquetaEdit" name="etiquetaEdit" placeholder="Ej:0022338...">
                </div>
              </div>
            </div>
            <div class="form-group col-lg-12">
              <label for="descripcionEdit">Descripción</label>
              <textarea class="form-control" id="descripcionEdit" name="descripcionEdit" placeholder="Ej: El equipo se encuentra en perfecto estado..." rows="3"></textarea>
            </div>
            <div class="form-row mt-2">
              <div class="form-group col-lg-6">
                <label for="estadoEdit">Estado</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-info-circle"></i></span>
                  </div>
                  <?php
                  $item = null;
                  $valor = null;
                  $estados = ControladorEstados::ctrMostrarEstados($item, $valor);
                  echo '<select class="form-control" id="estadoEdit" name="estadoEdit">';
                  echo '<option value="">Seleccione un estado</option>';
                  foreach ($estados as $key => $estado) {
                    echo '<option value="' . $estado["id_estado"] . '">' . $estado["estado"] . '</option>';
                  }
                  echo '</select>';
                  ?>
                </div>
              </div>
              <div class="form-group col-lg-6">
                <label for="categoriaEditId">Categoría</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-list-alt"></i></span>
                  </div>
                  <?php
                  $item = null;
                  $valor = null;
                  $categorias = ControladorCategorias::ctrMostrarCategorias($item, $valor);
                  echo '<select class="form-control" id="categoriaEditId" name="categoriaEditId" required>';
                  echo '<option value="">Seleccione una categoría</option>';
                  foreach ($categorias as $key => $categoria) {
                    echo '<option value="' . $categoria["categoria_id"] . '">' . $categoria["nombre"] . '</option>';
                  }
                  echo '</select>';
                  ?>
                </div>
              </div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
              <button type="submit" class="btn btn-primary">Editar</button>
            </div>

            <?php
            $equipos = ControladorEquipos::ctrEditarEquipos();

            ?>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- ========== Start Section ==========
  MODAL PARA TRASPASO EQUIPO CUENTADANTE
  ========== End Section ========== -->

  <div class="modal fade" id="modalTraspaso">
    <div class="modal-dialog modal-default">
      <div class="modal-content">
        <div class="modal-header bg-success">
          <h4 class="modal-title">Solicitud de traspaso de equipo</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form method="post">
            <input type="hidden" id="idTraspasoEquipo" name="idTraspasoEquipo">

            <div class="form-row ">

              <!-- INPUT CUENTADANTE ORIGEN -->
              <div class="form-group col-lg-12">
                <label for="cuentadanteOrigenTraspaso">Cuentadante origen</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                  </div>
                  <input type="text" class="form-control" id="cuentadanteOrigenTraspaso" name="cuentadanteOrigenTraspaso" readonly>
                </div>
              </div>

            </div>

            <div class="form-row mt-2 d-flex justify-content-lg-center ">
              <!-- ICONO TRASPASO -->
              <div class="form-group col-lg-2 d-flex justify-content-center align-content-end">
                <span class="input-group-text mt-4 h-80"><i class="fas fa-exchange-alt fa-rotate-90"></i></span>
              </div>

              <!-- INPUT BUSCAR POR CEDULA -->
              <div class="form-group col-lg-12">
                <label for="buscarDocumentoId">Ingrese a buscar por documento</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                  </div>
                  <input type="number" class="form-control" id="buscarDocumentoId" name="buscarDocumentoId" placeholder="Ej:12345..." required>
                  <div class="input-group-append">
                    <button class="bg-primary input-group-text btnBuscarCuentadante swalDefaultError"><i class="fas fa-search"></i></button>
                  </div>
                </div>
              </div>

              <!-- INPUT CUENTADANTE DESTINO -->
              <div class="form-group col-lg-12">
                <label for="cuentadanteDestino">Cuentadante destino</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-user-astronaut"></i></span>
                  </div>
                  <input type="hidden" id="cuentadanteDestinoId" name="cuentadanteDestinoId">
                  <input type="text" class="form-control" id="cuentadanteDestino" name="cuentadanteDestino" placeholder="Ej:Jane Doe" readonly>
                </div>
              </div>

            </div>

            <div class="modal-footer mt-2 justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
              <button type="submit" class="btn btn-primary">Realizar traspaso</button>
            </div>
            <?php
            // $cuentadantes = ControladorEquipos::ctrRealizarTraspasoCuentadante();
            $cuentadantes = new ControladorEquipos();
            $cuentadantes->ctrRealizarTraspasoCuentadante();
            ?>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- ========== Start Section ==========
  MODAL PARA TRASPASO EQUIPO UBICACIÓN
  ========== End Section ========== -->

  <div class="modal fade" id="modalTraspasoUbicacion">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-info">
          <h4 class="modal-title">Solicitud de traspaso de ubicacion</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <form method="post">
          <div class="modal-body">
            <!-- Id del equipo -->
            <input type="hidden" id="idTraspasoUbicacion" name="idTraspasoUbicacion">

            <div class="form-row d-flex justify-content-between align-items-center">

              <!-- INPUT UBICACIÓN ACTUAL -->
              <div class="form-group col-lg-5">
                <label for="ubicacionActual">Ubicación actual</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                  </div>
                  <input type="hidden" id="ubicacionActualId" name="ubicacionActualId">
                  <input type="text" class="form-control" id="ubicacionActual" name="ubicacionActual" readonly>
                </div>
              </div>

              <!-- ICONO TRASPASO -->
              <div class="form-group col-lg-1 mt-4">
                <span class="input-group-text p-2"><i class="fas fa-exchange-alt d-flex justify-content-center w-100"></i></span>
              </div>

              <div class="form-group col-lg-5">
                <label for="nuevaUbicacionId">Nueva ubicacion</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                  </div>
                  <?php

                  $item = null;
                  $valor = null;
                  $ubicaciones = ControladorUbicaciones::ctrMostrarUbicaciones($item, $valor);
                  // echo '<input type="hidden" id="nueva_ubicacion_id" name="nueva_ubicacion_id">';
                  echo '<select class="form-control" id="nuevaUbicacionId" name="nuevaUbicacionId" required>';
                  echo '<option value="">Seleccione una ubicación</option>';
                  foreach ($ubicaciones as $key => $ubicacion) {
                    echo '<option value="' . $ubicacion["ubicacion_id"] . '">' . $ubicacion["nombre"] . '</option>';
                  }
                  echo '</select>';
                  ?>
                </div>
              </div>

            </div>
          </div>

          <div class="modal-footer mt-2 justify-content-between">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            <button type="submit" class="btn btn-primary">Realizar traspaso</button>
          </div>
          <?php
          // $cuentadantes = ControladorEquipos::ctrRealizarTraspasoUbicacion();
          $ubicacion = new ControladorEquipos();
          $ubicacion->ctrRealizarTraspasoUbicacion();
          ?>
        </form>
      </div>
    </div>
  </div>