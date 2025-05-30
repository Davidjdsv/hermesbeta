-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2025 a las 23:52:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hermes002`
--
CREATE DATABASE IF NOT EXISTS `hermes002` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hermes002`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprendices_ficha`
--

CREATE TABLE `aprendices_ficha` (
  `id_aprendiz_ficha` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_ficha` int(11) NOT NULL,
  `fecha_asignacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo','desertor','trasladado') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aprendices_ficha`
--

INSERT INTO `aprendices_ficha` (`id_aprendiz_ficha`, `id_usuario`, `id_ficha`, `fecha_asignacion`, `estado`) VALUES
(2, 44, 5, '2025-04-04 22:32:43', 'activo'),
(3, 50, 4, '2025-04-04 22:32:43', 'activo'),
(4, 60, 10, '2025-04-04 22:32:43', 'activo'),
(5, 72, 11, '2025-04-13 22:11:36', 'activo'),
(6, 73, 11, '2025-04-24 23:41:43', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `categoria_id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`categoria_id`, `nombre`) VALUES
(1, 'Portátiles'),
(2, 'Video'),
(3, 'Sonido'),
(4, 'Cables'),
(5, 'Control Remoto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_prestamo`
--

CREATE TABLE `detalle_prestamo` (
  `cons_detalle` int(11) NOT NULL,
  `id_prestamo` int(11) NOT NULL,
  `equipo_id` int(11) NOT NULL,
  `estado` enum('Asignado','Devuelto') NOT NULL DEFAULT 'Asignado',
  `fecha_actualizacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_prestamo`
--

INSERT INTO `detalle_prestamo` (`cons_detalle`, `id_prestamo`, `equipo_id`, `estado`, `fecha_actualizacion`) VALUES
(2, 1, 1, 'Asignado', '2025-04-18 14:55:08'),
(3, 1, 2, 'Asignado', '2025-04-18 14:55:08'),
(4, 1, 6, 'Asignado', '2025-04-18 14:55:08'),
(5, 2, 4, 'Asignado', '2025-04-18 15:35:51'),
(6, 2, 7, 'Asignado', '2025-04-18 15:35:51'),
(7, 2, 11, 'Asignado', '2025-04-18 15:35:51'),
(8, 2, 27, 'Asignado', '2025-04-18 15:35:51'),
(11, 5, 5, 'Devuelto', '2025-04-18 15:42:48'),
(12, 5, 16, 'Devuelto', '2025-04-18 15:42:48'),
(15, 4, 31, 'Asignado', '2025-04-18 16:32:03'),
(16, 4, 42, 'Asignado', '2025-04-18 16:32:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `equipo_id` int(11) NOT NULL,
  `numero_serie` varchar(100) NOT NULL,
  `etiqueta` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fecha_entrada` timestamp NOT NULL DEFAULT current_timestamp(),
  `ubicacion_id` int(11) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT 1,
  `cuentadante_id` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`equipo_id`, `numero_serie`, `etiqueta`, `descripcion`, `fecha_entrada`, `ubicacion_id`, `categoria_id`, `cuentadante_id`, `id_estado`) VALUES
(1, 'SN001', '9125001SN001777', 'HP EliteBook 666', '2025-04-17 20:42:57', 1, 1, 55, 2),
(2, 'SN002', '9125001SN002', 'Dell XPS 13', '2025-04-17 20:42:57', 1, 1, 42, 2),
(3, 'SN003', '9125001SN003', 'Lenovo ThinkPad X1', '2025-04-17 20:42:57', 2, 1, 42, 5),
(4, 'SN004', '9125001SN004', 'MacBook Pro 16\"', '2025-04-17 20:42:57', 1, 1, 42, 3),
(5, 'SN005', '9125001SN005', 'Acer Swift 3', '2025-04-17 20:42:57', 2, 1, 42, 5),
(6, 'SN006', '9125002SN006', 'Cámara Sony AX53', '2025-04-17 20:43:57', 1, 2, 42, 2),
(7, 'SN007', '9125002SN007', 'Proyector Epson 4K', '2025-04-17 20:43:57', 2, 2, 42, 3),
(8, 'SN008', '9125002SN008', 'Trípode Manfrotto', '2025-04-17 20:43:57', 1, 2, 42, 5),
(9, 'SN009', '9125002SN009', 'Grabadora Panasonic', '2025-04-17 20:43:57', 2, 2, 42, 5),
(10, 'SN010', '9125002SN010', 'Lente Canon 24-70mm', '2025-04-17 20:43:57', 1, 2, 42, 5),
(11, 'SN011', '9125003SN011', 'Micrófono Shure SM58', '2025-04-17 20:43:57', 1, 3, 42, 3),
(12, 'SN012', '9125003SN012', 'Altavoz Bose S1 Pro', '2025-04-17 20:43:57', 2, 3, 42, 5),
(13, 'SN013', '9125003SN013', 'Mezcladora Yamaha MG10', '2025-04-17 20:43:57', 1, 3, 42, 5),
(14, 'SN014', '9125003SN014', 'Audífonos Sennheiser HD', '2025-04-17 20:43:57', 2, 3, 42, 5),
(15, 'SN015', '9125003SN015', 'Interface Audio Focusrite', '2025-04-17 20:43:57', 1, 3, 42, 5),
(16, 'SN016', '9125004SN016', 'HDMI 2.1 3m', '2025-04-17 20:43:57', 1, 4, 42, 5),
(17, 'SN017', '9125004SN017', 'USB-C a Ethernet', '2025-04-17 20:43:57', 2, 4, 42, 5),
(18, 'SN018', '9125004SN018', 'VGA 5m', '2025-04-17 20:43:57', 1, 4, 42, 5),
(19, 'SN019', '9125004SN019', 'DisplayPort 2m', '2025-04-17 20:43:57', 2, 4, 42, 5),
(20, 'SN020', '9125004SN020', 'Cable de Red CAT6', '2025-04-17 20:43:57', 1, 4, 42, 5),
(21, 'SN021', '9125005SN021', 'Control Universal Logitech', '2025-04-17 20:43:57', 1, 5, 42, 5),
(22, 'SN022', '9125005SN022', 'Control Sony TV', '2025-04-17 20:43:57', 2, 5, 42, 5),
(23, 'SN023', '9125005SN023', 'Control Samsung Smart', '2025-04-17 20:43:57', 1, 5, 42, 5),
(24, 'SN024', '9125005SN024', 'Control LG Magic', '2025-04-17 20:43:57', 2, 5, 42, 5),
(25, 'SN025', '9125005SN025', 'Control Philips HDMI', '2025-04-17 20:43:57', 1, 5, 42, 5),
(26, 'SN026', '9125001SN026', 'HP ProBook 450', '2025-04-17 20:43:57', 2, 1, 42, 5),
(27, 'SN027', '9125002SN027', 'Cámara Canon XA11', '2025-04-17 20:43:57', 1, 2, 42, 3),
(28, 'SN028', '9125003SN028', 'Micrófono Rode NT-USB', '2025-04-17 20:43:57', 2, 3, 42, 5),
(29, 'SN029', '9125004SN029', 'HDMI 1.4 5m', '2025-04-17 20:43:57', 1, 4, 42, 5),
(30, 'SN030', '9125005SN030', 'Control Panasonic TV', '2025-04-17 20:43:57', 2, 5, 42, 5),
(31, 'SN031', '9125001SN031', 'Dell Latitude 5420', '2025-04-17 20:46:40', 1, 1, 42, 3),
(32, 'SN032', '9125002SN032', 'Cámara Panasonic HC-X1500', '2025-04-17 20:46:40', 2, 2, 42, 5),
(33, 'SN033', '9125003SN033', 'Altavoz JBL EON 615', '2025-04-17 20:46:40', 1, 3, 42, 5),
(34, 'SN034', '9125004SN034', 'Cable USB 3.0 2m', '2025-04-17 20:46:40', 2, 4, 42, 5),
(35, 'SN035', '9125005SN035', 'Control Sony Blu-ray', '2025-04-17 20:46:40', 1, 5, 42, 5),
(36, 'SN036', '9125001SN036', 'MacBook Air M2', '2025-04-17 20:46:40', 2, 1, 42, 5),
(37, 'SN037', '9125002SN037', 'Trípode Gitzo GT3543', '2025-04-17 20:46:40', 1, 2, 42, 5),
(38, 'SN038', '9125003SN038', 'Micrófono Audio-Technica AT2020', '2025-04-17 20:46:40', 2, 3, 42, 5),
(39, 'SN039', '9125004SN039', 'Cable Optical Toslink 5m', '2025-04-17 20:46:40', 1, 4, 42, 5),
(40, 'SN040', '9125005SN040', 'Control LG Smart TV', '2025-04-17 20:46:40', 2, 5, 42, 5),
(41, 'SN041', '9125001SN041', 'Lenovo Yoga 920', '2025-04-17 20:46:40', 1, 1, 42, 5),
(42, 'SN042', '9125002SN042', 'Proyector BenQ HT3550', '2025-04-17 20:46:40', 2, 2, 42, 3),
(43, 'SN043', '9125003SN043', 'Interface Audio PreSonus 24c', '2025-04-17 20:46:40', 1, 3, 42, 5),
(44, 'SN044', '9125004SN044', 'Cable HDMI ARC 4m', '2025-04-17 20:46:40', 2, 4, 42, 5),
(45, 'SN045', '9125005SN045', 'Control Roku Ultra', '2025-04-17 20:46:40', 1, 5, 42, 5),
(46, 'SN046', '9125001SN046', 'Asus ZenBook 14', '2025-04-17 20:46:40', 2, 1, 42, 5),
(47, 'SN047', '9125002SN047', 'Grabadora Zoom H6', '2025-04-17 20:46:40', 1, 2, 42, 5),
(48, 'SN048', '9125003SN048', 'Audífonos Audio-Technica M50x', '2025-04-17 20:46:40', 2, 3, 42, 5),
(49, 'SN049', '9125004SN049', 'Cable VGA 3m con Conectores Dorados', '2025-04-17 20:46:40', 1, 4, 42, 5),
(50, 'SN050', '9125005SN050', 'Control Amazon Fire TV', '2025-04-17 20:46:40', 2, 5, 42, 5),
(51, 'loiujythrteb', '43QGV45J', 'Hola jota pe', '2025-05-26 21:31:30', 4, 2, 42, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id_estado` int(11) NOT NULL,
  `estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`id_estado`, `estado`) VALUES
(1, 'Disponible'),
(2, 'Prestado'),
(3, 'Reservado'),
(4, 'Mantenimiento'),
(5, 'Almacén');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fichas`
--

CREATE TABLE `fichas` (
  `id_ficha` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `id_sede` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activa','inactiva') DEFAULT 'activa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fichas`
--

INSERT INTO `fichas` (`id_ficha`, `codigo`, `descripcion`, `id_sede`, `fecha_inicio`, `fecha_fin`, `fecha_creacion`, `estado`) VALUES
(1, '1000001', 'Tecnología en Análisis y Desarrollo de Software', 1, '2024-01-15', '2024-12-15', '2025-03-25 04:26:50', 'inactiva'),
(2, '1000002', 'Técnico en Sistemas', 28, '2024-02-01', '2024-11-30', '2025-03-25 04:26:50', 'activa'),
(3, '1000003', 'Gestión Administrativa', 3, '2024-03-10', '2024-12-10', '2025-03-25 04:26:50', 'activa'),
(4, '1000004', 'Diseño e Integración de Multimedia', 27, '2024-04-05', '2025-03-05', '2025-03-25 04:26:50', 'activa'),
(5, '1000005', 'Producción Agropecuaria', 28, '2024-05-20', '2025-04-20', '2025-03-25 04:26:50', 'inactiva'),
(6, '1000006', 'Electricidad Industrial', 1, '2024-06-01', '2025-05-01', '2025-03-25 04:26:50', 'activa'),
(7, '1000007', 'Mecánica Automotriz', 2, '2024-07-15', '2025-06-15', '2025-03-25 04:26:50', 'activa'),
(8, '1000008', 'Contabilidad y Finanzas', 28, '2024-08-10', '2025-07-10', '2025-03-25 04:26:50', 'activa'),
(9, '1000009', 'Seguridad y Salud en el Trabajo', 27, '2024-09-05', '2025-08-05', '2025-03-25 04:26:50', 'inactiva'),
(10, '1000010', 'Redes y Telecomunicaciones', 28, '2024-10-20', '2025-09-20', '2025-03-25 04:26:50', 'activa'),
(11, '2847523', 'ADSO', 1, '2025-03-01', '2025-03-31', '2025-03-25 06:00:56', 'activa'),
(12, '1111', 'ADSO', 28, '2025-03-01', '2025-03-29', '2025-03-26 22:44:36', 'activa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_roles`
--

CREATE TABLE `historial_roles` (
  `id_historial` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_rol_anterior` int(11) DEFAULT NULL,
  `id_rol_nuevo` int(11) NOT NULL,
  `fecha_cambio` timestamp NULL DEFAULT current_timestamp(),
  `id_usuario_modificador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id_modulo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`id_modulo`, `nombre`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 'Gestión de equipos', 'Módulo para administrar equipos tecnológicos', '2025-03-22 21:35:28', 'activo'),
(2, 'Gestión de solicitudes', 'Módulo para gestionar solicitudes y asignaciones de equipos', '2025-03-22 21:35:28', 'activo'),
(3, 'Devoluciones', 'Módulo para gestionar devoluciones de equipos', '2025-03-22 21:35:28', 'activo'),
(4, 'Salidas', 'Módulo para controlar salidas de equipos', '2025-03-22 21:35:28', 'activo'),
(5, 'Configuración', 'Módulo para configuración general del sistema', '2025-03-22 21:35:28', 'activo'),
(6, 'Autorizaciones', 'Módulo para la autorización de las solicitudes ', '2025-03-31 06:40:46', 'activo'),
(7, 'Fichas', 'Módulo para administrar las fichas', '2025-04-15 03:54:08', 'activo'),
(8, 'Sedes', 'Módulo para la administración de las sedes', '2025-04-16 22:00:23', 'activo'),
(9, 'Roles', 'Módulo para la administración de los roles del sistema', '2025-04-16 23:25:01', 'activo'),
(10, 'Módulos', 'Módulo para la administracion de los módulos del sistema (sólo administrador)', '2025-04-17 01:18:32', 'activo'),
(11, 'Permisos', 'Módulo para el control general de permisos a los roles del sistema', '2025-04-17 03:51:17', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id_permiso` int(11) NOT NULL,
  `id_modulo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_permiso`, `id_modulo`, `nombre`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 1, 'Registrar equipooooo', 'Crear nuevos equipos en el sistemas', '2025-03-22 21:35:28', 'activo'),
(2, 1, 'Consultar equipos', 'Consultar información de equipos', '2025-03-22 21:35:28', 'activo'),
(3, 1, 'Modificar equipos', 'Modificar información de equipos', '2025-03-22 21:35:28', 'activo'),
(4, 1, 'Inhabilitar equipos', 'Inhabilitar equipos', '2025-03-22 21:35:28', 'activo'),
(5, 1, 'Asignar equipos', 'Asignar equipos a cuentadantes', '2025-03-22 21:35:28', 'activo'),
(6, 1, 'Revisar equipos', 'Revisar el estado de los equipos', '2025-03-22 21:35:28', 'activo'),
(7, 2, 'Realizar solicitudes', 'Realizar solicitudes de préstamo', '2025-03-22 21:35:28', 'activo'),
(8, 2, 'Consultar equipos', 'Consultar información de equipos para solicitudes', '2025-03-22 21:35:28', 'activo'),
(9, 2, 'Cancelar solicitudes', 'Cancelar solicitudes', '2025-03-22 21:35:28', 'activo'),
(10, 2, 'Aprobar solicitudes', 'Aprobar solicitudes de préstamo', '2025-03-22 21:35:28', 'activo'),
(11, 2, 'Entregar equipos', 'Entregar equipos a los usuarios', '2025-03-22 21:35:28', 'activo'),
(12, 3, 'Recibir equipos', 'Registrar la devolución de equipos', '2025-03-22 21:35:28', 'activo'),
(13, 3, 'Consultar solicitudes', 'Consultar solicitudes relacionadas con devoluciones', '2025-03-22 21:35:28', 'activo'),
(14, 3, 'Revisar equipos', 'Revisar el estado de los equipos devueltos', '2025-03-22 21:35:28', 'activo'),
(15, 3, 'Actualizar estados', 'Actualizar el estado de los equipos', '2025-03-22 21:35:28', 'activo'),
(16, 4, 'Autorizar salidas', 'Autorizar salidas de equipos', '2025-03-22 21:35:28', 'activo'),
(17, 4, 'Verificar autorizaciones', 'Verificar autorizaciones de salida', '2025-03-22 21:35:28', 'activo'),
(18, 4, 'Consultar salidas', 'Consultar registros de salidas de equipos', '2025-03-22 21:35:28', 'activo'),
(19, 5, 'Configuraraciones ', 'Acceso a configuraciones del sistema', '2025-03-22 21:35:28', 'activo'),
(20, 5, 'Gestionar usuarios', 'Gestionar usuarios del sistema', '2025-03-22 21:35:28', 'activo'),
(21, 5, 'Gestionar roles', 'Gestionar roles y permisos', '2025-03-22 21:35:28', 'activo'),
(22, 7, 'Gestionar fichas', 'Gestionar las fichas del sistema', '2025-04-15 03:57:21', 'activo'),
(23, 8, 'Editar sedes', 'Realizar cambios en la información de las sedes', '2025-04-16 22:03:36', 'activo'),
(24, 8, 'Crear sedes', 'Crear nuevas sedes en el sistema', '2025-04-16 22:03:36', 'activo'),
(25, 8, 'Consultar sedes', 'Permite entrar a consultar las sedes del sistema', '2025-04-16 23:13:24', 'activo'),
(26, 9, 'Editar roles', 'Realizar cambios en la información de los roles del sistema', '2025-04-16 23:28:22', 'activo'),
(27, 9, 'Crear roles', 'Crear nuevos roles en el sistemas', '2025-04-16 23:28:22', 'activo'),
(28, 9, 'Consultar roles', 'Permite consultar los diferentes roles del sistema', '2025-04-16 23:28:22', 'activo'),
(29, 10, 'Gestión de módulos (solo administrador)', 'Este acceso implica código (no aparecera en permisos)', '2025-04-17 01:19:52', 'activo'),
(30, 11, 'Gestión de permisos', 'Permitir la gestión de los diferentes permisos asignados a los roles del sistema', '2025-04-17 03:56:43', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id_prestamo` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo_prestamo` enum('Inmediato','Reservado') NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `estado_prestamo` enum('Prestado','Devuelto','Rechazado','Autorizado','Pendiente') NOT NULL DEFAULT 'Prestado',
  `motivo` varchar(200) DEFAULT NULL,
  `fecha_solicitud` datetime DEFAULT current_timestamp(),
  `fecha_devolucion_real` datetime DEFAULT NULL,
  `prestamoscol` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id_prestamo`, `usuario_id`, `tipo_prestamo`, `fecha_inicio`, `fecha_fin`, `estado_prestamo`, `motivo`, `fecha_solicitud`, `fecha_devolucion_real`, `prestamoscol`) VALUES
(1, 72, 'Inmediato', '2025-04-18 09:00:00', '2025-04-18 17:00:00', 'Prestado', 'Clase de informática', '2025-04-18 14:50:08', NULL, NULL),
(2, 46, 'Reservado', '2025-04-22 08:00:00', '2025-04-24 18:00:00', 'Autorizado', 'Grabación de documental', '2025-04-18 15:35:27', NULL, NULL),
(4, 51, 'Reservado', '2025-05-05 10:00:00', '2025-05-07 16:00:00', 'Pendiente', 'Conferencia académica', '2025-04-18 15:39:20', NULL, NULL),
(5, 1, 'Inmediato', '2025-04-10 14:00:00', '2025-04-10 18:00:00', 'Devuelto', 'Reunión de trabajo', '2025-04-18 15:42:48', NULL, NULL),
(6, 1, 'Inmediato', '2025-04-10 14:00:00', '2025-04-10 18:00:00', 'Devuelto', 'Reunión de trabajo', '2025-04-18 15:43:07', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 'Líder TIC', 'Rol con acceso completo a todos los módulos y permisos', '2025-03-22 21:35:28', 'activo'),
(2, 'Mesa de ayuda', 'Rol con permisos limitados para atención de solicitudes', '2025-03-22 21:35:28', 'activo'),
(3, 'Almacén', 'Rol con permisos para gestionar equipos y solicitudes', '2025-03-22 21:35:28', 'activo'),
(4, 'Biblioteca', 'Rol con permisos para consultar equipos y gestionar solicitudes', '2025-03-22 21:35:28', 'activo'),
(5, 'Coordinación', 'Rol con permisos similares a adminBiblioteca', '2025-03-22 21:35:28', 'activo'),
(6, 'Aprendiz', 'Rol con permisos limitados para realizar solicitudes', '2025-03-22 21:35:28', 'activo'),
(7, 'Instructor', 'Rol con permisos para solicitudes y autorizar salidas', '2025-03-22 21:35:28', 'activo'),
(8, 'Vigilante', 'Rol con permisos para verificar autorizaciones', '2025-03-22 21:35:28', 'activo'),
(9, 'Administrador', 'Rol con acceso completo a todos los módulos y configuración', '2025-03-22 21:35:28', 'activo'),
(10, 'Auxiliar administrativo', 'permisos de coordinación pero limitados', '2025-03-29 23:46:36', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso`
--

CREATE TABLE `rol_permiso` (
  `id_rol` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL,
  `fecha_asignacion` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id_rol`, `id_permiso`, `fecha_asignacion`) VALUES
(1, 1, '2025-04-17 01:26:02'),
(1, 2, '2025-04-17 01:26:02'),
(1, 3, '2025-04-17 01:26:02'),
(1, 4, '2025-04-17 01:26:02'),
(1, 5, '2025-04-17 01:26:02'),
(1, 6, '2025-04-17 01:26:02'),
(1, 7, '2025-04-17 01:26:02'),
(1, 8, '2025-04-17 01:26:02'),
(1, 9, '2025-04-17 01:26:02'),
(1, 10, '2025-04-17 01:26:02'),
(1, 11, '2025-04-17 01:26:02'),
(1, 12, '2025-04-17 01:26:02'),
(1, 13, '2025-04-17 01:26:02'),
(1, 14, '2025-04-17 01:26:02'),
(1, 15, '2025-04-17 01:26:02'),
(1, 16, '2025-04-17 01:26:02'),
(1, 17, '2025-04-17 01:26:02'),
(1, 18, '2025-04-17 01:26:02'),
(1, 19, '2025-04-17 01:26:02'),
(1, 20, '2025-04-17 01:26:02'),
(1, 21, '2025-04-17 01:26:02'),
(2, 2, '2025-04-16 23:15:44'),
(2, 6, '2025-04-16 23:15:44'),
(2, 12, '2025-04-16 23:15:44'),
(2, 14, '2025-04-16 23:15:44'),
(2, 15, '2025-04-16 23:15:44'),
(2, 25, '2025-04-16 23:15:44'),
(3, 1, '2025-03-22 21:35:28'),
(3, 2, '2025-03-22 21:35:28'),
(3, 3, '2025-03-22 21:35:28'),
(3, 4, '2025-03-22 21:35:28'),
(3, 5, '2025-03-22 21:35:28'),
(3, 7, '2025-03-22 21:35:28'),
(3, 8, '2025-03-22 21:35:28'),
(3, 9, '2025-03-22 21:35:28'),
(3, 10, '2025-03-22 21:35:28'),
(3, 11, '2025-03-22 21:35:28'),
(3, 12, '2025-03-22 21:35:28'),
(3, 13, '2025-03-22 21:35:28'),
(4, 2, '2025-03-22 21:35:28'),
(4, 7, '2025-03-22 21:35:28'),
(4, 8, '2025-03-22 21:35:28'),
(4, 9, '2025-03-22 21:35:28'),
(4, 10, '2025-03-22 21:35:28'),
(4, 11, '2025-03-22 21:35:28'),
(4, 12, '2025-03-22 21:35:28'),
(4, 13, '2025-03-22 21:35:28'),
(5, 2, '2025-03-22 21:35:28'),
(5, 7, '2025-03-22 21:35:28'),
(5, 8, '2025-03-22 21:35:28'),
(5, 9, '2025-03-22 21:35:28'),
(5, 10, '2025-03-22 21:35:28'),
(5, 11, '2025-03-22 21:35:28'),
(5, 12, '2025-03-22 21:35:28'),
(5, 13, '2025-03-22 21:35:28'),
(6, 7, '2025-03-22 21:35:28'),
(6, 8, '2025-03-22 21:35:28'),
(6, 9, '2025-03-22 21:35:28'),
(7, 7, '2025-03-22 21:35:28'),
(7, 8, '2025-03-22 21:35:28'),
(7, 9, '2025-03-22 21:35:28'),
(7, 16, '2025-03-22 21:35:28'),
(8, 17, '2025-04-13 23:23:05'),
(8, 18, '2025-04-13 23:23:05'),
(9, 1, '2025-04-17 04:13:19'),
(9, 2, '2025-04-17 04:13:19'),
(9, 3, '2025-04-17 04:13:19'),
(9, 4, '2025-04-17 04:13:19'),
(9, 5, '2025-04-17 04:13:19'),
(9, 6, '2025-04-17 04:13:19'),
(9, 7, '2025-04-17 04:13:19'),
(9, 8, '2025-04-17 04:13:19'),
(9, 9, '2025-04-17 04:13:19'),
(9, 10, '2025-04-17 04:13:19'),
(9, 11, '2025-04-17 04:13:19'),
(9, 12, '2025-04-17 04:13:19'),
(9, 13, '2025-04-17 04:13:19'),
(9, 14, '2025-04-17 04:13:19'),
(9, 15, '2025-04-17 04:13:19'),
(9, 16, '2025-04-17 04:13:19'),
(9, 17, '2025-04-17 04:13:20'),
(9, 18, '2025-04-17 04:13:20'),
(9, 19, '2025-04-17 04:13:20'),
(9, 20, '2025-04-17 04:13:20'),
(9, 21, '2025-04-17 04:13:20'),
(9, 22, '2025-04-17 04:13:20'),
(9, 23, '2025-04-17 04:13:20'),
(9, 24, '2025-04-17 04:13:20'),
(9, 25, '2025-04-17 04:13:20'),
(9, 26, '2025-04-17 04:13:20'),
(9, 27, '2025-04-17 04:13:20'),
(9, 28, '2025-04-17 04:13:20'),
(9, 29, '2025-04-17 04:13:20'),
(9, 30, '2025-04-17 04:13:20'),
(10, 18, '2025-04-14 02:51:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `id_sede` int(11) NOT NULL,
  `nombre_sede` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activa','inactiva') DEFAULT 'activa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sedes`
--

INSERT INTO `sedes` (`id_sede`, `nombre_sede`, `direccion`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 'Sede Principal', 'Carrera 50 #10-25', 'Sede central con capacidad para 1000 aprendices', '2025-03-23 20:18:06', 'activa'),
(2, 'Sede Norte', 'Calle 80 #45-12', 'Sede especializada en tecnologías de la información', '2025-03-23 20:18:06', 'inactiva'),
(3, 'Sede Sur', 'Avenida 1 de Mayo #30-15', 'Sede con enfoque en áreas industriales', '2025-03-23 20:18:06', 'activa'),
(27, 'Sagrado', 'Cra 26 25', 'Horario de formacion en ambas jornadas', '2025-03-24 19:57:38', 'activa'),
(28, 'Bicentenario', 'CC Bicentenario Plazas', 'dos salones de 25 aprendices (202 y 205)', '2025-03-24 19:57:58', 'activa'),
(29, 'aa', 'aa', 'aa', '2025-04-05 01:56:06', 'activa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicaciones`
--

CREATE TABLE `ubicaciones` (
  `ubicacion_id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `id_sede` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicaciones`
--

INSERT INTO `ubicaciones` (`ubicacion_id`, `nombre`, `descripcion`, `id_sede`) VALUES
(1, 'Biblioteca Sagrado', 'Área de préstamo de equipos en el edificio de la biblioteca principal, piso 1', 27),
(2, 'Coordinacion Sagrado', 'Oficina de coordinación tecnológica del campus Sagrado Corazón', 27),
(3, 'Coordinacion Principal', 'Oficina central de gestión de equipos tecnológicos', 1),
(4, 'Almacen', 'Almacen principal', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `tipo_documento` varchar(5) NOT NULL,
  `numero_documento` varchar(30) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `genero` int(11) DEFAULT 3,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `fecha_registro` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `tipo_documento`, `numero_documento`, `nombre`, `apellido`, `correo_electronico`, `nombre_usuario`, `clave`, `telefono`, `direccion`, `genero`, `estado`, `fecha_registro`) VALUES
(1, 'CC', '1', 'Admin', 'Sistema', 'admin@sistema.com', 'admin', 'admin123', NULL, NULL, 3, 'activo', '2025-03-22 21:35:28'),
(42, 'CC', '1023456789', 'Juan', 'Pérez', 'juan.perez@email.com', 'juanperez1', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(43, 'TI', '1234567', 'María', 'Gómez', 'maria.gomez@email.com', 'mariagomez2', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(44, 'CC', '1098765432', 'Carlos', 'López', 'carlos.lopez@email.com', 'carloslopez3', 'clave123', NULL, NULL, 3, 'inactivo', '2025-04-02 08:29:02'),
(45, 'TI', '7654321', 'Ana', 'Martínez', 'ana.martinez@email.com', 'anamartinez4', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(46, 'CC', '1002345678', 'Pedro', 'Sánchez', 'pedro.sanchez@email.com', 'pedrosanchez5', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(47, 'TI', '1122334', 'Laura', 'Fernández', 'laura.fernandez@email.com', 'laurafernandez6', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(48, 'CC', '1034567890', 'Luis', 'Torres', 'luis.torres@email.com', 'luistorres7', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(49, 'TI', '2233445', 'Sofía', 'Ramírez', 'sofia.ramirez@email.com', 'sofiaramirez8', 'clave123', NULL, NULL, 3, 'inactivo', '2025-04-02 08:29:02'),
(50, 'CC', '1045678901', 'Andrés', 'Vargas', 'andres.vargas@email.com', 'andresvargas9', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(51, 'TI', '3344556', 'Elena', 'Hernández', 'elena.hernandez@email.com', 'elenahernandez10', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(52, 'CC', '1056789012', 'Gabriel', 'Castro', 'gabriel.castro@email.com', 'gabrielcastro11', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(53, 'TI', '4455667', 'Paula', 'Ortega', 'paula.ortega@email.com', 'paulaortega12', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(54, 'CC', '1067890123', 'Ricardo', 'Molina', 'ricardo.molina@email.com', 'ricardomolina13', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(55, 'TI', '5566778', 'Fernanda', 'Ruiz', 'fernanda.ruiz@email.com', 'fernandaruiz14', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(56, 'CC', '1078901234', 'Hugo', 'Silva', 'hugo.silva@email.com', 'hugosilva15', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(57, 'TI', '6677889', 'Isabel', 'Jiménez', 'isabel.jimenez@email.com', 'isabeljimenez16', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(58, 'CC', '1089012345', 'José', 'Morales', 'jose.morales@email.com', 'josemorales17', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(59, 'TI', '7788990', 'Natalia', 'Paredes', 'natalia.paredes@email.com', 'nataliaparedes18', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(60, 'CC', '1090123456', 'Emilio', 'Guzmán', 'emilio.guzman@email.com', 'emilioguzman19', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(61, 'TI', '8899001', 'Valeria', 'Díaz', 'valeria.diaz@email.com', 'valeriadiaz20', 'clave123', NULL, NULL, 3, 'activo', '2025-04-02 08:29:02'),
(71, 'CC', '75', 'German', 'Ramirez', 'test@example.us', '75', '75', '6019521325', 'calle 20 33a42', 2, 'activo', '2025-04-04 21:00:40'),
(72, 'CC', '1116', 'Alonso', 'Arboleda', 'teste@exemplo.us', '1116', '1116', '315', 'calle 20 33a42', 2, 'activo', '2025-04-04 21:16:32'),
(73, 'CC', '1116281626', 'Jhoan', 'Sinisterra', 'sinisterravalenciajhoandavid@gmail.com', '1116281626', '1116281626', '3117233951', 'cra 23#23-10', 2, 'activo', '2025-04-24 23:41:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_asignacion` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`id_usuario`, `id_rol`, `fecha_asignacion`) VALUES
(1, 9, '2025-03-22 21:35:28'),
(42, 3, '2025-04-04 22:26:54'),
(43, 5, '2025-04-04 22:26:54'),
(44, 6, '2025-04-04 22:26:54'),
(45, 8, '2025-04-04 22:26:54'),
(46, 9, '2025-04-04 22:26:54'),
(47, 7, '2025-04-04 22:26:54'),
(48, 10, '2025-04-04 22:26:54'),
(49, 8, '2025-04-04 22:26:54'),
(50, 6, '2025-04-04 22:26:54'),
(51, 9, '2025-04-04 22:26:54'),
(52, 2, '2025-04-04 22:26:54'),
(53, 1, '2025-04-04 22:26:54'),
(54, 8, '2025-04-04 22:26:54'),
(55, 9, '2025-04-04 22:26:54'),
(56, 8, '2025-04-04 22:26:54'),
(57, 5, '2025-04-04 22:26:54'),
(58, 9, '2025-04-04 22:26:54'),
(59, 10, '2025-04-04 22:26:54'),
(60, 6, '2025-04-04 22:26:54'),
(71, 7, '2025-04-04 21:00:40'),
(72, 6, '2025-04-04 21:16:32'),
(73, 6, '2025-04-24 23:41:43');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aprendices_ficha`
--
ALTER TABLE `aprendices_ficha`
  ADD PRIMARY KEY (`id_aprendiz_ficha`),
  ADD UNIQUE KEY `unique_aprendiz_ficha` (`id_usuario`,`id_ficha`),
  ADD KEY `id_ficha` (`id_ficha`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`categoria_id`);

--
-- Indices de la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  ADD PRIMARY KEY (`cons_detalle`),
  ADD KEY `equipo_id` (`equipo_id`),
  ADD KEY `detalle_prestamo_ibfk_1` (`id_prestamo`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`equipo_id`),
  ADD UNIQUE KEY `numero_serie` (`numero_serie`),
  ADD KEY `id_estado_idx` (`id_estado`),
  ADD KEY `ubicacion_id_idx` (`ubicacion_id`),
  ADD KEY `categoria_id_idx` (`categoria_id`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `fichas`
--
ALTER TABLE `fichas`
  ADD PRIMARY KEY (`id_ficha`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `id_sede` (`id_sede`);

--
-- Indices de la tabla `historial_roles`
--
ALTER TABLE `historial_roles`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_rol_anterior` (`id_rol_anterior`),
  ADD KEY `id_rol_nuevo` (`id_rol_nuevo`),
  ADD KEY `id_usuario_modificador` (`id_usuario_modificador`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id_modulo`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id_permiso`),
  ADD UNIQUE KEY `unique_permiso_modulo` (`id_modulo`,`nombre`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre_rol`);

--
-- Indices de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD PRIMARY KEY (`id_rol`,`id_permiso`),
  ADD KEY `id_permiso` (`id_permiso`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`id_sede`),
  ADD UNIQUE KEY `nombre_sede` (`nombre_sede`);

--
-- Indices de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD PRIMARY KEY (`ubicacion_id`),
  ADD KEY `id_sede` (`id_sede`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `numero_documento_UNIQUE` (`numero_documento`);

--
-- Indices de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aprendices_ficha`
--
ALTER TABLE `aprendices_ficha`
  MODIFY `id_aprendiz_ficha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `categoria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  MODIFY `cons_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `equipo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `fichas`
--
ALTER TABLE `fichas`
  MODIFY `id_ficha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `historial_roles`
--
ALTER TABLE `historial_roles`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id_modulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id_prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `sedes`
--
ALTER TABLE `sedes`
  MODIFY `id_sede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  MODIFY `ubicacion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aprendices_ficha`
--
ALTER TABLE `aprendices_ficha`
  ADD CONSTRAINT `aprendices_ficha_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `aprendices_ficha_ibfk_2` FOREIGN KEY (`id_ficha`) REFERENCES `fichas` (`id_ficha`);

--
-- Filtros para la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  ADD CONSTRAINT `detalle_prestamo_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamos` (`id_prestamo`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_prestamo_ibfk_2` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`equipo_id`);

--
-- Filtros para la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD CONSTRAINT `categoria_id` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`categoria_id`),
  ADD CONSTRAINT `id_estado` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estado`),
  ADD CONSTRAINT `ubicacion_id` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicaciones` (`ubicacion_id`);

--
-- Filtros para la tabla `fichas`
--
ALTER TABLE `fichas`
  ADD CONSTRAINT `fichas_ibfk_1` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`);

--
-- Filtros para la tabla `historial_roles`
--
ALTER TABLE `historial_roles`
  ADD CONSTRAINT `historial_roles_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `historial_roles_ibfk_2` FOREIGN KEY (`id_rol_anterior`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `historial_roles_ibfk_3` FOREIGN KEY (`id_rol_nuevo`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `historial_roles_ibfk_4` FOREIGN KEY (`id_usuario_modificador`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`id_modulo`) REFERENCES `modulos` (`id_modulo`);

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id_permiso`);

--
-- Filtros para la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD CONSTRAINT `ubicaciones_ibfk_1` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`);

--
-- Filtros para la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD CONSTRAINT `usuario_rol_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `usuario_rol_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
--
-- Base de datos: `hermesbeta`
--
CREATE DATABASE IF NOT EXISTS `hermesbeta` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hermesbeta`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprendices_ficha`
--

CREATE TABLE `aprendices_ficha` (
  `id_aprendiz_ficha` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_ficha` int(11) NOT NULL,
  `fecha_asignacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo','desertor','trasladado') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aprendices_ficha`
--

INSERT INTO `aprendices_ficha` (`id_aprendiz_ficha`, `id_usuario`, `id_ficha`, `fecha_asignacion`, `estado`) VALUES
(2, 44, 5, '2025-04-04 17:32:43', 'activo'),
(3, 50, 4, '2025-04-04 17:32:43', 'activo'),
(4, 60, 10, '2025-04-04 17:32:43', 'activo'),
(5, 72, 11, '2025-04-13 17:11:36', 'activo'),
(6, 73, 1, '2025-05-15 15:59:20', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_usuarios`
--

CREATE TABLE `auditoria_usuarios` (
  `id_auditoria` int(11) NOT NULL,
  `id_usuario_afectado` int(11) NOT NULL,
  `id_usuario_editor` int(11) DEFAULT NULL,
  `campo_modificado` varchar(50) NOT NULL,
  `valor_anterior` text DEFAULT NULL,
  `valor_nuevo` text DEFAULT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `categoria_id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`categoria_id`, `nombre`) VALUES
(1, 'Portátiles'),
(2, 'Video'),
(3, 'Sonido'),
(4, 'Cables'),
(5, 'Control Remoto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_prestamo`
--

CREATE TABLE `detalle_prestamo` (
  `cons_detalle` int(11) NOT NULL,
  `id_prestamo` int(11) NOT NULL,
  `equipo_id` int(11) NOT NULL,
  `estado` enum('Asignado','Devuelto') NOT NULL DEFAULT 'Asignado',
  `fecha_actualizacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_prestamo`
--

INSERT INTO `detalle_prestamo` (`cons_detalle`, `id_prestamo`, `equipo_id`, `estado`, `fecha_actualizacion`) VALUES
(2, 1, 1, 'Asignado', '2025-04-18 14:55:08'),
(3, 1, 2, 'Asignado', '2025-04-18 14:55:08'),
(4, 1, 6, 'Asignado', '2025-04-18 14:55:08'),
(5, 2, 4, 'Asignado', '2025-04-18 15:35:51'),
(6, 2, 7, 'Asignado', '2025-04-18 15:35:51'),
(7, 2, 11, 'Asignado', '2025-04-18 15:35:51'),
(8, 2, 27, 'Asignado', '2025-04-18 15:35:51'),
(11, 5, 5, 'Devuelto', '2025-04-18 15:42:48'),
(12, 5, 16, 'Devuelto', '2025-04-18 15:42:48'),
(15, 4, 31, 'Asignado', '2025-04-18 16:32:03'),
(16, 4, 42, 'Asignado', '2025-04-18 16:32:03');

--
-- Disparadores `detalle_prestamo`
--
DELIMITER $$
CREATE TRIGGER `after_detalle_prestamo_insert` AFTER INSERT ON `detalle_prestamo` FOR EACH ROW BEGIN
    DECLARE v_tipo_prestamo VARCHAR(20);

    SELECT tipo_prestamo INTO v_tipo_prestamo
    FROM prestamos
    WHERE id_prestamo = NEW.id_prestamo;

    IF v_tipo_prestamo = 'Inmediato' THEN
        UPDATE equipos
        SET id_estado = 2
        WHERE equipo_id = NEW.equipo_id;
    ELSEIF v_tipo_prestamo = 'Reservado' THEN
        UPDATE equipos
        SET id_estado = 3
        WHERE equipo_id = NEW.equipo_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `equipo_id` int(11) NOT NULL,
  `numero_serie` varchar(100) NOT NULL,
  `etiqueta` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fecha_entrada` timestamp NOT NULL DEFAULT current_timestamp(),
  `ubicacion_id` int(11) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT 1,
  `cuentadante_id` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`equipo_id`, `numero_serie`, `etiqueta`, `descripcion`, `fecha_entrada`, `ubicacion_id`, `categoria_id`, `cuentadante_id`, `id_estado`) VALUES
(1, 'SN001', '9125001SN001', 'HP EliteBook 666', '2025-04-17 15:42:57', 1, 1, 43, 1),
(2, 'SN002', '9125001SN002', 'Dell XPS 13', '2025-04-17 15:42:57', 4, 1, 55, 2),
(3, 'SN003', '9125001SN003', 'Lenovo ThinkPad X1', '2025-04-17 15:42:57', 4, 1, 55, 5),
(4, 'SN004', '9125001SN004', 'MacBook Pro 16\"', '2025-04-17 15:42:57', 3, 1, 50, 3),
(5, 'SN005', '9125001SN005', 'Acer Swift 3', '2025-04-17 15:42:57', 4, 1, 50, 5),
(6, 'SN006', '9125002SN006', 'Cámara Sony AX53', '2025-04-17 15:43:57', 4, 2, 50, 2),
(7, 'SN007', '9125002SN007', 'Proyector Epson 4K', '2025-04-17 15:43:57', 4, 2, 50, 3),
(8, 'SN008', '9125002SN008', 'Trípode Manfrotto', '2025-04-17 15:43:57', 4, 2, 50, 5),
(9, 'SN009', '9125002SN009', 'Grabadora Panasonic', '2025-04-17 15:43:57', 4, 2, 50, 5),
(10, 'SN010', '9125002SN010', 'Lente Canon 24-70mm', '2025-04-17 15:43:57', 4, 2, 50, 5),
(11, 'SN011', '9125003SN011', 'Micrófono Shure SM58', '2025-04-17 15:43:57', 4, 3, 50, 3),
(12, 'SN012', '9125003SN012', 'Altavoz Bose S1 Pro', '2025-04-17 15:43:57', 4, 3, 50, 5),
(13, 'SN013', '9125003SN013', 'Mezcladora Yamaha MG10', '2025-04-17 15:43:57', 4, 3, 50, 5),
(14, 'SN014', '9125003SN014', 'Audífonos Sennheiser HD', '2025-04-17 15:43:57', 4, 3, 50, 5),
(15, 'SN015', '9125003SN015', 'Interface Audio Focusrite', '2025-04-17 15:43:57', 4, 3, 50, 5),
(16, 'SN016', '9125004SN016', 'HDMI 2.1 3m', '2025-04-17 15:43:57', 4, 4, 50, 5),
(17, 'SN017', '9125004SN017', 'USB-C a Ethernet', '2025-04-17 15:43:57', 4, 4, 50, 5),
(18, 'SN018', '9125004SN018', 'VGA 5m', '2025-04-17 15:43:57', 4, 4, 50, 5),
(19, 'SN019', '9125004SN019', 'DisplayPort 2m', '2025-04-17 15:43:57', 4, 4, 50, 5),
(20, 'SN020', '9125004SN020', 'Cable de Red CAT6', '2025-04-17 15:43:57', 4, 4, 50, 5),
(21, 'SN021', '9125005SN021', 'Control Universal Logitech', '2025-04-17 15:43:57', 4, 5, 50, 5),
(22, 'SN022', '9125005SN022', 'Control Sony TV', '2025-04-17 15:43:57', 4, 5, 50, 5),
(23, 'SN023', '9125005SN023', 'Control Samsung Smart', '2025-04-17 15:43:57', 4, 5, 50, 5),
(24, 'SN024', '9125005SN024', 'Control LG Magic', '2025-04-17 15:43:57', 4, 5, 50, 5),
(25, 'SN025', '9125005SN025', 'Control Philips HDMI', '2025-04-17 15:43:57', 4, 5, 50, 5),
(26, 'SN026', '9125001SN026', 'HP ProBook 450', '2025-04-17 15:43:57', 4, 1, 50, 5),
(27, 'SN027', '9125002SN027', 'Cámara Canon XA11', '2025-04-17 15:43:57', 4, 2, 50, 3),
(28, 'SN028', '9125003SN028', 'Micrófono Rode NT-USB', '2025-04-17 15:43:57', 4, 3, 50, 5),
(29, 'SN029', '9125004SN029', 'HDMI 1.4 5m', '2025-04-17 15:43:57', 4, 4, 50, 5),
(30, 'SN030', '9125005SN030', 'Control Panasonic TV', '2025-04-17 15:43:57', 4, 5, 50, 5),
(31, 'SN031', '9125001SN031', 'Dell Latitude 5420', '2025-04-17 15:46:40', 4, 1, 50, 3),
(32, 'SN032', '9125002SN032', 'Cámara Panasonic HC-X1500', '2025-04-17 15:46:40', 4, 2, 50, 5),
(33, 'SN033', '9125003SN033', 'Altavoz JBL EON 615', '2025-04-17 15:46:40', 4, 3, 50, 5),
(34, 'SN034', '9125004SN034', 'Cable USB 3.0 2m', '2025-04-17 15:46:40', 4, 4, 50, 5),
(35, 'SN035', '9125005SN035', 'Control Sony Blu-ray', '2025-04-17 15:46:40', 4, 5, 50, 5),
(36, 'SN036', '9125001SN036', 'MacBook Air M2', '2025-04-17 15:46:40', 4, 1, 50, 5),
(37, 'SN037', '9125002SN037', 'Trípode Gitzo GT3543', '2025-04-17 15:46:40', 4, 2, 50, 5),
(38, 'SN038', '9125003SN038', 'Micrófono Audio-Technica AT2020', '2025-04-17 15:46:40', 4, 3, 50, 5),
(39, 'SN039', '9125004SN039', 'Cable Optical Toslink 5m', '2025-04-17 15:46:40', 4, 4, 50, 5),
(40, 'SN040', '9125005SN040', 'Control LG Smart TV', '2025-04-17 15:46:40', 4, 5, 50, 5),
(41, 'SN041', '9125001SN041', 'Lenovo Yoga 920', '2025-04-17 15:46:40', 4, 1, 50, 5),
(42, 'SN042', '9125002SN042', 'Proyector BenQ HT3550', '2025-04-17 15:46:40', 4, 2, 50, 3),
(43, 'SN043', '9125003SN043', 'Interface Audio PreSonus 24c', '2025-04-17 15:46:40', 4, 3, 50, 5),
(44, 'SN044', '9125004SN044', 'Cable HDMI ARC 4m', '2025-04-17 15:46:40', 4, 4, 50, 5),
(45, 'SN045', '9125005SN045', 'Control Roku Ultra', '2025-04-17 15:46:40', 4, 5, 50, 5),
(46, 'SN046', '9125001SN046', 'Asus ZenBook 14', '2025-04-17 15:46:40', 4, 1, 50, 5),
(47, 'SN047', '9125002SN047', 'Grabadora Zoom H6', '2025-04-17 15:46:40', 4, 2, 50, 5),
(48, 'SN048', '9125003SN048', 'Audífonos Audio-Technica M50x', '2025-04-17 15:46:40', 4, 3, 50, 5),
(49, 'SN049', '9125004SN049', 'Cable VGA 3m con Conectores Dorados', '2025-04-17 15:46:40', 4, 4, 50, 5),
(50, 'SN050', '9125005SN050', 'Control Amazon Fire TV', '2025-04-17 15:46:40', 4, 5, 50, 5),
(51, 'SN051', '9125001SN051', 'Dell Latitude 5430', '2025-04-20 19:53:29', 1, 1, 55, 1),
(52, 'SN052', '9125001SN052', 'HP EliteBook 850 G8', '2025-04-20 19:53:29', 1, 1, 43, 1),
(53, 'SN053', '9125001SN053', 'Lenovo ThinkBook 14 G2', '2025-04-20 19:53:29', 1, 1, 57, 1),
(54, 'SN054', '9125001SN054', 'Asus VivoBook S14', '2025-04-20 19:53:29', 2, 1, 55, 1),
(55, 'SN055', '9125001SN055', 'Acer TravelMate P2', '2025-04-20 19:53:29', 1, 1, 43, 1),
(56, 'SN056', '9125001SN056', 'Microsoft Surface Laptop 5', '2025-04-20 19:53:29', 2, 1, 57, 1),
(57, 'SN057', '9125001SN057', 'Apple MacBook Pro M3', '2025-04-20 19:53:29', 1, 1, 55, 1),
(58, 'SN058', '9125001SN058', 'Samsung Galaxy Book3 Pro', '2025-04-20 19:53:29', 1, 1, 43, 1),
(59, 'SN059', '9125001SN059', 'LG Gram 17', '2025-04-20 19:53:29', 1, 1, 57, 1),
(60, 'SN060', '9125001SN060', 'Toshiba Dynabook Satellite Pro', '2025-04-20 19:53:29', 2, 1, 55, 1),
(61, 'SN061', '9125001SN061', 'MSI Modern 14 B11', '2025-04-20 19:53:29', 1, 1, 43, 1),
(62, 'SN062', '9125001SN062', 'Huawei MateBook D15', '2025-04-20 19:53:29', 2, 1, 57, 1),
(63, 'SN063', '9125001SN063', 'Chuwi HeroBook Pro', '2025-04-20 19:53:29', 1, 1, 55, 1),
(64, 'SN064', '9125001SN064', 'Gateway Ultra Slim Notebook', '2025-04-20 19:53:29', 1, 1, 43, 1),
(65, 'SN065', '9125001SN065', 'VAIO SX14', '2025-04-20 19:53:29', 1, 1, 57, 1),
(66, 'SN066', '9125001SN066', 'Alienware x14 R2', '2025-04-20 19:53:29', 2, 1, 55, 1),
(67, 'SN067', '9125001SN067', 'Razer Blade Stealth 13', '2025-04-20 19:53:29', 1, 1, 43, 1),
(68, 'SN068', '9125001SN068', 'Fujitsu Lifebook U7411', '2025-04-20 19:53:29', 2, 1, 57, 1),
(69, 'SN069', '9125001SN069', 'Panasonic Toughbook 55', '2025-04-20 19:53:29', 1, 1, 55, 1),
(70, 'SN070', '9125001SN070', 'HP Pavilion x360', '2025-04-20 19:53:29', 1, 1, 43, 1),
(71, 'SN071', '9125001SN071', 'Lenovo IdeaPad Flex 5', '2025-04-20 19:53:29', 1, 1, 57, 1),
(72, 'SN072', '9125001SN072', 'Dell XPS 13 Plus', '2025-04-20 19:53:29', 2, 1, 55, 1),
(73, 'SN073', '9125001SN073', 'Asus ROG Zephyrus G14', '2025-04-20 19:53:29', 1, 1, 43, 1),
(74, 'SN074', '9125001SN074', 'Acer Aspire 7', '2025-04-20 19:53:29', 2, 1, 57, 1),
(75, 'SN075', '9125001SN075', 'Samsung Notebook 9 Pro', '2025-04-20 19:53:29', 1, 1, 55, 1),
(76, '11111', 'abcd12345', 'descripcion 123', '2025-05-15 16:39:45', 1, 3, 55, NULL),
(77, '22222', 'abcd6789', 'descripcion456', '2025-05-15 16:41:32', 1, 3, 55, 1),
(78, '7777', '7777', 'equipo prueba', '2025-05-16 16:09:39', 1, 1, 48, 1),
(79, '55667788', '88776655', 'Equipo ASUS xt', '2025-05-16 16:46:37', 1, 2, 1, 2),
(80, '1111', '11334', 'asdas', '2025-05-18 00:12:33', 1, 1, 48, 1),
(81, '1231s1', 'xasxa', 'hola mundo', '2025-05-18 00:13:05', 4, 2, 56, 1),
(82, '890', '76584', 'adios mundo', '2025-05-18 00:15:56', 1, 1, 52, 1),
(83, 'asad', 'asada123', 'aasdfghj', '2025-05-18 21:43:42', 1, 1, 46, 3),
(84, 'aaaabcdefg12345', '12345aacdc', 'metalica', '2025-05-18 21:47:59', 1, 1, 46, 1),
(85, '1q2w3e4r5t', '6y7u8i9o0p', 'Equipo asus hacker', '2025-05-19 06:09:11', 1, 1, 46, 1),
(86, '1a2s3d4f', 'v0c9x8z7', 'Equipo poderoso', '2025-05-19 06:55:48', 1, 1, 52, 1),
(87, 'z12x3c4v', 'm098b7v', 'equipo molon que mola mogollon', '2025-05-19 07:17:50', 1, 1, 53, 1),
(88, 'zq1xw2ce3', 'fr12gt23', 'Hola mundo', '2025-05-19 08:20:00', 1, 1, 43, 1),
(89, 'q1q1w2w2e3', 'da4da67a6', 'equipo mañitp', '2025-05-19 08:25:34', 4, 1, 53, 1),
(96, '23', '12', 'lenovo', '2025-05-23 17:39:30', 1, 1, 45, 1),
(98, '12', '32', 'hola', '2025-05-23 17:40:32', 1, 1, 56, 1),
(99, 'a1ws2d3f4', 'j94hg58y76', 'Equipo marca asus superior', '2025-05-23 17:42:12', 4, 1, 53, 1),
(100, 'kk0ou8y7t6r5', 'A56G700', 'Equipo lenovo 67', '2025-05-23 17:43:47', 3, 1, 42, 1),
(101, 'u7i8io9', 'y7huji6', 'Equipo lenovo 8080', '2025-05-23 17:47:22', 1, 1, 55, 2),
(102, 'q1w2e3', 'u7t5r4e3', 'Asus 7899', '2025-05-23 18:57:24', 1, 1, 42, 1),
(103, 'p0q1w2i9e3u8384', 'hy7ju8ko12ko2', 'Equipo portatil HP 160 plus', '2025-05-23 19:01:05', 1, 1, 48, 1),
(104, 'z1x2c3z1n6', 'J7Y6N65BB5', 'Lenovo 675s', '2025-05-23 19:23:09', 2, 1, 46, 1),
(105, 'q1q1w22w', '32c2te4w3as', 'Asus 8879', '2025-05-23 21:37:30', 1, 1, 42, 2),
(106, '333666777', 'descrupcianwq', 'hola', '2025-05-23 22:01:57', 4, 1, 1, 1),
(107, 'q11qqazq1', '221AS134DQ', 'Equipo de prueba lolo', '2025-05-26 17:11:33', 4, 1, 42, 1),
(108, 'r9t8y7t7t7ur9e', 'ru48t573092i', 'Hola asus', '2025-05-26 18:24:35', 4, 2, 42, 1),
(109, '777777', '56565656', 'Equipo molon', '2025-05-26 19:35:38', 4, 1, 1, 1),
(111, 'hola nasus', 'grieta', 'Equipo molon 2', '2025-05-26 19:37:32', 4, 1, 42, 1),
(112, '7y7y7y', 'etiqueta777', 'varchar', '2025-05-26 20:05:38', 4, 1, 42, 1),
(113, 'asdas', '32wef', 'dq32d', '2025-05-26 20:07:47', 4, 1, 43, 1),
(114, '45h5e7nu', '24RC24Q', 'Splinter', '2025-05-26 20:08:19', 4, 1, 45, 1),
(115, 'hrstjyuf65e', 'SBRR5W4F', 'Hola yui', '2025-05-26 21:26:04', 4, 1, 42, 1),
(116, 'nw45g254', 'VGQ34T5B4W', 'si', '2025-05-26 21:53:21', 4, 2, 42, 1),
(117, 'KHF587F', 'HV7687VK', 'Equipo alojo', '2025-05-27 22:39:35', 4, 1, 55, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id_estado` int(11) NOT NULL,
  `estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`id_estado`, `estado`) VALUES
(1, 'Disponible'),
(2, 'Prestado'),
(3, 'Reservado'),
(4, 'Mantenimiento'),
(5, 'Almacén'),
(6, 'Formación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fichas`
--

CREATE TABLE `fichas` (
  `id_ficha` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `id_sede` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activa','inactiva') DEFAULT 'activa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fichas`
--

INSERT INTO `fichas` (`id_ficha`, `codigo`, `descripcion`, `id_sede`, `fecha_inicio`, `fecha_fin`, `fecha_creacion`, `estado`) VALUES
(1, '1000001', 'Tecnología en Análisis y Desarrollo de Software', 1, '2024-01-15', '2024-12-15', '2025-03-24 23:26:50', 'inactiva'),
(2, '1000002', 'Técnico en Sistemas', 28, '2024-02-01', '2024-11-30', '2025-03-24 23:26:50', 'activa'),
(3, '1000003', 'Gestión Administrativa', 3, '2024-03-10', '2024-12-10', '2025-03-24 23:26:50', 'activa'),
(4, '1000004', 'Diseño e Integración de Multimedia', 27, '2024-04-05', '2025-03-05', '2025-03-24 23:26:50', 'activa'),
(5, '1000005', 'Producción Agropecuaria', 28, '2024-05-20', '2025-04-20', '2025-03-24 23:26:50', 'inactiva'),
(6, '1000006', 'Electricidad Industrial', 1, '2024-06-01', '2025-05-01', '2025-03-24 23:26:50', 'activa'),
(7, '1000007', 'Mecánica Automotriz', 2, '2024-07-15', '2025-06-15', '2025-03-24 23:26:50', 'activa'),
(8, '1000008', 'Contabilidad y Finanzas', 28, '2024-08-10', '2025-07-10', '2025-03-24 23:26:50', 'activa'),
(9, '1000009', 'Seguridad y Salud en el Trabajo', 27, '2024-09-05', '2025-08-05', '2025-03-24 23:26:50', 'inactiva'),
(10, '1000010', 'Redes y Telecomunicaciones', 28, '2024-10-20', '2025-09-20', '2025-03-24 23:26:50', 'activa'),
(11, '2847523', 'ADSO', 1, '2025-03-01', '2025-03-31', '2025-03-25 01:00:56', 'activa'),
(12, '1111', 'ADSO', 28, '2025-03-01', '2025-03-29', '2025-03-26 17:44:36', 'activa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_roles`
--

CREATE TABLE `historial_roles` (
  `id_historial` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_rol_anterior` int(11) DEFAULT NULL,
  `id_rol_nuevo` int(11) NOT NULL,
  `fecha_cambio` timestamp NULL DEFAULT current_timestamp(),
  `id_usuario_modificador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id_modulo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`id_modulo`, `nombre`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 'Gestión de equipos', 'Módulo para administrar equipos tecnológicos', '2025-03-22 16:35:28', 'activo'),
(2, 'Gestión de solicitudes', 'Módulo para gestionar solicitudes y asignaciones de equipos', '2025-03-22 16:35:28', 'activo'),
(3, 'Devoluciones', 'Módulo para gestionar devoluciones de equipos', '2025-03-22 16:35:28', 'activo'),
(4, 'Salidas', 'Módulo para controlar salidas de equipos', '2025-03-22 16:35:28', 'activo'),
(5, 'Configuración', 'Módulo para configuración general del sistema', '2025-03-22 16:35:28', 'activo'),
(6, 'Autorizaciones', 'Módulo para la autorización de las solicitudes ', '2025-03-31 01:40:46', 'activo'),
(7, 'Fichas', 'Módulo para administrar las fichas', '2025-04-14 22:54:08', 'activo'),
(8, 'Sedes', 'Módulo para la administración de las sedes', '2025-04-16 17:00:23', 'activo'),
(9, 'Roles', 'Módulo para la administración de los roles del sistema', '2025-04-16 18:25:01', 'activo'),
(10, 'Módulos', 'Módulo para la administracion de los módulos del sistema (sólo administrador)', '2025-04-16 20:18:32', 'activo'),
(11, 'Permisos', 'Módulo para el control general de permisos a los roles del sistema', '2025-04-16 22:51:17', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id_permiso` int(11) NOT NULL,
  `id_modulo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_permiso`, `id_modulo`, `nombre`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 1, 'Registrar equipooooo', 'Crear nuevos equipos en el sistemas', '2025-03-22 16:35:28', 'activo'),
(2, 1, 'Consultar equipos', 'Consultar información de equipos', '2025-03-22 16:35:28', 'activo'),
(3, 1, 'Modificar equipos', 'Modificar información de equipos', '2025-03-22 16:35:28', 'activo'),
(4, 1, 'Inhabilitar equipos', 'Inhabilitar equipos', '2025-03-22 16:35:28', 'activo'),
(5, 1, 'Asignar equipos', 'Asignar equipos a cuentadantes', '2025-03-22 16:35:28', 'activo'),
(6, 1, 'Revisar equipos', 'Revisar el estado de los equipos', '2025-03-22 16:35:28', 'activo'),
(7, 2, 'Realizar solicitudes', 'Realizar solicitudes de préstamo', '2025-03-22 16:35:28', 'activo'),
(8, 2, 'Consultar equipos', 'Consultar información de equipos para solicitudes', '2025-03-22 16:35:28', 'activo'),
(9, 2, 'Cancelar solicitudes', 'Cancelar solicitudes', '2025-03-22 16:35:28', 'activo'),
(10, 2, 'Aprobar solicitudes', 'Aprobar solicitudes de préstamo', '2025-03-22 16:35:28', 'activo'),
(11, 2, 'Entregar equipos', 'Entregar equipos a los usuarios', '2025-03-22 16:35:28', 'activo'),
(12, 3, 'Recibir equipos', 'Registrar la devolución de equipos', '2025-03-22 16:35:28', 'activo'),
(13, 3, 'Consultar solicitudes', 'Consultar solicitudes relacionadas con devoluciones', '2025-03-22 16:35:28', 'activo'),
(14, 3, 'Revisar equipos', 'Revisar el estado de los equipos devueltos', '2025-03-22 16:35:28', 'activo'),
(15, 3, 'Actualizar estados', 'Actualizar el estado de los equipos', '2025-03-22 16:35:28', 'activo'),
(16, 4, 'Autorizar salidas', 'Autorizar salidas de equipos', '2025-03-22 16:35:28', 'activo'),
(17, 4, 'Verificar autorizaciones', 'Verificar autorizaciones de salida', '2025-03-22 16:35:28', 'activo'),
(18, 4, 'Consultar salidas', 'Consultar registros de salidas de equipos', '2025-03-22 16:35:28', 'activo'),
(19, 5, 'Configuraraciones ', 'Acceso a configuraciones del sistema', '2025-03-22 16:35:28', 'activo'),
(20, 5, 'Gestionar usuarios', 'Gestionar usuarios del sistema', '2025-03-22 16:35:28', 'activo'),
(21, 5, 'Gestionar roles', 'Gestionar roles y permisos', '2025-03-22 16:35:28', 'activo'),
(22, 7, 'Gestionar fichas', 'Gestionar las fichas del sistema', '2025-04-14 22:57:21', 'activo'),
(23, 8, 'Editar sedes', 'Realizar cambios en la información de las sedes', '2025-04-16 17:03:36', 'activo'),
(24, 8, 'Crear sedes', 'Crear nuevas sedes en el sistema', '2025-04-16 17:03:36', 'activo'),
(25, 8, 'Consultar sedes', 'Permite entrar a consultar las sedes del sistema', '2025-04-16 18:13:24', 'activo'),
(26, 9, 'Editar roles', 'Realizar cambios en la información de los roles del sistema', '2025-04-16 18:28:22', 'activo'),
(27, 9, 'Crear roles', 'Crear nuevos roles en el sistemas', '2025-04-16 18:28:22', 'activo'),
(28, 9, 'Consultar roles', 'Permite consultar los diferentes roles del sistema', '2025-04-16 18:28:22', 'activo'),
(29, 10, 'Gestión de módulos (solo administrador)', 'Este acceso implica código (no aparecera en permisos)', '2025-04-16 20:19:52', 'activo'),
(30, 11, 'Gestión de permisos', 'Permitir la gestión de los diferentes permisos asignados a los roles del sistema', '2025-04-16 22:56:43', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id_prestamo` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo_prestamo` enum('Inmediato','Reservado') NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `estado_prestamo` enum('Prestado','Devuelto','Rechazado','Autorizado','Pendiente','Tramite') NOT NULL DEFAULT 'Prestado',
  `motivo` varchar(200) DEFAULT NULL,
  `fecha_solicitud` datetime DEFAULT current_timestamp(),
  `fecha_devolucion_real` datetime DEFAULT NULL,
  `prestamoscol` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id_prestamo`, `usuario_id`, `tipo_prestamo`, `fecha_inicio`, `fecha_fin`, `estado_prestamo`, `motivo`, `fecha_solicitud`, `fecha_devolucion_real`, `prestamoscol`) VALUES
(1, 72, 'Inmediato', '2025-04-18 09:00:00', '2025-04-18 17:00:00', 'Prestado', 'Clase de informática', '2025-04-18 14:50:08', NULL, NULL),
(2, 46, 'Reservado', '2025-04-22 08:00:00', '2025-04-24 18:00:00', 'Autorizado', 'Grabación de documental', '2025-04-18 15:35:27', NULL, NULL),
(4, 51, 'Reservado', '2025-05-05 10:00:00', '2025-05-07 16:00:00', 'Pendiente', 'Conferencia académica', '2025-04-18 15:39:20', NULL, NULL),
(5, 1, 'Inmediato', '2025-04-10 14:00:00', '2025-04-10 18:00:00', 'Devuelto', 'Reunión de trabajo', '2025-04-18 15:42:48', NULL, NULL),
(6, 1, 'Inmediato', '2025-04-10 14:00:00', '2025-04-10 18:00:00', 'Devuelto', 'Reunión de trabajo', '2025-04-18 15:43:07', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 'Líder TIC', 'Rol con acceso completo a todos los módulos y permisos', '2025-03-22 16:35:28', 'activo'),
(2, 'Mesa de ayuda', 'Rol con permisos limitados para atención de solicitudes', '2025-03-22 16:35:28', 'activo'),
(3, 'Almacén', 'Rol con permisos para gestionar equipos y solicitudes', '2025-03-22 16:35:28', 'activo'),
(4, 'Biblioteca', 'Rol con permisos para consultar equipos y gestionar solicitudes', '2025-03-22 16:35:28', 'activo'),
(5, 'Coordinación', 'Rol con permisos similares a adminBiblioteca', '2025-03-22 16:35:28', 'activo'),
(6, 'Aprendiz', 'Rol con permisos limitados para realizar solicitudes', '2025-03-22 16:35:28', 'activo'),
(7, 'Instructor', 'Rol con permisos para solicitudes y autorizar salidas', '2025-03-22 16:35:28', 'activo'),
(8, 'Vigilante', 'Rol con permisos para verificar autorizaciones', '2025-03-22 16:35:28', 'activo'),
(9, 'Administrador', 'Rol con acceso completo a todos los módulos y configuración', '2025-03-22 16:35:28', 'activo'),
(10, 'Auxiliar administrativo', 'permisos de coordinación pero limitados', '2025-03-29 18:46:36', 'activo'),
(11, 'auxiliar TIC', 'Dependiente de lider TIC', '2025-04-23 14:27:49', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso`
--

CREATE TABLE `rol_permiso` (
  `id_rol` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL,
  `fecha_asignacion` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id_rol`, `id_permiso`, `fecha_asignacion`) VALUES
(1, 1, '2025-04-16 20:26:02'),
(1, 2, '2025-04-16 20:26:02'),
(1, 3, '2025-04-16 20:26:02'),
(1, 4, '2025-04-16 20:26:02'),
(1, 5, '2025-04-16 20:26:02'),
(1, 6, '2025-04-16 20:26:02'),
(1, 7, '2025-04-16 20:26:02'),
(1, 8, '2025-04-16 20:26:02'),
(1, 9, '2025-04-16 20:26:02'),
(1, 10, '2025-04-16 20:26:02'),
(1, 11, '2025-04-16 20:26:02'),
(1, 12, '2025-04-16 20:26:02'),
(1, 13, '2025-04-16 20:26:02'),
(1, 14, '2025-04-16 20:26:02'),
(1, 15, '2025-04-16 20:26:02'),
(1, 16, '2025-04-16 20:26:02'),
(1, 17, '2025-04-16 20:26:02'),
(1, 18, '2025-04-16 20:26:02'),
(1, 19, '2025-04-16 20:26:02'),
(1, 20, '2025-04-16 20:26:02'),
(1, 21, '2025-04-16 20:26:02'),
(2, 2, '2025-04-16 18:15:44'),
(2, 6, '2025-04-16 18:15:44'),
(2, 12, '2025-04-16 18:15:44'),
(2, 14, '2025-04-16 18:15:44'),
(2, 15, '2025-04-16 18:15:44'),
(2, 25, '2025-04-16 18:15:44'),
(3, 1, '2025-03-22 16:35:28'),
(3, 2, '2025-03-22 16:35:28'),
(3, 3, '2025-03-22 16:35:28'),
(3, 4, '2025-03-22 16:35:28'),
(3, 5, '2025-03-22 16:35:28'),
(3, 7, '2025-03-22 16:35:28'),
(3, 8, '2025-03-22 16:35:28'),
(3, 9, '2025-03-22 16:35:28'),
(3, 10, '2025-03-22 16:35:28'),
(3, 11, '2025-03-22 16:35:28'),
(3, 12, '2025-03-22 16:35:28'),
(3, 13, '2025-03-22 16:35:28'),
(4, 2, '2025-03-22 16:35:28'),
(4, 7, '2025-03-22 16:35:28'),
(4, 8, '2025-03-22 16:35:28'),
(4, 9, '2025-03-22 16:35:28'),
(4, 10, '2025-03-22 16:35:28'),
(4, 11, '2025-03-22 16:35:28'),
(4, 12, '2025-03-22 16:35:28'),
(4, 13, '2025-03-22 16:35:28'),
(5, 2, '2025-03-22 16:35:28'),
(5, 7, '2025-03-22 16:35:28'),
(5, 8, '2025-03-22 16:35:28'),
(5, 9, '2025-03-22 16:35:28'),
(5, 10, '2025-03-22 16:35:28'),
(5, 11, '2025-03-22 16:35:28'),
(5, 12, '2025-03-22 16:35:28'),
(5, 13, '2025-03-22 16:35:28'),
(6, 7, '2025-03-22 16:35:28'),
(6, 8, '2025-03-22 16:35:28'),
(6, 9, '2025-03-22 16:35:28'),
(7, 7, '2025-03-22 16:35:28'),
(7, 8, '2025-03-22 16:35:28'),
(7, 9, '2025-03-22 16:35:28'),
(7, 16, '2025-03-22 16:35:28'),
(8, 17, '2025-04-23 14:25:43'),
(8, 18, '2025-04-23 14:25:43'),
(9, 1, '2025-04-21 20:17:57'),
(9, 2, '2025-04-21 20:17:57'),
(9, 3, '2025-04-21 20:17:57'),
(9, 4, '2025-04-21 20:17:57'),
(9, 5, '2025-04-21 20:17:57'),
(9, 6, '2025-04-21 20:17:57'),
(9, 7, '2025-04-21 20:17:57'),
(9, 8, '2025-04-21 20:17:57'),
(9, 9, '2025-04-21 20:17:57'),
(9, 10, '2025-04-21 20:17:57'),
(9, 11, '2025-04-21 20:17:57'),
(9, 12, '2025-04-21 20:17:57'),
(9, 13, '2025-04-21 20:17:57'),
(9, 14, '2025-04-21 20:17:57'),
(9, 15, '2025-04-21 20:17:57'),
(9, 16, '2025-04-21 20:17:57'),
(9, 17, '2025-04-21 20:17:57'),
(9, 18, '2025-04-21 20:17:57'),
(9, 19, '2025-04-21 20:17:57'),
(9, 20, '2025-04-21 20:17:57'),
(9, 21, '2025-04-21 20:17:57'),
(9, 22, '2025-04-21 20:17:57'),
(9, 23, '2025-04-21 20:17:57'),
(9, 24, '2025-04-21 20:17:57'),
(9, 25, '2025-04-21 20:17:57'),
(9, 26, '2025-04-21 20:17:57'),
(9, 27, '2025-04-21 20:17:57'),
(9, 28, '2025-04-21 20:17:57'),
(9, 29, '2025-04-21 20:17:57'),
(9, 30, '2025-04-21 20:17:57'),
(10, 18, '2025-04-13 21:51:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `id_sede` int(11) NOT NULL,
  `nombre_sede` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` enum('activa','inactiva') DEFAULT 'activa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sedes`
--

INSERT INTO `sedes` (`id_sede`, `nombre_sede`, `direccion`, `descripcion`, `fecha_creacion`, `estado`) VALUES
(1, 'Sede Principal', 'Carrera 50 #10-25', 'Sede central con capacidad para 1000 aprendices', '2025-03-23 15:18:06', 'activa'),
(2, 'Sede Norte', 'Calle 80 #45-12', 'Sede especializada en tecnologías de la información', '2025-03-23 15:18:06', 'inactiva'),
(3, 'Sede Sur', 'Avenida 1 de Mayo #30-15', 'Sede con enfoque en áreas industriales', '2025-03-23 15:18:06', 'activa'),
(27, 'Sagrado', 'Cra 26 25', 'Horario de formacion en ambas jornadas', '2025-03-24 14:57:38', 'activa'),
(28, 'Bicentenario', 'CC Bicentenario Plazas', 'dos salones de 25 aprendices (202 y 205)', '2025-03-24 14:57:58', 'activa'),
(29, 'aa', 'aa', 'aa', '2025-04-04 20:56:06', 'activa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicaciones`
--

CREATE TABLE `ubicaciones` (
  `ubicacion_id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `id_sede` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicaciones`
--

INSERT INTO `ubicaciones` (`ubicacion_id`, `nombre`, `descripcion`, `id_sede`) VALUES
(1, 'Biblioteca Sagrado', 'Área de préstamo de equipos en el edificio de la biblioteca principal, piso 1', 27),
(2, 'Coordinacion Sagrado', 'Oficina de coordinación tecnológica del campus Sagrado Corazón', 27),
(3, 'Coordinacion Principal', 'Oficina central de gestión de equipos tecnológicos', 1),
(4, 'Almacen', 'Almacen principal', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `tipo_documento` varchar(5) NOT NULL,
  `numero_documento` varchar(30) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `genero` int(11) DEFAULT 3,
  `foto` varchar(100) DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `condicion` enum('penalizado','advertido','en_regla') NOT NULL DEFAULT 'en_regla',
  `fecha_registro` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `tipo_documento`, `numero_documento`, `nombre`, `apellido`, `correo_electronico`, `nombre_usuario`, `clave`, `telefono`, `direccion`, `genero`, `foto`, `estado`, `condicion`, `fecha_registro`) VALUES
(1, 'CC', '1', 'Admin', 'Sistema', 'admin@sistema.com', 'admin', '$2a$07$asxx54ahjppf45sd87a5aunxs9bkpyGmGE/.vekdjFg83yRec789S', '31123', 'cra 23#27-12 escobar', 1, 'vistas/img/usuarios/1/495.jpg', 'activo', 'en_regla', '2025-03-22 16:35:28'),
(42, 'CC', '1023456789', 'Juan', 'Pérez', 'juan.perez@email.com', 'juanperez1', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', '31112344', 'cra 34', 0, 'vistas/img/usuarios/1023456789/478.jpg', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(43, 'TI', '1234567', 'María', 'Gómez', 'maria.gomez@email.com', 'mariagomez2', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(44, 'CC', '1098765432', 'Carlos', 'López', 'carlos.lopez@email.com', 'carloslopez3', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'inactivo', 'en_regla', '2025-04-02 03:29:02'),
(45, 'TI', '7654321', 'Ana', 'Martínez', 'ana.martinez@email.com', 'anamartinez4', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(46, 'CC', '1002345678', 'Pedro', 'Sánchez', 'pedro.sanchez@email.com', 'pedrosanchez5', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(47, 'TI', '1122334', 'Laura', 'Fernández', 'laura.fernandez@email.com', 'laurafernandez6', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(48, 'CC', '1034567890', 'Luis', 'Torres', 'luis.torres@email.com', 'luistorres7', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(49, 'TI', '2233445', 'Sofía', 'Ramírez', 'sofia.ramirez@email.com', 'sofiaramirez8', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'inactivo', 'en_regla', '2025-04-02 03:29:02'),
(50, 'CC', '1045678901', 'Andrés', 'Vargas', 'andres.vargas@email.com', 'andresvargas9', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(51, 'TI', '3344556', 'Elena', 'Hernández', 'elena.hernandez@email.com', 'elenahernandez10', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(52, 'CC', '1056789012', 'Gabriel', 'Castro', 'gabriel.castro@email.com', 'gabrielcastro11', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(53, 'TI', '4455667', 'Paula', 'Ortega', 'paula.ortega@email.com', 'paulaortega12', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(54, 'CC', '1067890123', 'Ricardo', 'Molina', 'ricardo.molina@email.com', 'ricardomolina13', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(55, 'TI', '5566778', 'Fernanda', 'Ruiz', 'fernanda.ruiz@email.com', 'fernandaruiz14', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(56, 'CC', '1078901234', 'Hugo', 'Silva', 'hugo.silva@email.com', 'hugosilva15', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(57, 'TI', '6677889', 'Isabel', 'Jiménez', 'isabel.jimenez@email.com', 'isabeljimenez16', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(58, 'CC', '1089012345', 'José', 'Morales', 'jose.morales@email.com', 'josemorales17', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(59, 'TI', '7788990', 'Natalia', 'Paredes', 'natalia.paredes@email.com', 'nataliaparedes18', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(60, 'CC', '1090123456', 'Emilio', 'Guzmán', 'emilio.guzman@email.com', 'emilioguzman19', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(61, 'TI', '8899001', 'Valeria', 'Díaz', 'valeria.diaz@email.com', 'valeriadiaz20', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', NULL, NULL, 3, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-02 03:29:02'),
(71, 'CC', '75', 'German', 'Ramirez', 'test@example.us', '75', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', '6019521325', 'calle 20 33a42', 2, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-04 16:00:40'),
(72, 'CC', '1116', 'Alonso', 'Arboleda', 'teste@exemplo.us', '1116', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', '315', 'calle 20 33a42', 2, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-04-04 16:16:32'),
(73, 'CC', '11223344', 'asda', 'Sinisterra', 'dasdas@gmail.com', '11223344', '$2a$07$asxx54ahjppf45sd87a5auPSL9GB5Ad5sH/D3rUMKo4UJe4U/qGLO', '311233445', 'cra 23#23-10', 2, 'vistas/img/usuarios/default/anonymous.png', 'activo', 'en_regla', '2025-05-15 15:59:20');

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `trg_auditar_usuarios` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_asignacion` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`id_usuario`, `id_rol`, `fecha_asignacion`) VALUES
(1, 9, '2025-03-22 16:35:28'),
(42, 3, '2025-04-04 17:26:54'),
(43, 5, '2025-04-04 17:26:54'),
(44, 6, '2025-04-04 17:26:54'),
(45, 8, '2025-04-04 17:26:54'),
(46, 9, '2025-04-04 17:26:54'),
(47, 7, '2025-04-04 17:26:54'),
(48, 10, '2025-04-04 17:26:54'),
(49, 8, '2025-04-04 17:26:54'),
(50, 3, '2025-04-04 17:26:54'),
(51, 9, '2025-04-04 17:26:54'),
(52, 2, '2025-04-04 17:26:54'),
(53, 1, '2025-04-04 17:26:54'),
(54, 8, '2025-04-04 17:26:54'),
(55, 4, '2025-04-04 17:26:54'),
(56, 8, '2025-04-04 17:26:54'),
(57, 5, '2025-04-04 17:26:54'),
(58, 9, '2025-04-04 17:26:54'),
(59, 10, '2025-04-04 17:26:54'),
(60, 6, '2025-04-04 17:26:54'),
(71, 7, '2025-04-04 16:00:40'),
(72, 6, '2025-04-04 16:16:32'),
(73, 6, '2025-05-15 15:59:20');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aprendices_ficha`
--
ALTER TABLE `aprendices_ficha`
  ADD PRIMARY KEY (`id_aprendiz_ficha`),
  ADD UNIQUE KEY `unique_aprendiz_ficha` (`id_usuario`,`id_ficha`),
  ADD KEY `id_ficha` (`id_ficha`);

--
-- Indices de la tabla `auditoria_usuarios`
--
ALTER TABLE `auditoria_usuarios`
  ADD PRIMARY KEY (`id_auditoria`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`categoria_id`);

--
-- Indices de la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  ADD PRIMARY KEY (`cons_detalle`),
  ADD KEY `equipo_id` (`equipo_id`),
  ADD KEY `detalle_prestamo_ibfk_1` (`id_prestamo`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`equipo_id`),
  ADD UNIQUE KEY `numero_serie` (`numero_serie`),
  ADD KEY `id_estado_idx` (`id_estado`),
  ADD KEY `ubicacion_id_idx` (`ubicacion_id`),
  ADD KEY `categoria_id_idx` (`categoria_id`),
  ADD KEY `cuentadante_id_idx` (`cuentadante_id`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `fichas`
--
ALTER TABLE `fichas`
  ADD PRIMARY KEY (`id_ficha`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `id_sede` (`id_sede`);

--
-- Indices de la tabla `historial_roles`
--
ALTER TABLE `historial_roles`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_rol_anterior` (`id_rol_anterior`),
  ADD KEY `id_rol_nuevo` (`id_rol_nuevo`),
  ADD KEY `id_usuario_modificador` (`id_usuario_modificador`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id_modulo`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id_permiso`),
  ADD UNIQUE KEY `unique_permiso_modulo` (`id_modulo`,`nombre`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre_rol`);

--
-- Indices de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD PRIMARY KEY (`id_rol`,`id_permiso`),
  ADD KEY `id_permiso` (`id_permiso`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`id_sede`),
  ADD UNIQUE KEY `nombre_sede` (`nombre_sede`);

--
-- Indices de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD PRIMARY KEY (`ubicacion_id`),
  ADD KEY `id_sede` (`id_sede`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `numero_documento_UNIQUE` (`numero_documento`);

--
-- Indices de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aprendices_ficha`
--
ALTER TABLE `aprendices_ficha`
  MODIFY `id_aprendiz_ficha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `auditoria_usuarios`
--
ALTER TABLE `auditoria_usuarios`
  MODIFY `id_auditoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `categoria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  MODIFY `cons_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `equipo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `fichas`
--
ALTER TABLE `fichas`
  MODIFY `id_ficha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `historial_roles`
--
ALTER TABLE `historial_roles`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id_modulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id_prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `sedes`
--
ALTER TABLE `sedes`
  MODIFY `id_sede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  MODIFY `ubicacion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aprendices_ficha`
--
ALTER TABLE `aprendices_ficha`
  ADD CONSTRAINT `aprendices_ficha_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `aprendices_ficha_ibfk_2` FOREIGN KEY (`id_ficha`) REFERENCES `fichas` (`id_ficha`);

--
-- Filtros para la tabla `detalle_prestamo`
--
ALTER TABLE `detalle_prestamo`
  ADD CONSTRAINT `detalle_prestamo_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamos` (`id_prestamo`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_prestamo_ibfk_2` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`equipo_id`);

--
-- Filtros para la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD CONSTRAINT `categoria_id` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`categoria_id`),
  ADD CONSTRAINT `cuentadante_id` FOREIGN KEY (`cuentadante_id`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `id_estado` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estado`),
  ADD CONSTRAINT `ubicacion_id` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicaciones` (`ubicacion_id`);

--
-- Filtros para la tabla `fichas`
--
ALTER TABLE `fichas`
  ADD CONSTRAINT `fichas_ibfk_1` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`);

--
-- Filtros para la tabla `historial_roles`
--
ALTER TABLE `historial_roles`
  ADD CONSTRAINT `historial_roles_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `historial_roles_ibfk_2` FOREIGN KEY (`id_rol_anterior`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `historial_roles_ibfk_3` FOREIGN KEY (`id_rol_nuevo`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `historial_roles_ibfk_4` FOREIGN KEY (`id_usuario_modificador`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`id_modulo`) REFERENCES `modulos` (`id_modulo`);

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id_permiso`);

--
-- Filtros para la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD CONSTRAINT `ubicaciones_ibfk_1` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`);

--
-- Filtros para la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD CONSTRAINT `usuario_rol_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `usuario_rol_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"hermesbeta\",\"table\":\"usuarios\"},{\"db\":\"hermesbeta\",\"table\":\"roles\"},{\"db\":\"hermesbeta\",\"table\":\"ubicaciones\"},{\"db\":\"hermesbeta\",\"table\":\"equipos\"},{\"db\":\"hermesbeta\",\"table\":\"estados\"},{\"db\":\"hermesbeta\",\"table\":\"usuario_rol\"},{\"db\":\"hermesbeta\",\"table\":\"sedes\"},{\"db\":\"hermesbeta\",\"table\":\"detalle_prestamo\"},{\"db\":\"hermesbeta\",\"table\":\"rol_permiso\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'hermesbeta', 'equipos', '{\"sorted_col\":\"`equipos`.`equipo_id` DESC\"}', '2025-05-26 20:05:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-05-29 21:52:24', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `poke_adso`
--
CREATE DATABASE IF NOT EXISTS `poke_adso` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `poke_adso`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pokemon`
--

CREATE TABLE `pokemon` (
  `id_pokedex` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `peso` int(5) NOT NULL,
  `altura` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `ataque` int(3) NOT NULL,
  `defensa` int(3) NOT NULL,
  `foto` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pokemon`
--

INSERT INTO `pokemon` (`id_pokedex`, `nombre`, `tipo`, `peso`, `altura`, `descripcion`, `ataque`, `defensa`, `foto`) VALUES
(1, 'Arceus', 'Veneno', 705, '10', 'It is told in mythology that this Pokémon was born before the universe even existed.', 50, 50, 0x32),
(3, 'Pikachu', 'Eléctrico', 32, '35', 'Pokémon tipo ratón eléctrico', 45, 35, 0x32);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pokemon`
--
ALTER TABLE `pokemon`
  ADD PRIMARY KEY (`id_pokedex`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pokemon`
--
ALTER TABLE `pokemon`
  MODIFY `id_pokedex` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Base de datos: `proyecto_ferreteria`
--
CREATE DATABASE IF NOT EXISTS `proyecto_ferreteria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `proyecto_ferreteria`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `correo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `telefono`, `direccion`, `correo`) VALUES
(1, 'david', '312231', 'calle 23', 'dasd@cas.com'),
(7, 'Carlos Pérez', '3123456789', 'Calle 1', 'carlos.perez@example.com'),
(8, 'Mariana López', '3129876543', 'Avenida Siempre Viva 742', 'mariana.lopez@example.com'),
(13, 'Dayana', '3117665432', 'Calle 2', 'dayana123@hotmail.com'),
(14, 'Lucía Fernández', '3129988776', 'Calle Sol 89', 'lucia.fernandez@example.com'),
(15, 'Juan Herrera', '3123344556', 'Carrera 45B', 'juan.herrera@example.com'),
(16, 'Laura Castro', '3121122334', 'Calle 8 #334', 'laura.castro@example.com'),
(17, 'Diego Morales', '3127766554', 'Av. Amazonía 201', 'diego.morales@example.com'),
(18, 'Elena Ruiz', '3126677889', 'Calle Olivos 66', 'elena.ruiz@example.com'),
(19, 'Marco Vargas', '3122233445', 'Av. Los Pinos 10', 'marco.vargas@example.com'),
(21, 'Andrés Molina', '3128899001', 'Callejón Estrella 19', 'andres.molina@example.com'),
(22, 'Valentina Bravo', '3123344112', 'Av. Del Parque 5', 'valentina.bravo@example.com'),
(23, 'Mateo Salas', '3121234000', 'Residencial Norte 44', 'mateo.salas@example.com'),
(24, 'Camila Aguirre', '3128765432', 'Pasaje Luna 29', 'camila.aguirre@example.com'),
(25, 'Jorge Cedeño', '3125432198', 'Callejón 21B', 'jorge.cedeno@example.com'),
(26, 'Gabriela Paredes', '3129873210', 'Urbanización Central 11', 'gabriela.paredes@example.com'),
(27, 'Esteban Quintero', '3124567123', 'Av. Libertad 88', 'esteban.quintero@example.com'),
(28, 'Natalia Ramos', '3122223334', 'Calle 12C', 'natalia.ramos@example.com'),
(29, 'Ricardo Medina', '3129991234', 'Avenida Del Río 33', 'ricardo.medina@example.com'),
(30, 'Isabella Romero', '3127778889', 'Calle Bella 100', 'isabella.romero@example.com'),
(31, 'Tomás Salcedo', '3123332221', 'Zona Norte 18', 'tomas.salcedo@example.com'),
(32, 'Renata Mejía', '3124321567', 'Barrio Alegre 20', 'renata.mejia@example.com'),
(33, 'Felipe Ibáñez', '3126547890', 'Diagonal 21A #7', 'felipe.ibanez@example.com'),
(34, 'loco', '003121234000', 'Residencial Norte 44 tulua', 'mateo.salas@example.com'),
(35, 'Juan jose', '37271313', 'el sagrado', 'mangoa577@gmail.com'),
(36, 'Juan jose', '37271313', 'salesiano', 'mangoa577@gmail.com'),
(37, 'Juan jose', '37271313', 'bicentenario', 'mangoa577@gmail.com'),
(38, 'camilo muriel', '37271313', 'bicentenario', 'mangoa577@gmail.com'),
(39, 'Christian Henao', '37271313', 'el progresar', 'Christianhenao010@gmail.com'),
(40, 'camilo muriel', '3224525', 'el bosque', 'restrepo5088@gmail.com'),
(41, 'Jhoan', '24242', 'en la casa', 'sinisterravalenciajhoandavid@gmail.com'),
(42, 'david', '574774', 'fajfnahfa', 'davidsatizabal705@gmail.com'),
(44, 'cristian', '5433', 'afaf', 'restrepo5088@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `salario` float(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id_empleado`, `nombre`, `usuario`, `clave`, `cargo`, `salario`) VALUES
(1, 'Carlos M. Torres', 'admin', 'admin123', 'Administrador', 1000000.00),
(4, 'Marta S. López', 'mslopez', 'nuevaclave4', 'Gerente', 1000000.00),
(5, 'Jorge R. Díaz', 'jrdiaz', 'nuevaclave5', 'Empleado', 1000000.00),
(17, 'juan', 'juan', '123', 'Administrador', 1234.00),
(20, 'Luis Gómez', 'lgomez', 'clave123', 'Administrador', 1000000.00),
(23, 'Laura Fernández', 'lfernandez', 'clave123', 'Empleado', 1000000.00),
(26, 'Fernando Herrera', 'fherrera', 'clave123', 'Gerente', 1000000.00),
(29, 'Camila Díaz', 'cdiaz', 'clave123', 'Empleado', 1000000.00),
(30, 'Ricardo Castro', 'rcastro', 'clave123', 'Gerente', 1000000.00),
(31, 'Paula Mejía', 'pmejia', 'clave123', 'Administrador', 1000000.00),
(33, 'Valentina Silva', 'vsilva', 'clave123', 'Empleado', 1000000.00),
(34, 'Julián Pérez', 'jperez', 'clave123', 'Gerente', 1000000.00),
(35, 'Natalia Vargas', 'nvargas', 'clave123', 'Administrador', 1000000.00),
(38, 'Esteban', '123', '123', 'Empleado', 1.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_productos`
--

CREATE TABLE `inventario_productos` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(50) NOT NULL,
  `categoria` enum('Herramientas','Tornillos','Tuercas','Materiales de Construcción','Pinturas y Acabados','Fontanería y Tuberías','Electricidad y Cableado','Adhesivos y Selladores') NOT NULL,
  `cantidad_stock` int(11) NOT NULL,
  `precio_producto` decimal(10,2) NOT NULL,
  `id_proveedor_asociado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_productos`
--

INSERT INTO `inventario_productos` (`id_producto`, `nombre_producto`, `categoria`, `cantidad_stock`, `precio_producto`, `id_proveedor_asociado`) VALUES
(4, 'Alicate', 'Herramientas', 8, 500.00, 1),
(7, 'Serrucho', 'Herramientas', 0, 12.00, 1),
(8, 'Martillo', 'Herramientas', 29, 500.00, 1),
(69, 'Pala', 'Herramientas', 18, 700.00, 4),
(70, 'Cemento', 'Materiales de Construcción', 30, 80000.00, 4),
(71, 'Cegueta', 'Herramientas', 15, 5000.00, 7),
(72, 'Martillo de acero', 'Herramientas', 20, 85000.00, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes_compra`
--

CREATE TABLE `ordenes_compra` (
  `id_orden_compra` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `total` double(8,2) DEFAULT NULL,
  `estado_orden` enum('pendiente','pagada','enviada') NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ordenes_compra`
--

INSERT INTO `ordenes_compra` (`id_orden_compra`, `id_cliente`, `id_empleado`, `id_producto`, `total`, `estado_orden`, `fecha_compra`) VALUES
(18, 1, 1, 4, 595.00, 'pendiente', '2025-04-06 04:31:22'),
(19, 1, 1, 4, 1783.81, 'pendiente', '2025-04-06 04:34:33'),
(20, 1, 1, 4, 595.00, 'pendiente', '2025-04-06 04:47:55'),
(21, 1, 1, 4, 7720.72, 'pendiente', '2025-04-06 04:49:50'),
(23, 1, 1, 4, 595.00, 'pendiente', '2025-04-06 23:40:41'),
(24, 1, 1, 4, 595.00, 'pendiente', '2025-04-06 23:48:51'),
(28, 1, 1, 4, 595.00, 'pendiente', '2025-04-07 00:24:49'),
(30, 1, 4, 4, 2380.00, 'pagada', '2025-04-10 23:32:21'),
(31, 1, 1, 8, 1190.00, 'enviada', '2025-04-13 04:27:26'),
(32, 38, 5, 8, 2856.00, 'pagada', '2025-04-13 14:25:21'),
(33, 39, 5, 8, 1190.00, 'pagada', '2025-04-13 14:51:05'),
(34, 40, 5, 8, 1190.00, 'enviada', '2025-04-13 15:56:17'),
(35, 41, 5, 8, 1785.00, 'pagada', '2025-04-13 16:00:11'),
(36, 42, 1, 4, 1190.00, 'pagada', '2025-04-15 01:38:48'),
(37, 44, 1, 4, 1190.00, 'pagada', '2025-04-25 20:15:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `contacto` varchar(50) NOT NULL,
  `categoria_producto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `contacto`, `categoria_producto`) VALUES
(1, 'Jhoan David', '12345', 'Herramientas'),
(4, 'Karol Arbelaez', '31123441', 'Herramientas'),
(5, 'Quico', '5671222132', 'Maquinaria'),
(7, 'Suministros Industriales S.A.', '3123456789', 'Herramientas'),
(8, 'ElectroPartes LTDA', '3159876543', 'Herramientas'),
(10, 'FerreMax Distribuidores', '3195566778', 'Herramientas'),
(11, 'TecnoPlásticos S.R.L.', '111333213', 'Tubos y Conexiones'),
(12, 'Josefina', '33214453', 'Herramienta'),
(13, 'Gustavo', '3124442343', 'Fontanería y Tuberías');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_ventas`
--

CREATE TABLE `registro_ventas` (
  `id_venta` int(11) NOT NULL,
  `id_orden_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_producto` decimal(10,2) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `fecha_venta` datetime DEFAULT current_timestamp(),
  `id_cliente` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_ventas`
--

INSERT INTO `registro_ventas` (`id_venta`, `id_orden_compra`, `id_producto`, `cantidad`, `precio_producto`, `sub_total`, `fecha_venta`, `id_cliente`, `id_empleado`) VALUES
(1, 28, 4, 1, 500.00, 1.00, '2025-04-06 19:24:49', 1, 1),
(2, 30, 4, 2, 500.00, 1000.00, '2025-04-10 18:32:21', 1, 4),
(3, 30, 8, 2, 500.00, 1000.00, '2025-04-10 18:32:21', 1, 4),
(4, 31, 8, 2, 500.00, 1000.00, '2025-04-12 23:27:26', 1, 1),
(5, 32, 8, 2, 500.00, 1000.00, '2025-04-13 09:25:21', 38, 5),
(6, 32, 69, 2, 700.00, 1400.00, '2025-04-13 09:25:21', 38, 5),
(7, 33, 8, 2, 500.00, 1000.00, '2025-04-13 09:51:05', 39, 5),
(8, 34, 8, 2, 500.00, 1000.00, '2025-04-13 10:56:17', 40, 5),
(9, 35, 8, 3, 500.00, 1500.00, '2025-04-13 11:00:11', 41, 5),
(10, 36, 4, 2, 500.00, 1000.00, '2025-04-14 20:38:48', 42, 1),
(11, 37, 4, 2, 500.00, 1000.00, '2025-04-25 15:15:59', 44, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`);

--
-- Indices de la tabla `inventario_productos`
--
ALTER TABLE `inventario_productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_proveedor_asociado` (`id_proveedor_asociado`);

--
-- Indices de la tabla `ordenes_compra`
--
ALTER TABLE `ordenes_compra`
  ADD PRIMARY KEY (`id_orden_compra`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `registro_ventas`
--
ALTER TABLE `registro_ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_orden_compra` (`id_orden_compra`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `inventario_productos`
--
ALTER TABLE `inventario_productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT de la tabla `ordenes_compra`
--
ALTER TABLE `ordenes_compra`
  MODIFY `id_orden_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `registro_ventas`
--
ALTER TABLE `registro_ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventario_productos`
--
ALTER TABLE `inventario_productos`
  ADD CONSTRAINT `inventario_productos_ibfk_1` FOREIGN KEY (`id_proveedor_asociado`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `ordenes_compra`
--
ALTER TABLE `ordenes_compra`
  ADD CONSTRAINT `ordenes_compra_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordenes_compra_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordenes_compra_ibfk_3` FOREIGN KEY (`id_producto`) REFERENCES `inventario_productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `registro_ventas`
--
ALTER TABLE `registro_ventas`
  ADD CONSTRAINT `registro_ventas_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `inventario_productos` (`id_producto`),
  ADD CONSTRAINT `registro_ventas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `registro_ventas_ibfk_3` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
