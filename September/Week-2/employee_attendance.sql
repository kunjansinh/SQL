-- Name = Kunjan
-- Topic: Employee Attendance Analysis
-- Purpose:
-- Calculate attendance statistics for employees
-- and classify their attendance performance.

CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    EmployeeName VARCHAR(100) NOT NULL,
    Status VARCHAR(20) NOT NULL
);

-- Insert sample attendance records.
INSERT INTO Attendance VALUES
(1, 101, 'Rahul', 'Present'),
(2, 101, 'Rahul', 'Present'),
(3, 101, 'Rahul', 'Absent'),
(4, 102, 'Priya', 'Present'),
(5, 102, 'Priya', 'Present'),
(6, 102, 'Priya', 'Present'),
(7, 103, 'Amit', 'Absent'),
(8, 103, 'Amit', 'Present'),
(9, 103, 'Amit', 'Present'),
(10, 104, 'Sneha', 'Present'),
(11, 104, 'Sneha', 'Absent'),
(12, 104, 'Sneha', 'Present');

-- Generate an attendance report.
SELECT
    EmployeeID,
    EmployeeName,

    -- Count total attendance records.
    COUNT(*) AS TotalDays,

    -- Count days where the employee was present.
    SUM(
        CASE
            WHEN Status = 'Present' THEN 1
            ELSE 0
        END
    ) AS PresentDays,

    -- Count days where the employee was absent.
    SUM(
        CASE
            WHEN Status = 'Absent' THEN 1
            ELSE 0
        END
    ) AS AbsentDays,

    -- Calculate attendance percentage.
    ROUND(
        SUM(
            CASE
                WHEN Status = 'Present' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS AttendancePercentage

FROM Attendance

GROUP BY
    EmployeeID,
    EmployeeName

ORDER BY AttendancePercentage DESC;