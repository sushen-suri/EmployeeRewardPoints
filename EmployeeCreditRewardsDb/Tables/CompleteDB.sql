USE [EmployeeRewardPoints]
GO
/****** Object:  Table [dbo].[EarnedPoints]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EarnedPoints](
	[FromEmployeeId] [bigint] NOT NULL,
	[ToEmployeeId] [bigint] NOT NULL,
	[Points] [int] NOT NULL,
	[DateGiven] [date] NOT NULL,
	[IsRedeemed] [bit] NULL CONSTRAINT [DF_EarnedPoints_IsRedeemed]  DEFAULT ((0)),
	[DateRedeemed] [date] NULL,
	[Reason] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmployeeTable]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeTable](
	[LoginId] [bigint] NOT NULL,
	[EmployeeName] [varchar](100) NOT NULL,
	[DesignationId] [int] NOT NULL,
	[ProfilePic] [varchar](max) NULL,
	[TotalEarnedPoints] [bigint] NULL,
	[DateCreated] [date] NOT NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_EmployeeTable_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_EmployeeTable_IsDeleted]  DEFAULT ((0)),
	[DateDeleted] [date] NULL,
	[TotalRedeemedPoints] [bigint] NULL CONSTRAINT [DF_EmployeeTable_TotalRedeemedPoints]  DEFAULT ((0)),
 CONSTRAINT [PK_EmployeeTable_1] PRIMARY KEY CLUSTERED 
(
	[LoginId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoginTable]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginTable](
	[LoginId] [bigint] IDENTITY(1000,1) NOT NULL,
	[EmployeeId] [varchar](50) NOT NULL,
	[Email] [varchar](200) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Contact] [varchar](50) NOT NULL,
 CONSTRAINT [PK_LoginTable] PRIMARY KEY CLUSTERED 
(
	[LoginId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[EmployeeTable]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTable_DesignationTable] FOREIGN KEY([DesignationId])
REFERENCES [dbo].[DesignationTable] ([DesignationId])
GO
ALTER TABLE [dbo].[EmployeeTable] CHECK CONSTRAINT [FK_EmployeeTable_DesignationTable]
GO
ALTER TABLE [dbo].[EmployeeTable]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTable_LoginTable] FOREIGN KEY([LoginId])
REFERENCES [dbo].[LoginTable] ([LoginId])
GO
ALTER TABLE [dbo].[EmployeeTable] CHECK CONSTRAINT [FK_EmployeeTable_LoginTable]
GO
/****** Object:  StoredProcedure [dbo].[spFilterEmployee]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spFilterEmployee]
(
@Name varchar(50) = NULL,
@Email varchar(100) = NULL,
@Contact varchar (30) = NULL,
@Title varchar (50) = NULL
)
As
Begin
if (@Name<>'')
SELECT s.[EmployeeName],s.[DesignationId],s.[ProfilePic],s.[TotalEarnedPoints],l.EmployeeId,l.[LoginId],l.[Email],l.[Contact],s.[DateCreated],s.[IsActive],s.[IsDeleted],s.[DateDeleted],t.Title
  FROM [dbo].LoginTable l 
  JOIN [dbo].[EmployeeTable] s ON l.LoginId = s.LoginId
  JOIN [dbo].DesignationTable t ON s.DesignationId = t.DesignationId
 Where s.EmployeeName LIKE '%'+@Name+'%' AND s.IsActive = 1
if (@Email<>'')
SELECT s.[EmployeeName],s.[DesignationId],s.[ProfilePic],s.[TotalEarnedPoints],l.EmployeeId,l.[LoginId],l.[Email],l.[Contact],s.[DateCreated],s.[IsActive],s.[IsDeleted],s.[DateDeleted],t.Title
  FROM [dbo].LoginTable l 
  JOIN [dbo].[EmployeeTable] s ON l.LoginId = s.LoginId
  JOIN [dbo].DesignationTable t ON s.DesignationId = t.DesignationId
 Where l.Email LIKE '%'+@Email+'%' AND s.IsActive = 1
if(@Contact<>'')
SELECT s.[EmployeeName],s.[DesignationId],s.[ProfilePic],s.[TotalEarnedPoints],l.EmployeeId,l.[LoginId],l.[Email],l.[Contact],s.[DateCreated],s.[IsActive],s.[IsDeleted],s.[DateDeleted],t.Title
  FROM [dbo].LoginTable l 
  JOIN [dbo].[EmployeeTable] s ON l.LoginId = s.LoginId
  JOIN [dbo].DesignationTable t ON s.DesignationId = t.DesignationId
 Where l.Contact LIKE '%'+@Contact+'%' AND s.IsActive = 1
if(@Title<>'')
SELECT s.[EmployeeName],s.[DesignationId],s.[ProfilePic],s.[TotalEarnedPoints],l.EmployeeId,l.[LoginId],l.[Email],l.[Contact],s.[DateCreated],s.[IsActive],s.[IsDeleted],s.[DateDeleted],t.Title
  FROM [dbo].LoginTable l 
  JOIN [dbo].[EmployeeTable] s ON l.LoginId = s.LoginId
  JOIN [dbo].DesignationTable t ON s.DesignationId = t.DesignationId
 Where t.Title LIKE @Title AND s.IsActive = 1
if(@Name = '' AND @Email = '' AND @Contact = '' AND @Title = '')
SELECT s.[EmployeeName],s.[DesignationId],s.[ProfilePic],s.[TotalEarnedPoints],l.EmployeeId,l.[LoginId],l.[Email],l.[Contact],s.[DateCreated],s.[IsActive],s.[IsDeleted],s.[DateDeleted],t.Title
  FROM [dbo].LoginTable l 
  JOIN [dbo].[EmployeeTable] s ON l.LoginId = s.LoginId
  JOIN [dbo].DesignationTable t ON s.DesignationId = t.DesignationId
 Where s.IsActive = 1
SET NOCOUNT ON;
End
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployee]    Script Date: 12/25/2016 6:33:48 AM ******/
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
		s.IsActive = 1 and 
		s.IsDeleted = 0 AND
		s.DesignationId = t.DesignationId AND
		s.[LoginId] = @LoginId OR @LoginId IS NULL
