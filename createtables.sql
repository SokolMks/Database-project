SET TERMOUT ON
PROMPT Building demonstration tables.  Please wait.
SET TERMOUT OFF

drop table guestrooms;
drop table roombookings;
drop table bookings;
drop table rooms;
drop table roomprices;
drop table guests;
drop table customeraddresses;
drop table customers;

CREATE TABLE customers (
  CustomerID NUMBER(4) NOT NULL,
  FirstName varchar(20) NOT NULL,
  LastName varchar(20) NOT NULL,
  DoB date NOT NULL,
  ContactNumber NUMBER(11) NOT NULL,
  ContactEmail varchar(50) NOT NULL,
  PRIMARY KEY (CustomerID)
);

CREATE TABLE customeraddresses (
  CustomerID NUMBER(4) NOT NULL,
  DoorNumber NUMBER(4) NOT NULL,
  StreetName varchar(30) NOT NULL,
  PostCode varchar(8) NOT NULL,
  PRIMARY KEY (CustomerID)
);

CREATE TABLE guests (
  GuestID NUMBER(5) NOT NULL,
  FirstName varchar(20) NOT NULL,
  LastName varchar(20) NOT NULL,
  DoB date NOT NULL,
  PRIMARY KEY (GuestID)
);

CREATE TABLE roomprices (
  RoomType VARCHAR(11) NOT NULL,
  BasePrice NUMBER(6,2) NOT NULL,
  PRIMARY KEY (RoomType)
);

CREATE TABLE rooms (
  RoomNumber NUMBER(4) NOT NULL,
  RoomType VARCHAR(11) REFERENCES roomprices(RoomType) NOT NULL,
  RoomFloor NUMBER(2) NOT NULL,
  PRIMARY KEY (RoomNumber)
);

CREATE TABLE bookings (
  BookingID NUMBER(6) NOT NULL,
  CustomerID NUMBER(4) REFERENCES customers(CustomerID) NOT NULL,
  StartDate date NOT NULL,
  Duration NUMBER(2) NOT NULL,
  TotalPrice NUMBER(8,2) NOT NULL,
  PRIMARY KEY (BookingID)
);

CREATE TABLE roombookings (
  BookingID NUMBER(6) REFERENCES bookings(BookingID) NOT NULL,
  RoomNumber NUMBER(4) REFERENCES rooms(RoomNumber) NOT NULL,
  Price NUMBER(8,2) NOT NULL,
  PRIMARY KEY (RoomNumber)
);

CREATE TABLE guestrooms (
  BookingID NUMBER(6) REFERENCES bookings(BookingID) NOT NULL,
  RoomNumber NUMBER(4) REFERENCES rooms(RoomNumber) NOT NULL,
  GuestID NUMBER(5) REFERENCES guests(GuestID) NOT NULL,
  PRIMARY KEY(GuestID)
);

COMMIT;

SET TERMOUT ON
PROMPT Demonstration table build is complete.
