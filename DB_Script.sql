Create function TotalTickets(@EventId as int)
	Returns Int
	As
	Begin
	Return (select sum(ticketNumber)from Booking where eventId=@EventId)
	End;

Create Function ReturnSeatNo(
@EventId as Integer)
Returns Int
As
Begin
Return (Select SeatNumber from Event where EventId=@EventId) 
End;

alter table Booking  
Add Constraint Checkoverbooking check(BIT_SWD03_42.TotalTickets(eventId) <=BIT_SWD03_42.ReturnSeatNo(eventId))

--these 3 queries are for creating the constraint to prevent overbooking.


Create function totalAmoutTobePaid(@bookingnumber as int,@eventId as int)
returns int
as
Begin
return BIT_SWD03_42.getTicketNumberPerbooking(@bookingnumber) *BIT_SWD03_42.getTicketPrice(@eventId)
End

--It calculates the total amount of ticket price the buyer needs to pay for in a booking automatically. 

Create PROCEDURE BookingTicket(@memo as VARCHAR(10),@ticketnumber as int,@eventID as int)
AS
BEGIN

    INSERT INTO Booking(Memo,ticketNumber,EventId,bookingStatus,AmountTobePaid) VALUES
	(@memo,@ticketnumber,@eventID,'active',BIT_SWD03_42.totalAmoutTobePaid((Select bookingNumber from Booking),@eventID));
END

--This is to book a ticket as well as showing the total amount of ticket price the buyer needs to pay for in a booking automatically.


Create PROCEDURE CancelBooking(@bookingnumber as int)
AS
BEGIN

update Booking
Set BookingStatus = 'cancelled' where bookingNumber=@bookingnumber and not bookingStatus='sold'

END
--this is to cancel a booking.


Create PROCEDURE ChangeNumberOfTicket(@bookingnumber as int,@NumberOfTickets as int)
AS
BEGIN
update Booking
Set ticketNumber =@NumberOfTickets  where bookingNumber=@bookingnumber and not bookingStatus='sold'
END

--This is to change the number of tickets in a booking.


Create PROCEDURE CancelEvent(@EventId as int)
AS
BEGIN
	
Update Event
Set EventStatus='cancelled' where EventId=@EventId
END
--This is to cancel an event.

--TRIGGERS

--1) This trigger changes the status to booking when the tickets are purchased
CREATE TRIGGER Payed_Trigger
ON Payment
AFter Update
AS
	Begin
	
	Update Booking 
	Set bookingStatus='sold'
	from Booking
	JOIN Payment ON (Payment.BookingNumber = Booking.bookingNumber)
	 where Payment.PaymentStatus='Y'


End;

--TEST TRIGGER
--UPDATE Payment SET PaymentStatus = 'Y' WHERE BookingNumber = 1

--2) Remove the unpurchased bookings from DB of the past events

CREATE TRIGGER Event_trigger
ON Event
AFTER UPDATE
AS
BEGIN
	Delete Booking from Booking 
	 JOIN Event ON (Event.EventId = Booking.eventId)
	Where Event.EventStatus='passed' 
END;

--SELECT * FROM Booking
--Test trigger
--UPDATE Event SET EventStatus = '' WHERE EventId =1


--3)  Remove unpurchased tickers after 3 days of booking

CREATE TRIGGER RemoveBooking_Trigger
ON Booking
AFTER INSERT
AS
BEGIN
	
	DELETE Booking FROM Booking WHERE DATEPART(DD,GETDATE())- DATEPART(DD,BookingDate) >= 3
	

END;




	--total tickets booked for each venue 	
	SELECT SUM(ticketNumber) AS 'totalTickets',VenueId FROM Booking JOIN Event ON (Event.eventID = Booking.eventId)  GROUP BY VenueId


--Constraint to prevent overbooking , consists of 3 of the following queries

Create function TotalTickets(@EventId as int)
	Returns Int
	As
	Begin
	Return (select sum(ticketNumber)from Booking where eventId=@EventId)
	End

Create Function ReturnSeatNo(
@EventId as Integer)
Returns Int
As
Begin
Return (Select SeatNumber from Event where EventId=@EventId)
End

alter table Booking  Add Constraint Checkoverbooking check(BIT_SWD03_42.TotalTickets(eventId) <=BIT_SWD03_42.ReturnSeatNo(eventId))



-- trigger to show the total price amount for each booking automatically 
CREATE TRIGGER ShowTotal_Trigger
ON Booking
AFTER INSERT
AS
BEGIN
	UPDATE Booking SET AmountTobePaid = Booking.ticketNumber * Event.TicketPrice FROM Booking JOIN Event ON (Event.EventId = Booking.EventId)

END;

CREATE TRIGGER ShowTotal_Trigger_Update
ON Booking
AFTER UPDATE
AS
BEGIN
	UPDATE Booking SET AmountTobePaid = Booking.ticketNumber * Event.TicketPrice FROM Booking JOIN Event ON (Event.EventId = Booking.EventId)

END;

--TEST
--SELECT * FROM Booking

--INSERT INTO Booking (memo,ticketNumber,eventId,bookingStatus) VALUES
--('1112229992',10,2,'active')


	--TRIGGER used to refund in case of the event getting cancelled
CREATE TRIGGER Update_acc_Trigger
ON Event
AFTER UPDATE
AS
BEGIN
	UPDATE Account SET Balance = Balance - Booking.ticketNumber * Event.TicketPrice FROM Booking JOIN Event ON (Event.EventId = Booking.EventId)

END;




-- TEST SCRIPTS

--1)
SELECT * FROM Event WHERE Month(EventDate) = 6;

--2)
SELECT * FROM Event WHERE Month(EventDate) = 5;

--3)
SELECT ArtistPhoneNumber FROM Artist WHERE ArtistName = 'Saara Aalto';

--4)
SELECT EventDate,Artist.SpecialRequest FROM Artist JOIN Event ON (Event.ArtistId = Artist.ArtistId) WHERE ArtistName LIKE 'ZZ Top';

--5)
SELECT ticketNumber AS 'Sold Tickets',EventName, ArtistName FROM Event
JOIN Artist ON (Artist.ArtistId = Event.ArtistId) 
JOIN Booking ON (Booking.EventId = Event.EventId) 
WHERE EventDate = '12/06/2017' AND ArtistName = 'Jorma Uotinen' AND BookingStatus = 'confirm';

--6)
SELECT SeatNumber- ticketNumber  AS 'Tickets left',EventName FROM Event 
JOIN Artist ON (Artist.ArtistId = Event.ArtistId) 
JOIN Booking ON (Booking.EventId = Event.EventId) 
WHERE EventDate = '12/11/2017'

--7)





