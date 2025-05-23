  <!-- Content Wrapper. Contains page content -->
  <!-- <div class="content-wrapper"> -->
  <!-- Content Header (Page header) -->
  <!-- <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Usuarios</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="inicio">Inicio</a></li>
              <li class="breadcrumb-item">Usuarios</li>
            </ol>
          </div>
        </div>
      </div>
    </section> -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Usuarios</h1>
          </div>
          <div class="col-sm-6">
            <button class="btn btn-primary float-right" data-toggle="modal" data-target="#modalRegistrarUsuario">Agregar usuario</button>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <!-- <div class="card">
            <div class="card-header">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#registrarUsuario">
              Agregar Usuario</button> -->


      <!-- </div> -->
      <div class="card-body">
        <table id="tblUsuarios" class="table table-bordered table-striped">

          <thead>
            <tr>
              <th>#</th>
              <th>Tipo de documento</th>
              <th>Numero de documento</th>
              <th>Nombre</th>
              <th>Apellido</th>
              <th>Correo</th>
              <th>Rol</th>
              <th>Ficha</th>

              <!-- <th>Estado</th> -->
              <!-- Solo si es estudiante -->
              <th>Estado</th>
              <!-- <th>Ultimo Acceso</th> -->
              <th>Acciones</th>
            </tr>
          </thead>
          <?php
          $item = null;
          $valor = null;
          $usuarios = ControladorUsuarios::ctrMostrarUsuarios($item, $valor);

          foreach ($usuarios as $key => $usuario) {

            if ($usuario["id_usuario"] == 1) {
              continue; // Skip the user with id_usuario = 1
            }
            echo '<tr>
                <td>' . ($key) . '</td>
                <td>' . $usuario["tipo_documento"] . '</td>
                <td>' . $usuario["numero_documento"] . '</td>                
                <td>' . $usuario["nombre"] . '</td>
                <td>' . $usuario["apellido"] . '</td>
                <td>' . $usuario["correo_electronico"] . '</td>
                <td>' . $usuario["nombre_rol"] . '</td>
                <td>' . $usuario["codigo"] . '</td>
                <td>';
            if ($usuario["estado"] == "activo") {
              echo '<button class="btn btn-success btn-xs btnActivarUsuario" data-id="' . $usuario["id_usuario"] . '" data-estado="inactivo">Activo</button>';
            } else {
              echo '<button class="btn btn-danger btn-xs btnActivarUsuario" data-id="' . $usuario["id_usuario"] . '" data-estado="activo">Inactivo</button>';
            }
            echo '<td>
                  <div class="btn-group">
                    <button title="Consultar detalles de usuario" class="btn btn-default btn-xs btnConsultarUsuario" idUsuario="' . $usuario["id_usuario"] . '" data-toggle="modal" data-target="#modalConsularUsuario"><i class="fas fa-eye"></i></button>

                    <button title="Editar usuario" class="btn btn-default btn-xs btnEditarUsuario" idUsuario="' . $usuario["id_usuario"] . '" data-toggle="modal" data-target="#modalEditarUsuario"><i class="fas fa-edit"></i></button>

                    <button title="Solicitudes del usuario" class="btn btn-default btn-xs btnSolicitudesUsuario" idUsuario="' . $usuario["id_usuario"] . '" data-toggle="modal" data-target="#modalSolicitudesUsuario"><i class="fas fa-laptop"></i></button>
                    <button title="??" class="btn btn-default btn-xs btnSolicitudesUsuario" idUsuario="' . $usuario["id_usuario"] . '" data-toggle="modal" data-target="#modalSolicitudesUsuario"><i class="fas fa-file"></i></button>
                  </div>
                </td>
                </tr>';
          }
          ?>
          </tbody>
        </table

        </div>
        <!-- /.card-body -->

      </div>
      <!-- /.card -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

