CREATE TABLE nodes (
  node_id INT NOT NULL AUTO_INCREMENT,
  parent_id INT,
  PRIMARY KEY (node_id)
);

INSERT INTO nodes (node_id, parent_id) VALUES
(1, 2),
(2, 5),
(3, 5),
(4, 3),
(5, NULL);

with temp_view as (
	select cur.node_id , cur.parent_id, count(next.node_id) as No_of_Children
    from nodes cur left join nodes next on
    cur.node_id = next.parent_id
    group by cur.node_id)
select * from temp_view;

-- -----------------------------------------------------------
-- Write a query that gets the number of retained users per month. In this case, retention for a given month 
-- is defined as the number of users who logged in that month who also logged in the immediately previous month.

CREATE TABLE user_activity (
  user_id INT NOT NULL,
  date DATE NOT NULL,
  PRIMARY KEY (user_id, date)
);

drop table user_activity;

INSERT INTO user_activity (user_id, date) VALUES
(4, '2018-10-01');
(1, '2018-04-02'),
(1, '2018-06-02'),
(1, '2018-09-02'),
(2, '2018-07-07'),
(2, '2018-07-02'),
(2, '2018-11-02'),
(3, '2018-07-02');

WITH User_data AS(	
    SELECT user_id, MONTH(date) Cur_Month, LAG(MONTH(date)) OVER(order by User_id)-1 Prev_Month from user_activity)
SELECT count(distinct user_id) as Reactivated_Users from User_data
where Cur_Month - Prev_Month >= 2;

select * from user_activity;

select user_id Active_Users 
from user_activity
group by user_id
having count(*) > 1;


select a.date , a.user_id, extract(month from a.date) as logged_month,
count(distinct a.user_id) as reactivated_user, max(extract(month from a.date)) as most_recent from user_activity as a 
JOIN user_activity AS b on a.user_id=b.user_id
AND extract(month from a.date) > extract(month from b.date)
group by extract(month from a.date), a.date, a .user_id
having logged_month < most_recent+ 1;

-- Sol 1
select a.date , a.user_id, extract(month from a.date) as day_timestamp,
count(distinct a.user_id) as retained_users from user_activity a 
join user_activity b on a.user_id=b.user_id
AND extract(month from a.date)=extract(month from b.date)+ 1
group by extract(month from a.date), a.date, a .user_id;

-- Sol 2
WITH a AS
(SELECT user_id, MONTH(date) AS Logged_Month, YEAR(date) AS Logged_Year 
FROM user_activity),
B AS
(SELECT user_id, Logged_Month, LAG(Logged_Month) OVER() AS Prev_Month,
LAG(Logged_Year) OVER() AS Prev_Year FROM a)
SELECT COUNT(user_id) AS Retained_Users FROM B WHERE Prev_Month = Logged_Month - 1 
OR ((Prev_Month = 12 AND Logged_Month = 1) and (Prev_Year = Logged_Year - 1));


select a.date , a.user_id, extract(month from a.date) as day_timestamp,
count(distinct a.user_id) as churned_users from user_activity as a 
LEFT JOIN user_activity AS b on a.user_id=b.user_id
AND extract(month from a.date)=extract(month from b.date)+ 1
where b.user_id is null
group by extract(month from a.date), a.date, a .user_id
UNION ALL
select a.date , a.user_id, extract(month from a.date) as day_timestamp,
count(distinct a.user_id) as churned_users from user_activity as a 
RIGHT JOIN user_activity AS b on a.user_id=b.user_id
AND extract(month from a.date)=extract(month from b.date)+ 1
where b.user_id is null
group by extract(month from a.date), a.date, a .user_id;

SELECT a.date, COUNT(DISTINCT a.user_id) AS churned_users
FROM user_activity AS a
LEFT JOIN user_activity AS b
  ON a.user_id = b.user_id
  AND EXTRACT(MONTH FROM a.date) = EXTRACT(MONTH FROM b.date) + 1
WHERE b.user_id IS NULL
GROUP BY EXTRACT(MONTH FROM a.date), a.date
ORDER BY a.date;

SELECT
    date,
    user_id,
    EXTRACT(MONTH FROM date) AS month_timestamp,
    COUNT(DISTINCT user_id) AS churned_users
