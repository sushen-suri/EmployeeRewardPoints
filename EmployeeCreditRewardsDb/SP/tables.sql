USE [EmployeeRewardPoints]
GO
/****** Object:  Table [dbo].[DesignationTable]    Script Date: 12/21/2016 11:22:27 AM ******/
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
/****** Object:  Table [dbo].[EarnedPoints]    Script Date: 12/21/2016 11:22:27 AM ******/
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
/****** Object:  Table [dbo].[EmployeeTable]    Script Date: 12/21/2016 11:22:27 AM ******/
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
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DateDeleted] [date] NULL,
 CONSTRAINT [PK_EmployeeTable_1] PRIMARY KEY CLUSTERED 
(
	[LoginId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoginTable]    Script Date: 12/21/2016 11:22:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginTable](
	[LoginId] [bigint] IDENTITY(1000,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
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
ALTER TABLE [dbo].[EmployeeTable] ADD  CONSTRAINT [DF_EmployeeTable_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[EmployeeTable] ADD  CONSTRAINT [DF_EmployeeTable_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
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
