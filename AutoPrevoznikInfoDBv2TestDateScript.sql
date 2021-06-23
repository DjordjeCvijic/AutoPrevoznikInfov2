INSERT INTO `autoprevoznikinfodbv2`.`bus` (`busID`, `garage_number`, `bus_type`, `number_of_seats`, `number_of_doors`, `capacity`) VALUES ('1', 'G1', 'G', '20', '3', '50');
INSERT INTO `autoprevoznikinfodbv2`.`bus` (`busID`, `garage_number`, `bus_type`, `number_of_seats`, `number_of_doors`, `capacity`) VALUES ('2', 'G2', 'G', '25', '3', '60');
INSERT INTO `autoprevoznikinfodbv2`.`bus` (`busID`, `garage_number`, `bus_type`, `number_of_seats`, `number_of_doors`, `capacity`) VALUES ('3', 'G3', 'P', '30', '2', '40');
INSERT INTO `autoprevoznikinfodbv2`.`bus` (`busID`, `garage_number`, `bus_type`, `number_of_seats`, `number_of_doors`, `capacity`) VALUES ('4', 'G4', 'P', '10', '10', '10');
INSERT INTO `autoprevoznikinfodbv2`.`bus` (`busID`, `garage_number`, `bus_type`, `number_of_seats`, `number_of_doors`, `capacity`) VALUES ('5', 'G5', 'G', '30', '30', '30');

INSERT INTO `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`, `bus_station_code`, `name`) VALUES ('1', 'S1', 'Stanica 1');
INSERT INTO `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`, `bus_station_code`, `name`) VALUES ('2', 'S2', 'Stanica 2');
INSERT INTO `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`, `bus_station_code`, `name`) VALUES ('3', 'S3', 'Stanica 3');
INSERT INTO `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`, `bus_station_code`, `name`) VALUES ('4', 'S4', 'Stanica 4');
INSERT INTO `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`, `bus_station_code`, `name`) VALUES ('5', 'S5', 'Stanica 5');
INSERT INTO `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`, `bus_station_code`, `name`) VALUES ('6', 'S6', 'Stanica 6');
INSERT INTO `autoprevoznikinfodbv2`.`bus_station` (`bus_stationID`, `bus_station_code`, `name`) VALUES ('7', 'S7', 'Stanica 7');

INSERT INTO `autoprevoznikinfodbv2`.`bus_line` (`bus_lineID`, `start_bus_stationID`, `end_bus_stationID`, `bus_line_code`, `name`) VALUES ('1', '1', '2', 'L1', 'Linija 1');
INSERT INTO `autoprevoznikinfodbv2`.`bus_line` (`bus_lineID`, `start_bus_stationID`, `end_bus_stationID`, `bus_line_code`, `name`) VALUES ('2', '3', '4', 'L2', 'Linija 2');
INSERT INTO `autoprevoznikinfodbv2`.`bus_line` (`bus_lineID`, `start_bus_stationID`, `end_bus_stationID`, `bus_line_code`, `name`) VALUES ('3', '3', '7', 'L3', 'Linija 3');
INSERT INTO `autoprevoznikinfodbv2`.`bus_line` (`bus_lineID`, `start_bus_stationID`, `end_bus_stationID`, `bus_line_code`, `name`) VALUES ('4', '2', '6', 'L4', 'Linija 4');

