USE [EmployeeRewardPoints]
GO
/****** Object:  Table [dbo].[DesignationTable]    Script Date: 12/20/2016 2:16:30 PM ******/
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
/****** Object:  Table [dbo].[EarnedPoints]    Script Date: 12/20/2016 2:16:30 PM ******/
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
	[IsRedeemed] [bit] NOT NULL,
	[DateRedeemed] [date] NULL,
	[Reason] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmployeeTable]    Script Date: 12/20/2016 2:16:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeTable](
	[EmployeeId] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](100) NOT NULL,
	[DesignationId] [int] NOT NULL,
	[ProfilePic] [varchar](max) NOT NULL,
	[TotalEarnedPoints] [bigint] NOT NULL,
 CONSTRAINT [PK_EmployeeTable] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoginTable]    Script Date: 12/20/2016 2:16:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginTable](
	[EmployeeId] [bigint] IDENTITY(1,1) NOT NULL,
	[LoginId] [bigint] NOT NULL,
	[Email] [varchar](200) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Contact] [varchar](50) NOT NULL,
 CONSTRAINT [PK_LoginTable] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
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
ALTER TABLE [dbo].[LoginTable]  WITH CHECK ADD  CONSTRAINT [FK_LoginTable_EmployeeTable] FOREIGN KEY([LoginId])
REFERENCES [dbo].[EmployeeTable] ([EmployeeId])
GO
ALTER TABLE [dbo].[LoginTable] CHECK CONSTRAINT [FK_LoginTable_EmployeeTable]
GO
