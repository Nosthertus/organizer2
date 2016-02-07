-- MySQL Script generated by MySQL Workbench
-- 02/06/16 01:41:53
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema organizer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema organizer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `organizer` DEFAULT CHARACTER SET utf8 ;
USE `organizer` ;

-- -----------------------------------------------------
-- Table `organizer`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organizer`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `createdAt` DATETIME NULL DEFAULT NOW(),
  `updatedAt` TIMESTAMP NULL DEFAULT NOW(),
  `accessToken` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `organizer`.`projecttype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organizer`.`projecttype` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `organizer`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organizer`.`project` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  `description` TEXT NULL,
  `status` TINYINT(1) NOT NULL,
  `createdAt` DATETIME NULL DEFAULT NOW(),
  `updatedAt` TIMESTAMP NULL DEFAULT NOW(),
  `projecttype_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_project_projecttype1_idx` (`projecttype_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  CONSTRAINT `fk_project_projecttype1`
    FOREIGN KEY (`projecttype_id`)
    REFERENCES `organizer`.`projecttype` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `organizer`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organizer`.`task` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  `description` TEXT NULL,
  `status` TINYINT(1) NOT NULL,
  `createdAt` DATETIME NULL DEFAULT NOW(),
  `updatedAt` TIMESTAMP NULL DEFAULT NOW(),
  `user_id` INT(11) NOT NULL,
  `project_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `project_id`),
  INDEX `fk_task_user1_idx` (`user_id` ASC),
  INDEX `fk_task_project1_idx` (`project_id` ASC),
  CONSTRAINT `fk_task_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `organizer`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `organizer`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 74
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `organizer`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organizer`.`comment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `createdAt` DATETIME NULL DEFAULT NOW(),
  `updatedAt` TIMESTAMP NULL DEFAULT NOW(),
  `user_id` INT(11) NOT NULL,
  `task_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `task_id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_comment_task1_idx` (`task_id` ASC),
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `organizer`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `organizer`.`task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `organizer`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organizer`.`tags` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(128) NOT NULL,
  `Frequency` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 107
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `organizer`.`project_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organizer`.`project_has_user` (
  `project_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`project_id`, `user_id`),
  INDEX `fk_project_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_project_has_user_project1_idx` (`project_id` ASC),
  CONSTRAINT `fk_project_has_user_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `organizer`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `organizer`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `organizer`.`task_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organizer`.`task_has_user` (
  `task_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`task_id`, `user_id`),
  INDEX `fk_task_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_task_has_user_task1_idx` (`task_id` ASC),
  CONSTRAINT `fk_task_has_user_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `organizer`.`task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `organizer`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
