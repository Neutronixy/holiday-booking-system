-- filter function for departure cities
SET @countryName = 'United Kingdom';

SELECT * FROM country;

SELECT country_id FROM country WHERE country_name = @countryName;

SELECT * FROM city;

-- subqueries
SELECT * FROM city WHERE country_id IN (
	SELECT country_id FROM country WHERE country_name = @countryName
);

-- subqueries
SELECT city_name FROM city WHERE country_id IN (
	SELECT country_id FROM country WHERE country_name = @countryName
);