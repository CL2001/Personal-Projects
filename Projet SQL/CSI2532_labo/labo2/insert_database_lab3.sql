SET search_path = "labo3";

-- Insert into Departement
INSERT INTO Departement (IDDepartement, nom) VALUES 
(1, 'Informatique'),
(2, 'Marketing'),
(3, 'Ressources Humaines');

-- Insert into Employe
INSERT INTO Employe (NAS, Salaire, prenom, NomFamille, NoCivic, Rue, CodePostal, Ville, IDDepartement) VALUES 
(1001, 60000, 'Alice', 'Dubois', 123, 'Rue Principale', 'H1A1A1', 'Montréal', 1),
(1002, 55000, 'Bob', 'Lemoine', 456, 'Avenue des Pins', 'H2B2B2', 'Québec', 2),
(1003, 70000, 'Charlie', 'Bernard', 789, 'Boulevard René', 'H3C3C3', 'Laval', 1),
(1004, 48000, 'David', 'Tremblay', 101, 'Chemin Vert', 'H4D4D4', 'Gatineau', 3),
(1005, 52000, 'Emma', 'Roy', 202, 'Place du Marché', 'H5E5E5', 'Sherbrooke', 2),
(1006, 75000, 'Felix', 'Gagnon', 303, 'Rue Saint-Denis', 'H6F6F6', 'Trois-Rivières', 1),
(1007, 62000, 'Gabrielle', 'Morin', 404, 'Avenue Laurier', 'H7G7G7', 'Saguenay', 2),
(1008, 58000, 'Hugo', 'Pelletier', 505, 'Rue Wellington', 'H8H8H8', 'Longueuil', 3),
(1009, 67000, 'Isabelle', 'Fortin', 606, 'Chemin du Lac', 'H9I9I9', 'Drummondville', 1),
(1010, 53000, 'Jean', 'Bouchard', 707, 'Boulevard Taschereau', 'H1J1J1', 'Lévis', 3);

-- Insert into Projets
INSERT INTO Projets (IDProjet, nom, IDDepartement) VALUES 
(201, 'Développement Web', 1),
(202, 'Application Mobile', 1),
(203, 'Refonte Site Web', 1),
(204, 'Campagne Publicitaire', 2),
(205, 'Stratégie SEO', 2),
(206, 'Formation RH', 3),
(207, 'Recrutement 2025', 3),
(208, 'Optimisation ERP', 1),
(209, 'Étude de Marché', 2),
(210, 'Automatisation RH', 3);

-- Insert into TravailleProjet
INSERT INTO TravailleProjet (NAS, IDProjet, Heures) VALUES 
(1001, 201, 10),
(1001, 202, 15),
(1002, 204, 20),
(1002, 205, 12),
(1003, 201, 18),
(1003, 208, 22),
(1004, 206, 16),
(1004, 207, 14),
(1005, 204, 10),
(1005, 209, 8),
(1006, 202, 25),
(1007, 205, 13),
(1008, 210, 17),
(1009, 203, 19),
(1010, 206, 21);
