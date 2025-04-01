--Identifie laboratoires comme le schemas utilisé
SET search_path = "laboratoires";

--Selectionne tous les attributs de l'artiste ou Aname = Smith
--SELECT * FROM Artist WHERE AName = 'Smith';

--Selectionne l'attribut style de l'artiste ou Aname = Smith
--SELECT Style FROM Artist WHERE AName = 'Smith';

--Selectionne tous les artiste née à Ottawa
--SELECT AName FROM Artist WHERE Birthplace = 'Ottawa';

--Selectionne tous les titres et prix des oeuvres peint en 2000
--SELECT Title, Price FROM Artwork WHERE Year = '2000'

--Mets à jour le nom du client 1 pour Bruce
--UPDATE Customer SET Name = 'Bruce' WHERE CustID = 1;
--SELECT * FROM Customer;

--Met à jour la valeur de amount pour 9.3 à tous les customer de Gatineau
--UPDATE Customer SET amount = 9.3 WHERE address = 'Gatineau';
--SELECT * FROM Customer;

--Efface Smith de notre base de données (Ceci ne peut pas être fait car Smith appa
-- apparait dans la base de donné artwork comme clé étrangère)
--DELETE FROM Artist WHERE AName = 'Smith';
--SELECT * FROM Artist;
