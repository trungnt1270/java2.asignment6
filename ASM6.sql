CREATE DATABASE BillManagement
GO
USE BillManagement
GO
CREATE TABLE Bill( bill_code CHAR(5) PRIMARY KEY,
customer_name NVARCHAR(50) NOT NULL, 
created_date DATE,
discount DECIMAL)
GO
CREATE TABLE Item(product_name NVARCHAR(50), 
bill_code CHAR(5) FOREIGN KEY REFERENCES Bill(bill_code), 
quantity INT, 
price MONEY DEFAULT 0, 
PRIMARY KEY (product_name, bill_code))
GO
CREATE PROC usp_AddBill
@bill_code CHAR(5), @customer_name NVARCHAR(50), @created_date DATE, @discount INT, @result INT OUTPUT
AS
BEGIN
INSERT INTO Bill(bill_code, customer_name, created_date, discount) VALUES (@bill_code, @customer_name, @created_date, @discount)
SET @result = @@ROWCOUNT
RETURN @result
END
GO
CREATE PROC usp_DeleteBill
@bill_code INT, @result INT OUTPUT
AS
BEGIN
IF EXISTS (SELECT * FROM Item WHERE bill_code = @bill_code)
DELETE FROM Item WHERE bill_code = @bill_code
DELETE FROM Bill WHERE bill_code = @bill_code
SET @result = @@ROWCOUNT
RETURN @result
END
GO
CREATE FUNCTION udf_ComputeBillTotal(@bill_code CHAR(5))
RETURNS MONEY
AS
BEGIN
DECLARE @total_price MONEY


SELECT @total_price = SUM(quantity * price) 
FROM Item 
WHERE bill_code = @bill_code
GROUP BY bill_code


RETURN @total_price
END
GO
CREATE FUNCTION udf_FindItemsByBillCode(@bill_code CHAR(5))
RETURNS TABLE
AS
RETURN (SELECT *
FROM Item 
WHERE bill_code = @bill_code)

SELECT * FROM Bill
SELECT * FROM Item