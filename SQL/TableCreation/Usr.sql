-- use HOSPITAL;
-- CREATE TABLE USR (
--   usr_id BIGINT NULL AUTO_INCREMENT,
--   usr_name VARCHAR(45) NULL,
--   usr_username VARCHAR(45) NULL,
--   usr_password VARCHAR(45) NULL,
--   PRIMARY KEY (usr_id));
-- );

CREATE PROCEDURE createUser
    (IN p_name VARCHAR(20),IN p_usrname VARCHAR(20),IN p_password VARCHAR(20))
BEGIN 
    IF (
        SELECT EXISTS (SELECT 1 FROM USR WHERE usr_name = p_usrname)
    ) THEN SELECT 'Username Exists !!';
    ELSE
    INSERT INTO USR (usr_name, usr_username, usr_password)
    VALUES
        (p_name, p_usrname, p_password);
    END IF;
END;