USE HOSPITAL;

-- INSERT INTO PATIENT (ID, InsurID, LName, Minit,FName, Bdate, Addr, Sts)
-- VALUES 
    -- (012345678, 876543210, 'Why', 'Always', 'Me', '1980-05-12', '1241 Somewhere Road', 'Boarded'),
--     (321456789, 316835723, 'Trist', '', 'Merigold', '1967-09-18', '2872  Fieldcrest Road', 'Out'),
--     (234129568, 123457094, 'Setsuna', 'F', 'Seiei', '1990-06-26', '825  Fire Access Road', 'Out'),
--     (335124161, 782315681, 'Rhym', 'A', 'Stic', '1960-12-13', '1715  Findley Avenue', 'Out'),
--     (245123468, 356561233, 'Whute', 'M', 'An', '1940-09-30', 'Space', 'Out'),
--     (123456789, 123456711, 'Bui', 'Quang', 'Loc', '1944-08-17', '2243  Stroop Hill Road', 'Boarded'),
--     (091276243, 156782356, 'Wayne', 'L', 'Mao', '1974-09-27', '4856  Trainer Avenue', 'Boarded'),
--     (984316506, 315268147, 'Bluck', 'M', 'An', '1993-05-07', 'Underground', 'Boarded'),
--     (830185245, 312435612, 'Ray', '', 'B', '1930-08-28', '2758  Fowler Avenue', 'Boarded'),
--     (230761341, 125907436, 'Dale', 'J', 'Williams', '1994-08-25', '4284  Godfrey Road', 'Boarded'),
--     (527492357, 901270125, 'Manuel', 'A', 'Hayden', '1994-08-25', '7134  Frey Road', 'Boarded'),
--     (346282624, 129714334, 'Chrst', '', 'Pratt', '1984-03-12', '2162  God Road', 'Boarded')
-- ;

-- INSERT INTO NURSE (ID, LName, Minit, FName, Bdate, Addr)
-- VALUES 
--     (341634578, 'Do', 'Anh', 'Khoa', '1990-01-10', ' 123 Phu Nhuan'),
--     (123241512, 'Nguyen', 'Minh', 'Huy', '1988-05-06', '321 Q3'),
--     (215134751, 'Wayne', '', 'Rooney', '1981-05-12', '3424  Center Avenue'),
--     (213415131, 'Cristiano', '', 'Ronaldo', '1949-10-06', '4368  Duffy Street'),
--     (871291231, 'Hank', 'Something', 'Tom', '1946-03-08', '4563  Woodland Avenue'),
--     (812749312, 'The', 'Purple', 'Hulk', '1942-04-22', '1386  Adonais Way'),
--     (670137514, 'Bruno', 'Earth', 'Mars', '1988-04-15', '3129  Rainbow Road'),
--     (571415109, 'Jack', '@ss', 'Buttowski', '1941-04-01', '2361  Pyramid Valley Road')
-- ;

-- INSERT INTO DOCTOR (ID, LName, Minit, FName, Bdate, Addr, DepartID)
-- VALUES 
--     (461923053, 'Robert', 'J.', 'Parkinson', '1943-06-16', '1771  Rubaiyat Road', 1),
--     (245015682, 'Downey', 'Ariel', 'Aba', '1947-05-27', '1081 Oak St', 2),
--     (812749801, 'Sunlight', 'N.', 'Sunhouse', '1948-03-04', '8204 Buena Vista Blvd', 4),
--     (982367598, 'Carole', 'L.', 'Roy', '1985-01-09', '1112 N Gulliver', 3),
--     (345615634, 'Cadence', 'M.', 'May', '1999-08-12', '35 Odell Ln', 3),
--     (356474245, 'Tamara', 'A.', 'Mcmahon', '1990-09-26', '1407 Delano Trent St', 1),
--     (673582921, 'Carlton', 'W.', 'Copeland', '1985-03-25', '2648 Holly Ln', 2),
--     (768056761, 'Billie', 'B.', 'Jefferson', '1984-12-20', '481 Hazard Rd', 1),
--     (132468913, 'Aanya', 'R.', 'Shah', '1947-10-13', '132 W Main St', 2)
-- ;

-- INSERT INTO OUTPATIENT (ID, NxtExmTime)
-- VALUES 
--     (321456789, '2020-12-07'),
--     (234129568, '2020-11-24'),
--     (245123468, '2020-11-25'),
--     (335124161, '2020-12-31')
-- ;