FROM
    (
        SELECT
            date,
            user_id,
            LAG(date) OVER (PARTITION BY user_id ORDER BY date) AS prev_date
        FROM
            user_activity
    ) AS subquery
WHERE
    prev_date IS NOT NULL AND EXTRACT(MONTH FROM date) = EXTRACT(MONTH FROM prev_date) + 1
GROUP BY
    date,
    user_id,
    month_timestamp
ORDER BY
    date;
    
-- ---------------------------------------------------------------------------------------
CREATE TABLE cash_flow (
  date DATE NOT NULL,
  cash_flow INT NOT NULL,
  PRIMARY KEY (date)
);

INSERT INTO cash_flow (date, cash_flow) VALUES
('2018-01-01', -1000),
('2018-01-02', -100),
('2018-01-03', 50);

INSERT INTO cash_flow (date, cash_flow) VALUES
('2018-01-04', 200),
('2018-01-05', -300),
('2018-01-06', 100),
('2018-01-07', -50);

select a.date date,sum(b.cash_flow) as cumalative
from cash_flow a 
join cash_flow b on a.date>= b.date
group by a.date
order by date asc;

SELECT date, SUM(cash_flow) OVER (ORDER BY date ASC) AS cumulative
FROM cash_flow
ORDER BY date ASC;

CREATE TABLE sign_ups (
  date DATE NOT NULL,
  sign_ups INT NOT NULL,
  PRIMARY KEY (date)
);
select date_sub('2018-01-02', interval 6 day)
INSERT INTO sign_ups (date, sign_ups) VALUES
('2017-12-27', 10),
('2018-01-02', 20),
('2018-01-03', 50),
('2018-10-01', 35);

select date, AVG(sign_ups) over (order by date asc rows between 6 preceding and current row) AS AVG_SIGNUPS
from sign_ups
order by date;

SELECT  a.date FROM  sign_ups a
JOIN  sign_ups b ON b.date 
BETWEEN DATE_SUB(a.date, INTERVAL 6 DAY) AND a.date
GROUP BY  a.date
ORDER BY  a.date;

select DATE_SUB(a.date, INTERVAL 6 DAY) Window_Date from sign_ups a
where DATE_SUB(a.date, INTERVAL 6 DAY) in (select date from sign_ups);

-- Write a query to get the response time per email (id) sent to zach@g.com . Do not include ids that did not receive a response from zach@g.com. Assume each email thread has a unique subject.
-- Keep in mind a thread may have multiple responses back-and-forth between zach@g.com and another email address.
CREATE TABLE messages (
  id INT NOT NULL AUTO_INCREMENT,
  subject VARCHAR(255) NOT NULL,
  from_e VARCHAR(255) NOT NULL,
  to_e VARCHAR(255) NOT NULL,
  timestamp DATETIME NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO messages (subject, from_e, to_e, timestamp) VALUES
('Yosemite', 'zach@g.com', 'thomas@g.com', '2018-01-02 12:45:03'),
('Big Sur', 'sarah@g.com', 'thomas@g.com', '2018-01-02 16:30:01'),
('Yosemite', 'thomas@g.com', 'zach@g.com', '2018-01-02 16:35:04'),
('Running', 'jill@g.com', 'zach@g.com', '2018-01-03 08:12:45'),
('Yosemite', 'zach@g.com', 'thomas@g.com', '2018-01-03 14:02:01'),
('Yosemite', 'thomas@g.com', 'zach@g.com', '2018-01-03 15:01:05');

select * from messages;

with view as(
	select from_e,to_e,timestamp from messages
    where subject='Yosemite')
select * from view; 

select m1.id , TIMESTAMPDIFF(MINUTE, m1.timestamp, m2.timestamp) AS response_time 
from messages m1 join messages m2
on m1.subject = m2.subject
where m1.from_e = 'zach@g.com' AND m2.to_e = 'zach@g.com' 
and m1.timestamp < m2.timestamp
order by m1.id;

select a.id , min(b.timestamp) - a.timestamp as time_to_respond
from messages a 
join messages b
on b.subject = a.subject
and a.to_e =b.from_e
and a.timestamp < b.timestamp
where a .to_e ='zach@g.com'
group by a.id





