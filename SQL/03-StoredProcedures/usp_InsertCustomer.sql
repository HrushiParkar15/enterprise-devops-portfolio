CREATE PROCEDURE [dbo].[usp_InsertCustomer]
    @CustomerName NVARCHAR(100),
    @City NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validation

     SET @CustomerName = TRIM(@CustomerName);
    SET @City = TRIM(@City);

    -- Validation
    IF @CustomerName IS NULL OR @CustomerName = ''
    BEGIN
        THROW 50001, 'Customer Name cannot be empty.', 1;
    END

    IF @City IS NULL OR @City = ''
    BEGIN
        THROW 50002, 'City cannot be empty.', 1;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check for duplicate customer
        IF NOT EXISTS
        (
            SELECT 1
            FROM Customers
            WHERE CustomerName = @CustomerName
        )
        BEGIN
            INSERT INTO Customers (CustomerName, City)
            VALUES (@CustomerName, @City);

            SELECT
               1 AS Status,
    'Inserted Successfully' AS Message;
        END
        ELSE
        BEGIN
           -- PRINT 'Duplicate entry found. Insertion skipped.';
           THROW 50003,'Customer already exists.',1;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
