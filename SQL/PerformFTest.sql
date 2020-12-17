use HOSPITAL;
-- create table PERFORMFTEST(
--     DocID CHAR(9) NOT NULL,
--     ShiftID CHAR(11) NOT NULL,
--     FTestID INTEGER NOT NULL,
--     PRIMARY KEY (FTestID),
--     FOREIGN KEY(DocID) REFERENCES doctor(ID),
--     FOREIGN KEY(FTestID) REFERENCES ftest(ID),
--     FOREIGN KEY(ShiftID) REFERENCES shift(ID)
-- );
delete from PERFORMFTEST;