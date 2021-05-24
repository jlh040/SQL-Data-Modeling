DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    region TEXT NOT NULL,
    zip_code INT UNIQUE NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    pref_region INT REFERENCES region
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    text TEXT NOT NULL,
    username_id INT REFERENCES users ON DELETE CASCADE,
    region_id INT REFERENCES region
);

CREATE TABLE categories_posts (
    id SERIAL PRIMARY KEY,
    category_id INT REFERENCES categories,
    post_id INT REFERENCES posts
);

INSERT INTO
    categories (name)
VALUES
    ('JOBS'),
    ('SCHOOL'),
    ('SOCIAL'),
    ('MISC');

INSERT INTO
    regions (region, zip_code)
VALUES
    ('san diego', 92126),
    ('san diego', 92154),
    ('phoenix', 85387),
    ('new york', 12127),
    ('dallas', 65631);

INSERT INTO
    users (username, pref_region)
VALUES
    ('bubby11', 1),
    ('ridu987', 1),
    ('bobby99', 5),
    ('diesel_421', 3),
    ('rango854', 2);

INSERT INTO
    posts (title, text, username_id, region_id)
VALUES
    ('FREE DOGS', 'come get a free dog', 2, 1),
    ('Looking for friends', 'who wants to hang out', 5, 2),
    ('Hiring baristas', '$6.50 an hour come apply', 3, 5),
    ('Become a developer', 'apply for our new bootcamp', 1, 4),
    ('Training dog trainers', 'start your career as a dog trainer', 1, 3);

INSERT INTO
    categories_posts (post_id, category_id)
VALUES
    (5, 2),
    (1, 4),
    (2, 3),
    (3, 1),
    (4, 2);



--Display the titles, text, and categories of the posts made by the user 'bobby99'
SELECT 
    title, text, name
FROM 
    categories_posts 
JOIN 
    categories ON category_id = categories.id 
JOIN 
    posts ON post_id = posts.id 
WHERE 
    username_id = 1;