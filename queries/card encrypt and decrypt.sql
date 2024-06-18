SET @cardType = 'Visa';
SET @cardOwnerName = 'Roberto';
SET @cardOwnerSurname = 'Lo Duca';
SET @cardLongNumber = '5274 3258 9126 1322';
SET @cardCVV = '513';
SET @cardExpirationDate = '2024-10-01';
SET @customerLead = '1';
 
SET @password = 'MK4o4kqd1%ctvmmy1nhvgK$8BN8L%G';
 
-- we never store the cvv or card long number in our system because it's easy for a hacker to steal it. We do it only to demonstrate a way to encrypt data. It is advisable to have this work done by an external service
-- concatenate card long number and cvv, then encrypt it with a password
SET @cardLongNumberAndCVV = AES_ENCRYPT(CONCAT(@cardLongNumber, @cardCVV), @password);
 
-- insert the results
INSERT INTO `card` (`card_id`, `card_type`, `card_owner_name`, `card_owner_surname`, `card_expiration_date`, `card_long_number_cvv`, `customer_lead_id`) VALUES
    (NULL, @cardType, @cardOwnerName, @cardOwnerSurname, @cardExpirationDate, @cardLongNumberAndCVV, @customerLead);

-- show the table with the values decrypted. we use SUBSTRING function to divide the card long number from the cvv
SELECT
    `card_id`,
    `card_type`,
    `card_owner_name`,
    `card_owner_surname`,
    `card_expiration_date`,
    SUBSTRING(AES_DECRYPT(`card_long_number_cvv`, @password), 1, 19) AS 'Card Long Number',
    SUBSTRING(AES_DECRYPT(`card_long_number_cvv`, @password), 20, 22) AS CVV,
    `customer_lead_id`
FROM card WHERE customer_lead_id = @customerLead