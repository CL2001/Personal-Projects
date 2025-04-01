/*
This query joins the tables to list each album with its artist, 
release year, number of tracks, and total duration (both in seconds 
and converted to minutes). It filters out albums with a total duration of 
10 minutes or less and orders the results by album length in descending order.
*/

SELECT 
    ar.name AS artist,
    a.title AS album,
    a.release_year,
    COUNT(t.track_id) AS track_count,
    SUM(t.duration) AS total_duration_seconds,
    ROUND(SUM(t.duration) / 60.0, 2) AS total_duration_minutes
FROM albums a
JOIN artists ar ON a.artist_id = ar.artist_id
JOIN tracks t ON a.album_id = t.album_id
GROUP BY a.album_id, ar.artist_id
HAVING SUM(t.duration) > 600  -- Only include albums longer than 10 minutes
ORDER BY total_duration_seconds DESC;
