/*creation of schema optional
create schema "TravellingGB";
set schema 'TravellingGB';*/
/*creation of tables in schema public(or other)*/
create table airport 
(
    name varchar(50) not null,
    country varchar(50) not null,
    primary key(name)
);
create table flight_duration
(
    departuretime time with time zone not null,
    arrivaltime time with time zone not null,
    duration varchar(20) not null,
    primary key(departuretime,arrivaltime)
);
create table flight
(
    flightid varchar(20) not null,
    flightdate date not null,
    arrivaltime time with time zone not null,
    departuretime time with time zone not null,
    price numeric(6,2) not null,
    arrivalairport varchar(50) not null,
    departureairport varchar(50) not null,
    airlinename varchar(20) not null,
    primary key(flightid)
);
create table reservation 
(
    reservationid varchar(20) not null,
    reservationtype varchar(20) not null,
    flightid varchar(20) not null,
    primary key(reservationid)
);
create table passenger
(
    passengerid integer not null,
    seatnumber varchar(20) not null,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    birthdate date not null,
    sex varchar(10) not null,
    email varchar(100) unique not null,
    phonenumber varchar(20) unique not null,
    reservationid varchar(20) not null,
    primary key(passengerid)
);
create table reservation_baggage
(
    reservationid varchar(20) not null,
    baggage varchar(20) not null,
    primary key(reservationid,baggage)
);
create table airline
(
    name varchar(20) not null,
    numberofairplanes integer,
    primary key(name)
);
create table model
(
    modelid varchar(20) not null,
    capacity integer not null,
    primary key(modelid)
);
create table airplane
(
    airplaneid varchar(20) not null,
    model varchar(20) not null,
    airlinename varchar(20) not null,
    primary key(airplaneid)
);

/*creation of indexes*/
create index passenger_index
    on passenger using btree
    (reservationid);
create index reservation_index
    on reservation using btree
    (flightid);
create index flight_index
    on flight using btree
    (airlinename);
create index flight_departuretime_index
    on flight using btree
    (departuretime);
create index flight_arrivaltime_index
    on flight using btree
    (arrivaltime);

/*insert foreign keys into the tables*/
alter table flight add foreign key(arrivalairport) references airport(name) on delete cascade on update cascade;
alter table flight add foreign key(departureairport) references airport(name) on delete cascade on update cascade;
alter table flight add foreign key(arrivaltime,departuretime) references flight_duration(arrivaltime,departuretime) on delete cascade on update cascade;
alter table flight add foreign key(airlinename) references airline(name) on delete cascade on update cascade;
alter table reservation add foreign key(flightid) references flight(flightid) on delete cascade on update cascade;
alter table passenger add foreign key(reservationid) references reservation(reservationid) on delete cascade on update cascade;
alter table reservation_baggage add foreign key(reservationid) references reservation(reservationid) on delete cascade on update cascade;
alter table airplane add foreign key(airlinename) references airline(name) on delete cascade on update cascade;
alter table airplane add foreign key(model) references model(modelid) on delete cascade on update cascade;

/*insert into the tables*/

/*insert records into airport table*/
insert into airport values('SKG','GREECE');
insert into airport values('MAD','SPAIN');
insert into airport values('BER','GERMANY');
insert into airport values('AMS','NETHERLANDS');
insert into airport values('CDG','FRANCE');
insert into airport values('FCO','ITALY');
insert into airport values('ATH','GREECE');
insert into airport values('VCE','ITALY');

/*insert records into flight_duration table*/
insert into flight_duration values(time with time zone '16:35:00+02',time with time zone '17:20:00+01','1h 45min');
insert into flight_duration values(time with time zone '17:10:00+01',time with time zone '20:55:00+02','2h 45min');
insert into flight_duration values(time with time zone '16:15:00+02',time with time zone '18:45:00+01','3h 30min');
insert into flight_duration values(time with time zone '09:05:00+01',time with time zone '10:30:00+01','1h 25min');
insert into flight_duration values(time with time zone '07:50:00+01',time with time zone '10:55:00+01','3h 5min');
insert into flight_duration values(time with time zone '09:45:00+01',time with time zone '12:15:00+01','2h 30min');
insert into flight_duration values(time with time zone '19:55:00+02',time with time zone '21:25:00+01','2h 30min');
insert into flight_duration values(time with time zone '06:15:00+01',time with time zone '08:20:00+01','2h 5min');
insert into flight_duration values(time with time zone '09:55:00+01',time with time zone '12:15:00+01','2h 20min');
insert into flight_duration values(time with time zone '13:40:00+01',time with time zone '15:45:00+02','3h 5min');
insert into flight_duration values(time with time zone '06:20:00+01',time with time zone '07:30:00+01','1h 10min');
insert into flight_duration values(time with time zone '19:50:00+02',time with time zone '20:45:00+02','55min');

