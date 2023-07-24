CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

CREATE TABLE Persons_Track(
id INT,Updated_at DATETIME);

drop trigger abc;
CREATE TRIGGER abc
AFTER INSERT ON persons
FOR EACH ROW
INSERT INTO Persons_track
SET id = neW.Personid,
Updated_at = NOW();

INSERT INTO Persons VALUES(1,'qwerty','zxcvb','poiuy','hjkl');

select * from persons_track;