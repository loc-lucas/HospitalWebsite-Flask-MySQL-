--3: Get list of patient they in charge in 1 date
DROP PROCEDURE IF EXISTS getPatDate;
CREATE PROCEDURE getPatDate
    (IN dates DATE, IN docID INT)
BEGIN 
    SELECT Distinct P.*
    FROM PATIENT AS P
    JOIN DOCTOR as D ON D.ID = docID
    JOIN SHIFT as S ON S.Dates = dates
    JOIN EXAMINATION as E ON E.PatientID = P.ID
        AND E.ShiftID = S.ID
        AND E.DocID = D.ID
    ;
END;

--4: Get diagnosis of 1 patient
DROP PROCEDURE IF EXISTS getDiagRes;
CREATE PROCEDURE getDiagRes 
    (IN docID INT, IN pID INT)
BEGIN 
    SELECT E.DiagRes
    FROM EXAMINATION as E
    JOIN DOCTOR as D ON D.ID = docID
        AND E.DocID = D.ID
        AND E.PatientID = pID
    ;
END;   

--5: Get all medicine the boarded patient they in charged has used
DROP PROCEDURE IF EXISTS getUsedMedOfBP;
CREATE PROCEDURE getUsedMedOfBP
    (IN docID INT, IN pID INT)
BEGIN
    SELECT Distinct Pr.*
    FROM PRESCRIPTION as Pr 
    JOIN MEDICINE as M ON Pr.ID = M.PresID
        AND M.Dates < CAST(CURRENT_DATE() as DATE)    
    JOIN DOCTOR as D ON D.ID
    JOIN EXAMINATION as E ON E.DocID = D.ID
        AND E.PatientID = pID
        AND Pr.ExamID = E.ID
    JOIN BOARDEDPATIENT as B ON E.PatientID = B.ID
    ;
END;

--6: Get test list of a boarded patient they in charged 
DROP PROCEDURE IF EXISTS getTestOfBPat;
CREATE PROCEDURE getTestOfBPat
    (IN docID INT, IN pID INT)
BEGIN 
    SELECT T.ID, T.Result, T.Note
    FROM Test as T 
    JOIN EXAMINATION as E ON E.PatientID = pID
    JOIN TakeTest as TT ON TT.TestID = T.ID
        AND TT.ExamID = E.ID 
    JOIN DOCTOR as D ON D.ID = docID 
        AND E.DocID = D.ID
    JOIN BOARDEDPATIENT as B ON B.ID = E.PatientID
    ;
END;    

--7: Get film test list of a boarded patient they in charged 
DROP PROCEDURE IF EXISTS getFTestOfBPat;
CREATE PROCEDURE getFTestOfBPat
    (IN docID INT, IN pID INT)
BEGIN 
    SELECT T.ID, T.Result
    FROM Ftest as T
    JOIN EXAMINATION as E ON E.PatientID = pID
    JOIN TakeTest as TT ON TT.FTestID = T.ID
        AND TT.ExamID = E.ID 
    JOIN DOCTOR as D ON D.ID = docID 
        AND E.DocID = D.ID
    JOIN BOARDEDPATIENT as B ON B.ID = E.PatientID
    ;
END; 

--8: Get list of patient of 1 diagnosed diseases they diagnose
DROP PROCEDURE IF EXISTS getPatOfDisease;
CREATE PROCEDURE getPatOfDisease
    (IN docID INT, IN disease VARCHAR(255))
BEGIN 
    SELECT Distinct P.*
    FROM PATIENT as P
    JOIN DOCTOR as D ON D.ID = docID
    JOIN EXAMINATION as E ON E.PatientID = P.ID
        AND D.ID = E.DocID        
        AND E.DiagRes = disease
    ;
END; 
-- CALL getPatOfDisease(812749801,'Crazy in love');

--9: Get list of patient of 1 diagnosed diseases they diagnose with abnormal note
DROP PROCEDURE IF EXISTS getPatOfDiseaseAbnormal;
CREATE PROCEDURE getPatOfDiseaseAbnormal
    (IN docID INT, IN disease VARCHAR(255))
BEGIN 
    SELECT Distinct P.*
    FROM PATIENT as P
    JOIN DOCTOR  as D ON D.ID = docID
    JOIN EXAMINATION as E ON E.PatientID = P.ID
        AND E.DocID = D.ID
        AND E.DiagRes = disease        
    JOIN Test as T ON T.Note = 'Abnormal'
    JOIN TakeTest as TT ON TT.TestID = T.ID
        AND E.ID = TT.ExamID
    ;
END;

--10: Get list of patient that get out of boarded state that they in charge
DROP PROCEDURE IF EXISTS getPatOut;
CREATE PROCEDURE getPatOut
    (IN docID INT)
BEGIN 
    SELECT Distinct P.*
    FROM DOCTOR as D 
    JOIN BOARDEDPATIENT as B
    JOIN BoardedRecord as BR ON B.ID = BR.PatientID
        AND BR.LeaveAsnDocID = D.ID
    JOIN PATIENT as P ON P.ID = B.ID
    WHERE D.ID = docID
    ;
