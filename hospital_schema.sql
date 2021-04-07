DROP DATABASE IF EXISTS hospital;

CREATE DATABASE hospital;

\c hospital;

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name_of_doc TEXT NOT NULL -- Same comment as in the previous sql (Why "name_of_doc" instead of just "name"?)
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name_of_patient TEXT NOT NULL -- Again
);

CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    name_of_disease TEXT UNIQUE NOT NULL -- Again
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
doctors (name_of_doc)
VALUES
('John Wayne'),
('Sally Moore'),
('Richard Diesel');

INSERT INTO 
patients (name_of_patient)
VALUES
('Duane Chapman'),
('Robby Leland'),
('Lisa Brudi');

INSERT INTO
diseases (name_of_disease)
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
SELECT name_of_patient, name_of_disease
FROM diseases_patients JOIN patients ON patient_id = patients.id
JOIN diseases ON disease_id = diseases.id;
