delimiter $$
CREATE PROCEDURE get_payment_sum(in id int)
BEGIN
  SELECT sum(amount) FROM  payment  WHERE workerID=id;
END$$
delimiter ;
