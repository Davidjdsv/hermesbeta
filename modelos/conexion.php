<?php

class Conexion{

    static public function conectar(){
<<<<<<< HEAD
        $link = new PDO("mysql:host=localhost;dbname=hermes002", "root", "");
=======
        $link = new PDO("mysql:host=localhost;dbname=hermesbeta", "root", "");
>>>>>>> 4077495965506af35bd91684ad655bc3b2f8dd5b
        $link -> exec("set names utf8");
        return $link;
    }
}