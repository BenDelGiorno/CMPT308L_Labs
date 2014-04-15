-- Ben DelGiorno
-- Lab Assignment 9
-- CMPT 308L

DROP TABLE IF EXISTS crews;
DROP TABLE IF EXISTS catalog;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS systems;
DROP TABLE IF EXISTS astronauts;
DROP TABLE IF EXISTS flightControlOperators;
DROP TABLE IF EXISTS engineers;
DROP TABLE IF EXISTS spacecrafts;
DROP TABLE IF EXISTS people;


-- People
CREATE TABLE people (
  peopleID    integer not null,
  firstName   text,
  lastName    text,
  ageYears    integer,
 primary key(peopelId)
);


-- Engineers
CREATE TABLE engineers (
  pid                   integer not null references people(peopleId),
  highestEarnedDegree   text,
  favoriteVideoGame     text,
 primary key(peopleId)
);


-- Astronauts
Create Table astronauts (
  peopleID           integer not null references people(peopleID)
  yearsFlying        integer,
  golfHandicap       integer,
 primary key(peopleID)
);


-- Flight Control Operators
CREATE TABLE flightControlOperators (
  peopleID         integer not null references people(peopleID),
  chairPreference  text,
  drinkPreference  text,
 primary key(peopleID) 
);


-- Crew
CREATE TABLE crew (
  peopleID       integer not null references people(peopleID),
  spacecraftID   integer not null references spacecrafts(spacecraftID),
 primary key(peopleID, spacecraftID)
);


-- Spacecrafts
CREATE TABLE spacecrafts (
  spacecraftID    integer not null,
  craftName       text,
  tailNumber      integer,
  weightInTons    integer,
  fuelType        text,
  crewCapacity    integer,
 primary key(spacecraftID)
);


-- Systems
CREATE TABLE systems (
  systemID       integer not null,
  spacecraftID   integer not null references spacecrafts(spacecraftID)
  systemName     text,
  systemDescript text,
 primary key(systemID)
);


-- Parts
CREATE TABLE parts (
  partID        integer not null
  systemID      integer not null references systems(systemID),
  partName      text,
  partDescript  text,
 primary key(partID)
);


-- Suppliers
CREATE TABLE suppliers (
  supplierID      integer not null,
  supplierName    text,
  address         text,
  paymentTerms    text,
 primary key(supplierID)
);


-- Catalog
Create TABLE catalog (
  partID      integer not null references part(partID)
  supplierID  integer not null references suppliers(supplierID),
 primary key(partID, supplierID)
);
  