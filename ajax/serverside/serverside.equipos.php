<?php
    require 'serverside.php';
    $table_data->get('vista_equipos','equipo_id',array('equipo_id','numero_serie','etiqueta','descripcion','ubicacion_nombre','categoria_nombre','cuentadante_nombre','estado_nombre'));