  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <section class="content-header">
          <div class="container-fluid">
              <div class="row mb-2">
                  <div class="col-sm-6">
                      <h1>solicitudes</h1>
                  </div>
                  <div class="col-sm-6">
                      <ol class="breadcrumb float-sm-right">
                          <li class="breadcrumb-item"><a href="#">Inicio</a></li>
                      </ol>
                  </div>
              </div>
          </div><!-- /.container-fluid -->
      </section>

      <!-- Main content -->
      <section class="content">

          <div class="container-fluid">
              <!-- Info boxes -->
              <div class="row">

                  <div class="col-lg-3 col-6">
                      <!-- small box -->
                      <div class="small-box bg-info">
                          <div class="inner">
                              <h3>150</h3>

                              <p>Portátiles</p>
                          </div>
                          <div class="icon">
                              <i class="ion ion-bag"></i>
                          </div>
                          <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                      </div>
                  </div>

                  <div class="col-lg-3 col-6">
                      <!-- small box -->
                      <div class="small-box bg-info">
                          <div class="inner">
                              <h3>150</h3>

                              <p>Portátiles</p>
                          </div>
                          <div class="icon">
                              <i class="ion ion-bag"></i>
                          </div>
                          <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                      </div>
                  </div>

                  <div class="col-lg-3 col-6">
                      <!-- small box -->
                      <div class="small-box bg-info">
                          <div class="inner">
                              <h3>150</h3>

                              <p>Portátiles</p>
                          </div>
                          <div class="icon">
                              <i class="ion ion-bag"></i>
                          </div>
                          <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                      </div>
                  </div>

                  <div class="col-lg-3 col-6">
                      <!-- small box -->
                      <div class="small-box bg-info">
                          <div class="inner">
                              <h3>150</h3>

                              <p>Portátiles</p>
                          </div>
                          <div class="icon">
                              <i class="ion ion-bag"></i>
                          </div>
                          <a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                      </div>
                  </div>
              </div>
              <!-- row  -->

              <div class="row">
                  <!-- Left side - Equipos -->
                  <div class="col-md-7">
                      <div class="card">

                          <div class="card-header">
                              <h1 class="card-title">EQUIPOS</h1>
                          </div>

                          <div class="card-body p-10">

                              <!-- SOLICITANTE -->
                              <div class="form-group">
                                  <div class="row">
                                      <div class="col-lg-6">
                                          <div class="input-group ">
                                              <div class="input-group-prepend">
                                                  <span class="input-group-text"><i class="fas fa-user"></i></span>
                                              </div>
                                              <input type="text" class="form-control" name="NumeroIdSolicitante" id="NumeroIdSolicitante" placeholder="Número" required>
                                          </div>
                                      </div>
                                      <div class="col-lg-6">
                                          <div class="intput-group">
                                              <button class="btn btn-primary" id="btnBuscarSolicitante"><i class="fas fa-search"></i></button>
                                          </div>

                                      </div>
                                  </div>
                              </div>


<div class="infoEquiposSolicitados d-none">

                              <!-- RANGO DE FECHAS -->
                              <div class="form-group">
                                  <div class="row">
                                      <div class="col-lg-6">
                                          <div class="input-group">
                                              <div class="input-group-prepend">
                                                  <span class="input-group-text">
                                                      <i class="far fa-calendar-alt"></i>
                                                  </span>
                                              </div>
                                              <input type="text" class="form-control float-right" id="reservation">
                                          </div>
                                          <!-- /.input group -->
                                      </div>
                                      <!-- /.form group -->
                                  </div>
                              </div>



                              <?php

                                //capturamos la fecha de hoy y la asignmaso a fechaInicio y fechaFin
                                $hoy = date("Y-m-d");
                                $respuesta = ControladorSolicitudes::ctrMostrarEquiposDisponible($hoy, $hoy);

                                ?>

                              <!-- TABLA DE EQUIPOS DISPONIBLES EN EL RANGO DE FECHAS SELECCIONADO  -->
                              <div class="row">
                                  <div class="col-lg-12">
                                      <table id="tblActivosSolicitar" class="table table-bordered table-striped">
                                          <thead>
                                              <tr>
                                                  <th>Descripción</th>
                                                  <th>Serial</th>
                                                  <th>Categoría</th>
                                                  <th>Ubicación</th>
                                                  <th>Acción</th>
                                              </tr>
                                          </thead>
                                          <tbody>
                                              <?php
                                                // Loop through the equipos and display them in the table
                                                foreach ($respuesta as $key => $value) {
                                                    echo '<tr>
                                                        <td>' . $value["descripcion"] . '</td>
                                                        <td>' . $value["etiqueta"] . '</td>
                                                        <td>' . $value["categoria_nombre"] . '</td>
                                                        <td>' . $value["ubicacion_nombre"] . '</td>
                                                        <td> <button class="btn btn-primary btn-sm btnAgregarEquipo recoverButton" idEquipoAgregar="' . $value["equipo_id"] . '"><i class="fas fa-plus"></i> Agregar</button></td>
                                                    </tr>';
                                                }



                                                ?>




                                          </tbody>
                                      </table>
                                  </div>
                              </div>

