use HOSPITAL;
create table BoardedRecord(
    PatientID CHAR(9) NOT NULL,
    BoardedTime Date NOT NULL,
    BoardedDis VARCHAR(256) NOT NULL,
    LeaveAsnDocID CHAR(9),
    AsnDocID CHAR(9) NOT NULL,
    BoardedCond VARCHAR(256) NOT NULL,
    BedNo INTEGER NOT NULL,
    RoomNo INTEGER NOT NULL,
    LeaveTime Date,
    LeaveDis VARCHAR(256),
    LeaveNote VARCHAR(256),
    LeaveCond VARCHAR(256),
    PRIMARY KEY(BoardedTime, PatientID),
    FOREIGN KEY(LeaveAsnDocID) REFERENCES DOCTOR(ID),
    FOREIGN KEY(AsnDocID) REFERENCES DOCTOR(ID),
    FOREIGN KEY(PatientID,BoardedTime) REFERENCES BOARDEDPATIENT(ID,BoardedTime)
);