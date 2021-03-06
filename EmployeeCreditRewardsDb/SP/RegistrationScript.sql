USE [EmployeeRewardPoints]
GO
/****** Object:  StoredProcedure [dbo].[spInsertEmployee]    Script Date: 12/21/2016 11:06:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertEmployee]
(
@EmployeeId bigint,
@Email varchar(200),
@Password varchar(100),
@Contact varchar(50),
@EmployeeName varchar(100),
@DesignationId int,
@ProfilePic varchar(max) = null,
@TotalEarnedPoints bigint = null
)
AS
BEGIN
	BEGIN TRY        
		BEGIN TRANSACTION 
				INSERT INTO [dbo].[LoginTable] ([EmployeeId],[Email],[Password], [Contact])
				VALUES (@EmployeeId,@Email, @Password, @Contact)
				DECLARE @LAST_INSERTED_ID INT
				SELECT @LAST_INSERTED_ID = SCOPE_IDENTITY()
			INSERT INTO EmployeeTable ([LoginId], [EmployeeName],[DesignationId],[ProfilePic],[TotalEarnedPoints],[DateCreated],[IsActive],[IsDeleted],[DateDeleted])
				VALUES(@LAST_INSERTED_ID,@EmployeeName, @DesignationId, @ProfilePic,null, GETDATE(), 1, 0, null)
		COMMIT TRANSACTION        
	END TRY        
	BEGIN CATCH        
		ROLLBACK TRANSACTION        
 END CATCH  
END
GO
