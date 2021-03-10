DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE stars (
  id SERIAL PRIMARY KEY,
  name_of_star TEXT UNIQUE NOT NULL
);

CREATE TABLE galaxies (
  id SERIAL PRIMARY KEY,
  name_of_galaxy TEXT UNIQUE NOT NULL
);

CREATE TABLE planets (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  star_orbit_id INT REFERENCES stars(id),
  galaxy_id INT REFERENCES galaxies(id)
);

CREATE TABLE moons (
  id SERIAL PRIMARY KEY,
  name_of_moon TEXT UNIQUE NOT NULL,
  planet_id INT REFERENCES planets(id)
);

CREATE TABLE planet_moon (
  id SERIAL PRIMARY KEY,
  planet_id INT REFERENCES planets(id),
  moon_id INT REFERENCES moons(id)
);

INSERT INTO stars
  (name_of_star)
VALUES
  ('The Sun'),
  ('Proxima Centauri'),
  ('Gliese 876');

INSERT INTO galaxies
  (name_of_galaxy)
VALUES
  ('milky way');

INSERT INTO planets
  (name, orbital_period_in_years, star_orbit_id, galaxy_id)
VALUES
  ('Earth', 1.00, 1, 1),
  ('Mars', 1.88, 1, 1),
  ('Venus', 0.62, 1, 1),
  ('Neptune', 164.8, 1, 1),
  ('Proxima Centauri b', 0.03, 2, 1),
  ('Gliese 876 b', 0.23, 3, 1);

INSERT INTO moons
  (name_of_moon, planet_id)
VALUES
  ('Naiad', 4), 
  ('Thalassa', 4), 
  ('Despina', 4), 
  ('Galatea', 4), 
  ('Larissa', 4), 
  ('S/2004 N 1', 4),
  ('Proteus', 4), 
  ('Triton', 4), 
  ('Nereid', 4), 
  ('Halimede', 4), 
  ('Sao', 4), 
  ('Laomedeia', 4), 
  ('Psamathe', 4), 
  ('Neso', 4),
  ('The Moon', 1),
  ('Phobos', 2),
  ('Deimos', 2);
