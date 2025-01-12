SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `isucon` ;

CREATE SCHEMA IF NOT EXISTS `isucon` DEFAULT CHARACTER SET utf8 ;
USE `isucon` ;

CREATE TABLE IF NOT EXISTS `isucon`.`team` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `host` VARCHAR(255) NOT NULL,
  `best_score` INT(11) UNSIGNED ZEROFILL NOT NULL,
  `lang` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `isucon`.`queue` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `team_id` INT(11) UNSIGNED NOT NULL,
  `status` INT(10) UNSIGNED ZEROFILL NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `team_id_UNIQUE` (`team_id` ASC),
  CONSTRAINT `fk_queue_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `isucon`.`team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `isucon`.`score` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue_id` INT(11) UNSIGNED NOT NULL,
  `score` INT(11) UNSIGNED ZEROFILL NOT NULL,
  `message` LONGTEXT NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_score_queue`
    FOREIGN KEY (`queue_id`)
    REFERENCES `isucon`.`queue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `isucon`.`user` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `team_id` INT(11) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_user_team_idx` (`team_id` ASC),
  CONSTRAINT `fk_user_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `isucon`.`team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

USE `isucon` ;

CREATE TABLE IF NOT EXISTS `isucon`.`team_queue` (`team_id` INT, `queue_id` INT, `host` INT, `status` INT, `date` INT);

DROP TABLE IF EXISTS `isucon`.`team_queue`;
USE `isucon`;
CREATE VIEW `isucon`.`team_queue` AS select `t`.`id` AS `team_id`,`q`.`id` AS `queue_id`,`t`.`host` AS `host`,`q`.`status` AS `status`,`q`.`date` AS `date` from (`isucon`.`queue` `q` join `isucon`.`team` `t` on((`t`.`id` = `q`.`team_id`))) order by `q`.`date`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

grant all privileges on isucon.* to isucon@"10.0.50.%" identified by 'Passw0rd!' with grant option;
