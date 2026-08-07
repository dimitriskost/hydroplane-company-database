-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employees` (
  `ssn` INT NOT NULL,
  `full name` VARCHAR(45) NULL,
  `id badge` VARCHAR(45) NULL,
  `supervisor ssn` INT NOT NULL,
  PRIMARY KEY (`ssn`),
  INDEX `fk_Employees_Employees_idx` (`supervisor ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Employees_Employees`
    FOREIGN KEY (`supervisor ssn`)
    REFERENCES `mydb`.`Employees` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dependents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dependents` (
  `dname` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `Employees_ssn` INT NOT NULL,
  PRIMARY KEY (`dname`, `Employees_ssn`),
  INDEX `fk_Dependents_Employees1_idx` (`Employees_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Dependents_Employees1`
    FOREIGN KEY (`Employees_ssn`)
    REFERENCES `mydb`.`Employees` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Admins` (
  `Employees_ssn` INT NOT NULL,
  PRIMARY KEY (`Employees_ssn`),
  CONSTRAINT `fk_Admins_Employees1`
    FOREIGN KEY (`Employees_ssn`)
    REFERENCES `mydb`.`Employees` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pilots`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pilots` (
  `Employees_ssn` INT NOT NULL,
  PRIMARY KEY (`Employees_ssn`),
  CONSTRAINT `fk_Pilots_Employees1`
    FOREIGN KEY (`Employees_ssn`)
    REFERENCES `mydb`.`Employees` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Assistants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Assistants` (
  `Employees_ssn` INT NOT NULL,
  PRIMARY KEY (`Employees_ssn`),
  CONSTRAINT `fk_Assistants_Employees1`
    FOREIGN KEY (`Employees_ssn`)
    REFERENCES `mydb`.`Employees` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Technicians`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Technicians` (
  `Employees_ssn` INT NOT NULL,
  PRIMARY KEY (`Employees_ssn`),
  CONSTRAINT `fk_Technicians_Employees2`
    FOREIGN KEY (`Employees_ssn`)
    REFERENCES `mydb`.`Employees` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Technicians`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Technicians` (
  `Employees_ssn` INT NOT NULL,
  PRIMARY KEY (`Employees_ssn`),
  CONSTRAINT `fk_Technicians_Employees2`
    FOREIGN KEY (`Employees_ssn`)
    REFERENCES `mydb`.`Employees` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plane_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Plane_type` (
  `class` VARCHAR(45) NOT NULL,
  `capacity` INT NULL,
  `speed` INT NULL,
  PRIMARY KEY (`class`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Regions` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Waterports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Waterports` (
  `name` VARCHAR(45) NOT NULL,
  `Regions_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_Waterports_Regions1_idx` (`Regions_name` ASC) VISIBLE,
  CONSTRAINT `fk_Waterports_Regions1`
    FOREIGN KEY (`Regions_name`)
    REFERENCES `mydb`.`Regions` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`plane`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`plane` (
  `plane_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `km_count` INT NULL,
  `Plane_type_class` VARCHAR(45) NOT NULL,
  `Waterports_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`plane_id`),
  INDEX `fk_plane_Plane_type1_idx` (`Plane_type_class` ASC) VISIBLE,
  INDEX `fk_plane_Waterports1_idx` (`Waterports_name` ASC) VISIBLE,
  CONSTRAINT `fk_plane_Plane_type1`
    FOREIGN KEY (`Plane_type_class`)
    REFERENCES `mydb`.`Plane_type` (`class`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plane_Waterports1`
    FOREIGN KEY (`Waterports_name`)
    REFERENCES `mydb`.`Waterports` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`certified_for`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`certified_for` (
  `Pilots_Employees_ssn` INT NOT NULL,
  `Plane_type_class` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pilots_Employees_ssn`, `Plane_type_class`),
  INDEX `fk_Pilots_has_Plane_type_Plane_type1_idx` (`Plane_type_class` ASC) VISIBLE,
  INDEX `fk_Pilots_has_Plane_type_Pilots1_idx` (`Pilots_Employees_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Pilots_has_Plane_type_Pilots1`
    FOREIGN KEY (`Pilots_Employees_ssn`)
    REFERENCES `mydb`.`Pilots` (`Employees_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pilots_has_Plane_type_Plane_type1`
    FOREIGN KEY (`Plane_type_class`)
    REFERENCES `mydb`.`Plane_type` (`class`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Maintains`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Maintains` (
  `Technicians_Employees_ssn` INT NOT NULL,
  `Plane_type_class` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Technicians_Employees_ssn`, `Plane_type_class`),
  INDEX `fk_Technicians_has_Plane_type_Plane_type1_idx` (`Plane_type_class` ASC) VISIBLE,
  INDEX `fk_Technicians_has_Plane_type_Technicians1_idx` (`Technicians_Employees_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Technicians_has_Plane_type_Technicians1`
    FOREIGN KEY (`Technicians_Employees_ssn`)
    REFERENCES `mydb`.`Technicians` (`Employees_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Technicians_has_Plane_type_Plane_type1`
    FOREIGN KEY (`Plane_type_class`)
    REFERENCES `mydb`.`Plane_type` (`class`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Destinations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Destinations` (
  `name` VARCHAR(45) NOT NULL,
  `Regions_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_Destinations_Regions1_idx` (`Regions_name` ASC) VISIBLE,
  CONSTRAINT `fk_Destinations_Regions1`
    FOREIGN KEY (`Regions_name`)
    REFERENCES `mydb`.`Regions` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Club_tier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Club_tier` (
  `name` VARCHAR(30) NOT NULL,
  `discount_percentage` INT NULL,
  `required_kms` INT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `Full_name` VARCHAR(45) NULL,
  `date_of_birth` DATE NULL,
  `phone_number` INT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  `Club_tier_name` VARCHAR(30) NOT NULL,
  INDEX `fk_Customers_Club_tier1_idx` (`Club_tier_name` ASC) VISIBLE,
  PRIMARY KEY (`email`),
  CONSTRAINT `fk_Customers_Club_tier1`
    FOREIGN KEY (`Club_tier_name`)
    REFERENCES `mydb`.`Club_tier` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Flight` (
  `flight_id` VARCHAR(20) NOT NULL,
  `date` DATE NOT NULL,
  `from_waterport` VARCHAR(45) NOT NULL,
  `to_destination` VARCHAR(45) NOT NULL,
  `plane_plane_id` INT NOT NULL,
  PRIMARY KEY (`flight_id`, `date`),
  INDEX `fk_Flight_Waterports1_idx` (`from_waterport` ASC) VISIBLE,
  INDEX `fk_Flight_Destinations1_idx` (`to_destination` ASC) VISIBLE,
  INDEX `fk_Flight_plane1_idx` (`plane_plane_id` ASC) VISIBLE,
  CONSTRAINT `fk_Flight_Waterports1`
    FOREIGN KEY (`from_waterport`)
    REFERENCES `mydb`.`Waterports` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Destinations1`
    FOREIGN KEY (`to_destination`)
    REFERENCES `mydb`.`Destinations` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_plane1`
    FOREIGN KEY (`plane_plane_id`)
    REFERENCES `mydb`.`plane` (`plane_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reservation` (
  `code` VARCHAR(20) NOT NULL,
  `Customers_email` VARCHAR(45) NOT NULL,
  `Flight_flight_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`code`, `Flight_flight_id`),
  INDEX `fk_Reservation_Customers1_idx` (`Customers_email` ASC) VISIBLE,
  INDEX `fk_Reservation_Flight1_idx` (`Flight_flight_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reservation_Customers1`
    FOREIGN KEY (`Customers_email`)
    REFERENCES `mydb`.`Customers` (`Full_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_Flight1`
    FOREIGN KEY (`Flight_flight_id`)
    REFERENCES `mydb`.`Flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dependent_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dependent_customers` (
  `dname` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `Reservation_code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`dname`, `Reservation_code`),
  INDEX `fk_Dependent_customers_Reservation1_idx` (`Reservation_code` ASC) VISIBLE,
  CONSTRAINT `fk_Dependent_customers_Reservation1`
    FOREIGN KEY (`Reservation_code`)
    REFERENCES `mydb`.`Reservation` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transaction` (
  `id` VARCHAR(20) NOT NULL,
  `amount` FLOAT NULL,
  `date` DATE NULL,
  `Reservation_code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Transaction_Reservation1_idx` (`Reservation_code` ASC) VISIBLE,
  CONSTRAINT `fk_Transaction_Reservation1`
    FOREIGN KEY (`Reservation_code`)
    REFERENCES `mydb`.`Reservation` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reviews` (
  `review_id` VARCHAR(20) NOT NULL,
  `score` INT NULL,
  `comments` VARCHAR(300) NULL,
  `Customers_email` VARCHAR(45) NOT NULL,
  `Flight_flight_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_Reviews_Customers1_idx` (`Customers_email` ASC) VISIBLE,
  INDEX `fk_Reviews_Flight1_idx` (`Flight_flight_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reviews_Customers1`
    FOREIGN KEY (`Customers_email`)
    REFERENCES `mydb`.`Customers` (`Full_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reviews_Flight1`
    FOREIGN KEY (`Flight_flight_id`)
    REFERENCES `mydb`.`Flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Technicians_monitors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Technicians_monitors` (
  `Technicians_Employees_ssn` INT NOT NULL,
  `Flight_flight_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Technicians_Employees_ssn`, `Flight_flight_id`),
  INDEX `fk_Technicians_has_Flight_Flight1_idx` (`Flight_flight_id` ASC) VISIBLE,
  INDEX `fk_Technicians_has_Flight_Technicians1_idx` (`Technicians_Employees_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Technicians_has_Flight_Technicians1`
    FOREIGN KEY (`Technicians_Employees_ssn`)
    REFERENCES `mydb`.`Technicians` (`Employees_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Technicians_has_Flight_Flight1`
    FOREIGN KEY (`Flight_flight_id`)
    REFERENCES `mydb`.`Flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pilots_assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pilots_assignment` (
  `Pilots_Employees_ssn` INT NOT NULL,
  `Flight_flight_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Pilots_Employees_ssn`, `Flight_flight_id`),
  INDEX `fk_Pilots_has_Flight_Flight1_idx` (`Flight_flight_id` ASC) VISIBLE,
  INDEX `fk_Pilots_has_Flight_Pilots1_idx` (`Pilots_Employees_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Pilots_has_Flight_Pilots1`
    FOREIGN KEY (`Pilots_Employees_ssn`)
    REFERENCES `mydb`.`Pilots` (`Employees_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pilots_has_Flight_Flight1`
    FOREIGN KEY (`Flight_flight_id`)
    REFERENCES `mydb`.`Flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Assistants_assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Assistants_assignment` (
  `Assistants_Employees_ssn` INT NOT NULL,
  `Flight_flight_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Assistants_Employees_ssn`, `Flight_flight_id`),
  INDEX `fk_Assistants_has_Flight_Flight1_idx` (`Flight_flight_id` ASC) VISIBLE,
  INDEX `fk_Assistants_has_Flight_Assistants1_idx` (`Assistants_Employees_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Assistants_has_Flight_Assistants1`
    FOREIGN KEY (`Assistants_Employees_ssn`)
    REFERENCES `mydb`.`Assistants` (`Employees_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Assistants_has_Flight_Flight1`
    FOREIGN KEY (`Flight_flight_id`)
    REFERENCES `mydb`.`Flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
