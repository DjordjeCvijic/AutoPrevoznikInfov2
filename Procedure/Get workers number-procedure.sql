delimiter $$
CREATE PROCEDURE get_workers_number()
BEGIN
  SELECT COUNT(*) FROM  worker  ;
END$$
delimiter ;


