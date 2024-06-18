-- now we set the autocommit off with the transaction. in case we have an error the transaction will fail and the data rolled back to the previous status
START TRANSACTION;
    SET @flightPriceOne = 210;
    SET @flightPriceTwo = 150;
    SET @busPrice = 34;
    SET @start_date_reservation = '2023-01-16';
    SET @end_date_reservation = '2023-02-14';
    SET @bookingRoomNumber = 1;
    SET @hotelNumber = 1;
   
    -- select all the bookings for room number 2
    SELECT * FROM unavailable WHERE room_id = @bookingRoomNumber;

    -- select all the bookings that collide with the date of our booking. if the rows are empty it means that we can book that room, otherwise we should select a different room
    SELECT unavailable_id FROM unavailable WHERE
        (unavailable_start_date BETWEEN @start_date_reservation AND @end_date_reservation) OR
        (unavailable_end_date BETWEEN @start_date_reservation AND @end_date_reservation);
    -- if the columns are empty we can continue the booking process, otherwise we should raise an error and decline the transaction, we don't modify the data in the database if an error is raised.
	
    -- check the price of the room:
    -- select the correct room_type_id of that room
    SELECT @roomType := room_type_id FROM room WHERE hotel_id = @hotelNumber AND room_id = @bookingRoomNumber;
   
    SELECT * FROM hotel_room_type;
   
    -- take the id to find the price
    SELECT @hotelRoomType := hotel_room_type_id FROM hotel_room_type WHERE hotel_id = @hotelNumber AND room_type_id = @roomType;
   
    -- find all the prices for the room we have chosen
    SELECT * FROM price WHERE hotel_room_type_id = @hotelRoomType;
   
    -- find all the prices for that room in the period we chosen
    SELECT * FROM price WHERE hotel_room_type_id = @hotelRoomType AND (
        (price_start_period BETWEEN @start_date_reservation AND @end_date_reservation) OR
        (price_end_period BETWEEN @start_date_reservation AND @end_date_reservation)
    );

    -- now we need to count all the days between the 2 different interval of dates and multiply all the different prices
    -- first let's sum up all the periods in between our dates. We use DATEDIFF to count the number of days between two dates
    SELECT SUM(price_price * DATEDIFF(price_end_period, price_start_period)) FROM price WHERE hotel_room_type_id = @hotelRoomType AND (
        (price_start_period BETWEEN @start_date_reservation AND @end_date_reservation) OR
        (price_end_period BETWEEN @start_date_reservation AND @end_date_reservation)
    );
   
    -- we should change the condition to OR in AND otherwise we count the price for the whole period. we added IFNULL function to assign 0 if the result is NULL, we need it for the sum
    SELECT @priceStartPeriodBetween := IFNULL(SUM(price_price * DATEDIFF(price_end_period, price_start_period)), 0) FROM
        price WHERE hotel_room_type_id = @hotelRoomType AND (
            (price_start_period BETWEEN @start_date_reservation AND @end_date_reservation) AND
            (price_end_period BETWEEN @start_date_reservation AND @end_date_reservation)
    );
   
    -- now let's sum first from the beginning of the period and then to the end with the price changed
    SELECT @priceStartPeriodLeft := IFNULL(SUM(price_price * DATEDIFF(price_end_period, @start_date_reservation)), 0) FROM
        price WHERE hotel_room_type_id = @hotelRoomType AND (
            (price_start_period NOT BETWEEN @start_date_reservation AND @end_date_reservation) AND
            (price_end_period BETWEEN @start_date_reservation AND @end_date_reservation)
    );
   
    SELECT @priceStartPeriodRight := IFNULL(SUM(price_price * DATEDIFF(@end_date_reservation, price_start_period)), 0) FROM
        price WHERE hotel_room_type_id = @hotelRoomType AND (
            (price_start_period BETWEEN @start_date_reservation AND @end_date_reservation) AND
            (price_end_period NOT BETWEEN @start_date_reservation AND @end_date_reservation)
    );
    -- with the NOT BETWEEN we collect only the portion of data that we need for the sum. If we have more than one period with a different price this system returns the correct total price.
   
    -- return the total price of the room or rooms
    SELECT @priceRoom := @priceStartPeriodBetween + @priceStartPeriodLeft + @priceStartPeriodRight;
   
    -- return the total price of the booking
    SELECT @priceBooking := @priceRoom + @flightPriceOne + @flightPriceTwo + @busPrice;
   

    -- SAVEPOINT savepoint1;
   
    -- insert the data in the tables or replace them
    SET @bookingId = 3;
   
    -- insert the booking in the booking table
    REPLACE INTO `booking` (`booking_id`, `booking_reference`, `booking_creation_timestamp`, `booking_end_contract_date`, `booking_paid_price`, `booking_payment_reference`, `booking_discount_code`, `payment_method_id`, `customer_lead_id`) VALUES
        (@bookingId, 'DGWHW3246', current_timestamp(), @start_date_reservation, @priceBooking, 'si3bfu579dc', '263577', '2', '1');
   
    -- insert the booking of the room in the unavailable table
    INSERT INTO `unavailable` (`unavailable_id`, `unavailable_start_date`, `unavailable_end_date`, `room_id`, `booking_id`) VALUES
        (NULL, @start_date_reservation, @end_date_reservation, @bookingRoomNumber, @bookingId);
 
    -- insert the booking of the flight in the flight table. we use concat to concatenate the date with the time
    INSERT INTO `flight` (`flight_id`, `flight_departure_time`, `flight_arrival_time`, `flight_price`, `flight_type_id`, `route_id`, `booking_id`) VALUES
        (NULL, CONCAT(@start_date_reservation, ' 06:33:00'), CONCAT(@start_date_reservation, ' 10:06:00'), @flightPriceOne, '1', '3', @bookingId),
        (NULL, CONCAT(@end_date_reservation, ' 13:30:00'), CONCAT(@end_date_reservation, ' 16:03:00'), @flightPriceTwo, '1', '4', @bookingId);
   
    -- insert the additional product booking in the booking_product table
    INSERT INTO `booking_product` (`booking_product_id`, `booking_product_name`, `booking_product_description`, `booking_product_price`, `booking_id`) VALUES
        (NULL, 'Bus transport', 'Departure from the entrance of the airport direct to Catania', @busPrice, @bookingId);
   
    -- ROLLBACK TO savepoint1;
COMMIT;