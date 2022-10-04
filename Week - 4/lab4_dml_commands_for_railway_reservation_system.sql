--TASK-1

--1)Insert the above shown data into the respective tables using appropriate insert query.
show tables;

--2)Calculate and update age attribute in User Table.
UPDATE Train_user SET Age=Date_Format(From_Days(DATEDIFF(now(),DOB)),'%y')+0;

--3)Display all the route information whose distance fall in a range from 70 to 150 km.
SELECT * from route_info WHERE Distance BETWEEN 70 AND 150;

--4)Display the train route information which are going from Chennai and Sholingur
SELECT * from route_info WHERE from_station_name='chennai' AND to_station_name='sholingur';

--5)Display the train details whose type is not mail.
SELECT * from train WHERE train_type!='mail';

--6)Display the train name which goes to Chennai from Bangalore.
SELECT train_name from train WHERE source ='Bengaluru' AND Destination='Chennai';

--7)Display the list of trains starting from Chennai after 8:00.
SELECT train_no,departure_time from ticket WHERE departure_time > '08:00:00';

--8)Display the list of users who have born between 1980 to 1990.
SELECT * from train_user WHERE dob BETWEEN '1980-01-01' AND '1990-12-31';

--9)Display the train users whose name starts with the letter ‘S’
SELECT * from train_user  WHERE firstname like 'S%';

--10)Find the availability of I Class compartment of the train number 62621
SELECT compartment_no,availability from compartment WHERE train_number=62621 AND compartment_type='I Class';

--11)Find the PNR and Transaction ID of the users who made payment via Union Bank.
SELECT pnr,transaction_no from payment_info WHERE bank='UNION BANK'; 

--TASK-2

--1)Grant privileges on different tables to users and observe the effect.
create user 'user4'@'localhost' identified by 'password1'; 
create user 'user5'@'localhost' identified by 'password1';
create user 'user6'@'localhost' identified by 'password1';
GRANT select,insert,update on ticket to 'user4'@'localhost';
GRANT select on ticket to 'user5'@'localhost';
GRANT update on ticket to 'user6'@'localhost';
show grants for 'user4'@'localhost';
show grants for 'user5'@'localhost';
show grants for 'user6'@'localhost';

--2)Revoke UPDATE & DELETE privileges on any tables and observe the effect if any deletion/updation is performed.
create user 'user7'@'localhost' identified by 'password1';
GRANT select,delete,update on ticket to 'user7'@'localhost';
show grants for 'user7'@'localhost'; 

--3)Create different save points and perform some insert/update/delete operations. Observe the effect of commit & rollback operations.
savepoint sp1;
delete from payment_info where Bank='Union Bank';
savepoint sp2;
delete from user where FName='Virat';
commit;
select *from user;

