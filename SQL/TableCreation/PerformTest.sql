use HOSPITAL;
create table PERFORMTEST(
    DocID CHAR(9) NOT NULL,
    ShiftID CHAR(11) NOT NULL,
    TestID INTEGER NOT NULL,
    PRIMARY KEY (TestID),
    FOREIGN KEY(DocID) REFERENCES DOCTOR(ID),
    FOREIGN KEY(TestID) REFERENCES Test(ID),
    FOREIGN KEY(ShiftID) REFERENCES SHIFT(ID)
);
-- delete from PERFORMTEST;