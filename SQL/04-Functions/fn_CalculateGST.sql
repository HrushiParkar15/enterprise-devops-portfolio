/*
=========================================
Object Name : dbo.fn_CalculateGST
Object Type : Scalar Function
Author      : Hrushikesh Parkar
Created On  : 05-Jul-2026
Project     : Enterprise DevOps Portfolio
Description : Calculates 18% GST for a given price.
=========================================
*/
CREATE OR ALTER FUNCTION dbo.fn_CalculateGST
(
    @Price DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN (@Price * 18) / 100;
END;
