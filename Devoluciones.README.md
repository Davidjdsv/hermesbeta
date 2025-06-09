# Scripts SQL para la Base de Datos hermes002

Este archivo contiene instrucciones y consultas SQL que deben ejecutarse en la base de datos `hermes002` para realizar actualizaciones o modificaciones específicas.

**¡IMPORTANTE!**

* Asegúrate de estar conectado a la base de datos `hermes002` antes de ejecutar estas consultas.
* Realiza una copia de seguridad de la base de datos antes de ejecutar cualquier script, por si acaso necesitas revertir los cambios.
* Ejecuta las consultas en el orden en que aparecen en este archivo, si el orden es relevante.

## Insertar el nuevo estado de "baja" en la tabla de "estados"

```sql
INSERT INTO estados (estado) VALUES ('baja');
```

## Insertar el nuevo estado de "Devuelto" en la tabla "prestamos" en la colomna "estado_prestamo"

```sql
ALTER TABLE prestamos MODIFY COLUMN estado_prestamo ENUM('Prestado','Mantenimiento','Rechazado','Autorizado','Pendiente','Tramite','Disponible','Devuelto') NULL;
```


