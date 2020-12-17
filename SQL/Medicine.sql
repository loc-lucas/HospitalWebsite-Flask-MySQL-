use HOSPITAL;
create table MEDICINE(
    Dates Date NOT NULL,
    Amount INTEGER NOT NULL,
    UsageDes VARCHAR(50),
    MName VARCHAR(15) NOT NULL,
    PresID INTEGER NOT NULL,
    PRIMARY KEY (Dates, MName, PresID),
    FOREIGN KEY(PresID) REFERENCES prescription(ID)
);