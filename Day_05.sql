SET GLOBAL log_bin_trust_function_creators = 1;

select * from employees

-- lets get 4th highest salary
select row_number() over(order by salary desc) as 'row',salary from employees
limit 3,1;

select getNthHighestSalary(4) 4th_Highest_Sal;

select getExpertise("Senior");

-- Use stored procedure to give a hike of 5% for employees in dept_id 109
call update_employee_salary_details(5.0,109);

-- ------------------------------------------------------------------------------------------------

CREATE TABLE employeee (
	emp_id int primary key,
    name varchar(200),
    age int,
    salary decimal(7,2),
    joining_date date,
    department varchar(200)
);

INSERT INTO employeee (emp_id, name, age, salary, joining_date, department)
VALUES
    (1, 'John Doe', 30, 5000.00, '2022-01-01', 'Finance'),
    (2, 'Jane Smith', 35, 6000.00, '2021-09-15', 'HR'),
    (3, 'Michael Johnson', 28, 4500.00, '2022-03-10', 'Sales'),
    (4, 'Emily Davis', 32, 5500.00, '2022-02-20', 'Marketing'),
    (5, 'David Wilson', 40, 7000.00, '2021-07-01', 'IT'),
    (6, 'Sarah Brown', 27, 4000.00, '2022-05-05', 'Operations'),
    (7, 'Robert Lee', 33, 6000.00, '2022-01-15', 'Finance'),
    (8, 'Jennifer Clark', 31, 5500.00, '2022-04-02', 'HR'),
    (9, 'Daniel Taylor', 29, 4800.00, '2022-03-20', 'Sales'),
    (10, 'Olivia Moore', 34, 6500.00, '2021-12-10', 'Marketing');
    
with cte1 as(     
select department, sum(salary) as Dept_Expenditure from employeee
group by department),
cte2 as (select sum(salary) as total_Sal from employeee)
select  department, (Dept_Expenditure/total_Sal)*100 as Expediture_Percentage from cte1,cte2;

WITH A AS
(SELECT department, SUM(salary) as summ FROM employeee
GROUP BY department)
SELECT department, 
(summ/(SELECT SUM(salary) FROM employeee)*100) AS Sal_Per
FROM A;


-- Q.Task: Write a query to get the empno with the highest salary. 
-- Make sure your solution can handle ties!

CREATE TABLE emp (
  emp_id int NOT NULL AUTO_INCREMENT,
  depname varchar(200),
  empno int,
  salary decimal(7,2),
  PRIMARY KEY (emp_id)
);

INSERT INTO emp (depname, empno, salary)
VALUES ('sales', 12, 6000),
  ('develop', 11, 5200),
  ('develop', 7, 4200),
  ('develop', 9, 4500),
  ('develop', 8, 6000),
  ('develop', 10, 5200),
  ('personnel', 5, 3500),
  ('personnel', 2, 3900),
  ('sales', 3, 4800),
  ('sales', 1, 5000),
  ('sales', 4, 4800);

with X as (
	select empno,salary, HighestSal("emp") as HighestSalary
    from emp)
select empno, salary from X
where salary = HighestSalary;

SELECT empno
FROM emp
WHERE salary = (
    SELECT MAX(salary)
    FROM emp
);


-- Report player details per each game , including who logged in first

CREATE TABLE gameplay (
  player_id INT NOT NULL,
  device_id INT NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  game_id INT NOT NULL
);
drop table gameplay;
INSERT INTO gameplay (player_id, device_id, timestamp, game_id) VALUES 
(10, 104, '2023-05-20 20:00:00', 1003),(10, 104, '2023-05-20 22:00:00', 1003);
(5, 102, '2023-05-19 11:30:00', 1002),
(3, 103, '2023-05-19 12:45:00', 1003),
(1, 104, '2023-05-19 14:00:00', 1001),
(5, 105, '2023-05-19 15:15:00', 1002);



with game as(
select g1.player_id,g1.game_id, g1.timestamp as start_time, g2.timestamp as end_time
from gameplay g1 join
gameplay g2 on 
g1.game_id = g2.game_id and g1.timestamp < g2.timestamp)
select distinct game_id,
	player_id played_by,
    min(start_time) start_time,
    max(end_time) end_time from game
group by game_id,player_id;


with X as(
	select g1.game_id as game_id, 
	min(time(g2.timestamp)) as start_time,
	max(time(g2.timestamp)) as end_time
    from gameplay g1 join gameplay g2
    on g1.game_id = g2.game_id and g1.timestamp < g2.timestamp
    where date(g1.timestamp) = date(g2.timestamp)
    group by game_id)
select * from x;


SELECT ROUND(AVG(percent), 2) AS average_daily_percent
FROM (
  SELECT COUNT(r.post_id) * 100.0 / COUNT(a.post_id) AS percent
  FROM Actions a
  LEFT JOIN Removals r ON a.post_id = r.post_id
  WHERE a.action = 'report' AND a.extra = 'spam'
  GROUP BY a.action_date
) subquery;
 
 -- Write an SQL query to find the ctr of each Ad.Round ctr to 2 decimal points. 
 -- Order the result table by ctr in descending order and by ad_id in ascending order in case of a tie.
 
CREATE TABLE Ads (
  ad_id INT,
  user_id INT,
  action VARCHAR(10)
);

INSERT INTO Ads (ad_id, user_id, action)
VALUES
  (1, 1, 'Clicked'),
  (2, 2, 'Clicked'),
  (3, 3, 'Viewed'),
  (5, 5, 'Ignored'),
  (1, 7, 'Ignored'),
  (2, 7, 'Viewed'),
  (3, 5, 'Clicked'),
  (1, 4, 'Viewed'),
  (2, 11, 'Viewed'),
  (1, 2, 'Clicked');

SELECT  ad_id,
	ROUND((SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS ctr
FROM Ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC;

with X as(
	select ad_id,
		Sum(case when
			action = 'clicked' then 1
			else 0
			end)
	 as Ctr ,
     count(*) as Total_hits from Ads group by ad_id)
  select ad_id, (100/Total_hits)*Ctr as Ctr from X
  order by ad_id;
  
  
  