### 1. Agregar trigger a la tabla  `prestamos`
-- Este trigger se ejecutará después de cada actualización en la tabla prestamos.
```sql
DELIMITER //

CREATE TRIGGER actualizar_estado_equipo_por_prestamo
AFTER UPDATE ON prestamos
FOR EACH ROW
BEGIN
    
    IF OLD.estado_prestamo = 'Autorizado' AND NEW.estado_prestamo = 'Prestado' THEN
        
        UPDATE equipos e
        JOIN detalle_prestamo dp ON e.equipo_id = dp.equipo_id
        SET e.id_estado = 2
        WHERE dp.id_prestamo = NEW.id_prestamo
          AND e.id_estado = 3; 
    END IF;
END//

DELIMITER ;

```
