--1.Find the average distance between subsequent stations for every train
select route_info.train_no,train_name,avg(distance) from
route_info join train on route_info.train_no=train.train_no
where to_station_no - from_station_no=1 group by
route_info.train_no;

--2.Find the average distance between subsequent stations for every train and display them in descending order of distance
select route_info.train_no,train_name,avg(distance) from
route_info join train on route_info.train_no=train.train_no
where to_station_no - from_station_no=1 group by
route_info.train_no order by avg(distance) desc;

--3.Display the list of train numbers and the total distance traveled by each in descending order of the distance traveled
select route_info.train_no,train_name,sum(distance) from
route_info join train on route_info.train_no=train.train_no
where to_station_no - from_station_no=1 group by
route_info.train_no order by sum(distance);

--4.List those trains that have maximum and minimum number compartments and also display number of compartments they have. (2 queries one to find max and other to find min)
create view ques_4 as select train_number,count(*) as
Comprtments from compartment group by
train_number,compartment_no;
create view ques_4_1 as select train_number,count(*) as num
from ques_4 group by train_number;
select * from ques_4_1 where num=(select max(num) from
ques_4_1);
select * from ques_4_1 where num=(select min(num) from
ques_4_1);

--5.Display the number of phone numbers corresponding to the user_id(s) ADM_001,USR_006, USR_010
select user_id,count(*) from user_phone where
user_id='ADM_001' or user_id='USR_006' or user_id='USR_010'
group by user_id;

--6.Find the average fare per km for each train type specified and display the train type and corresponding average fare per km as ‘Avg_Fare’ in decreasing order of Avg_Fare
select train_type,avg(fare_per_km) as Avg_Fare from fare
group by train_type;

--7.Retrieve all details of the oldest passenger.
select * from ticket_passenger where age in (select
max(age) from ticket_passenger);

--8.Count the number of passengers whose name consists of ‘Ullal’. (Hint: Use the LIKE operator)
select count(*) from ticket_passenger where name like
'%Ullal%';


