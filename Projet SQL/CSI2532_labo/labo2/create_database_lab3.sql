SET search_path = "labo3"

CREATE TABLE Departement(
IDDepartement INTEGER,
nom VARCHAR(255),
PRIMARY KEY (IDDepartement);

CREATE TABLE Employe(
NAS INTEGER,
Salaire INTEGER,
prenom VARCHAR(255),
NomFamille VARCHAR(255),
NoCivic INTEGER,
Rue VARCHAR(255),
CodePostal VARCHAR(6),
Ville VARCHAR(255),
IDDepartement INTEGER,
PRIMARY KEY (NAS),
FOREIGN KEY(IDDepartement),
REFERENCES Departement);

CREATE TABLE Projets(
IDProjet INTEGER,
nom VARCHAR(255),
IDDepartement INTEGER,
PRIMARY KEY (IDProjet),
FOREIGN KEY(IDDepartement),
REFERENCES Departement);


CREATE TABLE TravailleProjet(
NAS INTEGER,
IDProjet INTEGER,
Heures INTEGER,
PRIMARY KEY (NAS),
PRIMARY KEY (IDProjet),
FOREIGN KEY(NAS),
REFERENCES Employe),
FOREIGN KEY(IDProjet),
REFERENCES Projets);