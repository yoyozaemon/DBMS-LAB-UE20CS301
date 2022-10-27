--insert
INSERT INTO ticket (PNR, Train_Number, Travel_Date, USER_ID, Arrival_Time, Departure_Time, Train_type, Compartment_Type, Cmpt_No, Arrival, Departure)
VALUES ('PNR021', 62621, '2021-10-22', 'USR_008', '20:30:00', '16:00:00', 'Superfast', 'I Class', 'F01', 'Chennai', 'Bengaluru' ); 

--update
update train set SRC = trim(SRC), Destination = trim(Destination);

--1.Find the list of passengers (user_id, user_type First name and last name) who have traveled from Bengaluru to Chennai during the month of Oct 2021 and Aug 2022 
select users.User_ID,users.User_Type,users.FName,users.LName from users join ticket on users.User_ID=ticket.USER_ID where Travel_Date > '2021-10-1' and Travel_Date<'2021-10-30' and Departure='bengaluru' and Arrival='chennai'
union
select users.User_ID,users.User_Type,users.FName,users.LName from users join ticket on users.User_ID=ticket.USER_ID where Travel_Date > '2022-8-1' and Travel_Date<'2022-8-30' and Departure='bengaluru' and Arrival='chennai';

--2.Find the list of passengers (user_id, user_type First name and last name) who have traveled from Bengaluru to Chennai during the month of Oct 2021 and also during Aug 2022
select u1.User_ID,u1.User_Type,u1.FName,u1.LName from users u1 join ticket on u1.User_ID=ticket.USER_ID where Travel_Date > '2021-10-1' and Travel_Date<'2021-10-30' and Departure='bengaluru' and Arrival='chennai'
and exists(
select u2.User_ID,u2.User_Type,u2.FName,u2.LName from users u2 join ticket on u2.User_ID=ticket.USER_ID where Travel_Date > '2022-8-1' and Travel_Date<'2022-8-30' and Departure='bengaluru' and Arrival='chennai' and u1.User_ID=u2.User_ID);

--3.Find the list of passengers (user_id, user_type First name and last name) who have traveled from Bengaluru to Chennai during the month of Aug 2022 and not in Oct 2021
select u2.User_ID,u2.User_Type,u2.FName,u2.LName from users u2 join ticket on u2.User_ID=ticket.USER_ID where Travel_Date > '2022-8-1' and Travel_Date<'2022-8-30' and Departure='bengaluru' and Arrival='chennai'
and not exists(
select u1.User_ID,u1.User_Type,u1.FName,u1.LName from users u1 join ticket on u1.User_ID=ticket.USER_ID where Travel_Date > '2021-10-1' and Travel_Date<'2021-10-30' and Departure='bengaluru' and Arrival='chennai' and u1.User_ID=u2.User_ID );

--4.Find the list of passengers (user_id, user_type, First name and last name) who have traveled from Bengaluru to Chennai and returned to Bengaluru within a week.
select u1.User_ID,u1.User_Type,u1.FName,u1.LName from users u1 join ticket t1 on u1.User_ID=t1.USER_ID where Departure='bengaluru' and Arrival='chennai'
and exists(
select u2.User_ID,u2.User_Type,u2.FName,u2.LName from users u2 join ticket t2 on u2.User_ID=t2.USER_ID where Departure='chennai' and Arrival='bengaluru'
and DATEDIFF(t2.travel_date,t1.travel_date)<= 7 and u2.User_ID=u1.User_ID);

--5.Find the list of passengers (user_id, user_type, First name and last name) who have traveled from Bengaluru to Chennai and did not return to Bengaluru (in other words, only one way travel from Bengaluru to Chennai) 
select u1.User_ID,u1.User_Type,u1.FName,u1.LName from users u1 join ticket t1 on u1.User_ID=t1.USER_ID where Departure='bengaluru' and Arrival='chennai'
and not exists(
select u2.User_ID,u2.User_Type,u2.FName,u2.LName from users u2 join ticket t2 on u2.User_ID=t2.USER_ID where Departure='chennai' and Arrival='bengaluru'
and u2.User_ID=u1.User_ID)
