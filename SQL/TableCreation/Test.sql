use HOSPITAL;
create table Test(
    ID INTEGER NOT NULL ,
    Result FLOAT NOT NULL,
    TName VARCHAR(30),
    CommonIndex FLOAT NOT NULL,
    Note ENUM('Normal','Abnormal'),
    PRIMARY KEY(ID)
);
ALTER TABLE Test
DROP COLUMN CommonIndex;
-- ADD FOREIGN KEY (TName) REFERENCES TESTLIST(TName);