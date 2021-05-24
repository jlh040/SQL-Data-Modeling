DROP DATABASE IF EXISTS sports_league;

CREATE DATABASE sports_league;

\c sports_league;

CREATE TABLE stadiums (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    home_stadium_id INT REFERENCES stadiums(id)
);

CREATE TABLE coaches (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE coaches_teams (
    id SERIAL PRIMARY KEY,
    coach_id INT REFERENCES coaches,
    team_id INT REFERENCES teams
);

CREATE TABLE players_teams (
    id SERIAL PRIMARY KEY,
    player_id INT REFERENCES players,
    team_id INT REFERENCES teams
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    team1_id INT REFERENCES teams,
    team2_id INT REFERENCES teams,
    stadium_id INT REFERENCES stadiums,
    referee_id INT REFERENCES referees,
    winning_team_id INT references teams,
    date DATE NOT NULL
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    scoring_player_id INT REFERENCES players,
    match_id INT REFERENCES matches
);

INSERT INTO stadiums
    (name)
VALUES
    ('wembley stadium'),
    ('england stadium'),
    ('birmingham stadium'),
    ('O2 arena'),
    ('UK field'),
    ('barcelona');

INSERT INTO teams
    (name, home_stadium_id)
VALUES
    ('liverpool', 1),
    ('Hudson FC', 2),
    ('sunderland', 3),
    ('chelsea', 4),
    ('watford', 5),
    ('spain united', 6);

INSERT INTO
    players (first_name, last_name)
VALUES
    ('bob', 'diesel'),
    ('christiano', 'ronaldo'),
    ('mesut', 'ozil'),
    ('david', 'beckham'),
    ('john', 'mayer'),
    ('warnold', 'rippen');

INSERT INTO
    referees (name)
VALUES
    ('andrew wentworth'),
    ('travis fickle'),
    ('eleanor trievo'),
    ('marcus brigham'),
    ('evan ringwald');

INSERT INTO
    matches (team1_id, team2_id, stadium_id, referee_id, winning_team_id, date)
VALUES
    (1, 3, 1, 4, 1, '2001-10-02'),
    (1, 3, 3, 5, 3, '2001-10-09'),
    (4, 2, 4, 2, 4, '2001-10-16'),
    (6, 3, 6, 3, 6, '2001-10-23'),
    (5, 4, 5, 1, 4, '2001-10-31'),
    (2, 3, 2, 1, 2, '2001-10-31'),
    (6, 4, 4, 5, 6, '2001-11-07');

INSERT INTO
    goals (match_id, scoring_player_id)
VALUES
    (1, 3),
    (2, 6),
    (2, 4),
    (3, 5),
    (3, 3),
    (4, 1),
    (5, 2),
    (6, 1),
    (7, 1);
    
-- List the rankings of the teams by number of wins

SELECT 
    t.name, COUNT(m.id) AS num_of_wins 
FROM 
    matches m 
JOIN 
    teams t 
ON 
    m.winning_team_id = t.id 
GROUP BY 
    t.name 
ORDER BY 
    num_of_wins DESC; 