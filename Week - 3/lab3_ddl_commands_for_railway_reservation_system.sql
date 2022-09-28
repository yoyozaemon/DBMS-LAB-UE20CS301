/*Create tables for the Above-mentioned Relational design and add check, default, not
null and unique constraints.*/

--1)PK and FK constraints for all applicable Relations

--i) CREATE TABLE FOR TRAIN
Create table Train (
Train_no int NOT NULL,
Train_name varchar(20),
Train_Type varchar(10),source varchar(20),
destination varchar(30), availability varchar(10),
PRIMARY KEY (Train_no)
);

--ii) CREATE TABLE FOR USER
Create table user (
User_ID varchar(20) NOT NULL,
Firstname Varchar(50),
Lastname Varchar(50),
age int,
DOB Date, phone varchar(20)
pincode varchar(20),
user_type varchar(10),
street_number varchar(30),
PRIMARY KEY(User_ID)
);

--iii) CREATE TABLE FOR TICKET
Create table Ticket(PNR varchar(10),Train_No int, Travel_date DATE, Passenger_
id varchar(20), arrival TIME, departure TIME,Train_Type varchar(20),compartment_type
varchar(10),compartment_No varchar(10), PRIMARY KEY(PNR), FOREIGN KEY (Train_No)
references train(Train_No),Foreign key Passenger_id references user(User_ID), FOREIGN KEY
(compartment_No) references compartment (compartment_no));

--iv) CREATE TABLE FOR COMPARTMENT 
Create table compartment(compartment_no varchar(10), type varchar(10), capacity int,
availability int, train_number int,PRIMARY KEY(compartment_no,train_number), FOREIGN
KEY (train_number) references train(Train_No));

--v) CREATE TABLE FOR ROUTE INFO 
Create table Route_info(from_station_no int, to_station_no int,from_station_name varchar(20),
to_station_name varchar(20), distance int, Train_No int,PRIMARY KEY(from_station_no ,
to_station_no), FOREIGN KEY (Train_No) references train(Train_No));

--vi) CREATE TABLE FOR PAYMENT INFO
Create table Payment_info(Transaction_no int,price DECIMAL(10,2),card_no
varchar(20),bank varchar(20), PNR varchar(10),PRIMARY KEY (Transaction_no), FOREIGN
KEY (PNR) references Ticket(PNR));

--vii) CREATE TABLE FOR FARE 
Create table Fare(compartment_type varchar(10), train_type varchar(20), fare_per_km
int,PRIMARY KEY(compartment_type, train_type));

--viii) CREATE TABLE FOR TICKET PASSENGER
create table Ticket_passenger(seat_No varchar(10), Name varchar(30), age int, PNR
varchar(10), PRIMARY KEY (PNR,seat_no,), FOREIGN KEY (PNR) references Ticket(PNR));

--ix) CREATE TABLE FOR USER TRAIN
create table user_train(user_id varchar(10), Train_id int, date_time_stamp DATETIME,
PRIMARY KEY(user_id,Train_id, date_time_stamp), FOREIGN KEY (user_id) references
user(User_ID), FOREIGN KEY (Train_id) references Train(Train_No));


--2)For Train_name, Train_Type in Train table add not null constraints value
ALTER table user modify column age int NULL;


--3) Add default constraint for compartment table setting Availability attribute to Yes


--4) VIN should be unique
ALTER table Train add UNIQUE(Train_name);


--5)Add check constraints to Age in the invoice (Age to be >5)
ALTER table ticket ADD CHECK (age>=5); //(if column does not exist add column)


--6)Rename the table
RENAME table user TO passenger;


--7)Create a view using create view command


--8) use Truncate and drop commands
Truncate [any table_name];
Drop view passenger_details;