</div>                              
<!-- d-none -->

                          </div>
                          <!-- card.body  -->
                      </div>
                      <!-- card  -->
                  </div>
                  <!-- col-md-7  -->



                  <!-- Right side - Solicitud -->
                  <div class="col-md-5">
                      <div class="card">

                          <div class="card-header">
                              <h1 class="card-title">SOLICITUD</h1>
                          </div>


                          <div class="card-body">

                            <!-- =============================================

                                    FORMULARIO DE SOLICITUD 

                            ============================================= -->

                              <form action="" method="POST" id="idFormularioSolicitud">

                                    <!-- NOMBRE SOLICITANTE -->
                                  <div class="form-group">
                                      <div class="row">
                                          <div class="col-lg-12">
                                              <div class="input-group ">
                                                  <div class="input-group-prepend">
                                                      <span class="input-group-text"><i class="fas fa-user"></i></span>
                                                  </div>
                                                  <input type="hidden" name="idSolicitante" id="idSolicitante">
                                                  <input type="text" class="form-control" name="nombreSolicitante" id="nombreSolicitante" placeholder="Nombre solicitante" readonly>
                                              </div>
                                          </div>
                                      </div>
                                  </div>

<div class="infoEquiposSolicitados d-none">                                  

                                  <!-- RANGO DE FECHAS -->
                                  <div class="form-group">
                                      <div class="row">
                                          <div class="col-lg-6">
                                              <div class="input-group">
                                                  <input type="text" class="form-control float-right" id="initialDate" value="<?php echo $hoy; ?>">
                                                  <div class="input-group-prepend">
                                                      <span class="input-group-text">
                                                          <i class="fas fa-arrow-right"></i>
                                                      </span>
                                                  </div>
                                              </div>
                                          </div>
                                          <div class="col-lg-6">
                                              <div class="input-group">
                                                  <div class="input-group-prepend">
                                                      <span class="input-group-text">
                                                          <i class="far fa-calendar-alt"></i>
                                                      </span>
                                                  </div>
                                                  <input type="text" class="form-control float-right" id="finalDate"  value="<?php echo $hoy; ?>">
                                              </div>
                                              <!-- /.input group -->
                                          </div>
                                          <!-- /.form group -->
                                      </div>
                                  </div>


                                  <div class="form-group nuevoEquipo">
                                      <!-- //contenido dinamico desde js -->
                                  </div>



                                  <!-- OBSERVACIONES  -->
                                  <div class="form-group">
                                      <div class="row">
                                          <div class="col-lg-12">
                                              <label>Observaciones</label>
                                              <textarea class="form-control" rows="3"></textarea>
                                          </div>
                                      </div>
                                  </div>

</div>
<!-- d-none-->
                          </div>
                          <!-- card-body  -->

<div class="infoEquiposSolicitados d-none">                             

                          <div class="card-footer">

                              <div class="action-buttons">
                                  <button type="button" class="btn btn-danger btnCancelarSolicitud">Cancelar</button>
                                  <button type="submit" class="btn btn-primary btnGuardarSolicitud">Aceptar</button>
                              </div>
                          </div>
</div>
<!-- d-none-->



                          </form>




                      </div>

                      <div class="infoEquiposSolicitados d-none">                         

                      <div class="card">
                          <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#modalHistoricoSolicitudes">Historial</button>
                      </div>

                      </div>
