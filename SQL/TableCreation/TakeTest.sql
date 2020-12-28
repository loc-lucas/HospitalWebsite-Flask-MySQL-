use HOSPITAL;
create table TAKETEST(
    ExamID INTEGER NOT NULL,
    TestID INTEGER DEFAULT 0,
    FTestID INTEGER DEFAULT 0,
    PRIMARY KEY(TestID, FTestID, ExamID),
    FOREIGN KEY(ExamID) REFERENCES EXAMINATION(ID),
    FOREIGN KEY(TestID) REFERENCES TEST(ID),
    FOREIGN KEY(FTestID) REFERENCES FTEST(ID)
);