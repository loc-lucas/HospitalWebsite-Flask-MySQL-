USE HOSPITAL;
DROP PROCEDURE IF EXISTS getDocAtSpecificDSD;
CREATE PROCEDURE getDocAtSpecificDSD(IN dates Date, IN dID INT, IN periods CHAR(1))
BEGIN
    SELECT Distinct D.*
    FROM doctor as D
    JOIN shift as S ON 
        S.Dates = dates
        AND S.DepartID = dID 
        AND S.Periods = periods
    JOIN onduty as O ON 
        O.ShiftID = S.ID 
        AND O.DocID = D.ID
    ;
END;
CALL getDocAtSpecificDSD('2020-11-23', 1, 'A')