/*insert records into airline table*/
insert into airline values('ITA AIRWAYS',70);
insert into airline values('AEGEAN AIRLINES',55);
insert into airline values('RYANAIR',500);

/*insert records into flight table*/
insert into flight values('GQ301',date '25/1/2023',time with time zone '17:20:00+01',time with time zone '16:35:00+02',50,'FCO','SKG','AEGEAN AIRLINES');
insert into flight values('GQ302',date '21/4/2023',time with time zone '20:55:00+02',time with time zone '17:10:00+01',150,'ATH','BER','AEGEAN AIRLINES');
insert into flight values('GQ303',date '9/3/2023',time with time zone '18:45:00+01',time with time zone '16:15:00+02',220,'CDG','ATH','AEGEAN AIRLINES');
insert into flight values('RA304',date '3/6/2023',time with time zone '10:30:00+01',time with time zone '09:05:00+01',130,'AMS','CDG','RYANAIR');
insert into flight values('RA305',date '16/5/2023',time with time zone '10:55:00+01',time with time zone '07:50:00+01',130,'BER','MAD','RYANAIR');
insert into flight values('RA306',date '2/2/2023',time with time zone '12:15:00+01',time with time zone '09:45:00+01',250,'MAD','AMS','RYANAIR');
insert into flight values('RA307',date '11/3/2023',time with time zone '21:25:00+01',time with time zone '19:55:00+02',80,'BER','SKG','RYANAIR');
insert into flight values('IT308',date '31/1/2023',time with time zone '08:20:00+01',time with time zone '06:15:00+01',125,'FCO','BER','ITA AIRWAYS');
insert into flight values('IT309',date '28/3/2023',time with time zone '12:15:00+01',time with time zone '09:55:00+01',180,'AMS','FCO','ITA AIRWAYS');
insert into flight values('GQ310',date '25/3/2023',time with time zone '15:45:00+02',time with time zone '13:40:00+01',110,'SKG','AMS','AEGEAN AIRLINES');
insert into flight values('IT311',date '19/12/2023',time with time zone '07:30:00+01',time with time zone '06:20:00+01',150,'VCE','FCO','ITA AIRWAYS');
insert into flight values('GQ312',date '21/12/2023',time with time zone '20:45:00+02',time with time zone '19:50:00+02',65,'ATH','SKG','AEGEAN AIRLINES');

/*insert records into reservation table*/
insert into reservation values('78FERG','ECONOMY CLASS','IT308');
insert into reservation values('79PICK','BUSINESS CLASS','RA305');
insert into reservation values('80REND','ECONOMY CLASS','GQ310');
insert into reservation values('81KQTG','ECONOMY CLASS','GQ310');
insert into reservation values('82PKZZ','BUSINESS CLASS','RA306');
insert into reservation values('83USDF','BUSINESS CLASS','RA304');
insert into reservation values('84YDFG','ECONOMY CLASS','IT309');
insert into reservation values('85VCXR','ECONOMY CLASS','RA307');
insert into reservation values('86FHFS','ECONOMY CLASS','GQ302');
insert into reservation values('87EIED','ECONOMY CLASS','RA305');
insert into reservation values('88FHDS','ECONOMY CLASS','RA305');
insert into reservation values('89TUED','ECONOMY CLASS','IT309');
insert into reservation values('90BOZZ','ECONOMY CLASS','GQ303');
insert into reservation values('91CEFF','ECONOMY CLASS','GQ301');
insert into reservation values('92FERD','BUSINESS CLASS','GQ302');

