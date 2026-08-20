-- Name = kunjan
-- Topic: Transactions
-- Purpose:
-- Learn how to safely modify database records
-- and undo changes when something goes wrong.
--
-- Transactions are important in banking, payments,
-- inventory systems, and other applications where
-- multiple database changes must succeed together.

-- Create Accounts table
CREATE TABLE Accounts 
(
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(50),
    Balance DECIMAL(10,2)
);

-- Insert sample accounts
INSERT INTO Accounts VALUES
(101, 'Rahul', 10000),
(102, 'Priya', 8000);

-- Check balances before the transaction.
SELECT *
FROM Accounts;

-- Start a transaction.
START TRANSACTION;

-- Deduct 2000 from Rahul's account.
UPDATE Accounts
SET Balance = Balance - 2000
WHERE AccountID = 101;

-- Add 2000 to Priya's account.
UPDATE Accounts
SET Balance = Balance + 2000
WHERE AccountID = 102;

-- Check the temporary result.
SELECT *
FROM Accounts;

-- If everything is correct, permanently save
-- both changes.
COMMIT;

-- Verify the final balances.
SELECT *
FROM Accounts;