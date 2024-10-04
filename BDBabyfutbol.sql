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

-- -----------------------------------------------------
-- Schema babyfutbol
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `babyfutbol` DEFAULT CHARACTER SET utf8mb4 ;
USE `babyfutbol` ;

-- -----------------------------------------------------
-- Table `babyfutbol`.`arbitros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`arbitros` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`arbitros` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `experiencia` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`entrenadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`entrenadores` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`entrenadores` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `experiencia` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
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
  CONSTRAINT `fk_equipos_entrenadores1`
    FOREIGN KEY (`entrenador_id`)
    REFERENCES `babyfutbol`.`entrenadores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
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
AUTO_INCREMENT = 13
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
AUTO_INCREMENT = 4
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
  PRIMARY KEY (`id`),
  CONSTRAINT `jugador_ibfk_1`
    FOREIGN KEY (`equipo_id`)
    REFERENCES `babyfutbol`.`equipos` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
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
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `babyfutbol`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `babyfutbol`.`roles` ;

CREATE TABLE IF NOT EXISTS `babyfutbol`.`roles` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
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
  `roles_id` INT(11) NULL DEFAULT NULL,
  `jugador_id` INT(11) NULL DEFAULT NULL,
  `entrenador_id` INT(11) NULL DEFAULT NULL,
  `arbitro_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_usuarios_arbitro1`
    FOREIGN KEY (`arbitro_id`)
    REFERENCES `babyfutbol`.`arbitros` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_entrenador1`
    FOREIGN KEY (`entrenador_id`)
    REFERENCES `babyfutbol`.`entrenadores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_jugador1`
    FOREIGN KEY (`jugador_id`)
    REFERENCES `babyfutbol`.`jugadores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `babyfutbol`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb4;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
