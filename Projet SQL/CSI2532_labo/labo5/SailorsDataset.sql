-------------------------------------------------------------
-- cs3200 Database design
-- v180121
-- Database instance and query from Ramakrishnan, Gehrke: Database management systems, 2nd ed (2000)
-------------------------------------------------------------

-------------------------
-- Drop tables if they already exist
-------------------------

DO $$
BEGIN
    IF EXISTS (SELECT * FROM information_schema.tables 
               WHERE table_name = 'reserves') THEN
       DROP TABLE Reserves;
    END IF;
    IF EXISTS (SELECT * FROM information_schema.tables 
               WHERE table_name = 'sailors') THEN
       DROP TABLE Sailors;
    END IF;
    IF EXISTS (SELECT * FROM information_schema.tables 
               WHERE table_name = 'boats') THEN
       DROP TABLE Boats;
    END IF;
END $$;


-------------------------
-- Create the tables
-------------------------

CREATE TABLE Sailors ( 
    sid int PRIMARY KEY, 
    sname varchar(20), 
    rating int, 
    age float
); 

CREATE TABLE Boats ( 
    bid int PRIMARY KEY, 
    bname varchar(20), 
    color varchar(20)
); 

CREATE TABLE Reserves ( 
    sid int, 
    bid int, 
    day date, 
    PRIMARY KEY (sid, bid, day), 
    FOREIGN KEY (sid) REFERENCES Sailors(sid), 
    FOREIGN KEY (bid) REFERENCES Boats(bid)
); 


---------------------------
-- Populate the tables
---------------------------

INSERT INTO Sailors VALUES (22, 'Dustin', 7, 45.0); 
INSERT INTO Sailors VALUES (29, 'Brutus', 1, 33.0); 
INSERT INTO Sailors VALUES (31, 'Lubber', 8, 55.0); 
INSERT INTO Sailors VALUES (32, 'Andy', 8, 25.0); 
INSERT INTO Sailors VALUES (58, 'Rusty', 10, 35.0); 
INSERT INTO Sailors VALUES (64, 'Horatio', 7, 35.0); 
INSERT INTO Sailors VALUES (71, 'Zorba', 10, 16.0); 
INSERT INTO Sailors VALUES (74, 'Horatio', 9, 35.0); 
INSERT INTO Sailors VALUES (85, 'Art', 3, 25.5); 
INSERT INTO Sailors VALUES (95, 'Bob', 3, 63.5); 

INSERT INTO Boats VALUES (101, 'Interlake', 'blue'); 
INSERT INTO Boats VALUES (102, 'Interlake', 'red'); 
INSERT INTO Boats VALUES (103, 'Clipper', 'green'); 
INSERT INTO Boats VALUES (104, 'Marine', 'red'); 

INSERT INTO Reserves VALUES (22, 101, '1998-10-10'); 
INSERT INTO Reserves VALUES (22, 102, '1998-10-10'); 
INSERT INTO Reserves VALUES (22, 103, '1998-10-08'); 
INSERT INTO Reserves VALUES (22, 104, '1998-10-07'); 
INSERT INTO Reserves VALUES (31, 102, '1998-11-10'); 
INSERT INTO Reserves VALUES (31, 103, '1998-11-06'); 
INSERT INTO Reserves VALUES (31, 104, '1998-11-12'); 
INSERT INTO Reserves VALUES (64, 101, '1998-09-05'); 
INSERT INTO Reserves VALUES (64, 102, '1998-09-08'); 
INSERT INTO Reserves VALUES (74, 103, '1998-09-08');
