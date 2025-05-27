<?php
// Mostrar log en la carpeta local
ini_set("display_errors", 0); //0: No aparecen errores en el navegador
ini_set("log_errors", 1); //Inidicamos que queremos crear un nuevo archivo de errores
ini_set("error_log", "C:/xampp/php/logs/php_error_log"); //ruta donde se guardan los logs error