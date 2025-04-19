-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema babyfutbol
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `babyfutbol` ;

-- -----------------------------------------------------
-- Schema babyfutbol
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `babyfutbol` DEFAULT CHARACTER SET utf8mb4 ;
USE `babyfutbol` ;

-- -----------------------------------------------------
-- Table `babyfutbol`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`roles` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`roles` (
  `idroles` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idroles`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`usuarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `apellido` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `edad` INT(11) NULL DEFAULT NULL,
  `rol_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuarios_roles1_idx` (`rol_id` ASC),
  CONSTRAINT `fk_usuarios_roles1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `babyfutbol`.`roles` (`idroles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`arbitros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`arbitros` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`arbitros` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `experiencia` INT(11) NULL DEFAULT NULL,
  `usuario_id` INT(11) NOT NULL,
  UNIQUE (`usuario_id`),
  PRIMARY KEY (`id`),
  INDEX `fk_arbitros_usuarios1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_arbitros_usuarios1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `babyfutbol`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`entrenadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`entrenadores` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`entrenadores` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `experiencia` INT(11) NULL DEFAULT NULL,
  `usuario_id` INT(11) NOT NULL,
  UNIQUE (`usuario_id`),
  PRIMARY KEY (`id`),
  INDEX `fk_entrenadores_usuarios1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_entrenadores_usuarios1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `babyfutbol`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`equipos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`equipos` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`equipos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `categoria` VARCHAR(100) NULL DEFAULT NULL,
  `entrenador_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_equipos_entrenadores1` (`entrenador_id` ASC),
  CONSTRAINT `fk_equipos_entrenadores1`
    FOREIGN KEY (`entrenador_id`)
    REFERENCES `babyfutbol`.`entrenadores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`torneos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`torneos` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`torneos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`equipos_torneos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`equipos_torneos` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`equipos_torneos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `equipo_id` INT(11) NULL DEFAULT NULL,
  `torneo_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `equipo_torneo_ibfk_1` (`equipo_id` ASC),
  INDEX `equipo_torneo_ibfk_2` (`torneo_id` ASC),
  CONSTRAINT `equipo_torneo_ibfk_1`
    FOREIGN KEY (`equipo_id`)
    REFERENCES `babyfutbol`.`equipos` (`id`),
  CONSTRAINT `equipo_torneo_ibfk_2`
    FOREIGN KEY (`torneo_id`)
    REFERENCES `babyfutbol`.`torneos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`estadios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`estadios` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`estadios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `ubicacion` VARCHAR(100) NULL DEFAULT NULL,
  `capacidad` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`jugadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`jugadores` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`jugadores` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `posicion` VARCHAR(100) NULL DEFAULT NULL,
  `numero_camiseta` INT(11) NULL DEFAULT NULL,
  `equipo_id` INT(11) NULL DEFAULT NULL,
  `usuario_id` INT(11) NOT NULL,
  UNIQUE (`usuario_id`),
  PRIMARY KEY (`id`),
  INDEX `jugador_ibfk_1` (`equipo_id` ASC),
  INDEX `fk_jugadores_usuarios1_idx` (`usuario_id` ASC),
  CONSTRAINT `jugador_ibfk_1`
    FOREIGN KEY (`equipo_id`)
    REFERENCES `babyfutbol`.`equipos` (`id`),
  CONSTRAINT `fk_jugadores_usuarios1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `babyfutbol`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`partidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`partidos` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`partidos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL DEFAULT NULL,
  `equipo_local_id` INT(11) NULL DEFAULT NULL,
  `equipo_visitante_id` INT(11) NULL DEFAULT NULL,
  `torneo_id` INT(11) NULL DEFAULT NULL,
  `estadio_id` INT(11) NULL DEFAULT NULL,
  `arbitro_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estadio` (`estadio_id` ASC),
  INDEX `fk_partido_arbitro1` (`arbitro_id` ASC),
  INDEX `fk_torneo` (`torneo_id` ASC),
  INDEX `partido_ibfk_1` (`equipo_local_id` ASC),
  INDEX `partido_ibfk_2` (`equipo_visitante_id` ASC),
  CONSTRAINT `fk_estadio`
    FOREIGN KEY (`estadio_id`)
    REFERENCES `babyfutbol`.`estadios` (`id`),
  CONSTRAINT `fk_partido_arbitro1`
    FOREIGN KEY (`arbitro_id`)
    REFERENCES `babyfutbol`.`arbitros` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_torneo`
    FOREIGN KEY (`torneo_id`)
    REFERENCES `babyfutbol`.`torneos` (`id`),
  CONSTRAINT `partido_ibfk_1`
    FOREIGN KEY (`equipo_local_id`)
    REFERENCES `babyfutbol`.`equipos` (`id`),
  CONSTRAINT `partido_ibfk_2`
    FOREIGN KEY (`equipo_visitante_id`)
    REFERENCES `babyfutbol`.`equipos` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`goles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`goles` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`goles` (
  `idgoles` INT(11) NOT NULL,
  `gol` INT(11) NULL DEFAULT NULL,
  `partidos_id` INT(11) NOT NULL,
  `jugadores_id` INT(11) NOT NULL,
  `minuto` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`idgoles`),
  INDEX `fk_goles_partidos1` (`partidos_id` ASC),
  INDEX `fk_goles_jugadores1` (`jugadores_id` ASC),
  CONSTRAINT `fk_goles_jugadores1`
    FOREIGN KEY (`jugadores_id`)
    REFERENCES `babyfutbol`.`jugadores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_goles_partidos1`
    FOREIGN KEY (`partidos_id`)
    REFERENCES `babyfutbol`.`partidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`tarjetas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`tarjetas` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`tarjetas` (
  `idtarjetas` INT(11) NOT NULL,
  `color_tarjeta` VARCHAR(45) NULL DEFAULT NULL,
  `minuto` TIME NULL DEFAULT NULL,
  `partidos_id` INT(11) NOT NULL,
  `jugadores_id` INT(11) NOT NULL,
  PRIMARY KEY (`idtarjetas`),
  INDEX `fk_tarjetas_partidos1` (`partidos_id` ASC),
  INDEX `fk_tarjetas_jugadores1` (`jugadores_id` ASC),
  CONSTRAINT `fk_tarjetas_jugadores1`
    FOREIGN KEY (`jugadores_id`)
    REFERENCES `babyfutbol`.`jugadores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tarjetas_partidos1`
    FOREIGN KEY (`partidos_id`)
    REFERENCES `babyfutbol`.`partidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
