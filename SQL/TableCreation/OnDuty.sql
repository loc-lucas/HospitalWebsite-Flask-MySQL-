use HOSPITAL;
CREATE TABLE HOSPITAL.OnDuty(
    DocID CHAR(9) NOT NULL,
    ShiftID CHAR(11) NOT NULL,
    FOREIGN KEY(DocID) REFERENCES DOCTOR(ID),
    FOREIGN KEY(ShiftID) REFERENCES SHIFT(ID)
);