DELIMITER $$
CREATE procedure updat_age(IN U_ID varchar(30), IN DOB DATE)
BEGIN
DECLARE new_age int; 
SET new_age = FLOOR(DATEDIFF(CURRENT_DATE,DOB)/365);
UPDATE Users set Age = new_age where User_ID = U_ID;
END;$$
DELIMITER ;

SELECT * from USERS WHERE User_ID='ADM_001' ;
CALL updat_age('ADM_001','1989-04-14');
SELECT * from USERS WHERE User_ID='ADM_001' ;
DELIMITER $$
CREATE FUNCTION no_of_tkts(U_ID varchar(255))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(50);
    DECLARE ticket_count int;
    
    SELECT count(PNR) into ticket_count
	FROM Ticket
	WHERE User_ID = U_ID AND 
    MONTH(Travel_date) = MONTH(sysdate()) AND 
	YEAR(Travel_date) = YEAR(sysdate());
    
	IF ticket_count > 3 THEN
		SET result = 'cannot purchase tickets current limit is over”';
	ELSE
		SET result = 'can purchase tickets';
	END IF;
		RETURN result;
END; $$
DELIMITER ;
SELECT User_ID, no_of_tkts(User_ID) FROM Users;
