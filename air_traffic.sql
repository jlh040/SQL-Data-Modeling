DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic;

CREATE TABLE flyers
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

CREATE TABLE airlines (
  id SERIAL PRIMARY KEY,
  name_of_airline TEXT UNIQUE NOT NULL
);

CREATE TABLE locations (
  id SERIAL PRIMARY KEY,
  country TEXT NOT NULL, -- This should probably be a separate table
  city TEXT UNIQUE NOT NULL
);

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline_id INT REFERENCES airlines(id),
  from_location_id INT REFERENCES locations(id),
  to_location_id INT REFERENCES locations(id)
);

CREATE TABLE flights_flyers (
  id SERIAL PRIMARY KEY,
  flyer_id INT REFERENCES flyers(id),
  flight_id INT REFERENCES flights(id),
  seat TEXT NOT NULL 
);


INSERT INTO flyers
  (first_name, last_name)
VALUES
  ('Jennifer', 'Finch'),
  ('Thadeus', 'Gathercoal'),
  ('Sonja', 'Pauley'),
  ('Jennifer', 'Finch'),
  ('Waneta', 'Skeleton'),
  ('Thadeus', 'Gathercoal'),
  ('Berkie', 'Wycliff'),
  ('Alvin', 'Leathes'),
  ('Berkie', 'Wycliff'),
  ('Cory', 'Squibbes');

INSERT INTO airlines
  (name_of_airline)
VALUES
  ('United'),
  ('British Airways'),
  ('Delta'),
  ('TUI Fly Belgium'),
  ('Air China'),
  ('American Airlines'),
  ('Avianca Brasil');

INSERT INTO locations
  (country, city)
VALUES
  ('United States', 'Seattle'), -- Look here how United States for instance is duplicated several times, that can cause problems
  ('United States', 'Washington DC'), -- , for instance, someone could write U.S. instead and the application would understand those as two different countries 
  ('United States', 'Chicago'), -- when the user's intention was the opposite
  ('United States', 'Las Vegas'),
  ('United States', 'Charlotte'),
  ('United States', 'Cedar Rapids'),
  ('United States', 'Los Angeles'),
  ('United States', 'New Orleans'),
  ('United States', 'New York'),
  ('United Kingdom', 'London'),
  ('Japan', 'Tokyo'),
  ('France', 'Paris'),
  ('China', 'Beijing'),
  ('Brazil', 'Sao Paolo'),
  ('Chile', 'Santiago'),
  ('Mexico', 'Mexico City'),
  ('Morocco', 'Casablanca'),
  ('UAE', 'Dubai');

INSERT INTO flights
  (departure, arrival, airline_id, from_location_id, to_location_id)
VALUES
  ('2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 2, 1),
  ('2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 10, 9),
  ('2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 7, 4),
  ('2018-04-15 16:50:00', '2018-04-15 21:00:00', 3, 1, 15),
  ('2018-08-01 18:30:00', '2018-08-01 21:50:00', 4, 11, 16),
  ('2018-10-31 01:15:00', '2018-10-31 12:55:00', 5, 17, 12), 
  ('2019-02-06 06:00:00', '2019-02-06 07:47:00', 1, 9, 5),
  ('2018-12-22 14:42:00', '2018-12-22 15:56:00', 6, 6, 3),
  ('2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 5, 8),
  ('2019-01-20 19:30:00', '2019-01-20 22:45:00', 7, 13, 14);

INSERT INTO flights_flyers
  (flyer_id, flight_id, seat)
VALUES
  (1, 10, '11B'),
  (5, 8, '6X'),
  (8, 7, '70N'),
  (4, 4, '20P'),
  (3, 3, '33B'),
  (7, 1, '65C'),
  (4, 9, '45V'),
  (3, 1, '15A'),
  (2, 2, '90D'),
  (10, 6, '80A');


-- Display the name of the flyer, along with their departure time and desination city
SELECT first_name, last_name, departure, city 
FROM flights_flyers 
JOIN flights ON flight_id = flights.id 
JOIN locations ON to_location_id = locations.id 
JOIN flyers ON flyer_id = flyers.id;
