-- insert login email and password, they need both to be correct
SET @loginEemail = 'neutronixyz@gmail.com';
SET @loginPassword = 'elGC%8*MED9ObHD01ImAgZBHD0%J';

-- first we need to take the salt concatenated before from the database related to our email. if the email is wrong the salt will be probably NULL
-- we need the same salt used in the registration process to allow us to compare the hash generated before with the new hash.
-- We can generate the same salted hash only if we type the same password. In this way our password will be never stored and we compare only the salted hash value generate with it
SELECT @salt := SUBSTRING(login_password, 1, 6) FROM login WHERE login_email = @loginEemail;

-- let's generate the salted hash with the same salt value but with the login password. we should use the same hashing function to make it work, in this case SHA256
SELECT @saltedHash := SHA2(CONCAT(@salt, @loginPassword), 256);

-- now concatenate again the salt before the comparison. we could also compare only the salted hash but for practical reasons we prefer to compare salt + salted hash together
SELECT @saltSaltedHash := CONCAT(@salt, @saltedHash);

-- compare the result with the stored value. if the selection is NULL it means that the password or the email are wrong
SELECT * FROM login WHERE login_password = @saltSaltedHash AND login_email = @loginEemail