INSERT INTO `autoprevoznikinfodbv2`.`worker` (`workerID`, `worker_code`, `first_name`, `last_name`, `username`, `password`, `phone_number`, `theme`) VALUES ('1', 'W1', 'Marko', 'Marković', 'marko', 'Kkxh7/nOmSHlxvva5/N8EULKjbx0GCC/GiDrCeiyaEdnRowu', '06506065', 'D');
INSERT INTO `autoprevoznikinfodbv2`.`worker` (`workerID`, `worker_code`, `first_name`, `last_name`, `username`, `password`, `phone_number`, `theme`) VALUES ('2', 'W2', 'Jovan', 'Jovanić', 'jovan', '4FvCx7uEHM/iVjUTz7cKRxzymNYWYBFwDWJ+I5jizR7pi7TB', '065123452', 'W');
INSERT INTO `autoprevoznikinfodbv2`.`worker` (`workerID`, `worker_code`, `first_name`, `last_name`, `username`, `password`, `phone_number`, `theme`) VALUES ('3', 'W3', 'Petar', 'Petrović', 'petar', 'mIp5Nney4LOB35DU46HDHsSiTtlXifEjh+IpZcmmJqCB2PZH', '065234556', 'D');
INSERT INTO `autoprevoznikinfodbv2`.`worker` (`workerID`, `worker_code`, `first_name`, `last_name`, `username`, `password`, `phone_number`, `theme`) VALUES ('4', 'W4', 'Radoja', 'Cvijić', 'radoja', 'Qgdar+Oh9zuYnPOW+t2rkACFPZv4ikbozjXFk0GOv1PcN60L', '065802044', 'W');
INSERT INTO `autoprevoznikinfodbv2`.`worker` (`workerID`, `worker_code`, `first_name`, `last_name`, `username`, `password`, `phone_number`, `theme`) VALUES ('5', 'W5', 'Suzana', 'Blagojevic', 'suzana', 'Qgdar+Oh9zuYnPOW+t2rkACFPZv4ikbozjXFk0GOv1PcN60L', '065033512', 'W');

INSERT INTO `autoprevoznikinfodbv2`.`traffic_manager` (`traffic_managerID`) VALUES ('1');

INSERT INTO `autoprevoznikinfodbv2`.`doorkeeper_manager` (`doorkeeper_managerID`) VALUES ('2');

INSERT INTO `autoprevoznikinfodbv2`.`doorkeeper` (`doorkeeperID`) VALUES ('4');

INSERT INTO `autoprevoznikinfodbv2`.`driver` (`driverID`) VALUES ('3');

INSERT INTO `autoprevoznikinfodbv2`.`trip_organizer` (`trip_organizerID`) VALUES ('5');

INSERT INTO `autoprevoznikinfodbv2`.`bus_has_driver` (`busID`, `driverID`) VALUES ('1', '3');

INSERT INTO `autoprevoznikinfodbv2`.`bus_line_has_bus` ( `bus_lineID`, `busID`, `driverID`, `date`, `start_time`, `end_time`) VALUES ( '1', '1', '3', '2021-04-22', '07:00:00', '18:00:00');

INSERT INTO `autoprevoznikinfodbv2`.`shift` (`shiftID`, `workerID`, `date`, `start_time`, `end_time`) VALUES ('2', '4', '2021-04-22', '06:00:00', '18:00:00');



INSERT INTO `autoprevoznikinfodbv2`.`message` (`messageID`, `from_workerID`, `to_workerID`, `date`, `message_content`) VALUES ('1', '1', '3', '2021-04-06 01:15:00', 'tekst poruke1');
INSERT INTO `autoprevoznikinfodbv2`.`message` (`messageID`, `from_workerID`, `to_workerID`, `date`, `message_content`) VALUES ('2', '2', '4', '2021-04-06 02:03:00', 'tekst poruke2');

INSERT INTO `autoprevoznikinfodbv2`.`damage` (`busID`, `driverID`, `date`, `note`) VALUES ('1', '3', '2021-04-22', 'Ostecen desni zmigavac');

INSERT INTO `autoprevoznikinfodbv2`.`trip` (`tripID`, `trip_organizerID`, `driverID`, `busID`, `trip_start`, `trip_end`, `cost`, `max_number_of_passenger`, `number_of_passenger`) VALUES ('1', '5', '3', '1', '2021-04-20', '2021-04-25', '600', '45', '0');

INSERT INTO `autoprevoznikinfodbv2`.`location` (`tripID`, `name`, `city`, `state`) VALUES ('1', 'Hram Svetog Save', 'Beograd', 'Srbija');

INSERT INTO `autoprevoznikinfodbv2`.`payment` (`workerID`, `for_month`, `amount`) VALUES ('3', '2021-04-01', '1200');
INSERT INTO `autoprevoznikinfodbv2`.`payment` (`workerID`, `for_month`, `amount`, `reduction`, `note_for_reduction`) VALUES ('4', '2021-04-01', '800', '100', 'Kasnio na posao');
