-- =========================
-- CLEAN START (DROP TABLES)
-- =========================

BEGIN EXECUTE IMMEDIATE 'DROP TABLE Enrollment'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Course'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Student'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE Student (
    StudentID VARCHAR2(10) PRIMARY KEY,
    Name VARCHAR2(50),
    DepartmentID VARCHAR2(10),
    Gender VARCHAR2(10)
);

CREATE TABLE Course (
    CourseID VARCHAR2(10) PRIMARY KEY,
    CourseName VARCHAR2(50),
    Credits NUMBER
);

CREATE TABLE Enrollment (
    StudentID VARCHAR2(10),
    CourseID VARCHAR2(10)
);

-- =========================
-- INSERT DATA (SAFE)
-- =========================

INSERT INTO Student (StudentID, Name, DepartmentID, Gender) VALUES ('S401','Aman','D1','Male');
INSERT INTO Student (StudentID, Name, DepartmentID, Gender) VALUES ('S402','Riya','D2','Female');
INSERT INTO Student (StudentID, Name, DepartmentID, Gender) VALUES ('S403','Neha','D1','Female');
INSERT INTO Student (StudentID, Name, DepartmentID, Gender) VALUES ('S404','Raj','D3','Male');
INSERT INTO Student (StudentID, Name, DepartmentID, Gender) VALUES ('S405','Simran','D2','Female');
INSERT INTO Student (StudentID, Name, DepartmentID, Gender) VALUES ('S406','Karan','D1','Male');

INSERT INTO Course (CourseID, CourseName, Credits) VALUES ('C1','DBMS',4);
INSERT INTO Course (CourseID, CourseName, Credits) VALUES ('C2','OS',3);
INSERT INTO Course (CourseID, CourseName, Credits) VALUES ('C3','Maths',5);
INSERT INTO Course (CourseID, CourseName, Credits) VALUES ('C4','CN',2);

INSERT INTO Enrollment (StudentID, CourseID) VALUES ('S401','C1');
INSERT INTO Enrollment (StudentID, CourseID) VALUES ('S401','C2');
INSERT INTO Enrollment (StudentID, CourseID) VALUES ('S402','C1');
INSERT INTO Enrollment (StudentID, CourseID) VALUES ('S403','C3');
INSERT INTO Enrollment (StudentID, CourseID) VALUES ('S405','C1');
INSERT INTO Enrollment (StudentID, CourseID) VALUES ('S406','C2');

COMMIT;

-- =========================
-- VERIFY DATA
-- =========================

SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Enrollment;

-- =========================
-- ALL QUERIES (FIXED)
-- =========================

-- 1. Same department as S401
SELECT Name FROM Student
WHERE DepartmentID = (SELECT DepartmentID FROM Student WHERE StudentID='S401');

-- 2. Same gender as S402
SELECT Name FROM Student
WHERE Gender = (SELECT Gender FROM Student WHERE StudentID='S402');

-- 3. Same department as S403
SELECT Name FROM Student
WHERE DepartmentID = (SELECT DepartmentID FROM Student WHERE StudentID='S403');

-- 4. Students in departments having female students
SELECT Name FROM Student
WHERE DepartmentID IN (
    SELECT DISTINCT DepartmentID FROM Student WHERE Gender='Female'
);

-- 5. Students who are enrolled
SELECT Name FROM Student
WHERE StudentID IN (SELECT StudentID FROM Enrollment);

-- 6. Students not enrolled
SELECT Name FROM Student
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollment);

-- 7. Courses with credits > average
SELECT CourseName FROM Course
WHERE Credits > (SELECT AVG(Credits) FROM Course);

-- 8. Students with ID greater than S403
SELECT Name FROM Student
WHERE StudentID > 'S403';

-- 9. Departments having more students than average
SELECT DepartmentID
FROM Student
GROUP BY DepartmentID
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (SELECT COUNT(*) cnt FROM Student GROUP BY DepartmentID)
);

-- 10. Students enrolled in at least one course
SELECT DISTINCT Name FROM Student
WHERE StudentID IN (SELECT StudentID FROM Enrollment);

-- 11. Students having valid department
SELECT Name FROM Student
WHERE DepartmentID IS NOT NULL;

-- 12. Courses which have enrollments
SELECT CourseName FROM Course
WHERE CourseID IN (SELECT CourseID FROM Enrollment);

-- 13. Course with maximum credits
SELECT CourseName FROM Course
WHERE Credits = (SELECT MAX(Credits) FROM Course);

-- 14. Students enrolled in more than one course
SELECT Name FROM Student
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollment
    GROUP BY StudentID
    HAVING COUNT(*) > 1
);

-- 15. Department with highest students
SELECT DepartmentID
FROM Student
GROUP BY DepartmentID
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (SELECT COUNT(*) cnt FROM Student GROUP BY DepartmentID)
);

-- 16. Students taking same courses as S401
SELECT DISTINCT Name FROM Student
WHERE StudentID IN (
    SELECT StudentID FROM Enrollment
    WHERE CourseID IN (
        SELECT CourseID FROM Enrollment WHERE StudentID='S401'
    )
);

-- 17. Students not enrolled in any course
SELECT Name FROM Student
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollment);

-- 18. Courses not taken by any student
SELECT CourseName FROM Course
WHERE CourseID NOT IN (SELECT CourseID FROM Enrollment);