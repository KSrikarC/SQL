CREATE table Activity (
    machine_id INT,
    process_id INT,
    activity_type VARCHAR(10),
    timestamp FLOAT
);

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'start', 0.712);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'end', 1.520);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 1, 'start', 3.140);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 1, 'end', 4.120);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 0, 'start', 0.550);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 0, 'end', 1.550);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 0.430);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 1.420);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'start', 4.100);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'end', 4.512);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 2.500);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 5.000);

with cte1 as(
select machine_id,process_id,round(max(timestamp)-min(timestamp),3) total_time, 
count(process_id) num_processes from activity
group by machine_id,process_id)

select machine_id, avg(total_time) 
from cte1
group by machine_id;

-- ------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

CREATE TABLE Subjects (
    subject_name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_name) REFERENCES Subjects(subject_name)
);

INSERT INTO Students (student_id, student_name) VALUES (1, 'Alice');
INSERT INTO Students (student_id, student_name) VALUES (2, 'Bob');
INSERT INTO Students (student_id, student_name) VALUES (13, 'John');
INSERT INTO Students (student_id, student_name) VALUES (6, 'Alex');

INSERT INTO Subjects (subject_name) VALUES ('Math');
INSERT INTO Subjects (subject_name) VALUES ('Physics');
INSERT INTO Subjects (subject_name) VALUES ('Programming');

INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (2, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (2, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');

select s.student_id, s.student_name, sub.subject_name,count(e.subject_name)
from students s join subjects sub
left join examinations e on
s.student_id = e.student_id and
sub.subject_name = e.subject_name
group by s.student_id,sub.subject_name
order by s.student_id,sub.subject_name;

-- --------------------------------------------------------------------------

INSERT INTO Employee (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);

CREATE TABLE Employee (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  department VARCHAR(255),
  managerId INT
);

select e1.name from employee e1 join 
employee e2 on e1.id = e2.managerid
group by e2.managerid having count(*) >= 5 ;

-- ----------------------------------------------------------------

INSERT INTO Signups (user_id, time_stamp) VALUES
(15, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');

INSERT INTO Confirmations (user_id, time_stamp, action) VALUES
(15, '2021-01-04 03:30:46', 'timeout'),
(15, '2021-01-06 03:30:46', 'timeout'),
(15, '2021-01-06 03:30:46', 'confirmed'),
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');

CREATE TABLE Signups (
  user_id INT,
  time_stamp DATETIME
);

CREATE TABLE Confirmations (
  user_id INT,
  time_stamp DATETIME,
  action VARCHAR(255)
);

with cte1 as(
	select user_id,action from confirmations
    where action = 'confirmed'),    
cte2 as(
	select user_id,action from confirmations
    where action = 'timeout')    
select s.user_id , 
/*case
	when count(c1.action)/(count(c1.action) + count(c2.action)) is null then 0.00
    else count(c1.action)/(count(c1.action) + count(c2.action))
end as confirmation_rate,*/
c1.action,c2.action
from signups s
left join cte1 c1 on
s.user_id = c1.user_id 
left join cte2 c2 on 
c1.user_id = c2.user_id;


-- ----------------------------------------------------------------------------------------

CREATE TABLE Prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price DECIMAL(10, 2)
);
CREATE TABLE UnitsSold (
    product_id INT,
    purchase_date DATE,
    units INT
);
INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);
INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);


with cte1 as(
  select a.product_id id, a.price pr, b.units un
  from prices a join unitssold b on
  a.product_id = b.product_id and
  b.purchase_date  between a.start_date and a.end_date
)
select id product_id , round(sum(pr*un) / sum(un),2) average_price  from cte1
group by id;

-- ----------------------------------------------------------------------------------------

CREATE TABLE Project (
    project_id INT,
    employee_id INT
);

CREATE TABLE Employee (
    employee_id INT,
    name VARCHAR(50),
    experience_years INT
);

INSERT INTO Project (project_id, employee_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);

INSERT INTO Employee (employee_id, name, experience_years)
VALUES
    (1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 1),
    (4, 'Doe', 2);
    
with cte1 as(
	select a.project_id pid, b.experience_years exp
    from project a join employee b
    on a.employee_id = b.employee_id)
select pid project_id,
	round(avg(exp),2) average_years
    from cte1
    group by pid;    
    
-- ----------------------------------------------------

CREATE TABLE Users (
    user_id INT,
    user_name VARCHAR(50)
);

CREATE TABLE Register (
    contest_id INT,
    user_id INT
);

INSERT INTO Users (user_id, user_name)
VALUES
    (6, 'Alice'),
    (2, 'Bob'),
    (7, 'Alex');

