create table Student(
roll int unique default 10,
GPA float);

insert into Student() values ();
select * from Student;

desc student;

alter table Student
add semester int;

update Student 
set semester=8, gpa=9.2
where roll=11;

show tables;
-- ----------------------------------------------------------------------------------------------------


create table employee (
E_ID int primary key,
E_Name varchar(30),
Dept varchar(20),
DOJ date);

/*
(1,"Tony",'Production Support','2022-07-29'),
(2,"Steve",'Developer','2022-08-30'),
(3,"Bruce",'Tester','2022-10-10');*/

insert into employee
values
(4,"Natasha",'Analyst','2022-12-15',70000,'F','No');

alter table employee 
add column Gender char(1) CHARACTER set ascii,
add column Vaccinated enum('Yes','No');


update employee
set salaryINRpm = salaryINRpm + (10/100)*salaryINRpm -- 10% hike for developer
where Dept = 'developer';

select * from employee;

set SQL_SAFE_UPDATES = 1;

-- -------------------------------------------------------------------------------------

create table Items (
a tinyint,
b smallint,
c mediumint,
d datetime,
e timestamp);

insert into Items values(80,32766,8388606, DATETIME(),' ');

select getdate();



-- --------------------------------------------------------------------------------------------------------
select * from mysql.user;

create user srikar@localhost identified by 'newuser';
grant all privileges on *.* to srikar@localhost;

create user Chandu identified by 'newuser';
grant all privileges on *.* to Chandu;

drop user Chandu;

select user, host , db, command from information_schema.processlist;

select user, host, account_locked, password_Expired from mysql.user;

-- -----------------------------------
-- Group Activity

create table loan (
loan_id int primary key,
account_id int,
loan_type enum('Home loan','Car loan','Educational loan'),
amount_issued float,
remaining_amount float,
tenure_yrs float,
foriegn key(account_id) references Account(account_id);












