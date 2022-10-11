alter table ticket change column arrival arrival_time time;
alter table ticket change column departure departure_time time;

alter table ticket add column arrival varchar(20) null;
alter table ticket add column departure varchar(20) null;

update ticket set departure ='Mangaluru', arrival = 'Chennai' where PNR = 'PNR004';
update ticket set departure ='Mangaluru', arrival = 'Kannur' where PNR = 'PNR010';
update ticket set departure ='Kannur', arrival = 'Palakkad' where PNR = 'PNR014';
update ticket set departure ='Palakkad', arrival = 'Chennai' where PNR = 'PNR015';
update ticket set departure ='Chennai', arrival = 'Mangaluru' where PNR = 'PNR003';
update ticket set departure ='Mangaluru', arrival = 'Bengaluru' where PNR = 'PNR006';
update ticket set departure ='Bengaluru', arrival = 'Mangaluru' where PNR = 'PNR005';
update ticket set departure ='Subramanya', arrival = 'Mangaluru' where PNR = 'PNR012';
update ticket set departure ='Chennai', arrival = 'Bengaluru' where PNR = 'PNR002';
update ticket set departure ='Chennai', arrival = 'Bangarpet' where PNR = 'PNR008';
update ticket set departure ='Bengaluru', arrival = 'Chennai' where PNR = 'PNR001';
update ticket set departure ='Bangarpet', arrival = 'Chennai' where PNR = 'PNR007';
update ticket set departure ='Katapadi', arrival = 'Chennai' where PNR = 'PNR011';

drop view compute_price;

CREATE VIEW compute_price AS
SELECT Ticket.PNR, Ticket.Train_No, Ticket.Departure, Ticket.Arrival,
Route_Info.Distance, Fare.fare_per_km
FROM Ticket, Route_Info, Fare
WHERE (Ticket.Train_No = Route_Info.Train_No AND
Ticket.Departure = Route_Info.From_Station_Name AND
Ticket.Arrival = Route_Info.To_Station_Name AND
Fare.Train_Type=Ticket.Train_Type AND
Fare.Compartment_Type =Ticket.Compartment_type);

select * from ticket;
select * from route_info;
select * from fare;


CREATE VIEW passenger_num AS select PNR, count(PNR) as numbers from
Ticket_Passenger group by PNR;

UPDATE Payment_Info AS p INNER JOIN compute_price AS cs ON p.PNR = cs.PNR INNER JOIN passenger_num AS pn ON cs.PNR = pn.PNR SET p.Price = cs.Distance * cs.Fare_Per_KM * pn.numbers;

select * from compute_price;
select * from compute_price where train_no = 25260;

select * from route_info where train_no = 25260 order by from_station_no;

update route_info set from_station_no = 3
where from_station_no = 4 and to_station_no = 4 and train_no = 25260;

Select T.Train_no, T.Train_Name, R.from_station_no, R.to_station_no, R.From_Station_Name, R.To_Station_Name, Distance
From Train as T NATURAL JOIN Route_Info as R 
where R.to_station_no - R.from_station_no = 1 
order by 1;

Select T.train_no, T.train_name
From Train as T, 
     Compartment as C
Where T.Train_No = C.Train_Number and 
      T.Source = 'Bengaluru' and 
      T.Destination = 'Chennai' and 
      C.Availability > 10;

Select U.FirstName, 
       U.LastName
From Passenger as U, 
     Ticket as T, 
     Payment_Info as P
Where U.User_ID=T.Passenger_ID and 
      T.PNR = P.PNR and 
      P.Price > 500;

Select U.FirstName, 
       U.LastName, 
       U.DOB, 
       T.PNR
From passenger as U LEFT OUTER JOIN Ticket as T ON U.User_ID = T.passenger_ID
where T.PNR is null;

Select T.PNR, 
       T.Train_No, 
       T.Travel_Date, 
       U.FirstName, 
       U.LastName 
	From Ticket as T RIGHT OUTER JOIN Passenger as U ON T.passenger_ID = U.User_ID;
    
Select U.User_ID, 
       T.Train_no, 
       T.Train_Name
From User_Train as U RIGHT OUTER JOIN Train AS T ON U.Train_ID=T.Train_No; 

SELECT TR.Train_No, 
       TR.Train_Name
FROM Train as TR
WHERE TR.Destination != 'Mangaluru' AND EXISTS  
(SELECT R.Train_No 
 FROM Route_Info AS R, Ticket as T
 WHERE R.Distance > 100 AND 
       T.Departure_Time != '8:30:00 PM' AND 
       T.train_No = TR.Train_no AND
       R.Train_No = TR.Train_no);

SELECT T.Passenger_ID
FROM Ticket AS T JOIN Payment_Info AS P ON T.PNR = P.PNR
WHERE P.Price > (SELECT AVG(P.Price) FROM Payment_Info AS P);