<!-- ============================================================================================================== -->

  <!-- Modal para Consultar usuario -->
  <div class="modal fade" id="modalConsularUsuario">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Consultar usuario</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        
        <div class="modal-body">
          <div class="box-body">

            <form id="formConsultarUsuario" method="POST">

              <input type="hidden" id="idConsultarUsuario" name="idConsultarUsuario" value="">

              <!-- row nombre y apellido -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                      </div>
                      <input type="text" class="form-control" id="consultarNombre" disabled>
                    </div>
                  </div>
                  <div class="col-lg-6">
                    <div class="input-group ">
                      <input type="text" class="form-control" id="consultarApellido" disabled>
                    </div>
                  </div>
                </div>
              </div>

              <!-- row documento -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-4">
                    <label>Tipo</label>
                    <input type="text" class="form-control" id="consultarTipoDocumento" disabled>
                  </div>
                  <div class="col-lg-8">
                    <label>Numero de documento</label>
                    <div class="input-group">
                      <input type="text" class="form-control" id="consultarNumeroDocumento" disabled>
                    </div>
                  </div>
                </div>
              </div>

              <!-- row rol -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <label>Rol</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                      </div>
                      <input type="text" class="form-control" id="consultarRol" disabled>
                    </div>
                  </div>
                </div>
              </div>


              <!-- row sede y ficha (solo si es aprendiz) -->
              <div class="form-group d-none" id="consultarSedeFicha">
                <div class="row">
                  <div class="col-lg-6">
                    <label>Sede</label>
                    <input type="text" class="form-control" id="consultarSede" disabled>
                  </div>
                  <div class="col-lg-6">
                    <label>Ficha</label>
                    <input type="text" class="form-control" id="consultarFicha" disabled>
                  </div>
                </div>
              </div>

              <!-- Espacio antes del row email -->
              <div class="mb-3"></div>

              <!-- row email -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                      </div>
                      <input type="email" class="form-control" id="consultarEmail" disabled>
                    </div>
                  </div>
                </div>
              </div>

              <!-- row telefono -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                      </div>
                      <input type="tel" class="form-control" id="consultarTelefono" disabled>
                    </div>
                  </div>
                </div>
              </div>

              <!-- row Direccion -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                      </div>
                      <input type="text" class="form-control" id="consultarDireccion" disabled>
                    </div>
                  </div>
                </div>
              </div>

              <!-- row Genero -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <label>Género</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-transgender"></i></span>
                      </div>
                      <input type="text" class="form-control" id="consultarGenero" disabled>
                    </div>
                  </div>
                </div>
              </div>

              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
              </div>

            </form>
        </div> <!-- box-body  -->
        </div> <!-- modal-body  -->

      </div> <!-- Modal content -->
    </div> <!-- modal-dialog  -->
  </div> <!-- modal  -->

  <!-- ============================================================================================================== -->

  <!-- Modal Solicitudes Usuario -->
  <div class="modal fade" id="modalSolicitudesUsuario">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Préstamos del Usuario</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="card card-success">
            <div class="card-body">
              <table class="table table-bordered table-striped" id="tblPrestamosUsuario">
                <thead>
                  <tr>
                    <th>#</th>
                    <th>Préstamo</th>
                    <th>Fecha Inicio</th>
                    <th>Fecha Fin</th>
                    <th>Estado</th>
                    <th>Motivo</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Maquetacion ejemplo datos ficticios -->
                  <tr>
                    <td>1</td>
                    <td>Préstamo 001</td>
                    <td>2024-06-01</td>
                    <td>2024-06-05</td>
                    <td><span class="badge badge-success">Activo</span></td>
                    <td>Práctica laboratorio</td>
                    <td>
                      <button class="btn btn-default btn-xs btnVerDetallePrestamo" data-toggle="modal" data-target="#modalDetallePrestamo" title="Ver Detalle">
                        <i class="fas fa-eye"></i>
                      </button>
                    </td>
                  </tr>
                  <tr>
                    <td>2</td>
                    <td>Préstamo 002</td>
                    <td>2024-05-20</td>
                    <td>2024-05-22</td>
                    <td><span class="badge badge-secondary">Finalizado</span></td>
                    <td>Examen</td>
                    <td>
                      <button class="btn btn-default btn-xs btnVerDetallePrestamo" data-toggle="modal" data-target="#modalDetallePrestamo" title="Ver Detalle">
                        <i class="fas fa-eye"></i>
                      </button>
                    </td>
                  </tr>
                  <!-- Fin ejemplo -->
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal Detalle Préstamo -->
  <div class="modal fade" id="modalDetallePrestamo">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-primary">
          <h4 class="modal-title">Detalle del Préstamo</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-md-12">
              <dl class="row">
                <dt class="col-sm-4">Tipo de Préstamo:</dt>
                <dd class="col-sm-8" id="detalleTipoPrestamo">Préstamo de equipos</dd>
                <dt class="col-sm-4">Fecha Inicio:</dt>
                <dd class="col-sm-8" id="detalleFechaInicio">2024-06-01</dd>
                <dt class="col-sm-4">Fecha Fin:</dt>
                <dd class="col-sm-8" id="detalleFechaFin">2024-06-05</dd>
                <dt class="col-sm-4">Motivo:</dt>
                <dd class="col-sm-8" id="detalleMotivo">Práctica laboratorio</dd>
              </dl>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <table class="table table-bordered table-striped" id="tblDetalleElementos">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Categoría</th>
                    <th>Equipo</th>
                    <th>Serial/Placa</th>
                    <th>Estado</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Ejemplo de fila -->
                  <tr>
                    <td>101</td>
                    <td>Portátil</td>
                    <td>HP 240 G7</td>
                    <td>SN123456</td>
                    <td><span class="badge badge-success">Bueno</span></td>
                  </tr>
                  <tr>
                    <td>102</td>
                    <td>Proyector</td>
                    <td>Epson X05</td>
                    <td>PL654321</td>
                    <td><span class="badge badge-success">Bueno</span></td>
                  </tr>
                  <!-- Fin ejemplo -->
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        </div>
      </div>
    </div>
  </div>
