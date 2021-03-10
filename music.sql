DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music;

CREATE TABLE albums
(
  id SERIAL PRIMARY KEY,
  name_of_album TEXT NOT NULL
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  album_id INT REFERENCES albums(id)
);

CREATE TABLE artists
(
  id SERIAL PRIMARY KEY,
  name_of_artist TEXT NOT NULL
);

CREATE TABLE producers
(
  id SERIAL PRIMARY KEY,
  name_of_producer TEXT NOT NULL
);

CREATE TABLE artists_songs
(
  id SERIAL PRIMARY KEY,
  artist_id INT REFERENCES artists(id),
  song_id INT REFERENCES songs(id)
);

CREATE TABLE songs_producers
(
  id SERIAL PRIMARY KEY,
  song_id INT REFERENCES songs(id),
  producer_id INT REFERENCES producers(id)
);

INSERT INTO albums
  (name_of_album)
VALUES
  ('boogie nights'),
  ('a land of dance'),
  ('one night in ibiza'),
  ('movies like jagger'),
  ('complicated'),
  ('a land before time');

INSERT INTO songs
    (title, duration_in_seconds, release_date, album_id)
  VALUES
    ('MMMBop', 238, '04-15-1997', 2),
    ('Bohemian Rhapsody', 355, '10-31-1975', 1),
    ('One Sweet Day', 282, '11-14-1995', 4),
    ('Shallow', 216, '09-27-2018', 5),
    ('How You Remind Me', 223, '08-21-2001', 2),
    ('New York State of Mind', 276, '10-20-2009', 6),
    ('Dark Horse', 215, '12-17-2013', 3),
    ('Moves Like Jagger', 201, '06-21-2011', 2),
    ('Complicated', 244, '05-14-2002', 1),
    ('Say My Name', 240, '11-07-1999', 5);

INSERT INTO artists
  (name_of_artist)
VALUES
  ('alicia keys'),
  ('madonna'),
  ('tiesto'),
  ('mick jagger'),
  ('avril lavigne'),
  ('deestiny''s child');

INSERT INTO producers
  (name_of_producer)
VALUES
  ('darkchild'),
  ('liza minelli'),
  ('the producer trio'),
  ('DJ produce me'),
  ('Max martin');

INSERT INTO artists_songs
  (artist_id, song_id)
VALUES
  (1, 4),
  (6, 8),
  (6, 3),
  (2, 5),
  (3, 10),
  (4, 4),
  (5, 7),
  (4, 9),
  (3, 1);

INSERT INTO songs_producers
  (song_id, producer_id)
VALUES
  (1, 4),
  (3, 1),
  (9, 4),
  (10, 3),
  (7, 2),
  (6, 5),
  (8, 3),
  (5, 3);

  -- Display the title of the songs, and artists for songs on 'A land of dance'.
  SELECT songs.title, name_of_artist
  FROM artists_songs JOIN songs ON songs.id = artists_songs.song_id
  JOIN artists ON artists.id = artists_songs.artist_id
  WHERE album_id IN (SELECT id FROM albums WHERE name_of_album = 'a land of dance');