DROP DATABASE IF EXISTS hospital;

CREATE DATABASE hospital;

\c hospital;

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE diseases_patients (
    id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients,
    disease_id INT REFERENCES diseases
);

CREATE TABLE doctors_patients (
    id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients,
    doctor_id INT REFERENCES doctors
);

INSERT INTO 
doctors (name)
VALUES
('John Wayne'),
('Sally Moore'),
('Richard Diesel');

INSERT INTO 
patients (name)
VALUES
('Duane Chapman'),
('Robby Leland'),
('Lisa Brudi');

INSERT INTO
diseases (name)
VALUES
('cancer'),
('heart disease'),
('lymphoma');

INSERT INTO 
diseases_patients (patient_id, disease_id)
VALUES
(1,3),
(1,1),
(2,3),
(3,2),
(2,2);

INSERT INTO
doctors_patients (patient_id, doctor_id)
VALUES
(2,3),
(1,1),
(3,1),
(2,2),
(1,3);


-- See which patients have which diseases.
SELECT patients.name, diseases.name
FROM diseases_patients JOIN patients ON patient_id = patients.id
JOIN diseases ON disease_id = diseases.id;