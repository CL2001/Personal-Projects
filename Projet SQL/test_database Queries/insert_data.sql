-- Insert sample artists
INSERT INTO artists (name, country) VALUES
    ('The Beatles', 'UK'),
    ('Pink Floyd', 'UK'),
    ('Miles Davis', 'USA');

-- Insert sample albums (assumes artists inserted in order)
INSERT INTO albums (artist_id, title, release_year) VALUES
    (1, 'Abbey Road', 1969),
    (1, 'Sgt. Pepper''s Lonely Hearts Club Band', 1967),
    (2, 'The Dark Side of the Moon', 1973),
    (2, 'Wish You Were Here', 1975),
    (3, 'Kind of Blue', 1959);

-- Insert sample tracks (assumes albums are assigned sequential album_ids)
INSERT INTO tracks (album_id, title, duration) VALUES
    (1, 'Come Together', 259),
    (1, 'Something', 182),
    (2, 'Lucy in the Sky with Diamonds', 208),
    (2, 'A Day in the Life', 337),
    (3, 'Money', 382),
    (3, 'Time', 412),
    (4, 'Shine On You Crazy Diamond', 810),
    (4, 'Welcome to the Machine', 452),
    (5, 'So What', 545),
    (5, 'Freddie Freeloader', 589);
