-- ==============================
-- Drop Tables to Avoid Conflicts
-- ==============================
DROP TABLE IF EXISTS Archive;
DROP TABLE IF EXISTS Chambre;
DROP TABLE IF EXISTS Employes;
DROP TABLE IF EXISTS Hotel_Telephones;
DROP TABLE IF EXISTS Hotel_Courriels;
DROP TABLE IF EXISTS Hotel;
DROP TABLE IF EXISTS Chaine_Hoteliere_Telephones;
DROP TABLE IF EXISTS Chaine_Hoteliere_Courriels;
DROP TABLE IF EXISTS Chaine_Hoteliere;
DROP TABLE IF EXISTS Clients;

-- ==============================
-- Table : Chaine_Hoteliere
-- ==============================
CREATE TABLE Chaine_Hoteliere (
    ID_Chaine SERIAL PRIMARY KEY,
    Nom_Chaine VARCHAR(100) NOT NULL,
    Classification NUMERIC(2,1) CHECK (Classification >= 1 AND Classification <= 5),
    Adresse_Bureaux_Centraux VARCHAR(255) NOT NULL,
    Nombre_Hotels INTEGER CHECK (Nombre_Hotels >= 0)
);

-- ==============================
-- Table : Chaine_Hoteliere_Courriels
-- ==============================
CREATE TABLE Chaine_Hoteliere_Courriels (
    ID_Chaine INTEGER,
    Courriel VARCHAR(100),
    PRIMARY KEY (ID_Chaine, Courriel),
    FOREIGN KEY (ID_Chaine) REFERENCES Chaine_Hoteliere(ID_Chaine) ON DELETE CASCADE
);

-- ==============================
-- Table : Chaine_Hoteliere_Telephones
-- ==============================
CREATE TABLE Chaine_Hoteliere_Telephones (
    ID_Chaine INTEGER,
    Telephone VARCHAR(15),
    PRIMARY KEY (ID_Chaine, Telephone),
    FOREIGN KEY (ID_Chaine) REFERENCES Chaine_Hoteliere(ID_Chaine) ON DELETE CASCADE
);

-- ==============================
-- Table : Hotel
-- ==============================
CREATE TABLE Hotel (
    ID_Hotel SERIAL PRIMARY KEY,
    Nom_Hotel VARCHAR(100) NOT NULL,
    Classification NUMERIC(2,1) CHECK (Classification >= 1 AND Classification <= 5),
    Adresse_Hotel VARCHAR(255) NOT NULL,
    Nombre_de_chambres INTEGER CHECK (Nombre_de_chambres >= 0),
    ID_Chaine INTEGER,
    NAS_Directeur CHAR(9),
    Nom_Directeur VARCHAR(100),
    Adresse_Directeur VARCHAR(255),
    FOREIGN KEY (ID_Chaine) REFERENCES Chaine_Hoteliere(ID_Chaine) ON DELETE CASCADE
);

-- ==============================
-- Table : Hotel_Courriels
-- ==============================
CREATE TABLE Hotel_Courriels (
    ID_Hotel INTEGER,
    Courriel VARCHAR(100),
    PRIMARY KEY (ID_Hotel, Courriel),
    FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel) ON DELETE CASCADE
);

-- ==============================
-- Table : Hotel_Telephones
-- ==============================
CREATE TABLE Hotel_Telephones (
    ID_Hotel INTEGER,
    Telephone VARCHAR(15),
    PRIMARY KEY (ID_Hotel, Telephone),
    FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel) ON DELETE CASCADE
);

-- ==============================
-- Table : Employes
-- ==============================
CREATE TABLE Employes (
    NAS CHAR(9) PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Adresse VARCHAR(255) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    ID_Hotel INTEGER,
    FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel) ON DELETE CASCADE
);

-- ==============================
-- Table : Chambre
-- ==============================
CREATE TABLE Chambre (
    Numero_Chambre INTEGER,
    ID_Hotel INTEGER,
    Prix_par_nuit DECIMAL(8, 2) CHECK (Prix_par_nuit > 0),
    Commodites TEXT,
    Capacite INTEGER CHECK (Capacite > 0),
    Vue VARCHAR(20) CHECK (Vue IN ('mer', 'montagne', 'forêt', 'océan', 'aucune')),
    Etendues BOOLEAN,
    Problemes TEXT,
    PRIMARY KEY (Numero_Chambre, ID_Hotel),
    FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel) ON DELETE CASCADE
);

-- ==============================
-- Table : Clients
-- ==============================
CREATE TABLE Clients (
    NAS CHAR(9) PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Adresse VARCHAR(255) NOT NULL,
    Date_Enregistrement DATE NOT NULL
);

-- ==============================
-- Table : Archive
-- ==============================
CREATE TABLE Archive (
    Date_de_debut DATE,
    Date_de_fin DATE,
    Enregistrement VARCHAR(20) CHECK (Enregistrement IN ('location', 'reservation')),
    NAS_Employes CHAR(9),
    NAS_Client CHAR(9) NOT NULL,
    ID_Hotel INTEGER,
    Numero_Chambre INTEGER,
    PRIMARY KEY (Date_de_debut, ID_Hotel, Numero_Chambre),
    FOREIGN KEY (NAS_Employes) REFERENCES Employes(NAS) ON DELETE SET NULL,
    FOREIGN KEY (NAS_Client) REFERENCES Clients(NAS) ON DELETE CASCADE,
    FOREIGN KEY (ID_Hotel, Numero_Chambre) REFERENCES Chambre(ID_Hotel, Numero_Chambre) ON DELETE SET NULL
);


