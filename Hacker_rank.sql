CREATE TABLE occupations (
    name VARCHAR(50),
    occupation VARCHAR(50)
);

drop table occupations;

INSERT into occupations Values
('aamina','doctor'),
('Ashley','professor'),
('Belvet','professor'),
('Britney','professor'),
('Christeen','Singer'),
('Eve','Actor'),
('Jane','Singer'),
('Julia','Dancer'),
('Ketty','Actor'),
('Kristeen','professor'),
('Maria','professor'),
('Meera','Professor'),
('Naomi','Professor'),
('Priya','Doctor'),
('Priyanka','Professor'),
('Samantha','Actor');


SELECT CONCAT(name,'(',SUBSTRING(Occupation,1,1),')') AS OUTPUT
FROM Occupations
ORDER BY output;

WITH cte1 AS (
SELECT Occupation,COUNT(occupation) AS Number FROM Occupations GROUP BY occupation ORDER BY Occupation)
SELECT Concat("There are a total of ",Number," ",lower(Substring(Occupation,1,1)), substring(occupation,2),"s.") FROM cte1;
-- ---------------------------------------------------------------------------------------------------------------------------------
with    
X as (select name, occupation  from occupations
	where occupation = 'Doctor'),
    
Y as (select name ,occupation from occupations
	where occupation = 'Professor'),    

Z as (select name ,occupation from occupations
	where occupation = 'Singer'),        

XYZ as (select name,occupation from occupations
	where occupation = 'Actor')
    
SELECT name, occupation FROM X
UNION ALL
SELECT name, occupation FROM Y
UNION ALL
SELECT name, occupation FROM Z
UNION ALL
SELECT name, occupation FROM XYZ;   


CREATE TABLE Visits (
    visit_id INT,
    customer_id INT
);
CREATE TABLE Transactions (
    transaction_id INT,
    visit_id INT,
    amount INT
);
INSERT INTO Visits (visit_id, customer_id) VALUES
    (1, 23),
    (2, 9),
    (4, 30),
    (5, 54),
    (6, 96),
    (7, 54),
    (8, 54);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES
    (2, 5, 310),
    (3, 5, 300),
    (9, 5, 200),
    (12, 1, 910),
    (13, 2, 970);

select v.customer_id , t.transaction_id from 
visits v cross join transactions t ;
 
    

            
            








