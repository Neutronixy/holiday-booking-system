-- we have setted the index for the email in UNIQUE, so we cannot register with the same email 2 times, otherwise we get an error
SET @email = 'neutronixyz@gmail.com';
SET @password = 'elGC%8*MED9ObHD01ImAgZBHD0%J';
SET @customer = '1';
 
-- again, better to use external and updated services for this job, there are always more updated methods and a hacker can have access to your password and log in other websites if you used the same password
-- always check if the website use the https secured and a SSL (Secure Sockets Layer) before type your password on it
-- first we generate randomly the salt because we need it to make the one-way hashing impossible to reverse
SELECT @salt := SUBSTRING(SHA1(RAND()), 1, 6);
 
-- use SHA256 that has a 160 bit long key to encrypt data. Concatenate the password with the salt to make a salted hash
SELECT @saltedHash := SHA2(CONCAT(@salt, @password), 256);
 
-- concatenate the salt and the salted hash together to store the data needed for the log in
SELECT @saltSaltedHash := CONCAT(@salt, @saltedHash);
 
-- store the data encrypted in the database
INSERT INTO `login` (`login_id`, `login_email`, `login_password`, `customer_id`) VALUES
    (NULL, @email, @saltSaltedHash, @customer);