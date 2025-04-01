-- Create the artists table
CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

-- Create the albums table with a foreign key to artists
CREATE TABLE albums (
    album_id SERIAL PRIMARY KEY,
    artist_id INTEGER REFERENCES artists(artist_id),
    title VARCHAR(100) NOT NULL,
    release_year INTEGER
);

-- Create the tracks table with a foreign key to albums
CREATE TABLE tracks (
    track_id SERIAL PRIMARY KEY,
    album_id INTEGER REFERENCES albums(album_id),
    title VARCHAR(100) NOT NULL,
    duration INTEGER  -- duration in seconds
);
