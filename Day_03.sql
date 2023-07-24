-- sql order of execution 
/* from
	joins
	where
    group by
    having
    select
    distinct
    order by
    limit/offset
*/

use c361cohort;

CREATE TABLE employees (
  employee_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  dept_id INT NOT NULL,
  manager_id INT,
  salary INT NOT NULL,
  expertise VARCHAR(255) NOT NULL,
  PRIMARY KEY (employee_id)
);

INSERT INTO employees (employee_id, first_name, last_name, dept_id, manager_id, salary, expertise) VALUES
(100, 'John', 'White', 103, 103, 120000, 'Senior'),
(101, 'Mary', 'Danner', 109, 109, 80000, 'Junior'),
(102, 'Ann', 'Lynn', 107, 107, 140000, 'Semisenior'),
(103, 'Peter', 'Oconnor', 110, 110, 130000, 'Senior'),
(106, 'Sue', 'Sanchez', 107, 107, 110000, 'Junior'),
(107, 'Marta', 'Doe', 110, 110, 180000, 'Senior'),
(109, 'Ann', 'Danner', 110, 110, 90000, 'Senior'),
(110, 'Simon', 'Yang', 110, NULL, 250000, 'Senior'),
(111, 'Faf', 'Duplesis', 115, 120, 130000, 'Senior');

-- rank function
select first_name, last_name, salary, rank() over(order by salary desc) as Rankings
from employees limit 10;

-- common table expression
with Data as (select *, rank() over(order by salary desc) as Rankings
from employees) 
select * from Data
where rankings > 5 ;

-- dense rank function
select first_name, last_name, salary, dense_rank() over(order by salary desc) as Rankings
from employees limit 10;

select * from employees;

-- partition by clause
with Employee_Ranking as
	(select dept_id,employee_id, first_name, last_name, salary, 
    rank() over (partition by dept_id order by salary desc) as Dept_Ranking
    from employees)
    
select * from employees;

select concat(e1.first_name,' ',e1.last_name) as Employee_Name, e2.first_name as Manager_Name
from employees e1 
join employees e2
on e1.employee_id=e2.manager_id;

select e1.first_name || e1.last_name as Employee_Name, e2.first_name as Manager_Name
from employees e1 
join employees e2
on e1.employee_id=e2.manager_id;


-- Create the table
CREATE TABLE sal (
  employee_id INT,
  salary INT
);

-- Insert 5 records
INSERT INTO sal (employee_id, salary) VALUES
(1, 50000),
(4, 80000),
(5, 90000);

-- Create the table
CREATE TABLE Emp(
  employee_id INT,
  name VARCHAR(255)
);

-- Insert 5 records
INSERT INTO emp (employee_id, name) VALUES
(2, 'Jane'),
(4, 'Emily'),
(5, 'David');

select * from sal;
select * from emp;

with temp as(
select e.employee_id
from emp e left join sal s
using(employee_id)
union
select e.employee_id
from emp e right join sal s
using(employee_id))
select * from temp;