/*insert records into passenger table*/
insert into passenger values(1,'4A','MARIA','ANAGNOSTOU',date '15/4/1992','Female','managn@gmail.com','+306964213381','83USDF');
insert into passenger values(2,'8E','JAMES','SMITH',date '17/9/1987','Male','jamsmith@gmail.com','+1(408) 785-9933','79PICK');
insert into passenger values(3,'5D','JOHN','TAYLOR',date '11/9/1964','Male','johntay64@gmail.com','+1(718) 456-9032','82PKZZ');
insert into passenger values(4,'2C','LINDA','BROWN',date '1/1/1981','Female','lbrown@gmail.com','+1(201) 678-3764','92FERD');
insert into passenger values(5,'2B','NICK','BROWN',date '7/1/1980','Male','nickbrown@gmail.com','+1(201) 839-2732','92FERD');
insert into passenger values(6,'9B','VASILEIOS','PAPAGEORGIOU',date '11/7/1967','Male','vasileiospapageo@gmail.com','+306934213445','80REND');
insert into passenger values(7,'9A','IOANNIS','PAPAGEORGIOU',date '14/10/2007','Male','ioapapageo07@gmail.com','+306936426391','80REND');
insert into passenger values(8,'9C','NIKOLETTA','PAPAGEORGIOU',date '4/3/2005','Female','nikpgeorgiou05@gmail.com','+306965432290','80REND');
insert into passenger values(9,'3B','GEORGIA','PANTAZI',date '16/12/1967','Female','geopant@gmail.com','+306943056412','85VCXR');
insert into passenger values(10,'15F','IOANNA','PAPPA',date '24/4/1976','Female','ionpappa@gmail.com','+306935423756','87EIED');
insert into passenger values(11,'14F','IOANNIS','GEORGIOU',date '25/12/1987','Male','georgiouioan@gmail.com','+306947853724','89TUED');
insert into passenger values(12,'22A','THODORIS','MARKOU',date '16/6/1998','Male','markouth@gmail.com','+306987432331','84YDFG');
insert into passenger values(13,'29E','CHRISTOS','PAPADOPOULOS',date '20/10/1973','Male','papadxrhstos@gmail.com','+306987342156','91CEFF');
insert into passenger values(14,'29D','ANASTASIOS','PAPADOPOULOS',date '17/9/1999','Male','anastpapad@gmail.com','+306988345655','91CEFF');
insert into passenger values(15,'12B','SOFIA','LAMPROU',date '30/8/1955','Female','sofialamp@gmail.com','+306981234577','81KQTG');
insert into passenger values(16,'24A','ATHANASIOS','NIKOU',date '4/7/2001','Male','athannikou@gmail.com','+306985345552','88FHDS');
insert into passenger values(17,'7A','PANAGIOTIS','DIMITRIADIS',date '25/3/1977','Male','panagiotissdim@gmail.com','+306985433422','86FHFS');
insert into passenger values(18,'11B','CHRISTINA','NOMIKOU',date '14/5/1965','Female','nomxrist@gmail.com','+306947432259','78FERG');
insert into passenger values(19,'11A','STELLA','PAPANIKOLAOU',date '12/3/2006','Female','papanikstel@gmail.com','+306978655213','78FERG');
insert into passenger values(20,'28F','ELENI','PETROU',date '25/2/1986','Female','petrele@gmail.com','+306943554581','90BOZZ');

/*insert records into reservation_baggage table*/
insert into reservation_baggage values('83USDF','baggage23kg');
insert into reservation_baggage values('83USDF','backpack');
insert into reservation_baggage values('79PICK','baggage23kg');
insert into reservation_baggage values('82PKZZ','baggage8kg');
insert into reservation_baggage values('87EIED','nobaggage');
insert into reservation_baggage values('80REND','baggage23kg');
insert into reservation_baggage values('80REND','baggage8kg');
insert into reservation_baggage values('80REND','backpack');
insert into reservation_baggage values('85VCXR','baggage8kg');
insert into reservation_baggage values('89TUED','backpack');
insert into reservation_baggage values('84YDFG','baggage8kg');
insert into reservation_baggage values('91CEFF','baggage23kg');
insert into reservation_baggage values('91CEFF','baggage8kg');
insert into reservation_baggage values('81KQTG','backpack');
insert into reservation_baggage values('88FHDS','baggage8kg');
insert into reservation_baggage values('86FHFS','baggage8kg');
insert into reservation_baggage values('90BOZZ','baggage8kg');
insert into reservation_baggage values('92FERD','baggage23kg');
insert into reservation_baggage values('92FERD','baggage8kg');
insert into reservation_baggage values('78FERG','baggage8kg');
insert into reservation_baggage values('78FERG','baggage23kg');

