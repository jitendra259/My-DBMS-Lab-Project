-- Part A: DDL (Structure / Table Creation)

-- Q3: Create table Student
CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50),
    Dept VARCHAR(20),
    Age INT,
    MobileNo VARCHAR(15)
);

-- Q4: Create table Course
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- Q5: Add a new column City to table Student
ALTER TABLE Student ADD City VARCHAR(30);

-- Q6: Add a new column Semester in table Student
ALTER TABLE Student ADD Semester VARCHAR(10);

-- Q7: Rename column MobileNo to Phone (Note: As per your PDF point 7)
ALTER TABLE Student RENAME COLUMN MobileNo TO Phone;

-- Q8: Delete (drop) the table Course
DROP TABLE Course;


-- Part B: DML (Insert / Update / Delete / View Data)

-- Q9: Insert 5 student records into Student
INSERT INTO Student VALUES (101, 'Rahul', 'CSE', 21, '9876543210', 'Delhi', '4th');
INSERT INTO Student VALUES (102, 'Anjali', 'ECE', 19, '9876543211', 'Mumbai', '2nd');
INSERT INTO Student VALUES (103, 'Amit', 'CSE', 22, '9876543212', 'Patna', '6th');
INSERT INTO Student VALUES (104, 'Priya', 'ME', 20, '9876543213', 'Pune', '4th');
INSERT INTO Student VALUES (105, 'Suresh', 'CE', 23, '9876543214', 'Bangalore', '8th');

-- Q10: Display all records from Student
SELECT * FROM Student;

-- Q11: Display only RollNo and Name from Student
SELECT RollNo, Name FROM Student;

-- Q12: Display all students from department "CSE"
SELECT * FROM Student WHERE Dept = 'CSE';

-- Q13: Display all students whose age is greater than 20
SELECT * FROM Student WHERE Age > 20;

-- Q14: Update the department of RollNo = 101 to "ECE"
UPDATE Student SET Dept = 'ECE' WHERE RollNo = 101;

-- Q15: Update the city of student "Rahul" to "Patna"
UPDATE Student SET City = 'Patna' WHERE Name = 'Rahul';

-- Q16: Increase age of all students by 1 year
UPDATE Student SET Age = Age + 1;

-- Q17: Delete record of student whose RollNo = 105
DELETE FROM Student WHERE RollNo = 105;

-- Q18: Delete all records from Student (table should remain)
DELETE FROM Student;

-- FINAL STEP: Permanent Save
COMMIT;