END; 

--11: Get list of boarded patient that have decreasing amount of a specific medicine in 3 consecutive used time
DROP PROCEDURE IF EXISTS getBPatWithDecUsed;
CREATE PROCEDURE getBPatWithDecUsed
    (IN docID INT, IN medName VARCHAR(255))
BEGIN
    SELECT Distinct P.*
    FROM PATIENT as P
    JOIN DOCTOR as D ON D.ID = docID
    JOIN BOARDEDPATIENT as B ON B.DoctorID = D.ID AND B.ID = P.ID
    JOIN EXAMINATION as E ON E.PatientID = P.ID
    JOIN PRESCRIPTION as Pr ON Pr.ExamID = E.ID
    JOIN MEDICINE as M1 ON M1.PresID = Pr.ID AND M1.MName = medName
    JOIN MEDICINE as M2 ON M2.PresID = Pr.ID AND M1.MName = M2.MName        
    JOIN MEDICINE as M3 ON M3.PresID = Pr.ID AND M1.MName = M3.MName            
    WHERE M1.Dates < M2.Dates AND M2.Dates < M3.Dates 
        AND M1.Amount > M2.Amount AND M2.Amount > M3.Amount
    ;            
END;    

--12: Get list of patient with normal res in 1 test that has abnormal result in the previous same test
DROP PROCEDURE IF EXISTS getPatWithNorAbnorRes;
CREATE PROCEDURE getPatWithNorAbnorRes
    (IN testName VARCHAR(255), IN docID INT)
BEGIN
    SELECT DISTINCT P.*
    FROM PATIENT as P
    JOIN DOCTOR as D ON D.ID = docID
    JOIN Test as T ON T.Note = 'Normal'
    JOIN Test as T2 ON T2.Note = 'Abnormal' AND T2.TName = T1.TName
    JOIN EXAMINATION as E ON E.DocID = D.ID AND E.PatientID = P.ID
    JOIN SHIFT as S ON S.ID = E.ShiftID
        AND S.Dates = (
            SELECT S.Dates
            FROM SHIFT AS S2
            JOIN DOCTOR as D2 ON D2.ID = docID
            JOIN EXAMINATION as E2 ON E2.DocID = D2.ID AND E2.ShiftID = S2.ID
            JOIN PATIENT as P2 ON E2.PatientID = P2.ID                                                        
            ORDER BY S.DATES DESC LIMIT 1
        )
    JOIN TakeTest as TT ON TT.ExamID = E.ID AND TT.TestID = T.ID    
    JOIN EXAMINATION as E2 ON E2.DocID = D.ID AND E2.PatientID = P.ID        
    JOIN TakeTest as TT2 ON E2.ID = TT2.ExamID AND TT2.TestID = T2.ID
    ;
END;

-- add new examination
DROP PROCEDURE IF EXISTS addExam;
CREATE PROCEDURE addExam
    (IN pID CHAR(9), IN nID CHAR(9), IN dID CHAR(9), IN shiftID CHAR(11), IN diagRes VARCHAR(256))
BEGIN 
    INSERT  EXAMINATION (PatientID, NurseID, DocID, ShiftID, DiagRes)
    VALUES 
        (pID, nID, dID, shiftID, diagRes)
    ;
END;

-- add new test
DROP PROCEDURE IF EXISTS addTest;
CREATE PROCEDURE addTest
    (IN id INTEGER, IN result FLOAT, IN tName VARCHAR(30), IN note VARCHAR(30))
BEGIN 
    INSERT Test (ID, Result, TName, Note)
    VALUES 
        (id, result, tName, note)
    ;
END;

-- add new film test
DROP PROCEDURE IF EXISTS addFTest;
CREATE PROCEDURE addFTest
    (IN id INTEGER, IN result FLOAT, IN tName VARCHAR(30))
BEGIN 
    INSERT  FTEST (ID, Result, TName)
    VALUES 
        (id, result, tName)
    ;
END;

-- add new prescription
DROP PROCEDURE IF EXISTS addPres;
CREATE PROCEDURE addPres
    (IN eID INTEGER, IN dID CHAR(9), IN diet VARCHAR(256))
BEGIN 
    INSERT  PRESCRIPTION (ExamID, DocID, Diet)
    VALUES 
        (eID, dID, diet)
    ;
END;

-- add new medicine
DROP PROCEDURE IF EXISTS addMed;
CREATE PROCEDURE addMed
    (IN dates DATE , IN amount INTEGER, IN usageDes VARCHAR(50), IN mName VARCHAR(15), IN presID INTEGER)
BEGIN 
    INSERT  MEDICINE (Dates, Amount, UsageDes, PresID)
    VALUES 
        (dates, amount, usageDes, mName, presID)
    ;
END;

-- add new take test
DROP PROCEDURE IF EXISTS addTakeTest;
CREATE PROCEDURE addTakeTest
    (IN examID INTEGER , IN testID INTEGER, IN fTestID INTEGER)
BEGIN 
    INSERT  TakeTest (ExamID, TestID, FTestID)
    VALUES 
        (examID, testID, fTestID)
    ;
END;