<!-- ============================================================================================================== -->

  <!-- Modal para agregar usuario -->
  <div class="modal fade" id="modalRegistrarUsuario">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Agregar usuario</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        
        <div class="modal-body">
          <div class="box-body">

            <form id="formAddUsuario" method="POST">

              <!-- row nombre y apellido -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                      </div>
                      <input type="text" class="form-control" name="nuevoNombre" placeholder="Nombre" required>
                    </div>
                  </div>
                  <div class="col-lg-6">
                    <div class="input-group ">
                      <input type="text" class="form-control" name="nuevoApellido" placeholder="Apellido" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row documento -->
              <div class="form-group">
                <div class="row">

                  <div class="col-lg-4">
                    <label>Tipo</label>
                    <select class="form-control" id="nuevoTipoDocumento" name="nuevoTipoDocumento" required>
                      <option value="">Seleccione...</option>
                      <option value="TI">TI</option>
                      <option value="CC">CC</option>
                      <option value="PS">PS</option>
                      <option value="PI">PI</option>
                    </select>
                  </div>

                  <div class="col-lg-8">
                    <label>Numero de documento</label>
                    <div class="input-group ">
                      <input type="text" class="form-control" name="nuevoNumeroDocumento" placeholder="Numero documento" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row rol -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <label>Rol</label>
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                      </div>
                      <?php
                      $item = null;
                      $valor = null;
                      $roles = ControladorRoles::ctrMostrarRoles($item, $valor);
                      echo '<select class="form-control" id="selectRol" name="selectRol" required>';
                      echo '<option value="">Seleccione un rol</option>';
                      foreach ($roles as $key => $rol) {
                        if ($rol["estado"] == "activo") {
                          echo '<option value="' . $rol["id_rol"] . '">' . $rol["nombre_rol"] . '</option>';
                        }
                      }
                      echo '</select>';
                      ?>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row sede  -->
              <div class="form-group d-none" id="sede">
                <div class="row">
                  <div class="col-lg-12">
                    <label>Sede</label>
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                      </div>
                      <?php
                      $item = null;
                      $valor = null;
                      $sedes = ControladorSedes::ctrMostrarSedes($item, $valor);
                      // Create a dropdown for sedes
                      echo '<select class="form-control" id="selectSede" name="id_sede" required>';
                      echo '<option value="">Seleccione una sede</option>';
                      // Loop through the sedes and create options
                      foreach ($sedes as $key => $value) {
                        if ($value["estado"] != "inactiva") {
                          echo '<option value="' . $value["id_sede"] . '">' . $value["nombre_sede"] . '</option>';
                        }
                      }
                      echo '</select>';

                      ?>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row grupo y programa -->
              <div class="form-group d-none" id="ficha">
                <div class="row">

                  <div class="col-lg-4">
                    <label>Ficha</label>
                    <select class="form-control" id="id_ficha" name="id_ficha" required>
                      <!-- aca se debe cargar la ficha o fichas segun la sede seleccionada con js -->
                    </select>
                  </div>

                  <div class="col-lg-8">
                    <label>Programa</label>
                    <div class="input-group ">
                      <input type="text" class="form-control" id="nombre_programa" name="nombre_programa" placeholder="No seleccionado" disabled>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->


              <!-- row mail  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                      </div>
                      <input type="email" class="form-control" name="nuevoEmail" placeholder="Email" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row telefono  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                      </div>
                      <input type="tel" class="form-control" name="nuevoTelefono" placeholder="celular" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row Direccion  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                      </div>
                      <input type="text" class="form-control" name="nuevaDireccion" placeholder="Dirección" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row Genero  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <label>Género</label>
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-transgender"></i></span>
                      </div>
                      <select class="form-control" name="nuevoGenero">
                        <option value="">Seleccione...</option>
                        <option value="1">Femenino</option>
                        <option value="2">Masculino</option>
                        <option value="0">No declara</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <!-- form group -->

              <!-- row password  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                      </div>
                      <input type="password" class="form-control" name="nuevoPassword" placeholder="Password" required>
                    </div>
                  </div>
                </div>
              </div>
              <!--- row -->

              <!-- row password  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                      </div>
                      <input type="password" class="form-control" name="nuevoPassword" placeholder="Password" required>
                    </div>
                  </div>
                </div>

              <!-- form group -->
              <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary">Agregar</button>
              </div>
              

              <?php

              // Include the PHP file for handling the form submission
              $crearUsuario = new ControladorUsuarios() ;
              $crearUsuario->ctrCrearUsuario();


              ?>

            </form>

          </div> <!-- box-body  -->
        </div> <!-- modal-body  -->

      </div> <!-- Modal content -->
    </div> <!-- modal-dialog  -->
  </div> <!-- modal  -->


