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


