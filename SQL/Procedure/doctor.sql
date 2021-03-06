DROP PROCEDURE IF EXISTS updateOPat;
CREATE PROCEDURE updateOPat
    (IN pID INT)
BEGIN 
    UPDATE OUTPATIENT
END;

DROP PROCEDURE IF EXISTS updateBPat;
CREATE PROCEDURE updateBPat
    (IN pID INT)
BEGIN 
    UPDATE BOARDEDPATIENT
END;

--3
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
-- CALL getPatDate('2020-11-23', 356474245);

--4
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
-- CALL getDiagRes(356474245, 321456789);

--5
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
-- CALL getUsedMedOfBP(356474245,830185245);

--6
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
-- CALL getTestOfBPat(345615634, 123456789);
--7
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
-- CALL getFTestOfBPat(345615634, 123456789);
--8 
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

--9
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
-- CALL getPatOfDiseaseAbnormal(345615634,'Broken Leg');
--10
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
-- CALL getPatOut(356474245);
--11
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
-- CALL getBPatWithDecUsed(345615634,'Alkeprotin');

--12
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
-- CALL getPatWithNorAbnorRes();