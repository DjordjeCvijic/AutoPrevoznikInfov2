-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema autoprevoznikinfodbv2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema autoprevoznikinfodbv2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `autoprevoznikinfodbv2` DEFAULT CHARACTER SET utf8 ;
USE `autoprevoznikinfodbv2` ;

-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`worker` (
  `workerID` INT NOT NULL AUTO_INCREMENT,
  `worker_code` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `username` VARCHAR(10) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(13) NULL DEFAULT NULL,
  `theme` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`workerID`),
  UNIQUE INDEX `workerID_UNIQUE` (`workerID` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`driver` (
  `driverID` INT NOT NULL,
  INDEX `fk_driver_worker_idx` (`driverID` ASC) VISIBLE,
  PRIMARY KEY (`driverID`),
  UNIQUE INDEX `driverID_UNIQUE` (`driverID` ASC) VISIBLE,
  CONSTRAINT `fk_driver_worker`
    FOREIGN KEY (`driverID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`doorkeeper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`doorkeeper` (
  `doorkeeperID` INT NOT NULL,
  INDEX `fk_doorkeeperID_worker1_idx` (`doorkeeperID` ASC) VISIBLE,
  PRIMARY KEY (`doorkeeperID`),
  UNIQUE INDEX `doorkeeperID_UNIQUE` (`doorkeeperID` ASC) VISIBLE,
  CONSTRAINT `fk_doorkeeperID_worker1`
    FOREIGN KEY (`doorkeeperID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`bus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`bus` (
  `busID` INT NOT NULL AUTO_INCREMENT,
  `garage_number` VARCHAR(10) NOT NULL,
  `bus_type` VARCHAR(1) NOT NULL,
  `number_of_seats` INT NULL DEFAULT NULL,
  `number_of_doors` INT NULL DEFAULT NULL,
  `capacity` INT NULL DEFAULT NULL,
  UNIQUE INDEX `garage_number_UNIQUE` (`garage_number` ASC) VISIBLE,
  PRIMARY KEY (`busID`),
  UNIQUE INDEX `busID_UNIQUE` (`busID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`bus_has_driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`bus_has_driver` (
  `busID` INT NOT NULL,
  `driverID` INT NOT NULL,
  PRIMARY KEY (`busID`, `driverID`),
  INDEX `fk_bus_has_driver_driver1_idx` (`driverID` ASC) VISIBLE,
  INDEX `fk_bus_has_driver_bus1_idx` (`busID` ASC) VISIBLE,
  CONSTRAINT `fk_bus_has_driver_driver1`
    FOREIGN KEY (`driverID`)
    REFERENCES `autoprevoznikinfodbv2`.`driver` (`driverID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_has_driver_bus1`
    FOREIGN KEY (`busID`)
    REFERENCES `autoprevoznikinfodbv2`.`bus` (`busID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`bus_station`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`bus_station` (
  `bus_stationID` INT NOT NULL AUTO_INCREMENT,
  `bus_station_code` VARCHAR(20) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`bus_stationID`),
  UNIQUE INDEX `bus_station_code_UNIQUE` (`bus_station_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`bus_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`bus_line` (
  `bus_lineID` INT NOT NULL AUTO_INCREMENT,
  `start_bus_stationID` INT NOT NULL,
  `end_bus_stationID` INT NOT NULL,
  `bus_line_code` VARCHAR(20) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`bus_lineID`),
  INDEX `fk_bus_line_bus_station1_idx` (`start_bus_stationID` ASC) VISIBLE,
  INDEX `fk_bus_line_bus_station2_idx` (`end_bus_stationID` ASC) VISIBLE,
  UNIQUE INDEX `bus_station_code_UNIQUE` (`bus_line_code` ASC) VISIBLE,
  CONSTRAINT `fk_bus_line_bus_station1`
    FOREIGN KEY (`start_bus_stationID`)
    REFERENCES `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_line_bus_station2`
    FOREIGN KEY (`end_bus_stationID`)
    REFERENCES `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`bus_line_has_bus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`bus_line_has_bus` (
  `bus_lineID` INT NOT NULL,
  `busID` INT NOT NULL,
  `driverID` INT NOT NULL,
  `date` DATE NOT NULL,
  `start_time` TIME NULL DEFAULT NULL,
  `end_time` TIME NULL DEFAULT NULL,
  INDEX `fk_bus_line_has_bus_bus_line1_idx` (`bus_lineID` ASC) VISIBLE,
  PRIMARY KEY (`bus_lineID`, `busID`, `driverID`, `date`),
  INDEX `fk_bus_line_has_bus_bus_has_driver1_idx` (`driverID` ASC, `busID` ASC) VISIBLE,
  CONSTRAINT `fk_bus_line_has_bus_bus_line1`
    FOREIGN KEY (`bus_lineID`)
    REFERENCES `autoprevoznikinfodbv2`.`bus_line` (`bus_lineID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_line_has_bus_bus_has_driver11`
    FOREIGN KEY (`driverID` , `busID`)
    REFERENCES `autoprevoznikinfodbv2`.`bus_has_driver` (`driverID` , `busID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`message` (
  `messageID` INT NOT NULL AUTO_INCREMENT,
  `from_workerID` INT NOT NULL,
  `to_workerID` INT NOT NULL,
  `date` DATETIME NULL DEFAULT NULL,
  `message_content` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`messageID`),
  INDEX `fk_message_worker1_idx` (`from_workerID` ASC) VISIBLE,
  INDEX `fk_message_worker2_idx` (`to_workerID` ASC) VISIBLE,
  UNIQUE INDEX `messageID_UNIQUE` (`messageID` ASC) VISIBLE,
  CONSTRAINT `fk_message_worker1`
    FOREIGN KEY (`from_workerID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_worker2`
    FOREIGN KEY (`to_workerID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`worker_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`worker_record` (
  `worker_recordID` INT NOT NULL AUTO_INCREMENT,
  `workerID` INT NOT NULL,
  `date` DATE NULL DEFAULT NULL,
  `enter_time` TIME NULL DEFAULT NULL,
  `exit_time` TIME NULL DEFAULT NULL,
  `note` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`worker_recordID`),
  INDEX `fk_worker_record_worker1_idx` (`workerID` ASC) VISIBLE,
  UNIQUE INDEX `worker_recordID_UNIQUE` (`worker_recordID` ASC) VISIBLE,
  CONSTRAINT `fk_worker_record_worker1`
    FOREIGN KEY (`workerID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`shift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`shift` (
  `shiftID` INT NOT NULL AUTO_INCREMENT,
  `workerID` INT NOT NULL,
  `date` DATE NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  PRIMARY KEY (`shiftID`),
  INDEX `fk_shift_schedule_worker1_idx` (`workerID` ASC) VISIBLE,
  CONSTRAINT `fk_shift_worker1`
    FOREIGN KEY (`workerID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`traffic_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`traffic_manager` (
  `traffic_managerID` INT NOT NULL,
  PRIMARY KEY (`traffic_managerID`),
  CONSTRAINT `fk_treffic_manager_worker1`
    FOREIGN KEY (`traffic_managerID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`doorkeeper_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`doorkeeper_manager` (
  `doorkeeper_managerID` INT NOT NULL,
  PRIMARY KEY (`doorkeeper_managerID`),
  CONSTRAINT `fk_doorkeeper_manager_worker1`
    FOREIGN KEY (`doorkeeper_managerID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`payment` (
  `workerID` INT NOT NULL,
  `for_month` DATE NOT NULL,
  `amount` DECIMAL(6,2) NOT NULL,
  `reduction` DECIMAL(6,2) NULL,
  `note_for_reduction` VARCHAR(1000) NULL,
  PRIMARY KEY (`workerID`, `for_month`),
  CONSTRAINT `fk_payment_worker1`
    FOREIGN KEY (`workerID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`damage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`damage` (
  `busID` INT NOT NULL,
  `driverID` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `note` VARCHAR(1000) NULL,
  PRIMARY KEY (`busID`, `driverID`, `date`),
  INDEX `fk_damage_driver1_idx` (`driverID` ASC) VISIBLE,
  CONSTRAINT `fk_damage_bus1`
    FOREIGN KEY (`busID`)
    REFERENCES `autoprevoznikinfodbv2`.`bus` (`busID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_damage_driver1`
    FOREIGN KEY (`driverID`)
    REFERENCES `autoprevoznikinfodbv2`.`driver` (`driverID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`trip_organizer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`trip_organizer` (
  `trip_organizerID` INT NOT NULL,
  PRIMARY KEY (`trip_organizerID`),
  CONSTRAINT `fk_trip_organizer_worker1`
    FOREIGN KEY (`trip_organizerID`)
    REFERENCES `autoprevoznikinfodbv2`.`worker` (`workerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`trip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`trip` (
  `tripID` INT NOT NULL AUTO_INCREMENT,
  `trip_organizerID` INT NOT NULL,
  `driverID` INT NOT NULL,
  `busID` INT NOT NULL,
  `trip_start` DATETIME NULL,
  `trip_end` DATETIME NULL,
  `cost` DECIMAL(6,2) NOT NULL,
  `max_number_of_passenger` INT NULL,
  `number_of_passenger` INT NULL,
  PRIMARY KEY (`tripID`),
  INDEX `fk_trip_trip_organizer1_idx` (`trip_organizerID` ASC) VISIBLE,
  INDEX `fk_trip_bus_has_driver1_idx` (`driverID` ASC, `busID` ASC) VISIBLE,
  CONSTRAINT `fk_trip_trip_organizer1`
    FOREIGN KEY (`trip_organizerID`)
    REFERENCES `autoprevoznikinfodbv2`.`trip_organizer` (`trip_organizerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_bus_has_driver1`
    FOREIGN KEY (`driverID` , `busID`)
    REFERENCES `autoprevoznikinfodbv2`.`bus_has_driver` (`driverID` , `busID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `autoprevoznikinfodbv2`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`location` (
  `tripID` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  PRIMARY KEY (`tripID`, `name`),
  INDEX `fk_location_trip1_idx` (`tripID` ASC) VISIBLE,
  CONSTRAINT `fk_location_trip1`
    FOREIGN KEY (`tripID`)
    REFERENCES `autoprevoznikinfodbv2`.`trip` (`tripID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `autoprevoznikinfodbv2` ;

-- -----------------------------------------------------
-- Placeholder table for view `autoprevoznikinfodbv2`.`doorkeeper_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`doorkeeper_info` (`doorkeeperID` INT, `workerID` INT, `worker_code` INT, `first_name` INT, `last_name` INT, `username` INT, `password` INT, `phone_number` INT, `theme` INT);

-- -----------------------------------------------------
-- Placeholder table for view `autoprevoznikinfodbv2`.`driver_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`driver_info` (`workerID` INT, `worker_code` INT, `first_name` INT, `last_name` INT, `username` INT, `password` INT, `phone_number` INT, `theme` INT, `driverID` INT);

-- -----------------------------------------------------
-- Placeholder table for view `autoprevoznikinfodbv2`.`driver_bus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autoprevoznikinfodbv2`.`driver_bus` (`busID` INT, `garage_number` INT, `bus_type` INT, `number_of_seats` INT, `number_of_doors` INT, `capacity` INT, `driverID` INT);

-- -----------------------------------------------------
-- View `autoprevoznikinfodbv2`.`doorkeeper_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoprevoznikinfodbv2`.`doorkeeper_info`;
USE `autoprevoznikinfodbv2`;
CREATE  OR REPLACE VIEW `doorkeeper_info` AS SELECT * FROM doorkeeper d Inner join worker w on d.doorkeeperID=w.workerID;

-- -----------------------------------------------------
-- View `autoprevoznikinfodbv2`.`driver_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoprevoznikinfodbv2`.`driver_info`;
USE `autoprevoznikinfodbv2`;
CREATE  OR REPLACE VIEW `driver_info` AS SELECT * from worker w INNER JOIN driver d ON  w.workerID=d.driverID;

-- -----------------------------------------------------
-- View `autoprevoznikinfodbv2`.`driver_bus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autoprevoznikinfodbv2`.`driver_bus`;
USE `autoprevoznikinfodbv2`;
CREATE  OR REPLACE VIEW `driver_bus` AS SELECT * from driver NATURAL JOIN bus_has_driver NATURAL JOIN bus;
USE `autoprevoznikinfodbv2`;

DELIMITER $$
USE `autoprevoznikinfodbv2`$$
CREATE DEFINER = CURRENT_USER TRIGGER `add_shift_trigger` AFTER INSERT ON `bus_line_has_bus` FOR EACH ROW
BEGIN
insert into `shift`(`shiftID`,`workerID`,`date`,`start_time`,`end_time`)
		values (0,new.driverID,new.date,new.start_time,new.end_time);
END$$

USE `autoprevoznikinfodbv2`$$
CREATE DEFINER = CURRENT_USER TRIGGER `delete_shift_trigger` AFTER DELETE ON `bus_line_has_bus` FOR EACH ROW
BEGIN
	DELETE FROM shift  WHERE workerID=old.driverID and `date`=old.date;
END$$


DELIMITER ;

delimiter $$
CREATE PROCEDURE is_username_unigue(in username char(20))
BEGIN
  SELECT COUNT(username) FROM  worker w WHERE  w.username=username   ;
END$$

CREATE PROCEDURE get_workers_number()
BEGIN
  SELECT COUNT(*) FROM  worker  ;
END$$

CREATE PROCEDURE get_payment_sum(in id int)
BEGIN
  SELECT sum(amount) FROM  payment  WHERE workerID=id;
END$$

CREATE PROCEDURE doorkeepersIDs()
BEGIN
  SELECT * FROM  doorkeeper;
END$$
delimiter ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
