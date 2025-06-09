///// Crear una nueva tabla de Mantenimiento

'''sql
CREATE TABLE `mantenimiento` (
  `Id_mantenimiento` int(30) NOT NULL,
  `equipo_id` int(11) NOT NULL,
  `detalles` text NOT NULL,
  `gravedad` enum('ninguno','leve','grave') DEFAULT NULL,
  `tipo_mantenimiento` enum('preventivo','correctivo') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

# Indices de la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  ADD PRIMARY KEY (`Id_mantenimiento`),
  ADD KEY `equipo_id` (`equipo_id`);

# AUTO_INCREMENT de la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  MODIFY `Id_mantenimiento` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;
