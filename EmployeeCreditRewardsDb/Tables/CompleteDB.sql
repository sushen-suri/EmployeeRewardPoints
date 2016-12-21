USE [master]
GO
/****** Object:  Database [EmployeeRewardPoints]    Script Date: 12/21/2016 12:50:53 PM ******/
CREATE DATABASE [EmployeeRewardPoints]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeRewardPoints', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\EmployeeRewardPoints.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EmployeeRewardPoints_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\EmployeeRewardPoints_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EmployeeRewardPoints] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeRewardPoints].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeRewardPoints] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeRewardPoints] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeRewardPoints] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeeRewardPoints] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeRewardPoints] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmployeeRewardPoints] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeRewardPoints] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeRewardPoints] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeRewardPoints] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeRewardPoints] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EmployeeRewardPoints] SET DELAYED_DURABILITY = DISABLED 
GO
USE [EmployeeRewardPoints]
GO
/****** Object:  Table [dbo].[DesignationTable]    Script Date: 12/21/2016 12:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DesignationTable](
	[DesignationId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DesignationTable] PRIMARY KEY CLUSTERED 
(
	[DesignationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EarnedPoints]    Script Date: 12/21/2016 12:50:54 PM ******/
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
	[IsRedeemed] [bit] NULL,
	[DateRedeemed] [date] NULL,
	[Reason] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmployeeTable]    Script Date: 12/21/2016 12:50:54 PM ******/
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
/****** Object:  Table [dbo].[LoginTable]    Script Date: 12/21/2016 12:50:54 PM ******/
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
ALTER TABLE [dbo].[EarnedPoints] ADD  CONSTRAINT [DF_EarnedPoints_IsRedeemed]  DEFAULT ((0)) FOR [IsRedeemed]
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
/****** Object:  StoredProcedure [dbo].[spInsertEmployee]    Script Date: 12/21/2016 12:50:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertEmployee]
(
@EmployeeId varchar(50),
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
/****** Object:  StoredProcedure [dbo].[spPointsGraph]    Script Date: 12/21/2016 12:50:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPointsGraph]
(
	@EmployeeId bigint
)

AS

SET NOCOUNT ON;

BEGIN
	SELECT DateGiven,SUM(Points) AS 'Total Points' FROM EarnedPoints
	GROUP BY DateGiven
END
GO
/****** Object:  StoredProcedure [dbo].[spSignin]    Script Date: 12/21/2016 12:50:54 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spTransferPoints]    Script Date: 12/21/2016 12:50:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTransferPoints]
(
	@FromEmployeeId bigint,
	@ToEmployeeId bigint,
	@Points int,
	@DateGiven date,
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
USE [master]
GO
ALTER DATABASE [EmployeeRewardPoints] SET  READ_WRITE 
GO
