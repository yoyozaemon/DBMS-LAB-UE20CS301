USE week4;
SET FOREIGN_KEY_CHECKS=0;

DELIMITER $$
CREATE TRIGGER compartment_check  
BEFORE INSERT 
ON compartment FOR EACH ROW  
BEGIN  
    DECLARE error_msg VARCHAR(255);  
    declare count int;
    SET error_msg = ('Cannot have more than four compartment');  
    IF (select count(*) from compartment where Train_No = new.Train_No) > 4 THEN  
    SIGNAL SQLSTATE '45000'   
    SET MESSAGE_TEXT = error_msg;  
    END IF;  
END $$   
DELIMITER ;

insert into compartment values ('F01','II Class',60,40,58451);
insert into compartment values ('S04','II Class',30,3,58450);


CREATE TABLE PAYMENT_BACK ( Transaction_ID varchar(30) PRIMARY KEY,
							Bank varchar(30),
                            Card_No varchar(16),
                            Price int,
                            PNR varchar(10) NOT NULL);
                            
DELIMITER $$

CREATE TRIGGER PAYMENT_BACKUP
BEFORE DELETE 
ON ticket FOR EACH ROW  
BEGIN 
	Insert into payment_back  select * from payment_info where PNR = old.PNR; 
	delete from payment_info where PNR = old.PNR;
    delete from ticket_passenger where PNR = old.PNR;
END $$   
DELIMITER ;

DELETE FROM ticket WHERE PNR = 'PNR004';

SELECT * FROM week4.payment_back;