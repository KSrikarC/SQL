use c361cohort;

show tables;

select table_name, engine from information_schema.tables 
where table_name = 'employee';

alter table employee engine='myisam';

repair table employee;

select * from employee;
show table status;
show engines;

-- --------------------------------------------------------------
use c361cohort;

-- locking a table
lock table employee write;
insert into employee values(10,'abc','xyz','2000-05-05',85285);
unlock tables;

-- locking a user
alter table employee rename column emp_id to E_ID;
alter user srikar@localhost account unlock ;

select * from employee, student;

-- Creating a view , alias and union
show tables;
create or replace view x as (
	select e_id as IDs_of_Students_Employees from employee union select roll from student);
create or replace view xyy as (
	select e_id , salaryinrpm from employee union select roll, semester from student);
select * from x;

-- Order by and group by statement
select e_name, salaryinrpm from employee order by salaryinrpm desc;
select e_name, count(DOJ) as frequency from employee group by e_name;
 
 
 -- Joins in SQL
 create table Customer(cust_id int primary key auto_increment, Name varchar(20));
 insert into customer(name) values('srikar'),('Eswar'),('Pavan'),('Ravi'),('Vamsi');
 select * from customer;
 
 create table Account(acc_id int primary key , Balance varchar(20), cust_id int, foreign key (cust_id) references Customer(cust_id));
 insert into account() values(100,25000,1),(105,20000,2),(110,17000,3),(115,23000,4),(120,14000,5);
 select * from account;
 
 select c.cust_id, a.acc_id from customer c inner join account a on c.cust_id = a.cust_id;
 
 -- Exercises
 
 CREATE TABLE ActorDirector (
  actor_id INT NOT NULL,
  director_id INT NOT NULL,
  timestamp INT NOT NULL,
  PRIMARY KEY (actor_id, director_id, timestamp)
);

INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES
(1, 1, 0),
(1, 1, 1),
(1, 1, 2),
(1, 2, 3),
(1, 2, 4),
(2, 1, 5),
(2, 1, 6);
select * from actordirector;

-- Q.Which actor worked as director more than 3 or equal to 3
select actor_id , director_id from actordirector where actor_id = director_id group by actor_id having count(*)>=3;

-- 2) - Write an SQL query to find all the authors that viewed at least one of their own articles, 
-- sorted in ascending order by their id.
CREATE TABLE ArticleViews (
  article_id INT NOT NULL,
  author_id INT NOT NULL,
  viewer_id INT NOT NULL,
  view_date DATE NOT NULL,
  PRIMARY KEY (article_id, viewer_id)
);

INSERT INTO ArticleViews (article_id, author_id, viewer_id, view_date) VALUES 
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21');

select author_id from articleviews
where author_id = viewer_id
order by author_id;

-- 3Q. Write an SQL query to find the average selling price for each product.
-- average_price should be rounded to 2 decimal places.

CREATE TABLE Prices (
  product_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (product_id, start_date)
);

INSERT INTO Prices (product_id, start_date, end_date, price) VALUES
(1, '2019-02-17', '2019-02-28', 5.00),
(1, '2019-03-01', '2019-03-22', 20.00),
(2, '2019-02-01', '2019-02-20', 15.00),
(2, '2019-02-21', '2019-03-31', 30.00);

CREATE TABLE UnitsSold (
  product_id INT NOT NULL,
  purchase_date DATE NOT NULL,
  units INT NOT NULL,
  PRIMARY KEY (product_id, purchase_date)
);

INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);

select p.product_id, p.price, sum(p.price*u.units) as Total_prices, u.units from prices p 
inner join unitssold u on p.product_id = u.product_id
group by p.product_id;

SELECT p.product_id, ROUND(AVG(p.price * u.units), 2) AS Average_price
FROM Prices p
JOIN UnitsSold u ON p.product_id = u.product_id
GROUP BY p.product_id;

select * from unitssold;

select p.product_id ,round((sum(p.price*s.units)/sum(s.units)),2) as average_Selling_price
from Prices p  inner join UnitsSold s on p.product_id=s.product_id
where s.purchase_date between p.start_date and p.end_date
group by p.product_id;


-- Q - Can you write a SQL query to find the biggest number, which only appears once.
CREATE TABLE Numbers (
  num INT NOT NULL
  );

INSERT INTO Numbers (num) VALUES
(8),
(8),
(3),
(3),
(1),
(4),
(5),
(6);

