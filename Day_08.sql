-- Start with regex

CREATE TABLE test_regex (
    name VARCHAR(50)
);

INSERT INTO test_regex (name) VALUES
    ('Alice'),
    ('Bob'),
    ('Charlie'),
    ('David'),
    ('Emily');
INSERT INTO test_regex (name) VALUES
    ('Giselle48'),
    ('Giselle'),
    ('Hiroshi'),
    ('Isabella'),
    ('Juan'),
    ('Katarina'),
    ('Liam'),
    ('Mia'),
    ('Nadia'),
    ('Oliver');

select name from test_regex
where name regexp '^[abc]';

select name from test_regex
where name regexp '^[^abc]';

select name from test_regex
where name regexp '^[A-Z].*[0-9]$ | [:space:]';



insert into test_regex values ('Nioe');

select name from test_regex
where name regexp '[:space:]';

SELECT *
FROM test_regex
WHERE name COLLATE utf8mb4_bin REGEXP '^[A-Z\s]+$';

select name from test_regex
where ASCII(left(name,1)) between ASCII('A') and ASCII('Z');

Select IFNULL(NULL,6);
Select NULLIF(5,6);

select strcmp('one1','one2');

create table table1(num_value int);
insert into table1(num_value) values (10),(20),(25);
create table table2(num_value int);
insert into table2(num_value) values (20),(7),(10);

select num_value from table1 where
num_value > ALL
(select num_value from table2);

select num_value from table1 where
num_value > (select max(num_value) from table2);

explain select 'Srikar' where 'Srikar' like 's%r';
