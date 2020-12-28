-- 1: Get list of doctors in charge of 1 period at 1 date in 1 department
DROP PROCEDURE IF EXISTS getDocAtSpecificDSD;
CREATE PROCEDURE getDocAtSpecificDSD
    (IN dates Date, IN dID INT, IN periods CHAR(1))
BEGIN    
    SELECT Distinct D.*, DP.DName
    FROM DOCTOR as D
    JOIN SHIFT as S ON 
        S.Dates = dates
        AND S.DepartID = dID
        AND S.Periods = periods
    JOIN OnDuty as O ON 
        O.ShiftID = S.ID 
        AND O.DocID = D.ID
    JOIN DEPARTMENT as DP ON DP.ID = D.DepartID
    ;
END;

-- 2: Get list of doctors in charge at 1 day in 1 department
DROP PROCEDURE IF EXISTS getDocICDateDepart;
CREATE PROCEDURE getDocICDateDepart
    (IN dates DATE, IN departID INT)
BEGIN
    SELECT Distinct D.*, DP.DName
    FROM DOCTOR as D
    JOIN SHIFT as S ON S.Dates = dates 
        AND S.DepartID = departID
    JOIN OnDuty as O ON  O.DocID = D.ID 
        AND S.ID = O.ShiftID
    JOIN DEPARTMENT as DP ON DP.ID = D.DepartID        
    ;
END;

-- 3: Get list of doctors in charge of 1 period at 1 date of all departments
DROP PROCEDURE IF EXISTS getDocICPerDate;
CREATE PROCEDURE getDocICPerDate
    (IN dates DATE, IN peri CHAR(1))
BEGIN 
    SELECT Distinct D.*, DP.DName
    FROM DOCTOR as D 
    JOIN SHIFT as S ON S.Dates = dates AND S.Periods = peri
    JOIN OnDuty as O ON S.ID = O.ShiftID AND O.DocID = D.ID
    JOIN DEPARTMENT as DP ON DP.ID = D.DepartID   
    ;
END;

-- 4: Get list of doctors in charge at 1 day in ALL departments
DROP PROCEDURE IF EXISTS getDocICDate;
CREATE PROCEDURE getDocICDate
    (IN dates DATE)
BEGIN 
    SELECT Distinct D.*, DP.Dname
    FROM DOCTOR as D 
    JOIN SHIFT as S ON S.Dates = dates 
    JOIN OnDuty as O ON S.ID = O.ShiftID AND O.DocID = D.ID
    JOIN DEPARTMENT as DP ON DP.ID = D.DepartID   
    ;
END;

-- 5: Count all patients in 1 period at 1 date in 1 department
DROP PROCEDURE IF EXISTS countPatPerDateDepart;
CREATE PROCEDURE countPatPerDateDepart
    (IN dates DATE, IN departID INT, IN peri CHAR(1))
BEGIN
    SELECT Count(*)
    FROM PATIENT as P 
    JOIN SHIFT as S ON S.Periods = peri
        AND S.Dates = dates
        AND S.DepartID = departID
    JOIN EXAMINATION as E ON S.ID = E.ShiftID
        AND E.PatientID = P.ID
    ;
END;

-- 6: Count all boarded patient in 1 period at 1 date in 1 department
DROP PROCEDURE IF EXISTS countBPatPerDateDepart;
CREATE PROCEDURE countBPatPerDateDepart
    (IN dates DATE, IN departID INT, IN peri CHAR(1))
BEGIN 
    SELECT Count(*)
    FROM PATIENT as P 
    JOIN SHIFT as S ON S.Periods = peri
        AND S.Dates = dates
        AND S.DepartID = departID
    JOIN EXAMINATION as E ON S.ID = E.ShiftID
        AND E.PatientID = P.ID        
    JOIN BOARDEDPATIENT as B ON B.ID = P.ID
        AND S.Dates = B.BoardedTime
    WHERE P.Sts = 'Boarded'
    ;
END;