INSERT INTO BOARDEDPATIENT (DoctorID, NxtVisitTime, DepartID, NurseID, BoardedTime, ID)
VALUES
    (345615634,'2020-11-25',1,341634578,'2020-11-23', 012345678);
    -- (461923053, '2021-01-12', 1, 341634578, '2020-11-23', 123456789),
    -- (982367598, '2021-06-04', 3, 871291231, '2020-11-25', 091276243),
    -- (812749801, '2021-08-23', 4, 670137514, '2020-11-24', 984316506),
    -- (356474245, '2021-08-26', 1, 213415131, '2020-11-23', 830185245),
    -- (768056761, '2021-10-12', 1, 670137514, '2020-11-26', 230761341),
    -- (132468913, '2021-03-02', 2, 812749312, '2020-11-25', 527492357),
    -- (345615634, '2021-03-22', 3, 571415109, '2020-11-24', 346282624)
;

INSERT INTO PRESCRIPTION (ExamID, DocID, Diet)
VALUES
    -- (12, 461923053, 'None'),
    -- (12, 245015682, 'Eat fressh'),
    -- (13, 673582921, 'Eat healthy'),
    -- (14, 673582921, 'Meat only'),
    -- (15, 132468913, 'Chicken only'),
    -- (16, 812749801, 'Need more protein'),
    -- (17, 345615634, 'Drink 2 litres of water everyday'),
    -- (18, 461923053, 'Smoke is good'),
    -- (19, 356474245, 'Workout'),
    -- (20, 768056761,'Eat more meat'),
    -- (21, 982367598, 'Drink alcohol'),
    -- (22, 345615634, 'Drink cola')
;

INSERT INTO MEDICINE (Dates, Amount, UsageDes, MName, PresID)
VALUES
    -- ('2020-12-02', 12, 'No usage found', "Apremumab", 78),
    -- ('2020-12-03', 2, '1 for a lifetime', "Ribamine", 79),
    -- ('2020-12-09', 26, '2 times a day - 3 pills each', 'Cefodiol', 80),
    -- ('2020-12-10', 50, '8 times a day', 'Aclorodine', 81),
    -- ('2020-12-24', 18, '2 times a day', 'Oflocriptine', 79),
    -- ('2020-11-30', 6, '1 time a month', 'Paroridol', 88),
    -- ('2020-12-03', 45, '3 times a week every 2 days', 'Acecerol', 86),
    -- ('2020-12-08', 8, '1 times a day in the morning', 'Enavatol', 87),
    -- ('2020-12-31', 12, '2 times a week', 'Alkeprotin', 83),
    -- ('2020-12-01', 15, 'No usage found', "Apremumab", 78),
    -- ('2020-11-30', 18, 'No usage found', "Apremumab", 78),
    -- ('2020-11-30', 30, 'Use wisely', "Paroridol", 89),
    -- ('2020-12-01', 25, 'Use brightly', "Paroridol", 89),
    -- ('2020-12-02', 20, 'Use deadly', "Paroridol", 89),
    -- ('2020-11-30', 30, 'Use deadly', "Alkeprotin", 89),
    -- ('2020-12-01', 25, 'Use deadly', "Alkeprotin", 89),
    -- ('2020-12-02', 20, 'Use deadly', "Alkeprotin", 89)
;

INSERT INTO BoardedRecord (PatientID, BoardedTime, BoardedDis, LeaveAsnDocID, AsnDocID, BoardedCond, BedNo, LeaveTime, LeaveDis, LeaveNote, LeaveCond, RoomNo)
VALUES
    (123456789, '2020-11-23', 'Dead', Null, 461923053, 'Dead', 1, Null, NUll, Null, Null, 1),
    (091276243, '2020-11-25', 'Deceased', 982367598, 768056761, 'Break head', 2, '2021-03-04', 'Cured', 'Uncured', 'Break everything', 2),
    (984316506, '2020-11-24', 'Unknown', 812749801, 982367598,'Unknown', 3, '2020-12-30', 'Lmao', 'mlao', 'nothing here', 3),
    (830185245, '2020-11-23', 'Something happened', 356474245, 356474245, 'Lmao', 4, '2020-12-25', 'Null', 'lmfaoo', 'No head', 5),
    (230761341, '2020-11-26', 'Pulled leg', Null, 768056761, 'Plam', 5, Null, Null, Null, Null, 6),
    (527492357, '2020-11-25', 'Missing head', 132468913, 356474245,'hello', 6, '2020-12-18', 'Unknow', 'back to space', 'to infinity', 7),
    (346282624, '2020-11-24', 'Missing genital', Null, 345615634, 'cant be cured', 7, Null, Null, Null, Null, 8)
;

INSERT INTO Test (ID, Result, CommonIndex, Note, TName)
VALUES
    (0,0,0,Null,Null),
    (1,12, 45, 'Abnormal', "Blood pressure"),
    (2,35, 50, 'Abnormal', "Brain test"),
    (3,60, 45, 'Normal' ,'Leg test'),
    (4,34, 20, 'Normal', 'Heart test'),
    (5,130, 100, 'Normal', 'Skin test'),
    (6,90, 100, 'Abnormal', 'Kidney'),
    (7,62, 80, 'Abnormal', "Lung"),
    (8,78, 10, 'Normal', 'Hair'),
    (9,70, 50, 'Abnormal', 'Thigh')
