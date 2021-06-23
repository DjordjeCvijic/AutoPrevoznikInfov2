delimiter $$
CREATE PROCEDURE is_username_unigue(in username char(20))
BEGIN
  SELECT COUNT(username) FROM  worker w WHERE  w.username=username   ;
END$$
delimiter ;

