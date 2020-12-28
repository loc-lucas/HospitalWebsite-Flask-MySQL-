use HOSPITAL;
create table TEST(
    ID INTEGER NOT NULL ,
    Result FLOAT NOT NULL,
    TName VARCHAR(30),
    Note ENUM('Normal','Abnormal'),
    PRIMARY KEY(ID),
    FOREIGN KEY (TName) REFERENCES TESTLIST(TName)
);

taketest