-- 7: Count all out patient in 1 period at 1 date in 1 department
DROP PROCEDURE IF EXISTS countOPatPerDateDepart;
CREATE PROCEDURE countOPatPerDateDepart
    (IN dates DATE, IN departID INT, IN peri CHAR(1))
BEGIN -- 5: Count all patients in 1 period at 1 date in 1 department
    SELECT Count(*)
    FROM PATIENT as P
    JOIN SHIFT as S ON S.Periods = peri
        AND S.Dates = dates
        AND S.DepartID = departID    
    JOIN EXAMINATION as E ON S.ID = E.ShiftID
        AND E.PatientID = P.ID
    JOIN OUTPATIENT as O ON O.ID = P.ID
    ;
END; 

-- 9: Count all boarded patient in 1 period at 1 date in all departments
DROP PROCEDURE IF EXISTS countBPatPerDate;
CREATE PROCEDURE countBPatPerDate
    (IN dates DATE, IN peri CHAR(1))
BEGIN 
    SELECT Count(*)
    FROM PATIENT as P
    JOIN SHIFT as S ON S.Periods = peri
        AND S.Dates = dates
    JOIN EXAMINATION as E ON S.ID = E.ShiftID
        AND E.PatientID = P.ID
    JOIN OUTPATIENT as O ON O.ID = P.ID
    ;
END;

-- 10: Count all out patient in 1 period at 1 date in all departments
CREATE PROCEDURE countOPatPerDate
    (IN dates DATE, IN peri CHAR(1))
BEGIN 
    SELECT Count(*)
    FROM patient as P
    JOIN shift as S ON S.Periods = peri
        AND S.Dates = dates
    JOIN examination as E ON S.ID = E.ShiftID
        AND E.PatientID = P.ID
    JOIN outpatient as O ON O.ID = P.ID
    ;
END; 

-- 11: Count all test taken in 1 date in 1 department
DROP PROCEDURE IF EXISTS countTestDateDepart;
CREATE PROCEDURE countTestDateDepart
    (IN dates DATE, IN departID INT)
BEGIN 
    SELECT        
        (SELECT COUNT(*)
        FROM SHIFT as S
        JOIN PERFORMTEST as P ON S.ID = P.ShiftID
        JOIN Test as T ON P.TestID = T.ID
        WHERE S.Dates = dates
            AND S.DepartID = departID
        ) + 
        (SELECT COUNT(*)
        FROM SHIFT as S
        JOIN PERFORMFTEST as P ON S.ID = P.ShiftID
        JOIN Ftest as F ON P.FTestID = F.ID
        WHERE S.Dates = dates
            AND S.DepartID = departID
        )
    As TotalTest
    ;
END;

-- 12: Count all test taken in 1 date in all departments
DROP PROCEDURE IF EXISTS countTestDate;
CREATE PROCEDURE countTestDate
    (IN dates DATE)
BEGIN 
    SELECT        
        (SELECT COUNT(*)
        FROM SHIFT as S
        JOIN PERFORMTEST as P ON S.ID = P.ShiftID
        JOIN Test as T ON P.TestID = T.ID
        WHERE S.Dates = dates
        ) + 
        (SELECT COUNT(*)
        FROM SHIFT as S
        JOIN PERFORMFTEST as P ON S.ID = P.ShiftID
        JOIN Ftest as F ON P.FTestID = F.ID
        WHERE S.Dates = dates
        )
    As TotalTest
    ;
END;

-- add new doctor
DROP PROCEDURE IF EXISTS addDoctor;
CREATE PROCEDURE addDoctor
    (IN ssn INT, IN lname VARCHAR(255), IN minit VARCHAR(255), IN fname VARCHAR(255),
    IN bdate DATE , IN addr VARCHAR(255), IN depart INT)
BEGIN 
    INSERT INTO DOCTOR (ID, LName, Minit, FName, Bdate, Addr, DepartID)
    VALUES
        (ssn, lname, minit, fname, bdate, addr, depart)
    ;
END;