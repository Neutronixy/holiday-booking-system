-- filter function for destination country, city, resort and hotels that have a particular facility and room type
SET @countryName = 'Italy';
SET @cityName = 'Catania';
SET @resortName = 'Sicily Country House & Beach';
SET @hotelName = 'Hotel & Residence Costa del Sol';
SET @facilityName = 'Swimming pool';
SET @roomType = 'Medium room for 3 people, animals allowed';
 
SELECT @countryId := country_id FROM country WHERE country_name = @countryName;
 
SELECT @cityId := city_id FROM city WHERE country_id = @countryId AND city_name = @cityName;

-- inner join
SELECT * FROM resort INNER JOIN city
    ON resort.city_id = city.city_id WHERE
    resort.city_id = @cityId;

-- multiple join
-- check if all the resorts have hotels in that city
SELECT
    city_name AS Cities,
    resort_name AS Resorts,
    hotel_name AS Hotels,
    hotel_description AS 'Hotel Description',
    hotel_url AS URL
FROM resort INNER JOIN city ON
    resort.city_id = city.city_id
LEFT JOIN hotel ON
    resort.resort_id = hotel.resort_id WHERE
    resort.city_id = @cityId;

-- multiple join
-- check if all the hotels are connected to a resort in that city. if not, the resort columns should be NULL
SELECT
    resort_name AS Resorts,
    hotel_name AS Hotels,
    hotel_description AS 'Hotel Description',
    hotel_url AS URL
FROM resort INNER JOIN city ON
    resort.city_id = city.city_id
RIGHT JOIN hotel ON
    resort.resort_id = hotel.resort_id WHERE
    address_id IN (SELECT address_id FROM address WHERE city_id = @cityId);

-- show all the hotels with a particular facility
SELECT * FROM hotel WHERE hotel_id IN (
    SELECT hotel_id FROM facility_hotel WHERE facility_id IN (
        SELECT facility_id FROM facility WHERE facility_name = @facilityName
    )
);

-- show all the rooms of a particular type
SELECT * FROM room WHERE room_type_id IN (
    SELECT room_type_id FROM room_type WHERE room_type_name = @roomType
);

-- shows all the hotel name, description and resort name of the hotels that provide that particular facility and that particular room type in the chosen resort
SELECT
    city_name AS Cities,
    resort_name AS Resorts,
    hotel_name AS Hotels,
    hotel_description AS 'Hotel Description',
    hotel_url AS URL
FROM resort INNER JOIN city ON
    resort.city_id = city.city_id
RIGHT JOIN hotel ON
    resort.resort_id = hotel.resort_id WHERE
    address_id IN (SELECT address_id FROM address WHERE city_id = @cityId) AND
    hotel_id IN (
        SELECT hotel_id FROM hotel WHERE hotel_id IN (
            SELECT hotel_id FROM facility_hotel WHERE facility_id IN (
                SELECT facility_id FROM facility WHERE facility_name = @facilityName
            )
        )
    ) AND hotel_id IN (
        SELECT hotel_id FROM room WHERE room_type_id IN (
            SELECT room_type_id FROM room_type WHERE room_type_name = 'Medium room for 3 people, animals allowed'
    ) AND resort_name = @resortName
);