INSERT INTO Register (contest_id, user_id)
VALUES
    (215, 6),
    (209, 2),
    (208, 2),
    (210, 6),
    (208, 6),
    (209, 7),
    (209, 6),
    (215, 7),
    (208, 7),
    (210, 2),
    (207, 2),
    (210, 7);
    
select count(distinct(user_id)) into @tot_users from users;

select contest_id , round((count(user_id)/(@tot_users) * 100.0),2) 
as percentage from register
group by contest_id;

-- ---------------------------------------------------------------------------------

-- Create Queries table
CREATE TABLE Queries (
    query_name VARCHAR(50),
    result VARCHAR(50),
    position INT,
    rating INT
);

-- Insert data into Queries table
INSERT INTO Queries (query_name, result, position, rating)
VALUES ('Dog', 'Golden Retriever', 1, 5),
       ('Dog', 'German Shepherd', 2, 5),
       ('Dog', 'Mule', 200, 1),
       ('Cat', 'Shirazi', 5, 2),
       ('Cat', 'Siamese', 3, 3),
       ('Cat', 'Sphynx', 7, 4);

       
with cte1 as(
	select query_name, rating/position qu
    from queries),
cte2 as(    
	select query_name, round(avg(qu),2) quality , count(query_name) tot from cte1
	group by query_name),
cte3 as(
	select query_name, COALESCE((SELECT COUNT(query_name) FROM queries WHERE rating < 3 GROUP BY query_name),0) AS tot
    from queries where rating < 3 
    group by query_name)
select cte2.query_name, cte2.quality, round((cte3.tot/cte2.tot * 100.0),2) poor_query_percentage
from cte2 join cte3 on
cte2.query_name = cte3.query_name;
    
    
select IF(count(query_name) is null,0,count(query_name)) tot
from queries where rating < 1 group by query_name;


-- ------------------------------------------------------------------------------------------------

-- Create table
CREATE TABLE transactions (
  id INT PRIMARY KEY,
  country VARCHAR(2),
  state VARCHAR(10),
  amount INT,
  trans_date DATE
);

-- Insert data
INSERT INTO transactions (id, country, state, amount, trans_date)
VALUES (121, 'US', 'approved', 1000, '2018-12-18'),
       (122, 'US', 'declined', 2000, '2018-12-19'),
       (123, 'US', 'approved', 2000, '2019-01-01'),
       (124, 'DE', 'approved', 2000, '2019-01-07');

select * from transactions;

select concat(year(trans_date),'-',substring(trans_date,6,2)) as month,
country,
count(*) trans_count,
SUM(IF(state='approved',1,0)) approved_count,
SUM(amount) transaction_total_amount,
SUM(IF(state='approved',amount,0)) approved_total_amount
from transactions
group by month,country;

-- ------------------------------------------------------------------------------------------------


-- Drop table if exists
DROP TABLE IF EXISTS delivery;

-- Create table
CREATE TABLE delivery (
  delivery_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  customer_pref_delivery_date DATE
);

-- Insert data
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES (1, 1, '2019-08-01', '2019-08-02'),
       (2, 2, '2019-08-02', '2019-08-02'),
       (3, 1, '2019-08-11', '2019-08-12'),
       (4, 3, '2019-08-24', '2019-08-24'),
       (5, 3, '2019-08-21', '2019-08-22'),
       (6, 2, '2019-08-11', '2019-08-13'),
       (7, 4, '2019-08-09', '2019-08-09');
       
with cte1 as(
	select customer_id, min(order_date) od, min(customer_pref_delivery_date) dd from delivery
    group by customer_id) 
       
select round((count(*)/ (select count(distinct(customer_id)) from delivery)) * 100,2) as immediate_percentage
from cte1
where od = dd;

-- ---------------------------------------------------------------------------------------------------------

-- Create table
CREATE TABLE player_stats (
  player_id INT,
  device_id INT,
  event_date DATE,
  games_played INT
);

-- Insert data
INSERT INTO player_stats (player_id, device_id, event_date, games_played)
VALUES
  (1, 2, '2016-03-01', 5),
  (1, 2, '2016-03-02', 6),
  (2, 3, '2017-06-25', 1),
  (3, 1, '2016-03-02', 0),
  (3, 4, '2018-07-03', 5);

with cte1 as(
	select player_id, event_date curr_day,
	lead(event_date) over(partition by player_id order by event_date) as next_day
	from player_stats)

select round(count(player_id) / (select count(distinct(player_id)) from player_stats),2) as fraction
from cte1
where curr_day = next_day - 1;


