use HOSPITAL;
-- DROP TABLE PERFORMFTEST;
create table PERFORMFTEST(
    DocID CHAR(9) NOT NULL,
    ShiftID CHAR(11) NOT NULL,
    FTestID INTEGER NOT NULL,
    PRIMARY KEY (FTestID),
    FOREIGN KEY(DocID) REFERENCES DOCTOR(ID),
    FOREIGN KEY(FTestID) REFERENCES Ftest(ID),
    FOREIGN KEY(ShiftID) REFERENCES SHIFT(ID)
);
-- delete from PERFORMFTEST;