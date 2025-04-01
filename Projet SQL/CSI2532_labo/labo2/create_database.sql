--Identifie laboratoires comme le schemas utilisé
SET search_path = "laboratoires";

--Créé la table Artist
CREATE TABLE Artist (
AName VARCHAR(20),
Birthplace VARCHAR(20),
Style VARCHAR(20),
DateOfBirth DATE,
PRIMARY KEY (AName)
);

--Créé la table Artwork
CREATE TABLE Artwork(
Title VARCHAR(20),
Year INTEGER,
Type VARCHAR(20),
Price NUMERIC(8,2),
AName VARCHAR(20),
PRIMARY KEY (Title),
FOREIGN KEY(AName)
REFERENCES Artist); 

--Créé la table Customer
CREATE TABLE Customer(
CustId INTEGER,
Name VARCHAR(20),
Address VARCHAR(20),
Amount NUMERIC(8,2),
PRIMARY KEY (CustId));

--Créé la table LikeArtist
CREATE TABLE LikeArtist(
CustId INTEGER,
AName VARCHAR(20),
PRIMARY KEY(Aname,
CustId),
FOREIGN KEY (Aname)
REFERENCES Artist,
FOREIGN KEY (CustId)
REFERENCES Customer);


--Insert des info dans la table Artist
INSERT INTO Artist (AName, Birthplace, Style, DateOfBirth)
VALUES ('Caravaggio', 'Milan', 'Baroque', '1571-09-28');

INSERT INTO Artist (AName, Birthplace, Style, DateOfBirth)
VALUES ('Smith', 'Ottawa', 'Modern', '1977-12-12');

INSERT INTO Artist (AName, Birthplace, Style, DateOfBirth)
VALUES ('Picasso', 'Malaga', 'Cubism', '1881-10-25');


--Insert des info dans la table Artwork
INSERT INTO Artwork (Title, Year, Type, Price, AName)
VALUES ('Blue', 2000, 'Modern', 10000.00, 'Smith');

INSERT INTO Artwork (Title, Year, Type, Price, AName)
VALUES ('The Cardsharps', 1594, 'Baroque', 40000.00, 'Caravaggio');

--Insert des info dans la table Customer
INSERT INTO Customer (CustId, Name, Address, Amount)
VALUES (1, 'John', 'Ottawa', 8.5);

INSERT INTO Customer (CustId, Name, Address, Amount)
VALUES (2, 'Amy', 'Orleans', 9.0);

INSERT INTO Customer (CustId, Name, Address, Amount)
VALUES (3, 'Peter', 'Gatineau', 6.3);


