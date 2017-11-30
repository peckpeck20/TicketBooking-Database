--Data INSERT script
--
--Made by Jose Zapata & Yi Zhuang
--12.05.2017

--DELETE FROM Club;
--DELETE FROM Artist;
--DELETE FROM Event;


/*
SELECT * FROM Club;
SELECT * FROM Artist;
SELECT * FROM Event;
SELECT * FROM Account;
SELECT * FROM Booking;
SELECT * FROM Payment;
*/

INSERT INTO Club(VenueName,Capacity) VALUES
	('smallroom',80),
	('large',400);

	--SELECT * FROM Club;

INSERT INTO Artist(ArtistName,SpecialRequest,Nationality,artistPhoneNumber) VALUES
	('Bob dylan','none','American','1238884444'),
	('ACDC','swimming pool','American','991237766'),
	('Paul macartney','clean towel','British','1239990000'),
	('Bob Marley','rizzlas','Jamaican','420123567'),
	('Tom Walker','cookies','Canadian','123456874'),
	('Saara Aalto','Sparking water','Finnish','041234563'),
	('ZZ Top','Shaving cream','Swedish','1239992222'),
	('Jorma Uotinen','Warm blankets','Finnish','420123564'),
	('Cold Play','Cold Ice','American','1113332244');

	--SELECT * FROM artist;



INSERT INTO Event(EventName,SeatNumber,TicketPrice,ArtistId,VenueId,EventStatus,EventDate) VALUES
		('TheEnd','70','15','2','1','active','01/05/2016'),
		('One-on-one','350','1','2','2','active','05/07/2017'),
		('KissMe','55','20','3','1','passed','03/24/2015'),
		('Burn one','400','20','4','2','active','05/31/2017'),
		('Classic hits','200','5','4','2','active','01/01/2017'),
		('The final one','40','20','7','1','active','06/20/2017'),
		('We are one','40','20','5','1','active','06/06/2017'),
		('Cold Play Classic','100','50','9','2','active','12/11/2017'),
		('Gold hits','50','25','3','1','active','01/31/2017'),
		('Carpe Diem','400','50','8','2','active','12/06/2017');

	--SELECT * FROM Event;
	--INSERT INTO Event(EventName,SeatNumber,TicketPrice,ArtistId,VenueId,EventStatus,EventDate) VALUES


	

--constraint check
/*
INSERT INTO Event(EventName,SeatNumber,TicketPrice,ArtistId,VenueId,eventStatus,eventDate) VALUES
	('Classic hits','200','18','14','2','confirm','01/01/2017'),
	('Burn one','400','20','13','4','not sure','05/31/2017');
*/

INSERT INTO Booking(memo,ticketNumber,eventId,bookingStatus) VALUES
	('0468413917',18,1,'active'),
	('0468418585',30,1,'sold'),
	('0469333917',20,2,'active'),
	('0468444917',80,4,'sold'),
	('0462225917',5,3,'cancelled'),
	('1112229999',50,9,'sold'),
	('9998881111',100,10,'sold'),
	('0003338888',50,10,'active'),
	('1110001100',75,10,'active'),
	('3332225533',20,5,'active'),
	('9999999999',20,7,'active'),
	('8888888888',40,6,'active'),
	('7777777777',20,2,'sold'),
	('6666666666',20,8,'active'),
	('2222222222',20,9,'active');
	
	--SELECT * FROM Booking
	--select * from EVENT

	--INSERT INTO Booking(Memo,ticketNumber,EventId,bookingStatus) VALUES






	
--constraint check
/*
INSERT INTO Booking(Memo,ticketNumber,EventId,bookingStatus) VALUES
	(NULl,18,10,'none');
*/

INSERT INTO Account(AccountNumber,balance,paymentNumber) VALUES
	('1',100,NULL);


	--SELECT * FROM Account;
	--SELECT * FROM Payment

	--SELECT * FROM Booking JOIN Payment ON (Payment.bookingNumber = Booking.bookingNumber)

	--SELECT * FROM Booking WHERE JOIN Event ON (Event. bookingStatus = 'sold'
	--SELECT

	--SELECT * FROM BOOKING WHERE bookingStatus NOT LIKE 'cancelled'
INSERT INTO Payment(paymentStatus,BookingNumber) VALUES
	('N',1),
	('Y',2),
	('N',3),
	('Y',4),
	('Y',6),
	('Y',7),
	('N',8),
	('N',9),
	('N',10),
	('N',11),
	('N',12),
	('Y',13),
	('N',14),
	('N',15);



--constraint check
/*
INSERT INTO Payment(PaymentNumber,PaymentStatus,BookingNumber,paymentAmount) VALUES
	(--,'Y','--',--),
*/

