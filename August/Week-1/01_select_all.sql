/*
-------------------------------------------------
Name    : Kunjan
Language: SQL
Purpose : Retrieve all records from a table
-------------------------------------------------
*/

-- =====================================================
-- Problem Statement:
-- Create a Student table, insert sample records,
-- and display all the records from the table.
-- =====================================================

-- Create the Student table
CREATE TABLE Student 
(
    StudentID INT,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50)
);

-- Insert sample records into the Student table
INSERT INTO Student (StudentID, Name, Age, City)
VALUES
(101, 'Rahul', 20, 'Mumbai'),
(102, 'Priya', 21, 'Delhi'),
(103, 'Amit', 19, 'Ahmedabad'),
(104, 'Sneha', 22, 'Pune');

-- Display all records from the Student table
SELECT * FROM Student;

-- End of Program