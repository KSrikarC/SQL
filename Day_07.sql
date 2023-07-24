CREATE TABLE emp_data (
    emp_id INT,
    emp_name VARCHAR(50)
);

CREATE TABLE emp_trigger (
    id INT,
    name VARCHAR(50),
    action VARCHAR(50),
    log_time DATETIME
);

DROP TRIGGER TRACK_EMP_UPDATES;

CREATE TRIGGER TRACK_EMP_UPDATES
BEFORE UPDATE ON emp_data
FOR EACH ROW
INSERT INTO emp_trigger
SET action = 'data_modified',
id = OLD.emp_id,
name = OLD.emp_name,
log_time = NOW();

DROP TRIGGER TRACK_EMP_DELETES;
CREATE TRIGGER TRACK_EMP_DELETES 
BEFORE DELETE ON emp_data
FOR EACH ROW
INSERT INTO emp_trigger
SET action = 'data_deleted',
id = OLD.emp_id,
name = OLD.emp_name,
log_time = NOW();

DROP TRIGGER TRACK_EMP_INSERTS;

CREATE TRIGGER TRACK_EMP_INSERTS 
BEFORE INSERT ON emp_data
FOR EACH ROW
INSERT INTO emp_trigger
SET action = 'data_inserted',
id = NEW.emp_id,
name = NEW.emp_name,
log_time = NOW();

INSERT INTO emp_data () VALUES (301,'Steve');

SELECT * from emp_data;

DELETE FROM emp_data
WHERE emp_id = 169;

UPDATE emp_data
SET emp_id = 169
WHERE emp_name = 'natasha';

SELECT * from emp_trigger;

-- -----------------------------------------------------------------------------------------------

CREATE TABLE birthdays (name varchar(20), DOB date);

CREATE TABLE messages(message VARCHAR(255));

DROP TRIGGER UPDATE_NULL_DOBS;

INSERT INTO birthdays Values('Srikar',NULL);

DELIMITER $$
CREATE TRIGGER UPDATE_NULL_DOBS
AFTER INSERT ON birthdays
FOR EACH ROW
	BEGIN
		IF NEW.DOB IS NULL THEN			
			-- UPDATE birthdays SET DOB = '2002-07-29' WHERE name = new.Name;
			INSERT INTO messages VALUES(concat("HI ",NEW.name,' YOU HAVE ENTERED INCORRECT D.O.B'));
		END IF;
	END $$
DELIMITER ;

    
SELECT * from Messages;

DROP TABLE Bikes;

CREATE TABLE Bikes( Name VARCHAR(20) ,
					Price FLOAT , 
                    Quantity INT,
                    CHECK (length(name) > 1 and length(Name)<15));
                    
DROP TRIGGER BU_INSERT_IDENTIFIER;

DELIMITER !!
CREATE TRIGGER BU_INSERT_IDENTIFIER                    
BEFORE INSERT ON Bikes
FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);
    SET msg = CONCAT('THE ENTERED NAME SHOULD BE WITHIN 15 CHARACTERS ONLY',
					' YOU HAVE ENTERED ',length(NEW.name),' CHARACTERS');
	IF length(NEW.name) > 10 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	END IF;
END !!
DELIMITER ;

INSERT INTO Bikes VALUES('YAMAHA FZ2 500CC ',20000,7);
SELECT * FROM BIKES;


create table passwords(pwd varchar(30));
create table passwords_track(messages Varchar(255));

drop trigger ONE_;

DELIMITER 1
CREATE TRIGGER ONE_
BEFORE INSERT ON passwords
FOR EACH ROW
BEGIN
	INSERT INTO Passwords_track VALUES('Password inserted !! (Message from trigger 1)');
END 1



DELIMITER 1
CREATE TRIGGER TWO_ 
BEFORE INSERT ON passwords
FOR EACH ROW
FOLLOWS ONE_
BEGIN
	INSERT INTO Passwords_track VALUES('Password inserted !! (Message from trigger 2)');
END 1

DELIMITER ;


insert into passwords VALUES('NEW PASSWORD');

select * from passwords_track;

TRUNCATE PASSWORDs_TRACK;
-- -------------------------------------------------------------------------------------
SELECT TRIGGER_NAME, ACTION_ORDER FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'c361cohort'
ORDER BY EVENT_OBJECT_TABLE,
ACTION_TIMING,
EVENT_MANIPULATION;
-- ---------------------------------------------------------------------------------------------

create table stocks(symbol VARCHAR(20) PRIMARY KEY);

CALL Insert_Stocks('NSE');

-- -------------------------------------------------------------------

CREATE TABLE student_marks (
    STUDENT_ID INT,
    NAME VARCHAR(50),
    SUB1 INT,
    SUB2 INT,
    SUB3 INT,
    SUB4 INT,
    SUB5 INT,
    TOTAL INT,
    PER_MARKS DECIMAL(5,2),
    GRADE VARCHAR(2)
);

DELIMITER $$
CREATE TRIGGER ST_MARKS_UPDATE
BEFORE INSERT ON student_marks
FOR EACH ROW
BEGIN
	INSERT INTO student_marks(total)
    VALUES (new.sub1+new.sub2+new.sub3+new.sub4+new.sub5);
END $$
DELIMITER ;

INSERT INTO student_marks (STUDENT_ID, NAME, SUB1, SUB2, SUB3, SUB4, SUB5)
VALUES
    (1, 'John', 80, 75, 90, 85, 95);










