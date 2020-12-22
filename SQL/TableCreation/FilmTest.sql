use HOSPITAL;
-- DROP TABLE Ftest;
create table Ftest(
    ID INT NOT NULL,
    Result VARCHAR(256),
    TName VARCHAR(30),
    PRIMARY KEY(ID),
    FOREIGN KEY (TName) REFERENCES FTESTLIST(TName)
);
-- ALTER TABLE Ftest
-- ADD 