<!-- ============================================================================================================== -->

  <!-- Modal para Editar usuario -->
  <div class="modal fade" id="modalEditarUsuario">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Editar usuario</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        
        <div class="modal-body">
          <div class="box-body">

            <form id="formEditUsuario" method="POST">

              <input type="hidden" id="idEditUsuario" name="idEditUsuario" value="">

              <!-- row nombre y apellido -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                      </div>
                      <input type="text" class="form-control" name="editNombre" id="editNombre" placeholder="Nombre" required>
                    </div>
                  </div>
                  <div class="col-lg-6">
                    <div class="input-group ">
                      <input type="text" class="form-control" name="editApellido" id="editApellido" placeholder="Apellido" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row documento -->
              <div class="form-group">
                <div class="row">

                  <div class="col-lg-4">
                    <label>Tipo</label>
                    <select class="form-control"  name="editTipoDocumento" required>
                      <option id="editTipoDocumento" value="">Seleccione...</option>
                      <option value="TI">TI</option>
                      <option value="CC">CC</option>
                      <option value="PS">PS</option>
                      <option value="PI">PI</option>
                    </select>
                  </div>

                  <div class="col-lg-8">
                    <label>Numero de documento</label>
                    <div class="input-group ">
                      <input type="text" class="form-control" name="editNumeroDocumento" id="editNumeroDocumento" placeholder="Numero documento" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row rol -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <label>Rol</label>
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                      </div>
                      <input type="hidden" id="rolOriginal" name="rolOriginal" value="">
                      <?php
                      $item = null;
                      $valor = null;
                      $roles = ControladorRoles::ctrMostrarRoles($item, $valor);
                      echo '<select class="form-control" name="EditRolUsuario" id="selectEditRolUsuario" required>';
                      echo '<option id="EditRolUsuario" value=""></option>';
                      foreach ($roles as $key => $rol) {
                        if ($rol["estado"] == "activo") {
                          echo '<option value="' . $rol["id_rol"] . '">' . $rol["nombre_rol"] . '</option>';
                        }
                      }
                      echo '</select>';
                      ?>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row sede  -->
              <div class="form-group d-none" id="editSede">
                <div class="row">
                  <div class="col-lg-12">
                    <label>Sede</label>
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                      </div>
                      <select class="form-control" name="selectEditSede" id="selectEditSede" inicial="true" required>
                        <option id="optionEditSede" value=""></option>
                        <?php
                      $item = null;
                      $valor = null;
                      $sedes = ControladorSedes::ctrMostrarSedes($item, $valor);
                      
                      // Loop through the sedes and create options
                      foreach ($sedes as $key => $sede) {
                        if ($sede["estado"] != "inactiva") {
                          echo '<option value="' . $sede["id_sede"] . '">' . $sede["nombre_sede"] . '</option>';
                        }
                      }
                      ?>
                      </select>
                      <!-- <div id="alerta"></div> -->

                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row grupo y programa -->
              <input type="hidden" id="fichaOriginal" name="fichaOriginal" value="">
              <div class="form-group d-none" id="EditFicha">
                <div class="row">

                  <div class="col-lg-4">
                    <label>Ficha</label>
                    <select class="form-control" name="selectEditIdFicha" id="selectEditIdFicha" required>
                      <option id="optionEditIdFicha" value=""></option>
                      <!-- aca se debe cargar la ficha o fichas segun la sede seleccionada con js -->
                    </select>
                  </div>

                  <div class="col-lg-8">
                    <label>Programa</label>
                    <div class="input-group ">
                      <input type="text" class="form-control" id="nombreEditPrograma" name="nombreEditPrograma" id="nombreEditPrograma" placeholder="No seleccionado" disabled>
                    </div>
                  </div>

                </div>     <!-- row -->
              </div>      <!-- form group -->


              <!-- row mail  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                      </div>
                      <input type="email" class="form-control" name="editEmail" id="editEmail"  placeholder="Email" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row telefono  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                      </div>
                      <input type="tel" class="form-control" name="editTelefono" id="editTelefono" placeholder="celular" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row Direccion  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                      </div>
                      <input type="text" class="form-control" id="editDireccion" name="editDireccion" placeholder="Dirección" required>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->

              <!-- row Genero  -->
              <div class="form-group">
                <div class="row">
                  <div class="col-lg-12">
                    <label>Género</label>
                    <div class="input-group ">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-transgender"></i></span>
                      </div>
                      <select class="form-control" name="editGenero" id="editGenero">
                        <option value="">Seleccione...</option>
                        <option value="1">Femenino</option>
                        <option value="2">Masculino</option>
                        <option value="0">No declara</option>
                      </select>
                    </div>
                  </div>
                </div>
                <!-- row -->
              </div>
              <!-- form group -->
              <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary">Modificar</button>
              </div>

              <?php

              // Include the PHP file for handling the form submission
              $editarUsuario = new ControladorUsuarios();
              $editarUsuario->ctrEditarUsuario();


              ?>

            </form>

          </div> <!-- box-body  -->
        </div> <!-- modal-body  -->

      </div> <!-- Modal content -->
    </div> <!-- modal-dialog  -->
  </div> <!-- modal  -->