/*insert records into model table*/
insert into model values('Airbus A320neo',180);
insert into model values('Airbus A321-200',206);
insert into model values('Airbus A320-200',180);
insert into model values('Boeing 737-800',189);

/*insert records into airplane table*/
insert into airplane values('AA1','Airbus A320neo','AEGEAN AIRLINES');
insert into airplane values('AA2','Airbus A321-200','AEGEAN AIRLINES');
insert into airplane values('IA1','Airbus A320-200','ITA AIRWAYS');
insert into airplane values('RB1','Boeing 737-800','RYANAIR');
insert into airplane values('RA1','Airbus A320-200','RYANAIR');
insert into airplane values('IA2','Airbus A320neo','ITA AIRWAYS');

/*Queries*/

/*AIRPLANES' MODELS OF AEGEAN AIRLINES: Να εμφανιστούν τα μοντέλα των αεροπλάνων καθώς και η χωρητικότητά τους της αεροπορικής εταιρείας Aegean Airlines.
SELECT a.model,m.capacity
FROM airplane a, model m
WHERE m.modelid=a.model AND airlinename='AEGEAN AIRLINES';*/

/*AIRPLANES OF AIRLINES: Εμφάνιση των κωδικών των αεροπλάνων, τα μοντέλα και την χωρητικότητά τους καθώς και σε ποια αεροπορική εταιρεία ανήκουν.
SELECT airlinename, airplaneid, model, capacity
FROM airline a, airplane ap, model m
WHERE a.name=ap.airlinename AND ap.model=m.modelid
ORDER BY airlinename;*/

/*ARRIVAL AIRPORTS WITH MAX TRAFFIC: Εμφάνιση των αεροδρομίων άφιξης και σε ποια χώρα βρίσκονται με τις περισσότερες πτήσεις προς σε αυτά τα αεροδρόμια.
SELECT arrivalairport, country, COUNT(arrivalairport) AS "number of flights"
FROM flight, airport
WHERE arrivalairport=name
GROUP BY arrivalairport, country
HAVING COUNT(arrivalairport)=(SELECT MAX(mycount)
                              FROM (SELECT arrivalairport,  COUNT(arrivalairport) mycount
                                    FROM flight
                                    GROUP BY arrivalairport) grouping)
ORDER BY arrivalairport;*/

/*BUSINESS CLASS RESERVATIONS: Να εμφανιστούν οι κωδικοί κράτησης καθώς και οι κωδικοί πτήσης όπου ο τύπος κράτησης είναι BUSINESS CLASS.
SELECT reservationid, flightid
FROM reservation 
WHERE reservationtype = 'BUSINESS CLASS';*/

/*DEPARTURE AIRPORTS WITH MAX TRAFFIC: Εμφάνιση των αεροδρομίων αναχώρησης και σε ποια χώρα βρίσκονται με τις περισσότερες πτήσεις αναχωρώντας από αυτά τα αεροδρόμια.
SELECT departureairport, country, COUNT(departureairport) AS "number of flights"
FROM flight, airport
WHERE departureairport=name
GROUP BY departureairport, country
HAVING COUNT(departureairport)=(SELECT MAX(mycount)
                                FROM (SELECT departureairport,  COUNT(departureairport) mycount
                                      FROM flight
                                      GROUP BY departureairport) grouping)
ORDER BY departureairport;*/

/*DOMESTIC FLIGHTS: Να εμφανιστούν όλα τα στοιχεία των πτήσεων, η διάρκεια τους καθώς και η χώρα των αεροδρομίων για πτήσεις εσωτερικού.
SELECT f.flightid, f.departureairport, f.arrivalairport, a1.country, 
f.departuretime, f.arrivaltime, duration, f.flightdate, f.price
FROM flight f, airport a1, airport a2, flight_duration fd
WHERE departureairport=a1.name AND arrivalairport=a2.name AND f.departuretime=fd.departuretime 
AND f.arrivaltime=fd.arrivaltime AND a1.country=a2.country;*/

