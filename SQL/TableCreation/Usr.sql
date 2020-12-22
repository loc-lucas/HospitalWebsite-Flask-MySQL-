use HOSPITAL;
DROP TABLE IF EXISTS USR;
CREATE TABLE USR (  
  usr_id INT NOT NULL,
  usr_password VARCHAR(45) NULL,
  usr_role VARCHAR (20) NOT NULL,
  PRIMARY KEY (usr_id)
);

INSERT INTO USR (usr_id, usr_password, usr_role)
VALUES 
    (999999999, 'iamadmin', 'admin'),
    (999999998, 'iamadmin2', 'admin'),
    (245015682, 'iamdoctor', 'doctor'),
    (246123512, 'iamdoctor2', 'doctor'),
    (230761341, 'thantainohu', 'patient'),
    (123456789, 'blackplayer', 'patient');


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