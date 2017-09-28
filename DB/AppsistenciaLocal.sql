-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-09-2017 a las 05:50:18
-- Versión del servidor: 10.1.25-MariaDB
-- Versión de PHP: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `appsistencia`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `acceder_alumnoEliminado` (IN `codigo_coordinador` VARCHAR(20))  NO SQL
BEGIN
UPDATE `personal_eliminado` SET personal_eliminado.codigo_udc=codigo_coordinador WHERE 1;
SELECT * FROM personal_eliminado WHERE personal_eliminado.rol='1';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `acceder_asignaturaEliminada` (IN `codigo_coordinador` VARCHAR(20))  NO SQL
BEGIN
UPDATE asignatura_eliminada
SET asignatura_eliminada.codigo_udc=codigo_coordinador
WHERE 1;
SELECT * FROM asignatura_eliminada WHERE 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `acceder_tutorEliminado` (IN `codigo_coordinador` VARCHAR(20))  NO SQL
BEGIN
UPDATE `personal_eliminado` SET personal_eliminado.codigo_udc=codigo_coordinador WHERE 1;
SELECT * FROM personal_eliminado WHERE personal_eliminado.rol='2';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_asignatura` (IN `codigo_asignatura` VARCHAR(20), IN `nombre_asignatura` VARCHAR(20), IN `sabado` VARCHAR(20), IN `credito_asignatura` VARCHAR(20))  NO SQL
UPDATE asignatura
SET asignatura.nombre=nombre_asignatura,asignatura.ciclo=sabado,
asignatura.credito=credito_asignatura
WHERE asignatura.codigo_asig=codigo_asignatura$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_codigo_asignatura` (IN `codigo_viejo` VARCHAR(20), IN `codigo_asignatura_nuevo` VARCHAR(20))  NO SQL
UPDATE asignatura
SET asignatura.codigo_asig=codigo_asignatura_nuevo
WHERE asignatura.codigo_asig=codigo_viejo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_codigo_udc` (IN `codigo_viejo` VARCHAR(20), IN `codigo_udc_nuevo` VARCHAR(20))  NO SQL
BEGIN
UPDATE personal SET personal.codigo_udc=codigo_udc_nuevo
WHERE personal.codigo_udc=codigo_viejo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_email` (IN `codigo_udc` VARCHAR(20), IN `reg_email` VARCHAR(40))  NO SQL
BEGIN
UPDATE personal
SET personal.email=reg_email
WHERE personal.codigo_udc=codigo_udc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_fecha_tutoria` (IN `id_tutoria` INT, IN `fecha_tutoria` DATE)  NO SQL
UPDATE tutoria SET tutoria.fecha_tutoria=fecha_tutoria
WHERE tutoria.id_tutoria=id_tutoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_fecha_tutoria1grupo` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `fecha_tutoria1` DATE)  NO SQL
BEGIN
DECLARE fecha DATE;
DECLARE orden INT;
SET fecha=fecha_tutoria1;
SET orden=1;
WHILE (orden<=7) DO
UPDATE tutoria SET tutoria.fecha_tutoria=fecha
WHERE ((tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura) AND tutoria.orden=orden);
SET fecha=DATE_ADD(fecha,INTERVAL 14 DAY);
SET orden=orden+1;
END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_fecha_tutoria_ngrupos` (IN `id_tutoria_inicial` INT, IN `fecha_tutoria1` DATE)  NO SQL
BEGIN
DECLARE fecha DATE;
DECLARE id INT;
DECLARE n INT;
SET fecha=fecha_tutoria1;
SET id=id_tutoria_inicial;
SET n=1;
WHILE (n<=7) DO
UPDATE tutoria SET tutoria.fecha_tutoria=fecha
WHERE tutoria.id_tutoria=id;
SET fecha=DATE_ADD(fecha,INTERVAL 14 DAY);
SET id=id+1;
SET n=n+1;
END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_horas_1grupo` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `hora_inicio` TIME, IN `hora_final` TIME)  NO SQL
UPDATE tutoria SET
tutoria.hora_inicio=hora_inicio,tutoria.hora_final=hora_final
WHERE tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_horas_ngrupos` (IN `id_tutoria_inicial` INT, IN `hora_inicio` TIME, IN `hora_final` TIME)  NO SQL
BEGIN
DECLARE id INT;
DECLARE n INT;
SET id=id_tutoria_inicial;
SET n=1;
WHILE (n<=7) DO
UPDATE tutoria SET tutoria.hora_inicio=hora_inicio,tutoria.hora_final=hora_final
WHERE tutoria.id_tutoria=id;
SET id=id+1;
SET n=n+1;
END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_nombres_apellidos` (IN `codigo_udc` VARCHAR(20), IN `reg_nombre1` VARCHAR(20), IN `reg_nombre2` VARCHAR(20), IN `reg_apellido1` VARCHAR(20), IN `reg_apellido2` VARCHAR(20))  NO SQL
BEGIN
UPDATE personal
SET personal.nombre1=reg_nombre1,personal.nombre2=reg_nombre2,
personal.apellido1=reg_apellido1,personal.apellido2=reg_apellido2
WHERE personal.codigo_udc=codigo_udc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_rol` (IN `codigo_udc` VARCHAR(20), IN `reg_rol` VARCHAR(1))  NO SQL
BEGIN
UPDATE personal
SET personal.rol=reg_rol
WHERE personal.codigo_udc=codigo_udc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_asignada` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20))  NO SQL
DELETE FROM asignada_tutor_asignatura
WHERE (asignada_tutor_asignatura.codigo_udc=codigo_tutor
      AND asignada_tutor_asignatura.codigo_asig=codigo_asignatura)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_asignatura` (IN `codigo_asignatura` VARCHAR(20), IN `nombre_asignatura` VARCHAR(20))  NO SQL
DELETE FROM asignatura WHERE asignatura.codigo_asig=codigo_asignatura OR asignatura.nombre=nombre_asignatura$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_matricula` (IN `codigo_estudiante` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20))  NO SQL
DELETE FROM matricula_estudiante_asignatura
WHERE (matricula_estudiante_asignatura.codigo_udc=codigo_estudiante
      AND matricula_estudiante_asignatura.codigo_asig=codigo_asignatura)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_personal` (IN `codigo_udc` VARCHAR(20))  NO SQL
DELETE FROM personal WHERE personal.codigo_udc=codigo_udc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_reporte` (IN `id_reporte` INT)  NO SQL
DELETE FROM reporte WHERE reporte.id_reporte=id_reporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_asistencia` (IN `codigo_estudiante` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `orden` VARCHAR(1))  NO SQL
SELECT bitacora.id_bitacora,bitacora.orden,bitacora.asistencia,bitacora.codigo_udc AS codigo_estudiante,bitacora.codigo_asig,asignatura.nombre
 AS asignatura,personal.nombre1 AS nombre_estudiante,personal.apellido1 AS apellido_estudiante
FROM bitacora JOIN asignatura ON bitacora.codigo_asig=asignatura.codigo_asig
JOIN estudiante ON estudiante.codigo_udc=bitacora.codigo_udc
JOIN personal ON personal.codigo_udc=estudiante.codigo_udc
WHERE ((bitacora.codigo_udc=codigo_estudiante AND bitacora.codigo_asig=codigo_asignatura) AND (bitacora.orden=orden))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_login` (IN `usuario` VARCHAR(20), IN `clave` VARCHAR(150))  NO SQL
SELECT * FROM login WHERE codigo_udc=usuario AND contraseña=clave$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_observacion_1grupo` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `orden` VARCHAR(1), IN `fecha_tutoria` DATE)  NO SQL
SELECT tutoria.id_tutoria,tutoria.orden,tutoria.observacion,tutoria.fecha_tutoria,tutoria.hora_inicio,tutoria.hora_final,tutoria.codigo_udc AS codigo_tutor,tutoria.codigo_asig AS codigo_asignatura,personal.nombre1,personal.apellido1,asignatura.nombre AS asignatura
FROM tutoria JOIN tutor ON tutoria.codigo_udc=tutor.codigo_udc
JOIN personal ON personal.codigo_udc=tutor.codigo_udc
JOIN asignatura ON asignatura.codigo_asig=tutoria.codigo_asig
WHERE (tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura) AND (tutoria.orden=orden OR tutoria.fecha_tutoria=fecha_tutoria)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_observacion_general` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `fecha_tutoria` DATE, IN `hora_inicio` TIME)  NO SQL
SELECT tutoria.id_tutoria,tutoria.orden,tutoria.observacion,tutoria.fecha_tutoria,tutoria.hora_inicio,tutoria.hora_final,tutoria.codigo_udc AS codigo_tutor,tutoria.codigo_asig AS codigo_asignatura,personal.nombre1,personal.apellido1,asignatura.nombre AS asignatura
FROM tutoria JOIN tutor ON tutoria.codigo_udc=tutor.codigo_udc
JOIN personal ON personal.codigo_udc=tutor.codigo_udc
JOIN asignatura ON asignatura.codigo_asig=tutoria.codigo_asig
WHERE ((tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura)AND(tutoria.fecha_tutoria=fecha_tutoria AND tutoria.hora_inicio=hora_inicio))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_tutoria_id` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20))  NO SQL
SELECT tutoria.id_tutoria,tutoria.orden,tutoria.observacion,tutoria.fecha_tutoria,tutoria.hora_inicio,tutoria.hora_final,tutoria.codigo_udc AS codigo_tutor,tutoria.codigo_asig AS codigo_asignatura
FROM tutoria
WHERE ((tutoria.codigo_udc=codigo_tutor) AND (tutoria.codigo_asig=codigo_asignatura))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_tutoria_tutor_asignatura` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20))  NO SQL
SELECT tutoria.id_tutoria,tutoria.orden,asignada_tutor_asignatura.grupo,asignatura.nombre AS asignatura,personal.nombre1 AS nombre_tutor,personal.apellido1 AS apellido_tutor
FROM personal INNER JOIN tutor ON personal.codigo_udc=tutor.codigo_udc
INNER JOIN tutoria ON tutoria.codigo_udc=tutor.codigo_udc
INNER JOIN asignatura ON asignatura.codigo_asig=tutoria.codigo_asig
INNER JOIN asignada_tutor_asignatura ON asignada_tutor_asignatura.codigo_asig=asignatura.codigo_asig
WHERE ((tutoria.codigo_udc=codigo_tutor) AND (tutoria.codigo_asig=codigo_asignatura))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_asignada` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `grupos` INT, IN `grupo` VARCHAR(20))  NO SQL
INSERT INTO asignada_tutor_asignatura (codigo_udc,codigo_asig,grupos,grupo)
VALUES (codigo_tutor,codigo_asignatura,grupos,grupo)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_asignatura` (IN `codigo_asignatura` VARCHAR(20), IN `nombre_asignatura` VARCHAR(40), IN `sabado` VARCHAR(1), IN `credito_asignatura` VARCHAR(20))  NO SQL
INSERT INTO asignatura (codigo_asig,nombre,ciclo,credito)
VALUES (codigo_asignatura,nombre_asignatura,sabado,credito_asignatura)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_asistencia` (IN `codigo_estudiante` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `id_tutoria` INT, IN `orden` VARCHAR(1), IN `editar_asistencia` VARCHAR(20))  NO SQL
UPDATE bitacora SET bitacora.id_tutoria=id_tutoria,bitacora.asistencia=editar_asistencia
WHERE ((bitacora.codigo_udc=codigo_estudiante AND bitacora.codigo_asig=codigo_asignatura) AND bitacora.orden=orden)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_fecha_horas_1grupo` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `fecha_tutoria1` DATE, IN `hora_inicio` TIME, IN `hora_final` TIME)  NO SQL
BEGIN
DECLARE fecha DATE;
DECLARE orden INT;
SET fecha=fecha_tutoria1;
SET orden=1;
WHILE (orden<=7) DO
UPDATE tutoria SET tutoria.fecha_tutoria=fecha
WHERE ((tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura) AND tutoria.orden=orden);
SET fecha=DATE_ADD(fecha,INTERVAL 14 DAY);
SET orden=orden+1;
END WHILE;
UPDATE tutoria SET
tutoria.hora_inicio=hora_inicio,tutoria.hora_final=hora_final
WHERE tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_fecha_hora_ngrupos` (IN `id_tutoria_inicial` INT, IN `fecha_tutoria1` DATE, IN `hora_inicio` TIME, IN `hora_final` TIME)  NO SQL
BEGIN
DECLARE fecha DATE;
DECLARE id INT;
DECLARE n INT;
SET fecha=fecha_tutoria1;
SET id=id_tutoria_inicial;
SET n=1;
WHILE (n<=7) DO
UPDATE tutoria SET tutoria.fecha_tutoria=fecha,tutoria.hora_inicio=hora_inicio,tutoria.hora_final=hora_final
WHERE tutoria.id_tutoria=id;
SET fecha=DATE_ADD(fecha,INTERVAL 14 DAY);
SET id=id+1;
SET n=n+1;
END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_login` (IN `reg_codigo_udc` VARCHAR(20), IN `reg_password` VARCHAR(255))  BEGIN
UPDATE login SET login.contraseña=reg_password
WHERE login.codigo_udc=reg_codigo_udc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_matricula` (IN `codigo_estudiante` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `codigo_tutor` VARCHAR(20), IN `grupo_asignatura` VARCHAR(10))  NO SQL
INSERT INTO matricula_estudiante_asignatura (codigo_udc,codigo_asig,codigo_tutor,grupo)
VALUES (codigo_estudiante,codigo_asignatura,codigo_tutor,grupo_asignatura)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_observacion_general` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `fecha_tutoria` DATE, IN `hora_inicio` TIME, IN `observacion` TEXT)  NO SQL
UPDATE tutoria SET tutoria.observacion=observacion
WHERE ((tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura)AND(tutoria.fecha_tutoria=fecha_tutoria AND tutoria.hora_inicio=hora_inicio))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_observacion_ngrupos` (IN `id_tutoria` INT, IN `observacion` TEXT)  NO SQL
UPDATE tutoria SET tutoria.observacion=observacion
WHERE tutoria.id_tutoria=id_tutoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_observacion_por_fecha1grupo` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `fecha_tutoria` DATE, IN `observacion` TEXT)  NO SQL
UPDATE tutoria SET tutoria.observacion=observacion
WHERE ((tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura) AND tutoria.fecha_tutoria=fecha_tutoria)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_observacion_por_orden1grupo` (IN `codigo_tutor` VARCHAR(20), IN `codigo_asignatura` VARCHAR(20), IN `orden` VARCHAR(1), IN `observacion` TEXT)  NO SQL
UPDATE tutoria SET tutoria.observacion=observacion
WHERE ((tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura) AND tutoria.orden=orden)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_personal` (`reg_codigo_udc` VARCHAR(20), `reg_nombre1` VARCHAR(20), `reg_nombre2` VARCHAR(20), `reg_apellido1` VARCHAR(20), `reg_apellido2` VARCHAR(20), `reg_email` VARCHAR(40), `reg_rol` VARCHAR(1))  BEGIN
INSERT INTO personal (codigo_udc,nombre1,nombre2,apellido1,apellido2,email,rol)
VALUES (reg_codigo_udc,reg_nombre1,reg_nombre2,reg_apellido1,reg_apellido2,reg_email,reg_rol);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_tutoria` (IN `codigo_coordinador` VARCHAR(20), IN `orden_tutoria` VARCHAR(1), IN `codigo_asignatura` VARCHAR(20), IN `codigo_tutor` VARCHAR(20), IN `grupo_asignatura` VARCHAR(10))  BEGIN
INSERT INTO reporte (codigo_udc,orden,grupo,codigo_tutor,codigo_asignatura) VALUES (codigo_coordinador,orden_tutoria,grupo_asignatura,codigo_tutor,codigo_asignatura);
SELECT asignatura.nombre AS Asignatura,bitacora.codigo_tutor,COUNT(*) AS Total_Estudiantes,COUNT(asistencia) AS Total_votos,bitacora.grupo,bitacora.orden FROM `bitacora` JOIN asignatura ON bitacora.codigo_asig=asignatura.codigo_asig WHERE (bitacora.orden=orden_tutoria AND bitacora.codigo_asig=codigo_asignatura) AND (bitacora.codigo_tutor=codigo_tutor AND bitacora.grupo=grupo_asignatura);
SELECT COUNT(asistencia) AS Sí_Asistió,personal.nombre1 AS Tutor_Nombre,personal.apellido1 AS Tutor_Apellido FROM bitacora JOIN personal ON bitacora.codigo_tutor=personal.codigo_udc WHERE ((bitacora.asistencia='SI' AND bitacora.orden=orden_tutoria) AND (bitacora.codigo_asig=codigo_asignatura AND bitacora.codigo_tutor=codigo_tutor)) AND bitacora.grupo=grupo_asignatura;
SELECT COUNT(asistencia) AS NO_Asistió,personal.nombre1 AS Tutor_Nombre,personal.apellido1 AS Tutor_Apellido FROM bitacora JOIN personal ON bitacora.codigo_tutor=personal.codigo_udc WHERE ((bitacora.asistencia='NO' AND bitacora.orden=orden_tutoria) AND (bitacora.codigo_asig=codigo_asignatura AND bitacora.codigo_tutor=codigo_tutor)) AND bitacora.grupo=grupo_asignatura;
INSERT INTO reporte (codigo_udc,orden,codigo_asig,codigo_tutor,grupo) VALUES (codigo_coordinador,orden_tutoria,codigo_asignatura,codigo_tutor,grupo_asignatura);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_tutoria_completo` (IN `codigo_coordinador` VARCHAR(20), IN `orden_tutoria` VARCHAR(1), IN `codigo_asignatura` VARCHAR(20), IN `codigo_tutor` VARCHAR(20), IN `grupo_asignatura` VARCHAR(10), IN `fecha_tutoria` DATE, IN `hora_inicio` TIME)  NO SQL
BEGIN
INSERT INTO reporte (codigo_udc,orden,grupo,codigo_tutor,codigo_asignatura) VALUES (codigo_coordinador,orden_tutoria,grupo_asignatura,codigo_tutor,codigo_asignatura);
SELECT asignatura.nombre AS Asignatura,bitacora.codigo_tutor,COUNT(*) AS Total_Estudiantes,COUNT(asistencia) AS Total_votos,bitacora.grupo,bitacora.orden FROM `bitacora` JOIN asignatura ON bitacora.codigo_asig=asignatura.codigo_asig WHERE (bitacora.orden=orden_tutoria AND bitacora.codigo_asig=codigo_asignatura) AND (bitacora.codigo_tutor=codigo_tutor AND bitacora.grupo=grupo_asignatura);
SELECT COUNT(asistencia) AS Sí_Asistió FROM bitacora WHERE ((bitacora.asistencia='SI' AND bitacora.orden=orden_tutoria) AND (bitacora.codigo_asig=codigo_asignatura AND bitacora.codigo_tutor=codigo_tutor)) AND bitacora.grupo=grupo_asignatura;
SELECT COUNT(asistencia) AS NO_Asistió FROM bitacora WHERE ((bitacora.asistencia='NO' AND bitacora.orden=orden_tutoria) AND (bitacora.codigo_asig=codigo_asignatura AND bitacora.codigo_tutor=codigo_tutor)) AND bitacora.grupo=grupo_asignatura;
SELECT tutoria.id_tutoria,tutoria.orden,tutoria.observacion,tutoria.fecha_tutoria,tutoria.hora_inicio,tutoria.hora_final,tutoria.codigo_udc AS codigo_tutor,tutoria.codigo_asig AS codigo_asignatura,personal.nombre1,personal.apellido1,asignatura.nombre AS asignatura
FROM tutoria JOIN tutor ON tutoria.codigo_udc=tutor.codigo_udc
JOIN personal ON personal.codigo_udc=tutor.codigo_udc
JOIN asignatura ON asignatura.codigo_asig=tutoria.codigo_asig
WHERE ((tutoria.codigo_udc=codigo_tutor AND tutoria.codigo_asig=codigo_asignatura)AND(tutoria.fecha_tutoria=fecha_tutoria AND tutoria.hora_inicio=hora_inicio));
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignada_tutor_asignatura`
--

CREATE TABLE `asignada_tutor_asignatura` (
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Código del Tutor',
  `codigo_asig` varchar(20) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Código de la Asignatura',
  `grupos` int(11) NOT NULL COMMENT 'Número de Cursos con la misma Asignatura',
  `grupo` varchar(10) COLLATE latin1_spanish_ci DEFAULT NULL COMMENT 'Grupo de la Asignatura ejemplo A2,B1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Disparadores `asignada_tutor_asignatura`
--
DELIMITER $$
CREATE TRIGGER `eliminar_tutoria_por_asignada_bd` BEFORE DELETE ON `asignada_tutor_asignatura` FOR EACH ROW DELETE FROM tutoria
WHERE ((tutoria.codigo_udc=OLD.codigo_udc) AND (tutoria.codigo_asig=OLD.codigo_asig))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `registro_tutoria_ai` AFTER INSERT ON `asignada_tutor_asignatura` FOR EACH ROW BEGIN
DECLARE n BIGINT;
DECLARE o BIGINT;
SET n=1;
WHILE (n<=NEW.grupos*7) DO
SET o=1;
WHILE (o<=7) DO
INSERT INTO tutoria (orden,codigo_udc,codigo_asig) VALUES (o,NEW.codigo_udc,NEW.codigo_asig);
SET o=o+1;
SET n=n+1;
END WHILE;
END WHILE;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignatura`
--

