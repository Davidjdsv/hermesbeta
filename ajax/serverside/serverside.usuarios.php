<?php
    require 'serverside.php';
    $table_data->get('vista_usuarios','id_usuario',array('id_usuario','tipo_documento', 'numero_documento', 'nombre', 'apellido', 'correo_electronico', 'nombre_rol', 'codigo','estado','condicion'));
 