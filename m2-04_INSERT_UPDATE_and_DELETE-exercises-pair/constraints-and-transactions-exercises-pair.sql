-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)

INSERT INTO city (name, countrycode, district, population)
VALUES ('Smallville', 'USA', 'Kansas', 45001);

-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.

INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('USA', 'Kryptonese', false, 0.0001);

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.

UPDATE countrylanguage SET language = 'Krypto-babble' WHERE language = 'Kryptonese';

-- 4. Set the US captial to Smallville, Kansas in the country table.

UPDATE country SET capital = 4080 WHERE code = 'USA';

-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE FROM city WHERE name = 'Smallville';

-- We can't delete Smallville from the city table because we tied it into the country table in Problem 4.

-- 6. Return the US capital to Washington.

UPDATE country SET capital = 3813 WHERE code = 'USA';

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE FROM city WHERE name = 'Smallville';

-- We can delete Smallville from the city table now that we've untied it from the country table in Problem 6.

-- 8. Reverse the "is the official language" setting for all languages where the 
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)

START TRANSACTION;
UPDATE countrylanguage SET isofficial = NOT isofficial WHERE countrycode IN (SELECT code FROM country WHERE indepyear > 1800 AND indepyear < 1972);
COMMIT;

-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)

START TRANSACTION;
UPDATE city SET population = TRUNC(CAST((population / 1000) AS DECIMAL), 0);
COMMIT;

-- 10. Assuming a country's surfacearea is expressed in miles, convert it to 
-- meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)

START TRANSACTION;
UPDATE country SET surfacearea = (surfacearea * 1609.344) WHERE code IN (SELECT countrycode FROM countrylanguage WHERE language = 'French' AND percentage > 20);
COMMIT;