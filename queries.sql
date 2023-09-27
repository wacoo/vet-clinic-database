/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Update data
BEGIN;
UPDATE animals SET species='unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;


UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
SELECT species FROM animals;
COMMIT;
SELECT species FROM animals;

-- delete all animals 
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
COMMIT;
-- new transaction deleted animals born after jan first 2022
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;

-- add savepoint
SAVEPOINT sp1;


UPDATE animals SET weight_kg= weight_kg * -1;

ROLLBACK TO SAVEPOINT sp1;
SELECT * FROM animals;

UPDATE animals SET weight_kg= weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;

COMMIT;

-- project 2 queies

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts) as count, neutered FROM animals GROUP BY neutered ORDER BY count DESC LIMIT 1;
SELECT MAX(weight_kg) as max_weight_in_kg, MIN(weight_kg) as min_weight_in_kg, species FROM animals GROUP BY species;
SELECT AVG(escape_attempts) as average_escape_attempts, species FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-01-01' GROUP BY species;
--project 3

SELECT a.name, o.full_name FROM animals as a INNER JOIN owners as o ON a.owners_id = o.id WHERE o.full_name = 'Melody Pond';

SELECT animals.name, species.name as type FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, owners.age, animals.name as animal_name, animals.date_of_birth as animal_dob, animals.weight_kg as animal_weight_kg FROM owners LEFT JOIN animals ON animals.owners_id = owners.id;
SELECT species.name, count(*) FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT animals.name as animal_name, species.name as type, owners.full_name as owner FROM animals INNER JOIN species ON animals.species_id = species.id INNER JOIN owners ON animals.owners_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
SELECT animals.name as animal_name, owners.full_name as owner FROM animals INNER JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name AS owner, COUNT(animals.id) AS animal_count FROM animals INNER JOIN owners ON animals.owners_id = owners.id GROUP BY owners.full_name HAVING COUNT(animals.id) = (SELECT MAX(animal_count) FROM (SELECT COUNT(id) AS animal_count FROM animals GROUP BY owners_id) AS subquery);
