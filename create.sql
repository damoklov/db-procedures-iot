-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`student` ;

CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `rate` FLOAT NOT NULL,
  `birth_date` DATETIME NOT NULL,
  `enrollment_date` DATETIME NOT NULL,
  `student_card` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `city_id` INT NOT NULL,
  `school_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`region` ;

CREATE TABLE IF NOT EXISTS `mydb`.`region` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `enrollment_year` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`school` ;

CREATE TABLE IF NOT EXISTS `mydb`.`school` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `school_head` VARCHAR(45) NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`city` ;

CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `region_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student_debt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`student_debt` ;

CREATE TABLE IF NOT EXISTS `mydb`.`student_debt` (
  `student_id` INT NOT NULL,
  `debt_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`, `debt_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`debt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`debt` ;

CREATE TABLE IF NOT EXISTS `mydb`.`debt` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`student`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`student` (`id`, `first_name`, `middle_name`, `last_name`, `rate`, `birth_date`, `enrollment_date`, `student_card`, `email`, `city_id`, `school_id`, `group_id`) VALUES (1, 'John', 'David', 'Price', 10, '2001-02-02', '2016-09-10', 'A11111111', 'name1@test.ua', 1, 2, 3);
INSERT INTO `mydb`.`student` (`id`, `first_name`, `middle_name`, `last_name`, `rate`, `birth_date`, `enrollment_date`, `student_card`, `email`, `city_id`, `school_id`, `group_id`) VALUES (2, 'John', 'David', 'Soap', 5, '2001-03-11', '2016-09-10', 'A11111111', 'name2@test.ua', 2, 1, 3);
INSERT INTO `mydb`.`student` (`id`, `first_name`, `middle_name`, `last_name`, `rate`, `birth_date`, `enrollment_date`, `student_card`, `email`, `city_id`, `school_id`, `group_id`) VALUES (3, 'Mike', 'David', 'Jackson', 5, '2001-08-10', '2016-09-10', 'A11111111', 'name3@test.ua', 2, 2, 2);
INSERT INTO `mydb`.`student` (`id`, `first_name`, `middle_name`, `last_name`, `rate`, `birth_date`, `enrollment_date`, `student_card`, `email`, `city_id`, `school_id`, `group_id`) VALUES (4, 'Frank', 'David', 'Herbert', 4, '2001-05-10', '2016-09-10', 'A11111111', 'name4@test.ua', 3, 1, 2);
INSERT INTO `mydb`.`student` (`id`, `first_name`, `middle_name`, `last_name`, `rate`, `birth_date`, `enrollment_date`, `student_card`, `email`, `city_id`, `school_id`, `group_id`) VALUES (5, 'Bob', 'David', 'Deelan', 10, '2001-08-17', '2016-09-10', 'A11111111', 'name5@test.ua', 4, 3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`region`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`region` (`id`, `name`, `code`) VALUES (1, 'West', 123);
INSERT INTO `mydb`.`region` (`id`, `name`, `code`) VALUES (2, 'Center', 127);
INSERT INTO `mydb`.`region` (`id`, `name`, `code`) VALUES (3, 'South', 117);
INSERT INTO `mydb`.`region` (`id`, `name`, `code`) VALUES (4, 'South-West', 128);
INSERT INTO `mydb`.`region` (`id`, `name`, `code`) VALUES (5, 'East', 126);
INSERT INTO `mydb`.`region` (`id`, `name`, `code`) VALUES (6, 'North', 115);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`group`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`group` (`id`, `name`, `number`, `enrollment_year`) VALUES (1, 'IoT-13', 3, '2020');
INSERT INTO `mydb`.`group` (`id`, `name`, `number`, `enrollment_year`) VALUES (2, 'IoT-21', 1, '2019');
INSERT INTO `mydb`.`group` (`id`, `name`, `number`, `enrollment_year`) VALUES (3, 'IoT-22', 2, '2019');
INSERT INTO `mydb`.`group` (`id`, `name`, `number`, `enrollment_year`) VALUES (4, 'IoT-32', 2, '2018');
INSERT INTO `mydb`.`group` (`id`, `name`, `number`, `enrollment_year`) VALUES (5, 'IoT-31', 1, '2018');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`school`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`school` (`id`, `name`, `phone`, `school_head`, `city_id`) VALUES (1, 'School 2', '+38099001010', 'Mr. Patterson', 1);
INSERT INTO `mydb`.`school` (`id`, `name`, `phone`, `school_head`, `city_id`) VALUES (2, 'School 17', '+38099001010', 'Mrs. Johnson', 4);
INSERT INTO `mydb`.`school` (`id`, `name`, `phone`, `school_head`, `city_id`) VALUES (3, 'School 14', '+38099001010', 'Ms. Perry', 1);
INSERT INTO `mydb`.`school` (`id`, `name`, `phone`, `school_head`, `city_id`) VALUES (4, 'School 13', '+38099001010', 'Mr. Jackson', 3);
INSERT INTO `mydb`.`school` (`id`, `name`, `phone`, `school_head`, `city_id`) VALUES (5, 'School 4', '+38099001010', 'Mr. Diamond', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`city`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`city` (`id`, `name`, `region_id`) VALUES (1, 'Lviv', 1);
INSERT INTO `mydb`.`city` (`id`, `name`, `region_id`) VALUES (2, 'Ivano-Frankivsk', 1);
INSERT INTO `mydb`.`city` (`id`, `name`, `region_id`) VALUES (3, 'Kyiv', 2);
INSERT INTO `mydb`.`city` (`id`, `name`, `region_id`) VALUES (4, 'Odesa', 3);
INSERT INTO `mydb`.`city` (`id`, `name`, `region_id`) VALUES (5, 'Kherson', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`student_debt`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`student_debt` (`student_id`, `debt_id`) VALUES (1, '2');
INSERT INTO `mydb`.`student_debt` (`student_id`, `debt_id`) VALUES (1, '3');
INSERT INTO `mydb`.`student_debt` (`student_id`, `debt_id`) VALUES (2, '2');
INSERT INTO `mydb`.`student_debt` (`student_id`, `debt_id`) VALUES (3, '1');
INSERT INTO `mydb`.`student_debt` (`student_id`, `debt_id`) VALUES (3, '2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`debt`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`debt` (`id`, `name`) VALUES (1, 'Physics');
INSERT INTO `mydb`.`debt` (`id`, `name`) VALUES (2, 'Math');
INSERT INTO `mydb`.`debt` (`id`, `name`) VALUES (3, 'Literature');
INSERT INTO `mydb`.`debt` (`id`, `name`) VALUES (4, 'History');
INSERT INTO `mydb`.`debt` (`id`, `name`) VALUES (5, 'Economics');

COMMIT;

