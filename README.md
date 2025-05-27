# Scripts SQL para la Base de Datos hermes002

Este archivo contiene instrucciones y consultas SQL que deben ejecutarse en la base de datos `hermes002` para realizar actualizaciones o modificaciones específicas.

**¡IMPORTANTE!**

* Asegúrate de estar conectado a la base de datos `hermes002` antes de ejecutar estas consultas.
* Realiza una copia de seguridad de la base de datos antes de ejecutar cualquier script, por si acaso necesitas revertir los cambios.
* Ejecuta las consultas en el orden en que aparecen en este archivo, si el orden es relevante.

## Consultas y Procedimientos

### 1. Agregar columna `foto` a la tabla `usuarios`

- Se debe agregar una columna llamada `foto` de tipo `VARCHAR(100)` a la tabla `usuarios`, ubicada después de la columna `genero`.

```sql
ALTER TABLE usuarios
ADD COLUMN foto VARCHAR(100) AFTER genero;
```

### 2. Ruta por defecto para la foto de usuario

- Al crear un nuevo usuario, el valor por defecto de la columna `foto` debe ser:  
    `vistas/img/usuarios/default/anonymous.png`

### 3. Creación automática de carpetas para fotos de usuario

- Cuando se crea un usuario nuevo:
    - Se debe crear automáticamente la carpeta `img` dentro de la carpeta `vistas` si no existe.
    - Dentro de `img`, se debe crear la carpeta `usuarios`.
    - Dentro de `usuarios`, se debe crear una carpeta con el número de documento del usuario.
    - En esa carpeta es donde se almacenará la foto del usuario.

### 4. Ejemplo de actualización de datos

```sql
-- Ejemplo: Actualizar la ruta de la foto para un usuario existente
UPDATE usuarios
SET foto = 'vistas/img/usuarios/default/anonymous.png'
WHERE id_usuario = 1;
```



### 5. Agregar tabla  `auditoria_usuarios` 
```sql
CREATE TABLE auditoria_aprendices 
  id INT AUTO_INCREMENT PRIMARY KEY,
  accion VARCHAR(50),
  descripcion TEXT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP`
  ```
  -Esto permite rastrear qué acciones se han ejecutado sobre los datos de los aprendices, cuándo ocurrieron y en qué consistieron

### 6. Agregar trigger a la tabla  `auditoria_usuarios`
```sql 
  DELIMITER $$

CREATE TRIGGER trg_auditar_usuarios
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
  DECLARE cambios TEXT DEFAULT '';
  DECLARE valores_anteriores TEXT DEFAULT '';
  DECLARE valores_nuevos TEXT DEFAULT '';

  -- Comparar y registrar cada campo que cambie
  IF OLD.tipo_documento <> NEW.tipo_documento THEN
    SET cambios = CONCAT(cambios, 'tipo_documento; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.tipo_documento, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.tipo_documento, '; ');
  END IF;

  IF OLD.numero_documento <> NEW.numero_documento THEN
    SET cambios = CONCAT(cambios, 'numero_documento; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.numero_documento, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.numero_documento, '; ');
  END IF;

  IF OLD.nombre <> NEW.nombre THEN
    SET cambios = CONCAT(cambios, 'nombre; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.nombre, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.nombre, '; ');
  END IF;

  IF OLD.apellido <> NEW.apellido THEN
    SET cambios = CONCAT(cambios, 'apellido; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.apellido, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.apellido, '; ');
  END IF;

  IF OLD.correo_electronico <> NEW.correo_electronico THEN
    SET cambios = CONCAT(cambios, 'correo_electronico; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.correo_electronico, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.correo_electronico, '; ');
  END IF;

  IF OLD.telefono <> NEW.telefono THEN
    SET cambios = CONCAT(cambios, 'telefono; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.telefono, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.telefono, '; ');
  END IF;

  IF OLD.direccion <> NEW.direccion THEN
    SET cambios = CONCAT(cambios, 'direccion; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.direccion, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.direccion, '; ');
  END IF;

  IF OLD.genero <> NEW.genero THEN
    SET cambios = CONCAT(cambios, 'genero; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.genero, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.genero, '; ');
  END IF;

  IF OLD.estado <> NEW.estado THEN
    SET cambios = CONCAT(cambios, 'estado; ');
    SET valores_anteriores = CONCAT(valores_anteriores, OLD.estado, '; ');
    SET valores_nuevos = CONCAT(valores_nuevos, NEW.estado, '; ');
  END IF;

  -- Si hubo algún cambio, insertar en la tabla de auditoría
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
      NEW.id_usuario, -- Asume que el campo NEW.id_usuario guarda el editor; puedes ajustarlo según tu lógica
      cambios,
      valores_anteriores,
      valores_nuevos,
      NOW()
    );
  END IF;
END$$

DELIMITER ;
```
-Este trigger compara los valores antiguos y nuevos de varios campos (como tipo_documento, nombre, apellido, correo_electronico, etc.) y, si detecta algún cambio, inserta un registro en la tabla auditoria_usuarios con los siguientes datos:

ID del usuario afectado.

ID del usuario que realizó el cambio.

Campos modificados.

Valores anteriores.

Valores nuevos.

Fecha del cambio