/*ECONOMY CLASS RESERVATIONS: Να εμφανιστούν οι κωδικοί κράτησης καθώς και οι κωδικοί πτήσης όπου ο τύπος κράτησης είναι ECONOMY CLASS.
SELECT reservationid, flightid
FROM reservation 
WHERE reservationtype = 'ECONOMY CLASS';*/

/*FLIGHTS FOR ARRIVAL AIRPORT FCO: Να εμφανιστούν οι κωδικοί πτήσης, η ώρα αναχώρησης, η ώρα άφιξης, η διάρκεια καθώς και η τιμή για κάθε πτήση όπου ισχύει ότι το αεροδρόμιο άφιξης είναι το FCO.
SELECT f.flightid, f.departuretime, f.arrivaltime, fd.duration, f.price
FROM flight f, flight_duration fd
WHERE fd.arrivaltime=f.arrivaltime AND fd.departuretime=f.departuretime 
AND f.arrivalairport='FCO';*/

/*FLIGHTS FOR DEPARTURE AIRPORT AMS: Να εμφανιστούν οι κωδικοί πτήσης, η ώρα αναχώρησης, η ώρα άφιξης, η διάρκεια καθώς και η τιμή για κάθε πτήση όπου ισχύει ότι το αεροδρόμιο αναχώρησης είναι το AMS.
SELECT f.flightid, f.departuretime, f.arrivaltime, fd.duration, f.price
FROM flight f, flight_duration fd
WHERE fd.arrivaltime=f.arrivaltime AND fd.departuretime=f.departuretime 
AND f.departureairport='AMS';*/

/*FLIGHTS WITH MINIMUM PRICE: Να εμφανιστούν οι κωδικοί πτήσης και το αεροδρόμιο αναχώρησης και άφιξης των πτήσεων με την χαμηλότερη τιμή.
SELECT flightid, departureairport, arrivalairport, price
FROM flight
WHERE price = (SELECT min(f.price)
               FROM flight f);*/

/*INTERNATIONAL FLIGHTS: Να εμφανιστούν όλα τα στοιχεία των πτήσεων, η διάρκεια τους καθώς και οι χώρες των αεροδρομίων για πτήσεις εξωτερικού.
SELECT f.flightid, f.departureairport, f.arrivalairport, a1.country departurecountry, 
a2.country arrivalcountry, f.departuretime, f.arrivaltime, duration, f.flightdate, f.price
FROM flight f, airport a1, airport a2, flight_duration fd
WHERE departureairport=a1.name AND arrivalairport=a2.name AND f.departuretime=fd.departuretime 
AND f.arrivaltime=fd.arrivaltime AND a1.country<>a2.country;*/

/*MORNING DEPARTURE FLIGHTS: Εμφάνιση των κωδικών πτήσης, την ώρα αναχώρησης και άφιξης καθώς και την διάρκεια των πτήσεων, για τις πτήσεις όπου ισχύει ότι έχουν ώρα αναχώρησης μετά τις 12 το βράδυ έως τις 12 το πρωί.
SELECT flightid, f.departuretime, f.arrivaltime, duration
FROM flight f, flight_duration fd
WHERE f.departuretime=fd.departuretime AND f.arrivaltime=fd.arrivaltime AND f.departuretime 
BETWEEN time with time zone '00:00:00' AND time with time zone '12:00:00';*/

/*NUM OF BAGGAGES(>=8KG) PER FLIGHT: Να εμφανιστούν οι κωδικοί πτήσης, το αεροδρόμιο αναχώρησης και άφιξης των πτήσεων καθώς και τον αριθμό των αποσκευώναποσκευών οι οποίες είναι μεγαλύτερες ή ίσες των 8 κιλών για κάθε πτήση.
SELECT f.flightid, f.departureairport, f.arrivalairport,COUNT(*) AS "num of baggages"
FROM flight f,reservation r, reservation_baggage rb
WHERE f.flightid=r.flightid AND r.reservationid=rb.reservationid AND rb.baggage LIKE 'baggage%'
GROUP BY f.flightid, f.departureairport, f.arrivalairport
ORDER BY "num of baggages";*/

