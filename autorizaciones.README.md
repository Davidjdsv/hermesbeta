### 1. Creación de la tabla 'Autorizaciones',
-- Creación de la tabla 'autorizaciones'

'''sql
CREATE TABLE autorizaciones (
    id_autorizacion INT PRIMARY KEY,
    id_prestamo INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_accion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    motivo_rechazo TEXT,
    
    -- Claves foráneas
    CONSTRAINT fk_autorizaciones_prestamos
        FOREIGN KEY (id_prestamo)
        REFERENCES prestamos(id_prestamo),
        
    CONSTRAINT fk_autorizaciones_usuario_rol
        FOREIGN KEY (id_usuario)
        REFERENCES usuario_rol(id_usuario)
);
'''

### 2. Insert de datos en la tabla 'autorizaciones'

'''sql

INSERT INTO autorizaciones (id_prestamo, id_usuario, motivo_rechazo) 
VALUES (2, 43, NULL);

INSERT INTO autorizaciones (id_prestamo, id_usuario, motivo_rechazo)
VALUES (4, 50, 'Equipos no disponibles para la fecha solicitada');

INSERT INTO autorizaciones (id_prestamo, id_usuario, motivo_rechazo)
VALUES (1, 55, NULL);

INSERT INTO autorizaciones (id_prestamo, id_usuario, motivo_rechazo)
VALUES (5, 53, 'Usuario con préstamos pendientes por devolver');

INSERT INTO autorizaciones (id_prestamo, id_usuario, motivo_rechazo)
VALUES (6, 46, NULL);
'''

### 3. Triggers para autorizaciones

'''
Resumen de Comportamiento
Situación	Estado del Préstamo	Equipos
Ninguna firma	Pendiente	Sin cambios
1-2 aprobaciones	Trámite	Sin cambios
3+ aprobaciones	Autorizado	Sin cambios
Al menos 1 rechazo	Rechazado	Todos a "Disponible"
'''

DELIMITER //

CREATE TRIGGER after_autorizaciones_insert
AFTER INSERT ON autorizaciones
FOR EACH ROW
BEGIN
    DECLARE firmas_aprobadas_count INT;
    DECLARE rechazos_count INT;
    DECLARE current_status VARCHAR(50);
    DECLARE new_status VARCHAR(50);
    
    -- Contar firmas aprobatorias (motivo_rechazo IS NULL)
    SELECT COUNT(DISTINCT id_rol) INTO firmas_aprobadas_count
    FROM autorizaciones
    WHERE id_prestamo = NEW.id_prestamo
    AND motivo_rechazo IS NULL;
    
    -- Contar rechazos (motivo_rechazo IS NOT NULL)
    SELECT COUNT(*) INTO rechazos_count
    FROM autorizaciones
    WHERE id_prestamo = NEW.id_prestamo
    AND motivo_rechazo IS NOT NULL;
    
    -- Obtener estado actual del préstamo
    SELECT estado_prestamo INTO current_status
    FROM prestamos
    WHERE id_prestamo = NEW.id_prestamo;
    
    -- Lógica de estados (prioridad a rechazos)
    IF rechazos_count > 0 THEN
        SET new_status = 'Rechazado';
        
        -- Liberar equipos asociados
        UPDATE equipos e
        JOIN detalle_prestamo pd ON e.equipo_id = pd.equipo_id
        SET e.id_estado = 1
        WHERE pd.id_prestamo = NEW.id_prestamo
        AND e.id_estado != 1; -- Optimización: solo actualizar si no está ya disponible
        
    ELSEIF firmas_aprobadas_count = 0 THEN
        SET new_status = 'Pendiente';
    ELSEIF firmas_aprobadas_count <= 2 THEN
        SET new_status = 'Trámite';
    ELSE
        SET new_status = 'Autorizado';
    END IF;
    
    -- Actualizar solo si el estado cambió
    IF current_status != new_status THEN
        UPDATE prestamos
        SET estado_prestamo = new_status
        WHERE id_prestamo = NEW.id_prestamo;        
    END IF;
END//

DELIMITER ;

'''********************************************************************************
para desautorizar un prestamo ya firmado
********************************************************************************'''

DELIMITER //

CREATE TRIGGER after_autorizaciones_delete
AFTER DELETE ON autorizaciones
FOR EACH ROW
BEGIN
    DECLARE firmas_count INT;
    
    -- Contar firmas restantes
    SELECT COUNT(DISTINCT id_rol) INTO firmas_count
    FROM autorizaciones
    WHERE id_prestamo = OLD.id_prestamo;
    
    -- Actualizar estado según conteo
    IF firmas_count = 0 THEN
        UPDATE prestamos SET estado_prestamo = 'Pendiente' WHERE id_prestamo = OLD.id_prestamo;
    ELSEIF firmas_count <= 2 THEN
        UPDATE prestamos SET estado_prestamo = 'Trámite' WHERE id_prestamo = OLD.id_prestamo;
    ELSE
        UPDATE prestamos SET estado_prestamo = 'Autorizado' WHERE id_prestamo = OLD.id_prestamo;
    END IF;
END//

DELIMITER ;