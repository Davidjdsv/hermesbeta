<?php

require_once "conexion.php";

class ModeloUsuarios{

    static public function mdlCrearUsuario($tabla, $datos){
        try{
            //Iniciar la transacción
            $conexion = Conexion::conectar();
            $conexion->beginTransaction();

            $stmt = $conexion->prepare("INSERT INTO $tabla(tipo_documento, numero_documento, nombre, apellido, correo_electronico, nombre_usuario, clave, telefono, direccion, genero, foto) VALUES (:tipo_documento, :documento, :nombre, :apellido, :email, :usuario, :clave, :telefono, :direccion, :genero, :foto)");

            $stmt->bindParam(":tipo_documento", $datos["tipo_documento"], PDO::PARAM_STR);
            $stmt->bindParam(":documento", $datos["documento"], PDO::PARAM_STR);
            $stmt->bindParam(":nombre", $datos["nombre"], PDO::PARAM_STR);
            $stmt->bindParam(":apellido", $datos["apellido"], PDO::PARAM_STR);
            $stmt->bindParam(":email", $datos["email"], PDO::PARAM_STR);
            $stmt->bindParam(":usuario", $datos["usuario"], PDO::PARAM_STR);
            $stmt->bindParam(":clave", $datos["password"], PDO::PARAM_STR);
            $stmt->bindParam(":telefono", $datos["telefono"], PDO::PARAM_STR);
            $stmt->bindParam(":direccion", $datos["direccion"], PDO::PARAM_STR);
            $stmt->bindParam(":genero", $datos["genero"], PDO::PARAM_STR);
            $stmt->bindParam(":foto", $datos["foto"], PDO::PARAM_STR);

            $stmt -> execute();

        
            //insertar los datos en la tabla usuario_rol
            $id_usuario = $conexion->lastInsertId();
            $stmt2 = $conexion->prepare("INSERT INTO usuario_rol(id_usuario, id_rol) VALUES (:id_usuario, :id_rol)");
            $stmt2->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
            $stmt2->bindParam(":id_rol", $datos["rol"], PDO::PARAM_INT);

            $stmt2 -> execute();



            //si el rol del usuario es 6 (aprendiz) se guarda el id de la ficha y el id del nuevo usuario en la tabla aprendices_ficha
            if ($datos["rol"] == "6") {
                $stmt3 = $conexion->prepare("INSERT INTO aprendices_ficha(id_usuario, id_ficha) VALUES (:id_usuario, :id_ficha)");
                $stmt3->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
                $stmt3->bindParam(":id_ficha", $datos["ficha"], PDO::PARAM_INT);

                $stmt3 -> execute();
    
            }

            //Confirmar transacción
            $conexion->commit();
            return "ok";
        } catch (Exception $e) {
            // Si ocurre un error, se revierte la transacción
            $conexion->rollBack();
            return "error";
        } finally {
            // Cerrar la conexión
            $conexion = null;
        }       
    }
    

    static public function mdlMostrarUsuarios($tabla, $item, $valor){

        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT u.*, 
                                                            r.id_rol, r.nombre_rol, 
                                                            f.id_ficha, f.descripcion AS descripcion_ficha, f.codigo, 
                                                            s.id_sede, s.nombre_sede
                                                    FROM $tabla as u      
                                                    LEFT JOIN usuario_rol ur ON u.id_usuario = ur.id_usuario
                                                    LEFT JOIN roles r ON ur.id_rol = r.id_rol
                                                    LEFT JOIN aprendices_ficha af ON u.id_usuario = af.id_usuario
                                                    LEFT JOIN fichas f ON af.id_ficha = f.id_ficha 
                                                    LEFT JOIN sedes s ON f.id_sede = s.id_sede
                                                    WHERE u.$item = :$item LIMIT 1");
            if ($item == "id_usuario") {
                $stmt -> bindParam(":".$item, $valor, PDO::PARAM_INT);
            } else {
                $stmt -> bindParam(":".$item, $valor, PDO::PARAM_STR);
            }            
            $stmt -> execute();
            return $stmt -> fetch(PDO::FETCH_ASSOC);
        }else{
            $stmt = Conexion::conectar()->prepare("SELECT u.*, r.id_rol, r.nombre_rol, f.id_ficha, f.descripcion AS descripcion_ficha, f.codigo
                                                    FROM $tabla as u      LEFT JOIN usuario_rol ur ON u.id_usuario = ur.id_usuario
                                                    LEFT JOIN roles r ON ur.id_rol = r.id_rol
                                                    LEFT JOIN aprendices_ficha af ON u.id_usuario = af.id_usuario
                                                    LEFT JOIN fichas f ON af.id_ficha = f.id_ficha;");
            $stmt -> execute();
            return $stmt -> fetchAll();
        }
        $stmt -> close();
        $stmt = null;
        
    }