/*NUM OF PASSENGERS PER FLIGHT: Να εμφανιστούν οι κωδικοί πτήσης και ο αριθμός των επιβατών ανά πτήση.
SELECT f.flightid, COUNT(r.reservationid) AS "num of passengers"
FROM  passenger p INNER JOIN reservation r ON p.reservationid=r.reservationid 
RIGHT JOIN flight f ON r.flightid=f.flightid
GROUP BY f.flightid
ORDER BY "num of passengers";*/

/*NUM OF PASSENGERS PER RESERVATION: Να εμφανιστούν οι κωδικοί κράτησης και ο αριθμός των επιβατών ανά κράτηση.
SELECT reservationid, COUNT(*) AS "num of passengers"
FROM passenger
GROUP BY reservationid
ORDER BY "num of passengers";*/

/*PASSENGERS' CONTACT INFO: Να εμφανιστούν το ονοματεπώνυμο, ο αριθμός τηλεφώνου και το email κάθε επιβάτη.
SELECT firstname, lastname, phonenumber, email
FROM passenger;*/

/*PASSENGERS' FLIGHTS: Να εμφανιστούν οι κωδικοί των επιβατών, κωδικοί κράτησης, κωδικοί πτήσης, το αεροδρόμιο αναχώρησης και άφιξης κάθε πτήσης καθώς και την αεροπορική εταιρεία που εξυπηρετεί κάθε πτήση.
SELECT passengerid, r.reservationid, f.flightid, f.departureairport, 
f.arrivalairport, f.airlinename
FROM passenger p, reservation r, flight f
WHERE p.reservationid=r.reservationid AND r.flightid=f.flightid;*/

/*PASSENGERS IN THE SAME RESERVATION: Να εμφανιστούν οι κωδικοί επιβατών, το ονοματεπώνυμό τους, ο κωδικός κράτησής τους, ο αριθμός θέσης τους και ο κωδικός πτήσης τους για εκείνους τους επιβάτες που βρίσκονται στην ίδια κράτηση.
SELECT p1.passengerid, p1.firstname, p1.lastname, p1.reservationid, p1.seatnumber, r.flightid
FROM passenger p1, reservation r
WHERE p1.reservationid=r.reservationid AND EXISTS (SELECT *
                                                   FROM passenger p2
                                                   WHERE p1.reservationid=p2.reservationid 
                                                   AND p1.passengerid<>p2.passengerid);*/

/*PASSENGERS' TICKETS: Να εμφανιστούν για τους επιβάτες το ονοματεπώνυμο, το φύλο, ο κωδικός κράτησης, ο αριθμός θέσης, ο τύπος κράτησης, ο κωδικός πτήσης, το αεροδρόμιο αναχώρησης και άφιξης, την χώρα αναχώρησης και άφιξης, την ώρα αναχώρησης και άφιξης, την διάρκεια και τιμή της πτήσης.
SELECT firstname, lastname, sex, p.reservationid, seatnumber, r.reservationtype,
f.flightid, f.airlinename, f.departureairport, a1.country departurecountry, f.departuretime, 
f.arrivalairport, a2.country arrivalcountry, f.arrivaltime, duration, price
FROM passenger p, reservation r, flight f, airport a1, airport a2, flight_duration fd
WHERE p.reservationid=r.reservationid AND r.flightid=f.flightid 
AND f.departureairport=a1.name AND f.arrivalairport=a2.name 
AND fd.arrivaltime=f.arrivaltime AND fd.departuretime=f.departuretime;*/

/*PASSENGERS UNDER 18 YEARS OF AGE: Να εμφανιστούν για τους επιβάτες το ονοματεπώνυμο, το φύλο, η ημερομηνία γέννησης, ο αριθμός τηλεφώνου και ο κωδικός κράτησης όπου βρίσκονται σε ηλικία κάτω των 18 ετών.
SELECT firstname, lastname, sex, birthdate, phonenumber, reservationid
FROM passenger
WHERE birthdate>= date '1/1/2005';*/

/*delete tables from the schema(optional)*/
/*DROP TABLE passenger CASCADE;
DROP TABLE reservation CASCADE;
DROP TABLE flight CASCADE;
DROP TABLE reservation_baggage CASCADE;
DROP TABLE flight_duration CASCADE;
DROP TABLE airport CASCADE;
DROP TABLE airline CASCADE;
DROP TABLE airplane CASCADE;
DROP TABLE model CASCADE;*/
