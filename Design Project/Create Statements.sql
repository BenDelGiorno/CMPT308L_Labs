-- Ben DelGiorno
-- Database Project
-- CMPT 308L
-- April 25, 2014

-- This file includes all create statements, views, reports, stored procedures,triggers and security.

drop table if exists people;
drop table if exists employee;
drop table if exists student;
drop table if exists dormBuilding;
drop table if exists studentProblem;
drop table if exists problem;
drop table if exists item;
drop table if exists status;


-- People Table
create table if not exists people (
    peopleID    int  not null,
    firstName   text not null,
    lastName    text not null,
    email       text not null,
    phoneNumber text not null,
  primary key(peopleID)
);


-- Employee Table
create table if not exists employee (
    peopleID     int  not null,
    officeNumber text not null, 
    hireDate     date not null default current_timestamp,
  primary key(peopleID),
  foreign key(peopleID) references people(peopleID)
); 


-- Student Table
create table if not exists student (
    peopleID        int  not null,
    dormID          int  not null,
    classStanding   text not null,
    CWID            text not null,
  primary key(peopleID) references people(peopleID),
  foreign key(dormID) references dormBuilding(dormID)
);
    

-- Dorm Table
create table if not exists dormBuilding (
    dormID   int  not null,
    name     text not null,
  primary key(dormID);
); 


-- StudentProblem Table
create table if not exists studentProblem (
    peopleID    int not null,
    problemID   int not null,
    primary key(problemID),
    foreign key(problemID) references problem(problemID),
    foreign key(peopleID)  references people(peopleID)
);


-- Problem Table
create table if not exists problem (
    problemID     int not null,
    itemID        int not null,
    statusID      int not null,
    submitDate    date not null default current_timestamp,
    description   text not null,
  primary key(problemID),
  foreign key(itemID)    references item(itemID),
  foreign key (statusID) references status(statusID)
);


-- Item Table
create table if not exists item (
    itemID      int  not null,
    brand       text not null,
    model       text not null,
    description text not null,
  primary key(itemID)
);


-- Status Table
create table if not exists status (
    statusID    int not null,
    description text not null
  primary key(statusID)
);


-- Recieved Problems View
create view ReceivedProblems as
select p.submitDate  as "Date",
        p.problemID   as "Problem ID",
        p.itemID      as "Item ID",
        p.description as "Problem Description"
from problem p, item i, status s
where p.itemID   = i.itemID  
  and p.statusID = s.statusID
  and p.statusID = 1; 


-- In Progress Problems View
create view InProgressProblems as 
select p.submitDate  as "Date",
        p.problemID   as "Problem ID",
        p.itemID      as "Item ID",
        p.description as "Problem Description"
from problem p, item i, status s
where p.itemID   = i.itemID  
  and p.statusID = s.statusID
  and p.statusID = 2; 
  

-- Report - Show all Employees
select p.firstName, p.lastName, p.email, p.phoneNumber
from people p
where p.peopleID in (
    select peopleID
    from employee
);


-- Report - Show the names of people with problems living in Gartland
select firstName, lastName
from people
where problem.problemID = studentProblem.problemID
  and studentProblem.peopleID = student.peopleID
  and student.dormID = dormBuilding.dormID
  and dormBuilding.dormID = 0;


-- Stored Procedure
create or replace function add_people('firstName' text, 'lastNname' text,
'email' text, 'phoneNumber' text) 
 RETURNS void AS 
$BODY$ begin
  insert into people values (firstName, lastName, email, phoneNumber); 
end$BODY$ 
 language plpgsql;

-- Insert Example
insert into people (firstName, lastName, email, phoneNumber) values

('Nick', 'Howard', 'Nick.Howard1@marist.edu', '215-340-1788')


-- Remove Resolved Problems Trigger
create function delResolvedProblem()
returns trigger AS $$
begin
   delete from problems
   where problem.problemID not exists(
       select problem.problemID
       from problem
   )
return null;
end;
$$ language plpgsql;

create trigger delResolvedProblem
    after delete on problem
    for each row
    execute procedure delResolvedProblem();

-- Admin Security
create role admin;

revoke all privileges on people from admin;
revoke all privileges on employee from admin;
revoke all privileges on student from admin;
revoke all privileges on dormBuilding from admin;
revoke all privileges on studentProblem from admin;
revoke all privileges on problem from admin;
revoke all privileges on item from admin;
revoke all privileges on status from admin;

grant select,insert,update on people to admin;
grant select,insert,update,delete on employee to admin;
grant select,insert,update,delete on student to admin;
grant select,insert,update on dormBuilding to admin;
grant select,insert,update on studentProblem to admin;
grant select,insert,update on problem to admin;
grant select,insert,update on item to admin;
grant select,insert,update on status to admin;


-- Student Security
create role student;

revoke all privileges on people from student;
revoke all privileges on employee from student;
revoke all privileges on student from student;
revoke all privileges on dormBuilding from student;
revoke all privileges on studentProblem from student;
revoke all privileges on problem from student;
revoke all privileges on item from student;
revoke all privileges on status from student;

grant select on people to student;
grant select on student to student;
grant select on dormBuilding to student;
grant select on studentProblem to student;
grant select,insert on problem to student;
grant select on item to student;
grant select on status to student;


