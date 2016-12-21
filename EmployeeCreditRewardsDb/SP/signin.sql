USE [EmployeeRewardPoints]
GO
/****** Object:  StoredProcedure [dbo].[spSignin]    Script Date: 12/21/2016 11:04:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSignin]
(
	@EmployeeId bigint,
	@Password varchar(100)
)

AS

SET NOCOUNT ON;

BEGIN
	SELECT [LoginId] FROM LoginTable
	Where EmployeeId = @EmployeeId AND Password=@Password
END
GO
