--1
DROP PROCEDURE IF EXISTS updateInfo;
CREATE PROCEDURE updateInfo
    (IN pID INT, IN insurID INT, IN lname VARCHAR(255), IN minit VARCHAR(255), IN fname VARCHAR(255), IN bdate DATE, IN addr VARCHAR(255))
BEGIN 
    UPDATE PATIENT
    SET InsurID = insurID, LName = lname, Minit = minit, Fname = fname, Bdate = bdate, Addr = addr
    WHERE ID = pID
    ;
END;

--2
DROP PROCEDURE IF EXISTS getMedLatest;
CREATE PROCEDURE getMedLatest
    (IN pID INT)
BEGIN 
    SELECT M.MName 
    FROM MEDICINE AS M
    JOIN PATIENT AS P on P.ID = pID
    JOIN EXAMINATION AS E on E.PatientID = P.ID
    JOIN PRESCRIPTION AS Pr ON Pr.ExamID = E.ID AND M.PresID = Pr.ID
    JOIN SHIFT AS S ON S.ID = E.ShiftID              
        AND S.Dates = (
            SELECT s2.Dates
            FROM SHIFT AS s2
            JOIN PATIENT AS p2 ON p2.ID = pID     
            JOIN EXAMINATION AS e2 ON e2.ShiftID = s2.ID AND e2.PatientID = p2.ID                                                   
            ORDER BY s2.Dates DESC limit 1           
        )
    ;
END;
-- CALL getMedLatest(346282624);

--3
DROP PROCEDURE IF EXISTS getMedAll;
CREATE PROCEDURE getMedAll
    (IN pID INT)
BEGIN 
    SELECT m.MName
    FROM MEDICINE as m
    JOIN PATIENT as p ON  p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID
    JOIN PRESCRIPTION as pre ON pre.ExamID = e.ID AND m.PresID = pre.ID                    
    ;
END;     
-- CALL getMedAll(346282624);

-- -- --4
DROP PROCEDURE IF EXISTS getTestResLatest;
CREATE PROCEDURE getTestResLatest
    (IN pID INT)
BEGIN 
    SELECT t.*
    FROM Test as t
    JOIN PATIENT as p ON p.ID = pID 
    JOIN EXAMINATION as e ON e.PatientID = p.ID
    JOIN TakeTest as tt ON tt.ExamID = e.ID AND tt.TestID = t.ID
    JOIN SHIFT as s ON s.ID = e.ShiftID
        AND s.Dates = (
            SELECT s2.Dates
            FROM SHIFT AS s2
            JOIN PATIENT AS p2 ON p2.ID = pID     
            JOIN EXAMINATION AS e2 ON e2.ShiftID = s2.ID AND e2.PatientID = p2.ID                                                   
            ORDER BY s.Dates DESC limit 1
        )
    ;
END;
-- CALL getTestResLatest(123456789);
-- -- --5
DROP PROCEDURE IF EXISTS getAllTest;
CREATE PROCEDURE getAllTest 
    (IN pID INT)
BEGIN 
    SELECT t.*
    FROM Test as t 
    JOIN PATIENT as p ON p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID    
    JOIN TakeTest as tt ON tt.ExamID = e.ID AND tt.TestID = t.ID     
    ;   
END; 
-- CALL getAllTest(123456789);

-- --6
DROP PROCEDURE IF EXISTS getAllAbnorTest;
CREATE PROCEDURE getAllAbnorTest
    (IN pID INT, IN tName VARCHAR(255))
BEGIN 
    SELECT t.*
    FROM Test as t
    JOIN PATIENT as p ON p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID
    JOIN TakeTest as tt ON  tt.TestID = t.ID AND tt.ExamID = e.ID
    WHERE t.TName = tName and t.Note = 'Abnormal'             
    ;
END;
-- CALL getAllAbnorTest(123456789,'Thigh');

-- --7
DROP PROCEDURE IF EXISTS getDocLatest;
CREATE PROCEDURE getDocLatest
    (IN pID INT)
