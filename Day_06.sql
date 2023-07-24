use c361cohort;

create table test1(
id int,
Name varchar(30),
Role varchar(20),
Loacation varchar(20),
Salary float);

ALTER TABLE test1
DROP PRIMARY KEY;

EXPLAIN SELECT * FROM test1 WHERE id=500;

CALL Insert_Data(1,15000);

create table test2(
id int,
Name varchar(30),
Role varchar(20),
Location varchar(20),
Salary float);

TRUNCATE test2;

ALTER TABLE test2;
CREATE INDEX idx_employee_id ON test2(id);

CALL Insert_Data(1,20000);

EXPLAIN SELECT * FROM test2 where id = 400;

create table empidx(
id int,
Name varchar(30),
Role varchar(20),
Loacation varchar(20),
Salary float);

TRUNCATE Empidx;

CALL Procedure_Insertion(1,200000);

SELECT count(*) from empidx;

explain SELECT * from empidx where id = 1;

CREATE INDEX idx ON empidx(id);



-- -------------------------------------------------------------------------
drop table orders;


CREATE TABLE orders(
	order_id INT,
    order_date DATE )
    
    PARTITION BY RANGE(YEAR(order_date))
    (partition p0 values less than (1991),
	partition p1 values less than (2001),
	partition p2 values less than (2011),
	partition p3 values less than (2021),
	partition p4 values less than MAXVALUE);
    
CALL Procedure_Insertion(1985,2020);

INSERT INTO orders VALUES(1,'1985-01-01'),
(2,'1995-01-01'),
(3,'2005-01-01'),
(4,'2015-01-01');

EXPLAIN SELECT * from orders where order_date = '1995-01-01';
EXPLAIN SELECT * from orders where order_date = '1985-01-01';
EXPLAIN SELECT * from orders where order_date = '2005-01-01';
EXPLAIN SELECT * from orders where order_date = '2015-01-01';
    
    
create table dummy(val int);
insert into dummy value (1980);    
SELECT DATE(val) from dummy;
    





















show tables;