CREATE TABLE `asignatura` (
  `codigo_asig` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `id_asignatura` int(11) NOT NULL,
  `nombre` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `credito` int(11) DEFAULT NULL,
  `ciclo` varchar(3) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Disparadores `asignatura`
--
DELIMITER $$
CREATE TRIGGER `borrar_asignatura_ad` AFTER DELETE ON `asignatura` FOR EACH ROW INSERT INTO asignatura_eliminada (usuario,fecha_hora,codigo_asig,nombre) VALUES (CURRENT_USER(),NOW(),OLD.codigo_asig,OLD.nombre)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignatura_eliminada`
--

CREATE TABLE `asignatura_eliminada` (
  `id_ae` int(11) NOT NULL,
  `usuario` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `codigo_asig` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `nombre` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

CREATE TABLE `bitacora` (
  `id_bitacora` int(11) NOT NULL,
  `orden` varchar(1) COLLATE latin1_spanish_ci NOT NULL,
  `asistencia` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `id_tutoria` int(11) DEFAULT NULL,
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `codigo_asig` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `codigo_tutor` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `grupo` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `id_reporte` int(11) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coordinador`
--

CREATE TABLE `coordinador` (
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`codigo_udc`) VALUES
('112233445566'),
('1202020'),
('123322'),
('41510010010'),
('4151001010'),
('7501710010'),
('7501720008');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `contraseña` varchar(255) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`codigo_udc`, `contraseña`) VALUES
('112233445566', ''),
('1202020', '123'),
('123322', '$2y$12$t8dQmdLzmXl01FRFisf1t.1lUoF6x9bv.V.ZMP1133qBWRvv5Z4j2'),
('41510010010', ''),
('4151001010', ''),
('7501710010', '$2y$12$ufcDD8AGPPGcAi4NnhJqaeF8QBotgAgXfxGFbjHH78txYLUYjTPMy'),
('7501720008', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula_estudiante_asignatura`
--

CREATE TABLE `matricula_estudiante_asignatura` (
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Código del Estudiante',
  `codigo_asig` varchar(20) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Código de la Asignatura',
  `codigo_tutor` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `grupo` varchar(10) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Disparadores `matricula_estudiante_asignatura`
--
DELIMITER $$
CREATE TRIGGER `eliminar_bitacora_por_matricula_bd` BEFORE DELETE ON `matricula_estudiante_asignatura` FOR EACH ROW DELETE FROM bitacora
WHERE (bitacora.codigo_udc=OLD.codigo_udc AND bitacora.codigo_asig=OLD.codigo_asig)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `registro_bitacora_ai` AFTER INSERT ON `matricula_estudiante_asignatura` FOR EACH ROW BEGIN
DECLARE n BIGINT;
DECLARE o BIGINT;
SET n=1;
SET o=1;
WHILE (n<=7) DO
INSERT INTO bitacora (orden,codigo_udc,codigo_asig,codigo_tutor,grupo) VALUES (o,NEW.codigo_udc,NEW.codigo_asig,NEW.codigo_tutor,NEW.grupo);
SET o=o+1;
SET n=n+1;
END WHILE;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `id_personal` int(11) NOT NULL,
  `nombre1` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `nombre2` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `apellido1` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `apellido2` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `email` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `rol` varchar(1) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Alumno es Tipo 1,Tutor 2,Coor 3, Coor y Tutor 4'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`codigo_udc`, `id_personal`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `email`, `rol`) VALUES
('112233445566', 87, 'Fernando', '', 'Garrido', 'Tercero', 'fernando@unicar.edu.co', '1'),
('1202020', 88, 'Fernando', '', 'Garrido', 'Tercero', 'fernando@unicar.edu.co', '1'),
('123322', 89, 'Fernando', '', 'Garrido', 'Tercero', 'fernando@unicar.edu.co', '1'),
('41510010010', 83, 'Fernando', '', 'Garrido', 'Tercero', 'fernando@unicar', '1'),
('4151001010', 84, 'Fernando', '', 'Garrido', 'Tercero', 'fernando@unicar.edu.co', '1'),
('7501710010', 90, 'Olman', '', 'Ortiz', 'Silva', 'ojortiz@unicartagena.edu.co', '1'),
('7501720008', 85, 'Luis', '', 'Avila', 'Soto', 'luis@asiasa.com', '1');

--
-- Disparadores `personal`
--
DELIMITER $$
CREATE TRIGGER `borrar_personal_ad` AFTER DELETE ON `personal` FOR EACH ROW INSERT INTO personal_eliminado (usuario,fecha_hora,codigo_personal,nombre1,apellido1,rol,email) VALUES (CURRENT_USER(),NOW(),OLD.codigo_udc,OLD.nombre1,OLD.apellido1,OLD.rol,OLD.email)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `fk_codigo_udc(tutor,estudiante,login)` AFTER INSERT ON `personal` FOR EACH ROW BEGIN
IF (NEW.rol=1) THEN
INSERT INTO estudiante (codigo_udc) VALUES (NEW.codigo_udc);
INSERT INTO login (codigo_udc) 	VALUES (NEW.codigo_udc);
ELSEIF (NEW.rol=2) THEN
INSERT INTO tutor (codigo_udc) VALUES (NEW.codigo_udc);
INSERT INTO login (codigo_udc) 	VALUES (NEW.codigo_udc);
ELSEIF (NEW.rol=3) THEN
INSERT INTO coordinador (codigo_udc) VALUES (NEW.codigo_udc);
INSERT INTO login (codigo_udc) 	VALUES (NEW.codigo_udc);
ELSEIF (NEW.rol=4) THEN
INSERT INTO tutor (codigo_udc) VALUES (NEW.codigo_udc);
INSERT INTO coordinador (codigo_udc) VALUES (NEW.codigo_udc);
INSERT INTO login (codigo_udc) 	VALUES (NEW.codigo_udc);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_eliminado`
--

CREATE TABLE `personal_eliminado` (
  `id_te` int(11) NOT NULL,
  `usuario` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `codigo_personal` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `nombre1` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `apellido1` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `rol` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `email` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `personal_eliminado`
--

INSERT INTO `personal_eliminado` (`id_te`, `usuario`, `fecha_hora`, `codigo_personal`, `nombre1`, `apellido1`, `rol`, `email`, `codigo_udc`) VALUES
(17, 'root@localhost', '2017-09-20 23:23:49', '123456', 'Luis', 'Garrido', '1', 'fernando@unicar.edu.co', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reporte`
--

CREATE TABLE `reporte` (
  `id_reporte` int(11) NOT NULL,
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `orden` varchar(1) COLLATE latin1_spanish_ci NOT NULL,
  `grupo` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `codigo_tutor` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `codigo_asignatura` varchar(20) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Disparadores `reporte`
--
DELIMITER $$
CREATE TRIGGER `fk_reporte_ai` AFTER INSERT ON `reporte` FOR EACH ROW UPDATE bitacora SET bitacora.id_reporte=NEW.id_reporte
WHERE (bitacora.orden=NEW.orden AND bitacora.codigo_tutor=NEW.codigo_tutor) AND (bitacora.grupo=NEW.grupo AND bitacora.codigo_asig=NEW.codigo_asignatura)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutor`
--

CREATE TABLE `tutor` (
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutoria`
--

CREATE TABLE `tutoria` (
  `id_tutoria` int(11) NOT NULL,
  `orden` varchar(1) COLLATE latin1_spanish_ci NOT NULL,
  `observacion` text COLLATE latin1_spanish_ci,
  `fecha_tutoria` date DEFAULT NULL COMMENT 'Formato Fecha: YYYY-MM-DD (Año:Mes:Día)',
  `hora_inicio` time DEFAULT NULL COMMENT 'Formato HH:MM:SS y Hora Militar (Hasta las 24 hors, 59min,59seg)',
  `hora_final` time DEFAULT NULL COMMENT 'Formato HH:MM:SS y Hora Militar (Hasta las 24 hors, 59min,59seg)',
  `fecha` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y Hora Automática',
  `codigo_udc` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `codigo_asig` varchar(20) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignada_tutor_asignatura`
--
ALTER TABLE `asignada_tutor_asignatura`
  ADD PRIMARY KEY (`codigo_udc`,`codigo_asig`),
  ADD KEY `codigo_asig` (`codigo_asig`);

--
-- Indices de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  ADD PRIMARY KEY (`codigo_asig`),
  ADD UNIQUE KEY `id_asignatura` (`id_asignatura`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `asignatura_eliminada`
--
ALTER TABLE `asignatura_eliminada`
  ADD PRIMARY KEY (`id_ae`),
  ADD KEY `codigo_udc` (`codigo_udc`);

--
-- Indices de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  ADD PRIMARY KEY (`id_bitacora`),
  ADD KEY `id_tutoria` (`id_tutoria`),
  ADD KEY `codigo_udc` (`codigo_udc`),
  ADD KEY `codigo_asig` (`codigo_asig`),
  ADD KEY `id_reporte` (`id_reporte`),
  ADD KEY `codigo_tutor` (`codigo_tutor`),
  ADD KEY `grupo` (`grupo`);

--
-- Indices de la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD PRIMARY KEY (`codigo_udc`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`codigo_udc`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`codigo_udc`);

--
-- Indices de la tabla `matricula_estudiante_asignatura`
--
ALTER TABLE `matricula_estudiante_asignatura`
  ADD PRIMARY KEY (`codigo_udc`,`codigo_asig`),
  ADD KEY `codigo_asig` (`codigo_asig`),
  ADD KEY `codigo_tutor` (`codigo_tutor`),
  ADD KEY `grupo` (`grupo`);

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`codigo_udc`),
  ADD UNIQUE KEY `id_personal` (`id_personal`);

--
-- Indices de la tabla `personal_eliminado`
--
ALTER TABLE `personal_eliminado`
  ADD PRIMARY KEY (`id_te`),
  ADD KEY `codigo_udc` (`codigo_udc`);

--
-- Indices de la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD PRIMARY KEY (`id_reporte`),
  ADD KEY `codigo_tutor` (`codigo_tutor`),
  ADD KEY `codigo_asignatura` (`codigo_asignatura`),
  ADD KEY `codigo_udc` (`codigo_udc`);

--
-- Indices de la tabla `tutor`
--
ALTER TABLE `tutor`
  ADD PRIMARY KEY (`codigo_udc`);

--
-- Indices de la tabla `tutoria`
--
ALTER TABLE `tutoria`
  ADD PRIMARY KEY (`id_tutoria`),
  ADD KEY `codigo_udc` (`codigo_udc`),
  ADD KEY `codigo_asig` (`codigo_asig`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  MODIFY `id_asignatura` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `asignatura_eliminada`
--
ALTER TABLE `asignatura_eliminada`
  MODIFY `id_ae` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `personal`
--
ALTER TABLE `personal`
  MODIFY `id_personal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT de la tabla `personal_eliminado`
--
ALTER TABLE `personal_eliminado`
  MODIFY `id_te` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT de la tabla `reporte`
--
ALTER TABLE `reporte`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tutoria`
--
ALTER TABLE `tutoria`
  MODIFY `id_tutoria` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignada_tutor_asignatura`
--
ALTER TABLE `asignada_tutor_asignatura`
  ADD CONSTRAINT `asignada_tutor_asignatura_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `tutor` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asignada_tutor_asignatura_ibfk_2` FOREIGN KEY (`codigo_asig`) REFERENCES `asignatura` (`codigo_asig`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asignatura_eliminada`
--
ALTER TABLE `asignatura_eliminada`
  ADD CONSTRAINT `asignatura_eliminada_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `coordinador` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `bitacora`
--
ALTER TABLE `bitacora`
  ADD CONSTRAINT `bitacora_ibfk_1` FOREIGN KEY (`id_tutoria`) REFERENCES `tutoria` (`id_tutoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bitacora_ibfk_2` FOREIGN KEY (`codigo_udc`) REFERENCES `estudiante` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bitacora_ibfk_3` FOREIGN KEY (`codigo_asig`) REFERENCES `asignatura` (`codigo_asig`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bitacora_ibfk_4` FOREIGN KEY (`id_reporte`) REFERENCES `reporte` (`id_reporte`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `bitacora_ibfk_5` FOREIGN KEY (`codigo_tutor`) REFERENCES `tutor` (`codigo_udc`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD CONSTRAINT `coordinador_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `personal` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `personal` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `login_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `personal` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `matricula_estudiante_asignatura`
--
ALTER TABLE `matricula_estudiante_asignatura`
  ADD CONSTRAINT `matricula_estudiante_asignatura_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `estudiante` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `matricula_estudiante_asignatura_ibfk_2` FOREIGN KEY (`codigo_asig`) REFERENCES `asignatura` (`codigo_asig`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `matricula_estudiante_asignatura_ibfk_3` FOREIGN KEY (`codigo_tutor`) REFERENCES `tutor` (`codigo_udc`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `personal_eliminado`
--
ALTER TABLE `personal_eliminado`
  ADD CONSTRAINT `personal_eliminado_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `coordinador` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `coordinador` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_2` FOREIGN KEY (`codigo_tutor`) REFERENCES `tutor` (`codigo_udc`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_3` FOREIGN KEY (`codigo_asignatura`) REFERENCES `asignatura` (`codigo_asig`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `tutor`
--
ALTER TABLE `tutor`
  ADD CONSTRAINT `tutor_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `personal` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tutoria`
--
ALTER TABLE `tutoria`
  ADD CONSTRAINT `tutoria_ibfk_1` FOREIGN KEY (`codigo_udc`) REFERENCES `tutor` (`codigo_udc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tutoria_ibfk_2` FOREIGN KEY (`codigo_asig`) REFERENCES `asignatura` (`codigo_asig`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