End
GO
/****** Object:  StoredProcedure [dbo].[spInsertEmployee]    Script Date: 12/25/2016 6:33:48 AM ******/
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
@TotalEarnedPoints bigint = 0
)
AS
BEGIN
	BEGIN TRY        
		BEGIN TRANSACTION 
				INSERT INTO [dbo].[LoginTable] ([EmployeeId],[Email],[Password], [Contact])
				VALUES (@EmployeeId,@Email, @Password, @Contact)
				DECLARE @LAST_INSERTED_ID INT
				SELECT @LAST_INSERTED_ID = SCOPE_IDENTITY()
			INSERT INTO [dbo].[EmployeeTable] ([LoginId], [EmployeeName],[DesignationId],[ProfilePic],[TotalEarnedPoints],[DateCreated],[IsActive],[IsDeleted],[DateDeleted])
				VALUES(@LAST_INSERTED_ID,@EmployeeName, @DesignationId, @ProfilePic,null, GETDATE(), 1, 0, null)
		COMMIT TRANSACTION        
	END TRY        
	BEGIN CATCH        
		ROLLBACK TRANSACTION        
 END CATCH  
END
GO
/****** Object:  StoredProcedure [dbo].[spPointsBetweenDates]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPointsBetweenDates]
(
	@ToEmployeeId bigint,
	@FromDate Date,
	@ToDate Date
)

AS

SET NOCOUNT ON;

BEGIN
	SELECT SUM(point.Points) AS 'TotalPoints' FROM EarnedPoints point
	JOIN LoginTable l ON point.ToEmployeeId = l.EmployeeId
	WHERE l.LoginId = @ToEmployeeId AND point.DateGiven BETWEEN @FromDate AND @ToDate
END

GO
/****** Object:  StoredProcedure [dbo].[spPointsGraph]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPointsGraph]
(
	@ToEmployeeId bigint
)

AS

SET NOCOUNT ON;

BEGIN
	SELECT point.DateGiven,SUM(point.Points) AS 'TotalPoints' FROM EarnedPoints point
	JOIN LoginTable l ON point.ToEmployeeId = l.EmployeeId
	WHERE l.LoginId = @ToEmployeeId
	GROUP BY DateGiven
END

GO
/****** Object:  StoredProcedure [dbo].[spSignin]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSignin]
(
	@EmployeeId varchar(50),
	@Password varchar(100)
)

AS

SET NOCOUNT ON;

BEGIN
	SELECT [LoginId] FROM LoginTable
	Where EmployeeId = @EmployeeId AND [Password]=@Password
END

GO
/****** Object:  StoredProcedure [dbo].[spTransferPoints]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTransferPoints]
(
	@FromEmployeeId bigint,
	@ToEmployeeId bigint,
	@Points int,
	@Reason varchar(max)
)

AS

SET NOCOUNT ON;

BEGIN
	BEGIN TRY
		BEGIN TRANSACTION 
			INSERT INTO EarnedPoints(FromEmployeeId,ToEmployeeId,Points,DateGiven,Reason)
			VALUES(@FromEmployeeId,@ToEmployeeId,@Points,GETDATE(),@Reason)

			DECLARE @PREV_POINTS INT
			DECLARE @LoginId bigint

			SELECT @LoginId=LoginId FROM LoginTable
			Where EmployeeId = @ToEmployeeId

			SELECT @PREV_POINTS=TotalEarnedPoints FROM EmployeeTable
			Where LoginId = @LoginId

			DECLARE @NEW_POINTS INT = @PREV_POINTS+@Points

			UPDATE EmployeeTable
			SET TotalEarnedPoints=@NEW_POINTS
			WHERE LoginId=@LoginId

		COMMIT TRANSACTION        
	END TRY        
	BEGIN CATCH        
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmployee]    Script Date: 12/25/2016 6:33:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spUpdateEmployee]
(
@LoginId bigint,
@EmployeeId bigint,
@Email varchar(200),
@Password varchar(100),
@Contact varchar(50),
@EmployeeName varchar(100),
@DesignationId int,
@ProfilePic varchar(max) = null,
@TotalEarnedPoints bigint = 0
)
AS
BEGIN
	BEGIN TRY        
		UPDATE LoginTable 
			SET [EmployeeId] = @EmployeeId, [Email] = @Email,[Password] = @Password, [Contact] = @Contact
			WHERE LoginId = @LoginId

		   UPDATE [dbo].[EmployeeTable] 
		   SET [EmployeeName] = @EmployeeName,[DesignationId] = @DesignationId,[ProfilePic] = @ProfilePic,[TotalEarnedPoints] = @TotalEarnedPoints
		WHERE LoginId = @LoginId
	END TRY        
	BEGIN CATCH        

	END CATCH  
END
GO