SELECT MAX(num) AS Highest_Number
FROM Numbers
WHERE num IN (
    SELECT num
    FROM Numbers
    GROUP BY num
    HAVING COUNT(num) = 1
);

-- Write a SQL query for a report that provides the following information for each person in the Person table,
-- regardless if there is an address for each of those people:

CREATE TABLE Person (
  PersonId INT NOT NULL AUTO_INCREMENT,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  PRIMARY KEY (PersonId)
);

CREATE TABLE Address (
  AddressId INT NOT NULL AUTO_INCREMENT,
  PersonId INT NOT NULL,
  City VARCHAR(50) NOT NULL,
  State VARCHAR(50) NOT NULL,
  PRIMARY KEY (AddressId)
);
INSERT INTO Person (FirstName, LastName)
VALUES
('John', 'Doe'),
('Jane', 'Smith'),
('Michael', 'Johnson'),
('Emily', 'Brown'),
('David', 'Davis');

INSERT INTO Address (PersonId, City, State)
VALUES
(1, 'New York City', 'New York'),
(2, 'Los Angeles', 'California'),
(3, 'Chicago', 'Illinois'),
(4, 'Houston', 'Texas'),
(5, ' ', ' ');

select * from person p inner join address a on 
p.personid = a.personid;

-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?

CREATE TABLE seat (
  seat_id INT NOT NULL,
  free BOOLEAN NOT NULL,
  PRIMARY KEY (seat_id)
);

INSERT INTO seat (seat_id, free) VALUES
(6, 1),
(7, 1),
(8, 0)
(4, 1),
(5, 1);

select seat_id from seat
where seat_id in 
	(select seat_id from seat
      where free=1)
order by seat_id;

select seat_id from (select seat_id, free,lead(free,1) over() as next, 
lag(free,1) over() as prev from seat) a
where free=True and (next = True or prev=True)
order by seat_id;




-- Suppose that a website contains two tables, 
-- the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.

-- Table: Customers.

CREATE TABLE Customers (
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO Customers (id, name) VALUES
(1, 'Joe'),
(2, 'Henry'),
(3, 'Sam'),
(4, 'Max');

CREATE TABLE Orders (
  id INT NOT NULL,
  customer_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

INSERT INTO Orders (id, customer_id) VALUES
(1, 3),
(2, 1);

select c.name,c.id from customers c left join orders o on 
	c.id = o.customer_id
    where o.id is null;
    
select * from customers 
where id not in(
	select c.id from Customers c inner join orders o on 
	c.id = o.customer_id);
    


-- Q.Select all employee's name and bonus whose bonus is < 1000.
-- Table:Employee
CREATE TABLE Employees (
  empId INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  supervisor INT,
  salary INT,
  PRIMARY KEY (empId)
);

INSERT INTO Employees (empId, name, supervisor, salary) VALUES
(1, 'John', 3, 1000),
(2, 'Dan', 3, 2000),
(3, 'Brad', NULL, 4000),
(4, 'Thomas', 3, 4000);

CREATE TABLE Bonus (
  empId INT NOT NULL,
  bonus INT,
  PRIMARY KEY (empId),
  FOREIGN KEY (empId) REFERENCES Employees(empId)
);

INSERT INTO Bonus (empId, bonus) VALUES
(2, 500),
(4, 2000);

select e.name,b.bonus from 
employees e inner join bonus b
on e.empid = b.empid
where b.bonus<1000;

-- Write an SQL query that reports the first login date for each player.

CREATE TABLE Activity (
  player_id INT NOT NULL,
  device_id INT NOT NULL,
  event_date DATE NOT NULL,
  games_played INT,
  PRIMARY KEY (player_id, event_date),
   FOREIGN KEY (player_id) REFERENCES Players(player_id),
   FOREIGN KEY (device_id) REFERENCES Devices(device_id)
);

INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

select distinct player_id, min(event_date) as First_Login_Date from activity
group by(player_id);

-- partitioning 

create table Cust(id int primary key, region varchar(20)),
partition by range(region)
(partition p0 values less that 'IN',
partition p0 values less that 'US')

drop table t1;

create table t1(id int,year_col int)
partition by range(year_col)
(partition p0 values less than (1991),
partition p1 values less than (2001),
partition p2 values less than (2011),
partition p3 values less than (2021))
	

