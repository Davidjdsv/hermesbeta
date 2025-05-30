# Scripts SQL para la Base de Datos hermes002

Este archivo contiene instrucciones y consultas SQL que deben ejecutarse en la base de datos `hermes002` para realizar actualizaciones o modificaciones específicas.

**¡IMPORTANTE!**

* Asegúrate de estar conectado a la base de datos `hermes002` antes de ejecutar estas consultas.
* Realiza una copia de seguridad de la base de datos antes de ejecutar cualquier script, por si acaso necesitas revertir los cambios.
* Ejecuta las consultas en el orden en que aparecen en este archivo, si el orden es relevante.

## Consultas y Procedimientos

### Agregar columna `condicion` a la tabla `usuarios`

Se debe agregar una columna llamada `condicion` de tipo `ENUM` a la tabla `usuarios`, ubicada después de la columna `estado`. Los posibles valores son `'penalizado'`, `'advertido'` y `'en_regla'`, siendo `'en_regla'` el valor por defecto.

```sql
ALTER TABLE usuarios
ADD COLUMN condicion ENUM('penalizado', 'advertido', 'en_regla') NOT NULL DEFAULT 'en_regla'
AFTER estado;
```

### Encriptación de claves para usuarios

Se recomienda almacenar las contraseñas de los usuarios encriptadas utilizando el algoritmo bcrypt. A continuación se muestran los valores encriptados para las contraseñas de ejemplo:

- **admin123**  
  Valor encriptado:  
  `$2a$07$asxx54ahjppf45sd87a5aunxs9bkpyGmGE/.vekdjFg83yRec789S`

- **clave123**  
  Valor encriptado:  
  `$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO`

#### Consultas SQL para actualizar las contraseñas en la tabla `usuarios`