<!-- d-none-->

                  </div>
              </div>
              <!-- row  -->


          </div>
  </div>
  </div>
  </section>





























































  </section>
  <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->



  <!-- Modal para historico de solicitudes -->

  <div class="modal fade" id="modalHistoricoSolicitudes">
      <div class="modal-dialog modal-lg">
          <div class="modal-content">
              <!-- Header -->
              <div class="modal-header bg-primary">
                  <h4 class="modal-title">Historical solicitudes</h4>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>

              <!-- Body -->
              <div class="modal-body">
                  <div class="table-responsive">
                      <table id="tblModalHistoricoSolicitudes" class="table table-bordered table-striped">
                          <thead>
                              <tr>
                                  <th>Solicitud</th>
                                  <th>Fecha</th>
                                  <th>Acciones</th>
                              </tr>
                          </thead>
                          <tbody>
                              <tr>
                                  <td>1234567</td>
                                  <td>11/11/2024</td>
                                  <td>
                                      <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#detalleSolicitudModal"><i class="fas fa-file-alt"></i></button>
                                  </td>
                              </tr>
                              <tr>
                                  <td>1234567</td>
                                  <td>11/11/2024</td>
                                  <td><button class="btn btn-primary btn-sm"><i class="fas fa-file-alt"></i></button></td>
                              </tr>
                              <tr>
                                  <td>1234567</td>
                                  <td>11/11/2024</td>
                                  <td><button class="btn btn-primary btn-sm"><i class="fas fa-file-alt"></i></button></td>
                              </tr>
                              <tr>
                                  <td>1234567</td>
                                  <td>11/11/2024</td>
                                  <td><button class="btn btn-primary btn-sm"><i class="fas fa-file-alt"></i></button></td>
                              </tr>
                              <tr>
                                  <td>1234567</td>
                                  <td>11/11/2024</td>
                                  <td><button class="btn btn-primary btn-sm"><i class="fas fa-file-alt"></i></button></td>
                              </tr>
                              <tr>
                                  <td>1234567</td>
                                  <td>11/11/2024</td>
                                  <td><button class="btn btn-primary btn-sm"><i class="fas fa-file-alt"></i></button></td>
                              </tr>
                          </tbody>
                      </table>
                  </div>
              </div>

              <!-- Footer -->
              <div class="modal-footer">
                  <button type="button" class="btn btn-danger" data-dismiss="modal">Salir</button>
              </div>
          </div>
      </div>
  </div>



  <!-- ############################################################################################################### -->


  <!-- Modal Detalle Solicitud -->
  <div class="modal fade" id="detalleSolicitudModal">
      <div class="modal-dialog modal-lg">
          <div class="modal-content">
              <!-- Header -->
              <div class="modal-header bg-primary">
                  <h4 class="modal-title">Solicitud #1234567</h4>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>

              <!-- Body -->
              <div class="modal-body">
                  <div class="table-responsive">
                      <table class="table table-bordered table-striped">
                          <tbody>
                              <tr>
                                  <td class="font-weight-bold" style="width: 30%">Desde</td>
                                  <td style="width: 70%">[Fecha desde]</td>
                              </tr>
                              <tr>
                                  <td class="font-weight-bold">Hasta</td>
                                  <td>[Fecha hasta]</td>
                              </tr>
                              <tr>
                                  <td class="font-weight-bold">Descripción</td>
                                  <td>[Descripción del solicitante]</td>
                              </tr>
                          </tbody>
                      </table>
                  </div>

                  <div class="card mt-3">
                      <div class="card-header">
                          <h3 class="card-title">Materiales solicitados</h3>
                      </div>
                      <div class="card-body p-0">
                          <div class="table-responsive">
                              <table class="table table-bordered table-hover mb-0">
                                  <thead>
                                      <tr>
                                          <th style="width: 60%">Artículo</th>
                                          <th style="width: 40%">Serial</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      <tr>
                                          <td>Portatil</td>
                                          <td>325462</td>
                                      </tr>
                                      <tr>
                                          <td>Portatil</td>
                                          <td>325462</td>
                                      </tr>
                                      <tr>
                                          <td>Video Beam</td>
                                          <td>654789851</td>
                                      </tr>
                                      <tr>
                                          <td>Cable HDMI</td>
                                          <td>006</td>
                                      </tr>
                                  </tbody>
                              </table>
                          </div>
                      </div>
                  </div>

                  <div class="form-group mt-3">
                      <label class="font-weight-bold">Observaciones</label>
                      <textarea class="form-control" rows="3" style="min-height: 100px;"></textarea>
                  </div>
              </div>

              <!-- Footer -->
              <div class="modal-footer">
                  <button type="button" class="btn btn-danger p-10" data-dismiss="modal">Salir</button>
              </div>
          </div>
      </div>
  </div>