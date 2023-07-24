drop table movies;

create table moviees(movie_id int primary key auto_increment,movie_name varchar(30),release_date date, 
user_rating float, gener varchar(200), 
movie_status ENUM('released','post production'),movie_language varchar(30),budget_cr double);

insert into moviees(movie_name,release_date,user_rating,gener,movie_status,movie_language,budget_cr) values
('Avatar','2009-12-17',7.6,'Action, Adventure, Fantasy, Science Fiction','Released','English',237000000.0),
('John Wick: Chapter 2','2017-05-18',7.3,'Action, Thriller, Crime','Released','English',40000000.0),
('The Whale', '2023-02-02', 8.1, 'Drama','Released','English',3000000.0),
('Thor: Love and Thunder','2022-07-06',6.6,'Fantasy, Action, Comedy','Released','English',250000000.0),
("Suro",'2022-02-12', 7.3,"Thriller,Drama","released","chinese",1182000000.0),
("Fall",'2022-09-22',7.3,"Thriller,Drama","released","English",3000000.0),
("Terrifier 2",'2022-10-28',6.9,"Horror","released","English",2500000.0),
('Pulp Fiction', '2008-10-14',7.0, 'Crime', 'released', 'English', 2500000.5),
('Fight Club', '2010-10-15', 9.2, 'Drama', 'released', 'English', 3100000.0),
('Parasite', '2019-05-21', 8.3, 'Thriller', 'released', 'Korean', 4500000.4),
('Amélie', '2014-04-25', 8.0, 'Romantic Comedy', 'released', 'French', 4900000.5),
('Crouching Tiger, Hidden Dragon', '2012-05-20', 6.8, 'Action', 'released', 'Mandarin', 5150000.5),
('Life is Beautiful', '2004-12-20', 7.4, 'Drama', 'released', 'Italian', 5580000.0),
('City of God', '2002-08-30', 6.2, 'Crime', 'released', 'Portuguese', 5250000.3),
('Pans Labyrinth', '2006-10-15', 8.2, 'Fantasy', 'released', 'Spanish', 1340000.0),
  ('The Intouchables', '2011-11-02', 8.5, 'Comedy-Drama', 'released', 'French', 1500000.0),
  ('Rashomon', '2003-08-26', 8.2, 'Mystery', 'post production', 'Japanese', 3200000.5),
  ('A Separation', '2011-03-16', 8.3, 'Drama', 'post production', 'Persian', 2480000.0),
  ('City Lights', '1931-03-07', 8.5, 'Romantic Comedy-Drama', 'post production', 'Silent', 8000000.25);
  
select * from moviees;

-- How many movies have been released in each language?
SELECT movie_language, COUNT(*) AS total_movies
FROM moviees
WHERE movie_status = 'released'
GROUP BY movie_language;

-- Which movie genre has the highest number of released movies with a user rating above 8.0?
SELECT gener, COUNT(*) AS total_movies
FROM moviees
WHERE movie_status = 'released' AND user_rating > 8.0
GROUP BY gener
ORDER BY total_movies DESC
LIMIT 1;

-- List all movies released in the same year as the movie "Avatar" along with their genres.
SELECT m2.movie_name, m2.gener
FROM moviees m1
JOIN moviees m2 ON YEAR(m1.release_date) = YEAR(m2.release_date)
WHERE m1.movie_name = 'Avatar';


SELECT m.release_year, m.highest_rating, mo.movie_name
FROM (
  SELECT YEAR(release_date) AS release_year, MAX(user_rating) AS highest_rating
  FROM moviees
  GROUP BY YEAR(release_date)
) AS m
JOIN moviees AS mo ON YEAR(mo.release_date) = m.release_year AND mo.user_rating = m.highest_rating;

-- retrive the count of movies released in each year
select year(release_date) AS release_year, COUNT(*) AS movie_count FROM moviees 
GROUP BY release_year
order by release_year asc;

-- retrive total budget of movies in each gener
select gener, SUM(budget_cr) AS total_budget FROM moviees GROUP BY gener;

-- query to find best film in a category based on user rating
select gener, movie_name, user_rating
from moviees
where (gener, user_rating) IN (
    select gener, MAX(user_rating)
    from moviees
    group by gener
);


-- query to find the budget of movies befor 2010 and and after
select
    case
        when release_date < '2010-01-01' THEN 'Before 2010'
        when release_date >= '2010-01-01' THEN 'After 2010'
    end as year_released,
    sum(budget_cr) as total_budget
from moviees
group by year_released;

-- query to find the average budget based on language
SELECT movie_language, AVG(budget_cr) AS average_budget
FROM moviees
GROUP BY movie_language;

-- Which movie genre has the highest average user rating among movies with a budget above 10 crores?
select gener,avg(user_rating) as avg_user_rating 
from moviees where budget_cr>10.0e7 
group by gener order by avg_user_rating 
desc limit 1;

-- What is the highest budget among movies in the 'Action' genre?
select max(budget_cr) as highest_budget from moviees where gener = 'Action';
