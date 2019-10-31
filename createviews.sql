SET TERMOUT ON
PROMPT Building demonstration tables.  Please wait.
SET TERMOUT OFF

drop view CustomersWhoAreGuests;
drop view Children;
drop view RoomTypeAvgDur;
drop view BookingConfirmations;

CREATE VIEW CustomersWhoAreGuests AS
SELECT t1.CustomerID, t2.GuestID, t1.FirstName, t1.LastName, t1.DoB
FROM customers t1
INNER JOIN guests t2 ON t2.FirstName=t1.FirstName AND t2.LastName=t1.LastName AND t2.DoB=t1.DoB;

CREATE VIEW Children AS 
SELECT t1.GuestID, t1.FirstName,
TRUNC(MONTHS_BETWEEN(sysdate,t1.DoB)/12) Age
FROM guests t1
INNER JOIN guestrooms t2 ON t2.GuestID=t1.GuestID
WHERE TRUNC(MONTHS_BETWEEN(sysdate,t1.DoB)/12) <= 12;

CREATE VIEW RoomTypeAvgDur AS
SELECT DISTINCT t1.RoomType, ROUND(AVG(t2.Duration),0) AS AVGDUR
FROM rooms t1
INNER JOIN roombookings t3 ON t3.RoomNumber=t1.RoomNumber
INNER JOIN bookings t2 ON t2.BookingID=t3.BookingID
GROUP BY t1.RoomType;

CREATE VIEW BookingConfirmations AS 
SELECT t1.CustomerID, t1.FirstName, t1.LastName, t1.ContactEmail, t2.TotalPrice
FROM customers t1
INNER JOIN bookings t2 ON t2.CustomerID = t1.CustomerID;

COMMIT;

SET TERMOUT ON
PROMPT Demonstration table build is complete.
