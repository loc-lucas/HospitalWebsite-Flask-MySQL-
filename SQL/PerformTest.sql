use HOSPITAL;
-- create table PERFORMTEST(
--     DocID CHAR(9) NOT NULL,
--     ShiftID CHAR(11) NOT NULL,
--     TestID INTEGER NOT NULL,
--     PRIMARY KEY (TestID),
--     FOREIGN KEY(DocID) REFERENCES doctor(ID),
--     FOREIGN KEY(TestID) REFERENCES test(ID),
--     FOREIGN KEY(ShiftID) REFERENCES shift(ID)
-- );
delete from PERFORMTEST;