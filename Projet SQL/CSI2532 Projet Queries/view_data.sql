CREATE OR REPLACE VIEW Vue_Capacite_Hotel AS
SELECT 
    h.ID_Hotel,
    h.Nom_Hotel,
    SUM(c.Capacite) AS Capacite_Totale
FROM Hotel h
JOIN Chambre c ON h.ID_Hotel = c.ID_Hotel
GROUP BY h.ID_Hotel, h.Nom_Hotel;
SELECT * FROM Vue_Capacite_Hotel ORDER BY id_hotel;