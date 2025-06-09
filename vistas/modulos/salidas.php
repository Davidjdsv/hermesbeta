<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Salidas</h1>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <table id="tblSedes" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID Préstamo</th>
                                        <th>Usuario</th>
                                        <th>Tipo de Préstamo</th>
                                        <th>Estado De Préstamo</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    $item = null;
                                    $valor = null;
                                    $salidas = Controladorsalidas::ctrMostrarsalidas($item, $valor);


                                    foreach ($salidas as $key => $value)   {
                                        echo '
                                        <tr> 
                                        
                                            <td>'.$value["id_prestamo"].'</td>
                                            <td>'.$value["nombre"].'</td>
                                            <td>'.$value["tipo_prestamo"].'</td>
                                            <td>'.$value["estado_prestamo"].'</td>
                                    
                                            <td>
                                                <div class="btn-group">
                                                    <button class="btn btn-info btn-sm btnVerDetalles" data-id="'.$value["id_prestamo"].'" data-toggle="modal" data-target="#modalDetallesPrestamo">
                                                        <i class="fa fa-eye"></i> Ver Detalles
                                                    </button>
                                                </div>
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

    <!-- Modal de Detalles del Préstamo -->
    <div class="modal fade" id="modalDetallesPrestamo" tabindex="-1" role="dialog" aria-labelledby="modalDetallesPrestamoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h4 class="modal-title">Detalle del Préstamo #<span id="numeroPrestamo"></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <dl class="row">

                            <dt class="col-sm-4">Estado:</dt>
                            <dd class="col-sm-8" id="detalleTipoPrestamo"></dd>

                            <dt class="col-sm-4">Fecha Préstamo:</dt>
                            <dd class="col-sm-8" id="detalleFechaInicio"></dd>

                            <dt class="col-sm-4">Fecha Devolución:</dt>
                            <dd class="col-sm-8" id="detalleFechaFin"></dd>

                            <dt class="col-sm-4">Motivo:</dt>
                            <dd class="col-sm-8" id="detalleMotivoPrestamo"></dd>
                        </dl>
                    </div>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Equipos Solicitados</h5>
                            </div>
                            <div class="card-body p-10">
                                <table class="table table-bordered table-striped " id="tblDetallePrestamo">
                                    <thead>
                                        <tr>
                                

                                            <th>ID</th>
                                            <th>Categoría</th>
                                            <th>Equipo</th>
                                            <th>etiqueta</th>
                                            <th>Serial</th>
                                            <th>Ubicación</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
               
<button type="button" class="btn btn-success d-none" id="btnAceptarPrestamo">Aceptar</button>
            </div>
        </div>
    </div>
</div>

