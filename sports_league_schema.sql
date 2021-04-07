DROP DATABASE IF EXISTS sports_league;

CREATE DATABASE sports_league;

\c sports_league;

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name_of_team TEXT UNIQUE NOT NULL,
    name_of_coach TEXT UNIQUE NOT NULL, -- Can somenone coach more than one team? If so this should be a separate table + FK
    stadium TEXT NOT NULL -- Same for stadium, this only holds if there's 1-1 relation between team & stadium
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT,
    team_id INT REFERENCES teams
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    team1_id INT REFERENCES teams,
    team2_id INT REFERENCES teams,
    date DATE NOT NULL,
    home_team_id INT REFERENCES teams, -- Isn't this redundant with team1 or team2?
    winning_team_id INT references teams
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    name_of_ref TEXT
);

CREATE TABLE match_referee ( -- Can a match have more than one referee?
    id SERIAL PRIMARY KEY,
    match_id INT REFERENCES matches,
    referee_id INT REFERENCES referees 
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    scoring_player_id INT REFERENCES players,
    match_id INT REFERENCES matches
);

INSERT INTO
    teams (name_of_team, name_of_coach, stadium)
VALUES
    ('liverpool', 'john mayor', 'wembley stadium'),
    ('Hudson FC', 'bobby wagner', 'england stadium'),
    ('sunderland', 'ricky bobby', 'birmingham stadium'),
    ('chelsea', 'matt patricia', 'O2 arena'),
    ('watford', 'arnold palmer', 'UK field'),
    ('spain united', 'mark andrews', 'barcelona');

INSERT INTO
    players (first_name, last_name, team_id)
VALUES
    ('bob', 'diesel', 1),
    ('christiano', 'ronaldo', 2),
    ('mesut', 'ozil', 5),
    ('david', 'beckham', 4),
    ('john', 'mayer', 3),
    ('warnold', 'rippen', 2);

INSERT INTO
    matches (team1_id, team2_id, date, home_team_id, winning_team_id)
VALUES
    (1, 3, '2001-10-02', 1, 3),
    (1, 3, '2001-10-09', 2, 1),
    (4, 2, '2001-10-16', 4, 2),
    (6, 3, '2001-10-23', 6, 3),
    (5, 4, '2001-10-31', 5, 5),
    (2, 3, '2001-10-31', 3, 2),
    (6, 4, '2001-11-07', 4, 4);

INSERT INTO
    referees (name_of_ref)
VALUES
    ('andrew wentworth'),
    ('travis fickle'),
    ('eleanor trievo'),
    ('marcus brigham'),
    ('evan ringwald');

INSERT INTO
    match_referee (match_id, referee_id)
VALUES
    (1, 1),
    (1, 4),
    (2, 5),
    (2, 4),
    (3, 3),
    (3, 1),
    (4, 4),
    (4, 2),
    (5, 3),
    (5, 5),
    (6, 1),
    (6, 2),
    (7, 5),
    (7, 3);

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
    name_of_team, COUNT(winning_team_id) AS num_of_wins -- You probably want to count match_id instead of winning_team_id
FROM 
    matches m 
JOIN 
    teams t 
ON 
    m.winning_team_id = t.id 
GROUP BY 
    name_of_team, winning_team_id 
ORDER BY 
    num_of_wins DESC; 