;

INSERT INTO Ftest (ID, Result, TName)
VALUES
    (0,Null,Null),
    (1,'Normal', "Breast"),
    (2,'Squeezed bone', "Body"),
    (3,'Abnormal spine', "Body"),
    (4,'Broken leg', "Leg"),
    (5,'Shattered skull', "Head"),
    (6,'Amputated arm', "Arm"),
    (7,'Disallocated shoulder', "Shoulder"),
    (8,'Broken neck', "Neck")
;

INSERT INTO DEPARTMENT (Dname)
VALUES
    ('Traumatology'),
    ('Incretology'),
    ('Dermatology'),
    ('Obstetrics')
;

INSERT INTO SHIFT (ID, DepartID, Dates, Periods)
VALUES
    ('0120201123A', 1, '2020-11-23', 'A'),
    ('0120201123B', 1, '2020-11-23', 'B'),
    ('0220201123A', 2, '2020-11-23', 'A'),
    ('0220201123B', 2, '2020-11-23', 'B'),
    ('0320201123A', 3, '2020-11-23', 'A'),
    ('0320201123B', 3, '2020-11-23', 'B'),
    ('0420201123A', 4, '2020-11-23', 'A'),
    ('0420201123B', 4, '2020-11-23', 'B'),

    ('0120201124A', 1, '2020-11-24', 'A'),
    ('0120201124B', 1, '2020-11-24', 'B'),
    ('0220201124A', 2, '2020-11-24', 'A'),
    ('0220201124B', 2, '2020-11-24', 'B'),
    ('0320201124A', 3, '2020-11-24', 'A'),
    ('0320201124B', 3, '2020-11-24', 'B'),
    ('0420201124A', 4, '2020-11-24', 'A'),
    ('0420201124B', 4, '2020-11-24', 'B'),

    ('0120201125A', 1, '2020-11-25', 'A'),
    ('0120201125B', 1, '2020-11-25', 'B'),
    ('0220201125A', 2, '2020-11-25', 'A'),
    ('0220201125B', 2, '2020-11-25', 'B'),
    ('0320201125A', 3, '2020-11-25', 'A'),
    ('0320201125B', 3, '2020-11-25', 'B'),
    ('0420201125A', 4, '2020-11-25', 'A'),
    ('0420201125B', 4, '2020-11-25', 'B'),

    ('0120201126A', 1, '2020-11-26', 'A'),
    ('0120201126B', 1, '2020-11-26', 'B'),
    ('0220201126A', 2, '2020-11-26', 'A'),
    ('0220201126B', 2, '2020-11-26', 'B'),
    ('0320201126A', 3, '2020-11-26', 'A'),
    ('0320201126B', 3, '2020-11-26', 'B'),
    ('0420201126A', 4, '2020-11-26', 'A'),
    ('0420201126B', 4, '2020-11-26', 'B'),

    ('0120201127A', 1, '2020-11-27', 'A'),
    ('0120201127B', 1, '2020-11-27', 'B'),
    ('0220201127A', 2, '2020-11-27', 'A'),
    ('0220201127B', 2, '2020-11-27', 'B'),
    ('0320201127A', 3, '2020-11-27', 'A'),
    ('0320201127B', 3, '2020-11-27', 'B'),
    ('0420201127A', 4, '2020-11-27', 'A'),
    ('0420201127B', 4, '2020-11-27', 'B')
;

INSERT INTO EXAMINATION (PatientID, NurseID, DocID, ShiftID, DiagRes)
VALUES
    (012345678, 341634578,345615634,'0120201123A','Unknown props');
--     (321456789, 213415131, 356474245, '0120201123A', 'Normal'),
--     (234129568, 215134751, 132468913, '0220201123B', 'Abnormal'),
--     (335124161, 341634578, 812749801, '0420201124A', 'Crazy in love'),
--     (245123468, 123241512, 132468913, '0220201124B', 'Broken Neck'),
--     (123456789, 812749312, 345615634, '0320201126B', 'Broken Leg'),
--     (091276243, 571415109, 245015682, '0220201125A', 'Malfunction Kidney'),
--     (984316506, 670137514, 461923053, '0120201126A', 'Multiple broken legs'),
--     (830185245, 123241512, 673582921, '0220201123A', 'No brain found'),
--     (230761341, 215134751, 812749801, '0420201123A', 'Heartbroken'),
--     (527492357, 571415109, 982367598, '0320201126B', 'Unknown disease'),
--     (346282624, 871291231, 345615634, '0320201127A', 'Broken Skull')
-- ;

