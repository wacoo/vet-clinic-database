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

-- project 4

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit TIMESTAMP,
    PRIMARY KEY (animal_id, vet_id, date_of_visit)
);

-- project 5

-- animal_id and vet_id columns in the visits table are part of the primary key, they are not the primary key.
-- that means the non clustered index only works for the three columns as a whole, not for each column.
-- That why it is necessary to index the each column is important.

CREATE INDEX animal_id_idx ON visits(animal_id);
CREATE INDEX vet_id_idx ON visits(vet_id);
CREATE INDEX owners_email_idx ON owners(email);