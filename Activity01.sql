-- Create the Subjects table
CREATE TABLE Subjects (
  subject_name VARCHAR(30) 
);

-- Insert data into the Subjects table
INSERT INTO Subjects (subject_name)
VALUES
  ('Math'),
  ('Physics'),
  ('Programming');

-- Create the Examinations table
CREATE TABLE Examinations (
  student_id INT NOT NULL,
  subject_name VARCHAR(255) NOT NULL
);

-- Insert data into the Examinations table
INSERT INTO Examinations (student_id, subject_name)
VALUES
  (1, 'Math'),
  (1, 'Physics'),
  (1, 'Programming'),
  (2, 'Programming'),
  (1, 'Physics'),
  (1, 'Math'),
  (13, 'Math'),
  (13, 'Programming'),
  (13, 'Physics'),
  (2, 'Math'),
  (1, 'Math');


INSERT INTO customer_data (customer_id, name, visited_on, amount)
VALUES
  (1, 'Jhon', '2019-01-01', 100),
  (2, 'Daniel', '2019-01-02', 110),
  (3, 'Jade', '2019-01-03', 120),
  (4, 'Khaled', '2019-01-04', 130),
  (5, 'Winston', '2019-01-05', 110),
  (6, 'Elvis', '2019-01-06', 140),
  (7, 'Anna', '2019-01-07', 150),
  (8, 'Maria', '2019-01-08', 80),
  (9, 'Jaze', '2019-01-09', 110),
  (1, 'Jhon', '2019-01-10', 130),
  (3, 'Jade', '2019-01-10', 150);
  
  SELECT a.visited_on, SUM(b.amount) AS Total_Amt, 
  AVG(b.amount) AS Rolling_Avg FROM
  customer a JOIN customer b
  ON a.visited_on <= b.visited_on + 6 
  AND a.visited_on >= b.visited_on
  GROUP BY a.visited_on ORDER BY visited_on;
  
  
  WITH A AS
(SELECT DepartmentId, Employee.Name, Salary, DENSE_RANK() 
OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS Ranking
FROM Employee)
SELECT Department.name AS DepartmentName, 
A.Name as Employee, Salary FROM A
JOIN Department ON A.departmentid = Department.id
WHERE Ranking <= 3;

-- ------------------------------------------------------------------------------

WITH A AS  
(SELECT * FROM movie_rating WHERE MONTH(created_at) = 02),
B AS
(SELECT movie_id, AVG(rating) AS Month_Avg FROM A 
GROUP BY movie_id)
SELECT title FROM Movies JOIN B ON Movies.movie_id = B.movie_id
WHERE Month_Avg = (SELECT MAX(Month_Avg) FROM B) ORDER BY title
LIMIT 1;


-- ------------------------------------------------------------------------------


