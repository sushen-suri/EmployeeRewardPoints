USE [EmployeeRewardPoints]
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployee]    Script Date: 12/22/2016 6:32:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetEmployee]
(
@LoginId bigint = NULL
)
As
Begin
SET NOCOUNT ON;
SELECT s.[EmployeeName],s.[DesignationId],s.[ProfilePic],s.[TotalEarnedPoints],l.EmployeeId,l.[LoginId],l.[Email],l.[Contact],s.[DateCreated],s.[IsActive],s.[IsDeleted],s.[DateDeleted],t.Title
  FROM [dbo].LoginTable l 
  JOIN [dbo].[EmployeeTable] s ON l.LoginId = s.LoginId
  JOIN [dbo].DesignationTable t ON s.DesignationId = t.DesignationId
 Where l.LoginId = @LoginId and
		s.[LoginId] = @LoginId OR @LoginId IS NULL and s.DesignationId = t.DesignationId and
		s.IsActive = 1 and s.IsDeleted = 0
End
GO
