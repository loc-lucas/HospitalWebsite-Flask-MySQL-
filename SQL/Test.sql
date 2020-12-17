use HOSPITAL;
create table Test(
    ID INTEGER NOT NULL ,
    Result FLOAT NOT NULL,
    TName VARCHAR(30),
    CommonIndex FLOAT NOT NULL,
    Note ENUM('Normal','Abnormal'),
    PRIMARY KEY(ID)
);