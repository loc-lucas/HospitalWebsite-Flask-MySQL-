use HOSPITAL;
drop table patient;
CREATE TABLE HOSPITAL.PATIENT(
    ID  CHAR(9) NOT NULL,
    InsurID CHAR(9),
    LName VARCHAR(15)   NOT NULL,
    Minit VARCHAR(15),
    FName VARCHAR(15)   NOT NULL,
    Bdate Date NOT NULL,
    Addr VARCHAR(30) NOT NULL,
    Sts ENUM('Boarded','Out'),
    PRIMARY KEY(ID)
);
