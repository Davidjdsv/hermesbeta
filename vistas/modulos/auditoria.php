<?php
// auditoria.php
?>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Historial de Auditoría de Usuarios</h1>
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
                            <table id="tablaAuditoria" class="table table-bordered table-striped w-100">
                                <thead>
                                    <tr>
                                        <th>ID Usuario</th>
                                        <th>Tipo Doc.</th>
                                        <th>Número Doc.</th>
                                        <th>Nombre</th>
                                        <th>Apellido</th>
                                        <th>Correo</th>
                                        <th>Usuario</th>
                                        <th>Teléfono</th>
                                        <th>Dirección</th>
                                        <th>Género</th>
                                        <th>Foto</th>
                                        <th>Estado</th>
                                        <th>Condición</th>
                                        <th>Fecha Registro</th>
                                        <th>Editado Por</th>
                                        <th>Campos Modificados</th>
                                        <th>Valores Anteriores</th>
                                        <th>Valores Nuevos</th>
                                        <th>Fecha Cambio</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- El tbody queda vacío porque lo llena DataTables por AJAX -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->
<!-- Tu archivo JS con la tabla y modal -->
<script src="/hermesbeta/vistas/js/auditoria.js"></script>