BEGIN 
    (SELECT  d.*
    FROM DOCTOR as d
    JOIN PATIENT as p ON p.ID = pID 
    JOIN EXAMINATION as e ON e.PatientID = p.ID AND d.ID = e.DocID
    JOIN SHIFT as s ON s.ID = e.ShiftID
        AND s.Dates = (
            SELECT s2.Dates
            FROM SHIFT AS s2
            JOIN PATIENT AS p2 ON p2.ID = pID     
            JOIN EXAMINATION AS e2 ON e2.ShiftID = s2.ID AND e2.PatientID = p2.ID                                                   
            ORDER BY s2.Dates DESC limit 1
        )
    )
    UNION 
    (SELECT  d.*
    FROM DOCTOR as d
    JOIN PATIENT as p ON p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID
    JOIN TakeTest as tt ON tt.ExamID = e.ID
    JOIN PERFORMTEST as pt ON pt.DocID = d.ID AND tt.TestID = pt.TestID
    JOIN SHIFT as s ON s.ID = e.ShiftID
        AND s.Dates = (
            SELECT s2.Dates
            FROM SHIFT AS s2
            JOIN PATIENT AS p2 ON p2.ID = pID     
            JOIN EXAMINATION AS e2 ON e2.ShiftID = s2.ID AND e2.PatientID = p2.ID                                                   
            ORDER BY s2.Dates DESC limit 1
        )
    )
    UNION 
    (
    SELECT d.*
    FROM DOCTOR as d
    JOIN PATIENT as p ON p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID
    JOIN TakeTest as tt ON tt.ExamID = e.ID
    JOIN PERFORMFTEST as pf ON pf.DocID = d.ID AND tt.FTestID = pf.FTestID 
    JOIN SHIFT as s ON s.ID = e.ShiftID
        AND s.Dates = (
            SELECT s2.Dates
            FROM SHIFT AS s2
            JOIN PATIENT AS p2 ON p2.ID = pID     
            JOIN EXAMINATION AS e2 ON e2.ShiftID = s2.ID AND e2.PatientID = p2.ID                                                   
            ORDER BY s2.Dates DESC limit 1
        )
    )
    ;
END;
-- CALL getDocLatest(346282624);

-- --8
DROP PROCEDURE IF EXISTS getAllDoc;
CREATE PROCEDURE getAllDoc
    (IN pID INT)
BEGIN 
    (SELECT d.*
    FROM DOCTOR as d
    JOIN PATIENT as p ON p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID AND d.ID = e.DocID    
    )
    UNION 
    (SELECT  d.*
    FROM DOCTOR as d
    JOIN PATIENT as p ON p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID
    JOIN TakeTest as tt ON tt.ExamID = e.ID
    JOIN PERFORMTEST as pt ON pt.DocID = d.ID AND tt.TestID = pt.TestID
    )
    UNION 
    (SELECT  d.*
    FROM DOCTOR as d
    JOIN PATIENT as p ON p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID
    JOIN TakeTest as tt ON tt.ExamID = e.ID
    JOIN PERFORMFTEST as pf ON pf.DocID = d.ID AND tt.FTestID = pf.FTestID                            
    )
    ;    
END;
-- CALL getAllDoc(346282624);

-- --9
DROP PROCEDURE IF EXISTS getDietLatest;
CREATE PROCEDURE getDietLatest
    (IN pID INT)
BEGIN 
    SELECT pre.Diet
    FROM PRESCRIPTION as pre
    JOIN PATIENT as p ON p.ID = pID 
    JOIN EXAMINATION as e ON e.PatientID = p.ID    
    JOIN SHIFT as s ON s.ID = e.ShiftID AND pre.ExamID = e.ID
        AND s.Dates = (
            SELECT s2.Dates
            FROM SHIFT AS s2
            JOIN PATIENT AS p2 ON p2.ID = pID     
            JOIN EXAMINATION AS e2 ON e2.ShiftID = s2.ID AND e2.PatientID = p2.ID                                                   
            ORDER BY s2.Dates DESC limit 1
        )
    ;
END;
-- CALL getDietLatest(346282624);

-- --10
DROP PROCEDURE IF EXISTS getAllDiet;
CREATE PROCEDURE getAllDiet
    (IN pID INT)
BEGIN 
    SELECT pre.Diet
    FROM PRESCRIPTION as pre    
    JOIN PATIENT as p ON p.ID = pID
    JOIN EXAMINATION as e ON e.PatientID = p.ID AND pre.ExamID = e.ID   
    ;     
END;
-- CALL getAllDiet(830185245);