```sql
-- Asignar clave encriptada para el usuario administrador : clave=admin123
UPDATE usuarios
SET clave = '$2a$07$asxx54ahjppf45sd87a5aunxs9bkpyGmGE/.vekdjFg83yRec789S'
WHERE nombre = 'admin';

-- Asignar clave encriptada para los demás usuarios excepto para el admin clave=clave123
UPDATE usuarios
SET clave = '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO'
WHERE nombre <> 'admin';


Asegúrate de que la columna `clave` en la tabla `usuarios` tenga suficiente longitud para almacenar los hashes bcrypt (al menos `VARCHAR(200)`).

### Agregar columna `foto` a la tabla `usuarios`

Se debe agregar una columna llamada `foto` de tipo `VARCHAR(100)` a la tabla `usuarios`, ubicada después de la columna `genero`.

```sql
ALTER TABLE usuarios
ADD COLUMN foto VARCHAR(100) AFTER genero;
```

### Ruta por defecto para la foto de usuario

Al crear un nuevo usuario, el valor por defecto de la columna `foto` debe ser:  
`vistas/img/usuarios/default/anonymous.png`

### Creación automática de carpetas para fotos de usuario

Cuando se crea un usuario nuevo:
- Se debe crear automáticamente la carpeta `img` dentro de la carpeta `vistas` si no existe.
- Dentro de `img`, se debe crear la carpeta `usuarios`.
- Dentro de `usuarios`, se debe crear una carpeta con el número de documento del usuario.
- En esa carpeta es donde se almacenará la foto del usuario.

### Ejemplo de actualización de datos

```sql
-- Ejemplo: Actualizar la ruta de la foto para todos los usuarios existentes
UPDATE usuarios
SET foto = 'vistas/img/usuarios/default/anonymous.png';
```


### Espacio para la instrucciones de auditoria 
Para registrar un historial de modificaciones en los usuarios, sigue estos pasos para crear la tabla de auditoría y el trigger que registra los cambios automáticamente:
1. Crear la tabla de auditoría: `auditoria_usuarios` 
```sql
CREATE TABLE auditoria_usuarios (
  id_auditoria INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_usuario_afectado INT(11) NOT NULL,
  id_usuario_editor INT(11) DEFAULT NULL,
  campo_modificado VARCHAR(50) NOT NULL,
  valor_anterior TEXT,
  valor_nuevo TEXT,
  fecha_cambio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```
2. Crear el trigger `trg_auditar_usuarios` que registra los cambios en la tabla `usuarios`
- Este trigger se ejecuta después de cada actualización en la tabla usuarios y detecta cambios en campos específicos. Inserta un registro en la tabla auditoria_usuarios por cada cambio detectado.
```sql
DELIMITER $$

CREATE TRIGGER trg_auditar_usuarios
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
  DECLARE cambios TEXT DEFAULT '';
  DECLARE cambios_anterior TEXT DEFAULT '';
  DECLARE campos TEXT DEFAULT '';
  DECLARE separador VARCHAR(3) DEFAULT '';

  -- Detectar cambios en cada campo
  IF NOT (OLD.tipo_documento <=> NEW.tipo_documento) THEN
    SET cambios = CONCAT(cambios, separador, NEW.tipo_documento);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.tipo_documento);
    SET campos = CONCAT(campos, separador, 'tipo_documento');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.numero_documento <=> NEW.numero_documento) THEN
    SET cambios = CONCAT(cambios, separador, NEW.numero_documento);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.numero_documento);
    SET campos = CONCAT(campos, separador, 'numero_documento');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.nombre <=> NEW.nombre) THEN
    SET cambios = CONCAT(cambios, separador, NEW.nombre);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.nombre);
    SET campos = CONCAT(campos, separador, 'nombre');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.apellido <=> NEW.apellido) THEN
    SET cambios = CONCAT(cambios, separador, NEW.apellido);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.apellido);
    SET campos = CONCAT(campos, separador, 'apellido');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.correo_electronico <=> NEW.correo_electronico) THEN
    SET cambios = CONCAT(cambios, separador, NEW.correo_electronico);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.correo_electronico);
    SET campos = CONCAT(campos, separador, 'correo_electronico');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.nombre_usuario <=> NEW.nombre_usuario) THEN
    SET cambios = CONCAT(cambios, separador, NEW.nombre_usuario);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.nombre_usuario);
    SET campos = CONCAT(campos, separador, 'nombre_usuario');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.telefono <=> NEW.telefono) THEN
    SET cambios = CONCAT(cambios, separador, NEW.telefono);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.telefono);
    SET campos = CONCAT(campos, separador, 'telefono');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.direccion <=> NEW.direccion) THEN
    SET cambios = CONCAT(cambios, separador, NEW.direccion);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.direccion);
    SET campos = CONCAT(campos, separador, 'direccion');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.genero <=> NEW.genero) THEN
    SET cambios = CONCAT(cambios, separador, NEW.genero);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.genero);
    SET campos = CONCAT(campos, separador, 'genero');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.estado <=> NEW.estado) THEN
    SET cambios = CONCAT(cambios, separador, NEW.estado);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.estado);
    SET campos = CONCAT(campos, separador, 'estado');
    SET separador = '; ';
  END IF;

  IF NOT (OLD.condicion <=> NEW.condicion) THEN
    SET cambios = CONCAT(cambios, separador, NEW.condicion);
    SET cambios_anterior = CONCAT(cambios_anterior, separador, OLD.condicion);
    SET campos = CONCAT(campos, separador, 'condicion');
    SET separador = '; ';
  END IF;

  -- Insertar registro solo si hubo cambios
  IF cambios <> '' THEN
    INSERT INTO auditoria_usuarios (
      id_usuario_afectado,
      id_usuario_editor,
      campo_modificado,
      valor_anterior,
      valor_nuevo,
      fecha_cambio
    ) VALUES (
      OLD.id_usuario,
      @id_usuario_editor,
      campos,
      cambios_anterior,
      cambios,
      NOW()
    );
  END IF;
END$$

DELIMITER ;
```