    static public function mdlMostrarFichasSede($tabla, $item, $valor){

        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE $item = :$item");
            $stmt -> bindParam(":".$item, $valor, PDO::PARAM_STR);
            $stmt -> execute();
            return $stmt -> fetchAll();
        }else{
            $stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla");
            $stmt -> execute();
            return $stmt -> fetchAll();
        }
        $stmt -> close();
        $stmt = null;
        
    }

    
        /*=============================================
        EDITAR PERFIL
        =============================================*/
        static public function mdlEditarPerfil($tabla, $datos){
            error_log("Consulta SQL: UPDATE $tabla SET tipo_documento = {$datos['tipo_documento']}, numero_documento = {$datos['numero_documento']}, nombre = {$datos['nombre']}, apellido = {$datos['apellido']}, correo_electronico = {$datos['correo_electronico']}, telefono = {$datos['telefono']}, direccion = {$datos['direccion']}, genero = {$datos['genero']}, foto = {$datos['foto']} WHERE id_usuario = {$datos['id_usuario']}");
            try {
                $stmt = Conexion::conectar()->prepare("UPDATE $tabla SET 
                    correo_electronico = :correo_electronico,
                    telefono = :telefono,
                    direccion = :direccion,
                    genero = :genero,
                    foto = :foto
                    WHERE id_usuario = :id_usuario");

                $stmt->bindParam(":correo_electronico", $datos["correo_electronico"], PDO::PARAM_STR);
                $stmt->bindParam(":telefono", $datos["telefono"], PDO::PARAM_STR);
                $stmt->bindParam(":direccion", $datos["direccion"], PDO::PARAM_STR);
                $stmt->bindParam(":genero", $datos["genero"], PDO::PARAM_STR);
                $stmt->bindParam(":foto", $datos["foto"], PDO::PARAM_STR);
                $stmt->bindParam(":id_usuario", $datos["id_usuario"], PDO::PARAM_INT);

                if($stmt->execute()){
                    return "ok";
                }

                return "error";

            } catch(PDOException $e) {
                return "error: " . $e->getMessage();
            } finally {
                if(isset($stmt)){
                    $stmt = null;
                }
            }
        }
        /*=============================================
        CAMBIAR ESTADO DE USUARIO
        =============================================*/
        static public function mdlCambiarEstadoUsuario($id, $estado) {
            $stmt = Conexion::conectar()->prepare("UPDATE usuarios SET estado = :estado WHERE id_usuario = :id");
            $stmt->bindParam(":estado", $estado, PDO::PARAM_STR);
            $stmt->bindParam(":id", $id, PDO::PARAM_INT);
            return $stmt->execute();
        }


    
       static public function mdlEditarUsuario($tabla, $datos){

        error_log("Consulta SQL: UPDATE $tabla SET tipo_documento = {$datos['tipo_documento']}, numero_documento = {$datos['numero_documento']}, nombre = {$datos['nombre']}, apellido = {$datos['apellido']}, correo_electronico = {$datos['correo_electronico']}, telefono = {$datos['telefono']}, direccion = {$datos['direccion']}, genero = {$datos['genero']} WHERE id_usuario = {$datos['id_usuario']}");

        try{        
            //iniciar la transacción
            $conexion = Conexion::conectar();
            $conexion->beginTransaction();
    
            $stmt1 = $conexion->prepare("UPDATE $tabla SET tipo_documento = :tipo_documento, numero_documento = :numero_documento, nombre = :nombre, apellido = :apellido, correo_electronico = :correo_electronico, telefono = :telefono, direccion = :direccion, genero = :genero, foto = :foto WHERE id_usuario = :id_usuario");

            $stmt1 -> bindParam(":tipo_documento", $datos["tipo_documento"], PDO::PARAM_STR);
            $stmt1 -> bindParam(":numero_documento", $datos["numero_documento"], PDO::PARAM_STR);
            $stmt1 -> bindParam(":nombre", $datos["nombre"], PDO::PARAM_STR);
            $stmt1 -> bindParam(":apellido", $datos["apellido"], PDO::PARAM_STR);
            $stmt1 -> bindParam(":correo_electronico", $datos["correo_electronico"], PDO::PARAM_STR);
            $stmt1 -> bindParam(":telefono", $datos["telefono"], PDO::PARAM_STR);
            $stmt1 -> bindParam(":direccion", $datos["direccion"], PDO::PARAM_STR);
            $stmt1 -> bindParam(":genero", $datos["genero"], PDO::PARAM_INT);
            $stmt1 -> bindParam(":genero", $datos["genero"], PDO::PARAM_INT);
            $stmt1 -> bindParam(":foto", $datos["foto"], PDO::PARAM_STR);
            $stmt1 -> bindParam(":id_usuario", $datos["id_usuario"], PDO::PARAM_INT);
            $stmt1 -> execute();
    
            //capturar los datos del rol y la ficha anteriores y nuevos
            $rolOriginal = $datos["idRolOriginal"];
            $fichaOriginal = $datos["idFichaOriginal"];
            $rolNuevo = $datos["id_rol"];
            $fichaNueva = $datos["id_ficha"];

            error_log("Rol original: $rolOriginal, Rol nuevo: $rolNuevo, Ficha original: $fichaOriginal, Ficha nueva: $fichaNueva");

            // Si el rol ha cambiado, actualiza la tabla usuario_rol
            if ($rolOriginal != $rolNuevo) {
                $stmt2 = $conexion->prepare("UPDATE usuario_rol SET id_rol = :id_rol WHERE id_usuario = :id_usuario");
                $stmt2->bindParam(":id_rol", $rolNuevo, PDO::PARAM_INT);
                $stmt2->bindParam(":id_usuario", $datos["id_usuario"], PDO::PARAM_INT);
                $stmt2->execute();
            }

            // Si el rol era aprendiz y ha cambiado a otro rol, elimina la relación de la tabla aprendices_ficha
            if ($rolOriginal == 6 && $rolNuevo != 6) {
                $stmt3 = $conexion->prepare("DELETE FROM aprendices_ficha WHERE id_usuario = :id_usuario");
                $stmt3->bindParam(":id_usuario", $datos["id_usuario"], PDO::PARAM_INT);
                $stmt3->execute();
            }

            // Si el rol anterior no era aprendiz y el nuevo rol es aprendiz, inserta en la tabla aprendices_ficha
            if ($rolOriginal != 6 && $rolNuevo == 6) {
                $stmt4 = $conexion->prepare("INSERT INTO aprendices_ficha(id_usuario, id_ficha) VALUES (:id_usuario, :id_ficha)");
                $stmt4->bindParam(":id_usuario", $datos["id_usuario"], PDO::PARAM_INT);
                $stmt4->bindParam(":id_ficha", $fichaNueva, PDO::PARAM_INT);
                $stmt4->execute();
            }

            // Si el rol sigue siendo aprendiz pero la ficha ha cambiado, actualiza la tabla aprendices_ficha
            if ($rolNuevo == 6 && $fichaOriginal != $fichaNueva) {
                $stmt5 = $conexion->prepare("UPDATE aprendices_ficha SET id_ficha = :id_ficha WHERE id_usuario = :id_usuario");
                $stmt5->bindParam(":id_ficha", $fichaNueva, PDO::PARAM_INT);
                $stmt5->bindParam(":id_usuario", $datos["id_usuario"], PDO::PARAM_INT);
                $stmt5->execute();
            }

            // Confirmar transacción
            $conexion->commit();
            return "ok";
        }  catch (Exception $e) {
            // Si ocurre un error, se revierte la transacción
            $conexion->rollBack();
            error_log("Error al editar usuario: " . $e->getMessage());
            return "Error: " . $e->getMessage();
        } finally {
            // Cerrar la conexión
            $conexion = null;
        }
    }

}