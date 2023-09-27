/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

 -- prohect 2

ALTER TABLE animals
ADD COLUMN species VARCHAR(50);

-- project 3

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

ALTER TABLE animals
ADD id INT SERIAL PRIMARY KEY;

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT REFERENCES species (id);

ALTER TABLE animals
ADD owners_id INT REFERENCES owners (id);