INSERT INTO OnDuty (DocID, ShiftID)
VALUES
--23A
    (461923053, '0120201123A'),
    (356474245, '0120201123A'),
    (768056761, '0120201123A'),

    (245015682, '0220201123A'),
    (673582921, '0220201123A'),

    (982367598, '0320201123A'),
    (345615634, '0320201123A'),

    (812749801, '0420201123A'),
--23B
    (356474245, '0120201123B'),

    (132468913, '0220201123B'),

    (345615634, '0320201123B'),
    (982367598, '0320201123B'),

    (812749801, '0420201123B'),
--24A
    (461923053, '0120201124A'),
    (768056761, '0120201124A'),

    (245015682, '0220201124A'),
    (673582921, '0220201124A'),
    
    (982367598, '0320201124A'),

    (812749801, '0420201124A'),
--24B
    (461923053, '0120201124B'),

    (245015682, '0220201124B'),
    (673582921, '0220201124B'),
    
    (982367598, '0320201124B'),

    (812749801, '0420201124B'),

--25A  
    (461923053, '0120201125A'),
    (768056761, '0120201125A'),

    (245015682, '0220201125A'),

    (982367598, '0320201125A'),

    (812749801, '0420201125A'),
--25B
    (356474245, '0120201125B'),
    (461923053, '0120201125B'),

    (673582921, '0220201125B'),
    (132468913, '0220201125B'),
    
    (982367598, '0320201125B'),

    (812749801, '0420201125B'),
--26A
    (356474245, '0120201126A'),

    (245015682, '0220201126A'),
    (132468913, '0220201126A'),
    
    (982367598, '0320201126A'),

    (812749801, '0420201126A'),
--26B
    (356474245, '0120201126B'),
    (768056761, '0120201126B'),

    (673582921, '0220201126B'),

    (982367598, '0320201126B'),

    (812749801, '0420201126B'),
--27A
    (356474245, '0120201127A'),
    (768056761, '0120201127A'),

    (245015682, '0220201127A'),
    (132468913, '0220201127A'),

    (345615634, '0320201127A'),
    (982367598, '0320201127A'),

    (812749801, '0420201127A'),
--27B
    (356474245, '0120201127B'),

    (673582921, '0220201127B'),
    (132468913, '0220201127B'),

    (345615634, '0320201127B'),
    (982367598, '0320201127B'),

    (812749801, '0420201127B')
;

INSERT INTO TakeTest (ExamID, TestID, FtestID)
VALUES
    (21, 1, 3),
    (12, 2, 5),
    (13, 3, 6),
    (14, 4, 7),
    (15, 5, 0),
    (16, 6, 8),
    (15, 7, 1),
    (17, 8, 2),
    (18, 6, 7),
    (20, 0, 4)
;

INSERT INTO PERFORMTEST (DocID, ShiftID, TestID)
VALUES
    (132468913, '0120201123A', 2),
    (982367598, '0120201123A', 3),
    (812749801, '0120201123B', 5),
    (245015682, '0220201123B', 1),
    (245015682, '0420201123A', 7),
    (768056761, '0420201123B', 4),
    (245015682, '0120201126A', 6),
    (812749801, '0120201127A', 8)
;

INSERT INTO PERFORMFTEST (DocID, ShiftID, FTestID)
VALUES
    (245015682, '0120201123A', 1),
    (982367598, '0120201123A', 2),
    (812749801, '0120201123A', 4),
    (132468913, '0120201127A', 6),
    (245015682, '0120201127A', 7),
    (768056761, '0120201123A', 8),
    (245015682, '0420201123B', 3),
    (812749801, '0120201123B', 5)
;

INSERT INTO TakeTest (ExamID, TestID, FtestID)
VALUES
    (14, 1, 1),
    (15, 2, 2),
    (16, 3, 3),
    (17, 4, 4),
    (18, 5, 5),
    (14, 6, 0),
    (15, 7, 6),
    (19, 8, 0),
    (16, 9, 7),
    (12, 0, 8)
;

INSERT INTO MEDICINELIST (MName)
VALUES
    -- ('Apremumab'),
    -- ('Alkeprotin'),
    -- ('Paroridol'),
    -- ('Ribamine'),
    -- ('Cefodiol'),
    -- ('Aclorodine'),
    -- ('Oflocriptine'),
    ('Acecerol'),
    ('Enavatol')    
;

INSERT INTO TESTLIST (TName, CommonIndex)
VALUES
    ('Blood pressure', 45),
    ('Brain test',50),
    ('Leg test',45),
    ('Heart test', 20),
    ('Skin test',100),
    ('Kidney',100),
    ('Lung',80),
    ('Hair',10),
    ('Thigh',50)
;

INSERT INTO FTESTLIST (TName)
VALUES
    ('Breast'),
    ('Body'),
    ('Leg'),
    ('Head'),
    ('Arm'),
    ('Shoulder'),
    ('Neck')
;