CREATE DATABASE BEST;
GO

USE [Best]
GO
/****** Object:  User [loginbest]    Script Date: 05/31/2012 22:08:54 ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'loginbest')
CREATE USER [loginbest] FOR LOGIN [loginbest] WITH DEFAULT_SCHEMA=[loginbest]
GO
/****** Object:  Schema [loginbest]    Script Date: 05/31/2012 22:08:54 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'loginbest')
EXEC sys.sp_executesql N'CREATE SCHEMA [loginbest] AUTHORIZATION [loginbest]'
GO
/****** Object:  Table [dbo].[BestEMailTemplates]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestEMailTemplates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestEMailTemplates](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestEMailTemplates_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestEMailTemplates_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestEMailTemplates_lastChangeUser]  DEFAULT (app_name()),
	[emialTemplateName] [varchar](50) NOT NULL,
	[templateDescription] [varchar](max) NOT NULL,
 CONSTRAINT [PK_BestEMailTemplates] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestPaymentTypes]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestPaymentTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestPaymentTypes](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestPaymentTypes_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestPaymentTypes_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestPaymentTypes_lastChangeUser]  DEFAULT (app_name()),
	[paymentType] [varchar](100) NOT NULL,
 CONSTRAINT [PK_BestPaymentTypes] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestProgamTypes]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestProgamTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestProgamTypes](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BProgTypes_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BProgTypes_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BProgTypes_lastChangeUser]  DEFAULT (app_name()),
	[programType] [varchar](100) NOT NULL,
 CONSTRAINT [PK_BestProgamTypes] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestPrograms]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestPrograms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestPrograms](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestPrograms_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestPrograms_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestPrograms_lastChangeUser]  DEFAULT (app_name()),
	[programName] [varchar](50) NOT NULL,
	[programType] [varchar](100) NOT NULL,
	[amount] [decimal](10, 2) NULL,
	[amountType] [varchar](50) NULL,
 CONSTRAINT [PK_BestPrograms] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'BestPrograms', N'COLUMN',N'amountType'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per Week, Per Day, Per Hour' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BestPrograms', @level2type=N'COLUMN',@level2name=N'amountType'
GO
/****** Object:  Table [dbo].[BestLogins]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestLogins]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestLogins](
	[guidfield] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BestLogins_guidfield]  DEFAULT (newsequentialid()),
	[username] [varchar](128) NOT NULL,
	[loginDate] [datetime] NOT NULL CONSTRAINT [DF_BestLogins_loginDate]  DEFAULT (getdate()),
	[sourceIP] [varchar](50) NULL,
	[loginvalid] [bit] NOT NULL CONSTRAINT [DF_BestLogins_loginvalid]  DEFAULT ((0)),
	[serverIP] [varchar](50) NULL,
	[sessionguid] [uniqueidentifier] NULL,
	[logoutdate] [datetime] NULL,
	[additionalInfo] [varchar](1000) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestSuspicion]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestSuspicion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestSuspicion](
	[guidfield] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BestSuspicion_guidfield]  DEFAULT (newid()),
	[target] [varchar](200) NULL,
	[score] [int] NULL,
	[logdate] [datetime] NULL CONSTRAINT [DF_BestSuspicion_logdate]  DEFAULT (getdate()),
	[reasonCode] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentReference]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentReference]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestStudentReference](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentReference_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentReference_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestStudentReference_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[studentId] [varchar](50) NOT NULL,
	[centerId] [varchar](50) NOT NULL,
	[referencedby] [varchar](100) NULL,
	[expectedDuration] [varchar](50) NULL,
	[blcRecommend] [varchar](500) NULL,
	[proposedProg] [varchar](50) NULL,
	[proposedHour] [varchar](50) NULL,
	[parentComments] [varchar](500) NULL,
	[parentExpects] [varchar](500) NULL,
	[emergName] [varchar](50) NULL,
	[emergPhone] [varchar](50) NULL,
	[healthConditions] [varchar](500) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestLogs]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestLogs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestLogs](
	[Logdate] [datetime] NOT NULL CONSTRAINT [DF_Table_1_logdate]  DEFAULT (getdate()),
	[Message] [varchar](max) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestMessages]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestMessages]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestMessages](
	[messageDate] [datetime] NOT NULL CONSTRAINT [DF_BestMessages_messageDate]  DEFAULT (getdate()),
	[parentGuid] [uniqueidentifier] NULL,
	[messageText] [varchar](5000) NULL,
	[messageTo] [varchar](128) NOT NULL,
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestMessages_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestMessages_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestMessages_lastChangeUser]  DEFAULT (app_name()),
	[CenterId] [varchar](50) NOT NULL,
	[messageFrom] [varchar](128) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestServices]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestServices]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestServices](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestServices_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestServices_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestServices_lastChangeUser]  DEFAULT (app_name()),
	[Service] [varchar](128) NOT NULL,
	[CenterId] [varchar](50) NULL,
 CONSTRAINT [PK_BestServices] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestSchedules]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestSchedules]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestSchedules](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestSchedules_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestSchedules_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestSchedules_lastChangeUser]  DEFAULT (app_name()),
	[tutGuid] [uniqueidentifier] NULL,
	[stuGuid1] [uniqueidentifier] NULL,
	[stuGuid2] [uniqueidentifier] NULL,
	[stuGuid3] [uniqueidentifier] NULL,
	[stuGuid4] [uniqueidentifier] NULL,
	[stuGuid5] [uniqueidentifier] NULL,
	[schDate] [varchar](10) NULL,
	[schFrom] [varchar](4) NULL,
	[schTo] [varchar](4) NULL,
	[isDeleted] [bit] NOT NULL CONSTRAINT [DF_BestSchedules_isDeleted]  DEFAULT ((0)),
	[attended1] [int] NOT NULL CONSTRAINT [DF_BestSchedules_attended]  DEFAULT ((0)),
	[attended2] [int] NOT NULL CONSTRAINT [DF_BestSchedules_attended2]  DEFAULT ((0)),
	[attended3] [int] NOT NULL CONSTRAINT [DF_BestSchedules_attended3]  DEFAULT ((0)),
	[attended4] [int] NOT NULL CONSTRAINT [DF_BestSchedules_attended4]  DEFAULT ((0)),
	[attended5] [int] NOT NULL CONSTRAINT [DF_BestSchedules_attended5]  DEFAULT ((0)),
	[note1] [varchar](100) NULL,
	[note2] [varchar](100) NULL,
	[note3] [varchar](100) NULL,
	[note4] [varchar](100) NULL,
	[note5] [varchar](100) NULL,
	[progGuid1] [uniqueidentifier] NULL,
	[progGuid2] [uniqueidentifier] NULL,
	[progGuid3] [uniqueidentifier] NULL,
	[progGuid4] [uniqueidentifier] NULL,
	[progGuid5] [uniqueidentifier] NULL,
	[tutorattend] [int] NOT NULL CONSTRAINT [DF_BestSchedules_tutorattend]  DEFAULT ((0)),
	[amount1] [decimal](18, 2) NULL,
	[amount2] [decimal](18, 2) NULL,
	[amount3] [decimal](18, 2) NULL,
	[amount4] [decimal](18, 2) NULL,
	[amount5] [decimal](18, 2) NULL,
	[CenterId] [varchar](50) NULL,
 CONSTRAINT [PK_BestSchedules] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [loginbest].[BestTutorNotes]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[loginbest].[BestTutorNotes]') AND type in (N'U'))
BEGIN
CREATE TABLE [loginbest].[BestTutorNotes](
	[guidfield] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BestTutorNotes_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestTutorNotes_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestTutorNotes_lastChangeUser]  DEFAULT (app_name()),
	[tutorGuid] [uniqueidentifier] NOT NULL,
	[noteDate] [datetime] NOT NULL,
	[notes] [varchar](max) NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [loginbest].[BestTutorNotes] ADD [CenterId] [varchar](50) NULL
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [loginbest].[BestDates]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[loginbest].[BestDates]') AND type in (N'U'))
BEGIN
CREATE TABLE [loginbest].[BestDates](
	[date] [datetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BestStudentGPA]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentGPA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestStudentGPA](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentGPA_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentGPA_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestStudentGPA_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[assessmentDate] [datetime] NULL,
	[assessmentGPA] [varchar](50) NULL,
	[assessmentLevel] [varchar](50) NULL,
	[studentId] [varchar](50) NOT NULL,
	[centerId] [varchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentPrograms]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPrograms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestStudentPrograms](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentPrograms_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentPrograms_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestStudentPrograms_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[programguid] [uniqueidentifier] NOT NULL,
	[studentId] [varchar](50) NOT NULL,
	[centerId] [varchar](50) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL CONSTRAINT [DF_BestStudentPrograms_amount]  DEFAULT ((0))
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentNotes]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentNotes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestStudentNotes](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentNotes_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentNotes_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestStudentNotes_lastChangeUser]  DEFAULT (app_name()),
	[studentGuid] [uniqueidentifier] NOT NULL,
	[noteDate] [datetime] NOT NULL,
	[notes] [varchar](max) NULL,
	[studentId] [varchar](50) NULL,
	[centerId] [nchar](10) NULL,
 CONSTRAINT [PK_BestStudentNotes] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentPickup]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPickup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestStudentPickup](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentPickup_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentPickup_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestStudentPickup_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[contactName] [varchar](50) NOT NULL,
	[contactPhone] [varchar](50) NULL,
	[relationship] [varchar](50) NULL,
	[studentId] [varchar](50) NOT NULL,
	[centerId] [varchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentPicture]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPicture]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestStudentPicture](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentPicture_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentPicture_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestStudentPicture_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[picture] [image] NULL,
	[hobbies] [varchar](500) NULL,
	[personality] [varchar](500) NULL,
	[goals] [varchar](500) NULL,
	[learningstyle] [varchar](500) NULL,
	[tutorpreference] [varchar](100) NULL,
	[studentId] [varchar](50) NOT NULL,
	[centerId] [varchar](50) NOT NULL,
	[photoSize] [decimal](18, 0) NULL,
	[photoName] [varchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudents]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestStudents]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestStudents](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BStudents_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BStudents_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BStudents_lastChangeUser]  DEFAULT (app_name()),
	[CenterId] [varchar](50) NOT NULL,
	[StudentId] [varchar](50) NOT NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[middleName] [varchar](50) NULL,
	[parentName] [varchar](80) NULL,
	[address1] [varchar](50) NULL,
	[address2] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](2) NULL,
	[zip] [varchar](15) NULL,
	[cellPhone] [varchar](15) NULL,
	[homePhone] [varchar](15) NULL,
	[workPhone] [varchar](15) NULL,
	[emailId] [varchar](200) NULL,
	[gender] [varchar](10) NULL,
	[hours] [decimal](18, 2) NULL,
	[amount] [decimal](18, 2) NULL,
	[hourType] [varchar](10) NULL,
	[amountType] [varchar](50) NULL,
	[programGuid] [uniqueidentifier] NULL,
	[joinDate] [datetime] NULL,
	[birthDate] [datetime] NULL,
	[guardianName] [varchar](50) NULL,
	[school] [varchar](50) NULL,
	[grade] [varchar](50) NULL,
 CONSTRAINT [PK_BestStudents] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestTutors]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestTutors]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestTutors](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BTutors_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BTutors_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BTutors_lastChangeUser]  DEFAULT (app_name()),
	[TutorId] [varchar](50) NOT NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[middleName] [varchar](50) NULL,
	[address1] [varchar](50) NULL,
	[address2] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](2) NULL,
	[zip] [varchar](15) NULL,
	[cellPhone] [varchar](15) NULL,
	[homePhone] [varchar](15) NULL,
	[workPhone] [varchar](15) NULL,
	[emailId] [varchar](200) NULL,
	[gender] [varchar](10) NULL,
	[joinDate] [datetime] NULL,
	[school] [varchar](50) NULL,
	[yearGraduated] [varchar](50) NULL,
	[GPA] [varchar](50) NULL,
	[Major] [varchar](50) NULL,
	[Expertise] [varchar](50) NULL,
	[learningStyle] [varchar](50) NULL,
	[matchup] [varchar](50) NULL,
	[gradeLevels] [varchar](50) NULL,
	[otherSkill] [varchar](50) NULL,
	[programStyle] [varchar](50) NULL,
	[salary] [decimal](18, 2) NULL,
	[perhour] [decimal](18, 2) NULL,
	[CenterId] [varchar](50) NULL,
 CONSTRAINT [PK_BestTutors] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestUserRoles]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestUserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestUserRoles](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestUserRoles_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestUserRoles_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestUserRoles_lastChangeUser]  DEFAULT (app_name()),
	[Service] [varchar](128) NOT NULL,
	[userName] [varchar](128) NOT NULL,
	[allowAdd] [bit] NOT NULL CONSTRAINT [DF_BestUserRoles_allowAdd]  DEFAULT ((0)),
	[allowView] [bit] NOT NULL CONSTRAINT [DF_BestUserRoles_allowView]  DEFAULT ((0)),
	[allowEdit] [bit] NOT NULL CONSTRAINT [DF_BestUserRoles_allowEdit]  DEFAULT ((0)),
	[allowDelete] [bit] NOT NULL CONSTRAINT [DF_BestUserRoles_allowDelete]  DEFAULT ((0)),
 CONSTRAINT [PK_BestUserRoles] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestDocuments]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestDocuments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestDocuments](
	[documentTitle] [varchar](50) NULL,
	[documentDate] [datetime] NULL CONSTRAINT [DF_BestDocuments_documentDate]  DEFAULT (getdate()),
	[documentExpiry] [datetime] NULL CONSTRAINT [DF_BestDocuments_documentExpiry]  DEFAULT ('12/31/2100'),
	[documentFileName] [varchar](100) NULL,
	[documentFileSize] [decimal](18, 0) NULL,
	[documentFile] [image] NULL,
	[studentGuid] [uniqueidentifier] NULL,
	[showToStudent] [bit] NOT NULL CONSTRAINT [DF_BestDocuments_showToStudent]  DEFAULT ((0)),
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestDocuments_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestDocuments_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestDocuments_lastChangeUser]  DEFAULT (app_name()),
	[CenterId] [varchar](50) NULL,
	[StudentId] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestUsers]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestUsers](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestUsers_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestUsers_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestUsers_lastChangeUser]  DEFAULT (app_name()),
	[userName] [varchar](128) NOT NULL,
	[password] [varchar](128) NULL,
	[tempPwd] [varchar](50) NULL,
	[passwordExpiration] [datetime] NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[middleName] [varchar](50) NULL,
	[address1] [varchar](50) NULL,
	[address2] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](2) NULL,
	[zip] [varchar](15) NULL,
	[cellPhone] [varchar](15) NULL,
	[homePhone] [varchar](15) NULL,
	[workPhone] [varchar](15) NULL,
	[emailId] [varchar](200) NULL,
	[securityQuestion1] [varchar](300) NULL,
	[answer1] [nchar](10) NULL,
	[securityQuestion2] [varchar](300) NULL,
	[answer2] [nchar](10) NULL,
	[gender] [varchar](10) NULL,
	[Centers] [varchar](1000) NULL,
	[userType] [varchar](50) NULL,
	[passwordExpiredDate] [datetime] NULL,
	[initialPassword] [bit] NOT NULL CONSTRAINT [DF_BestUsers_initialPassword]  DEFAULT ((1)),
	[logindisabled] [bit] NOT NULL CONSTRAINT [DF_BestUsers_lolgindisabled]  DEFAULT ((0)),
	[studentGuid] [uniqueidentifier] NULL,
	[tutorGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_BestUsers] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogChanges]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogChanges]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogChanges](
	[tablename] [varchar](50) NOT NULL,
	[guidfield] [uniqueidentifier] NOT NULL,
	[fieldname] [varchar](50) NOT NULL CONSTRAINT [DF_LogChangesS1_fieldName]  DEFAULT (''),
	[oldValue] [varchar](6000) NULL,
	[newValue] [varchar](6000) NULL,
	[changeDate] [datetime] NOT NULL CONSTRAINT [DF_LogChangesS1_changeDate]  DEFAULT (getdate()),
	[changedBy] [varchar](228) NULL CONSTRAINT [DF_LogChangesS1_changedBy]  DEFAULT (app_name()),
	[changeType] [char](1) NOT NULL CONSTRAINT [DF_LogChangesS1_changeType]  DEFAULT ('?'),
	[CenterId] [varchar](50) NULL,
	[StudentId] [varchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentPayment]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPayment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestStudentPayment](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentPayment_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentPayment_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestStudentPayment_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NULL,
	[parentemail] [varchar](128) NULL,
	[name] [varchar](50) NULL,
	[paymethod] [varchar](50) NULL,
	[centerId] [varchar](50) NOT NULL,
	[studentId] [varchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestSTPlans]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestSTPlans]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestSTPlans](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestSTPlans_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestSTPlans_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestSTPlans_lastChangeUser]  DEFAULT (app_name()),
	[studentId] [varchar](50) NULL,
	[centerId] [varchar](50) NULL,
	[studentGuid] [uniqueidentifier] NULL,
	[tutorGuid] [uniqueidentifier] NULL,
	[schDay] [varchar](50) NULL,
	[schFrom] [varchar](50) NULL,
	[schTo] [varchar](50) NULL,
	[isDeleted] [bit] NOT NULL CONSTRAINT [DF_BestSTPlans_isDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_BestSTPlans] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [loginbest].[VDates]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[loginbest].[VDates]'))
EXEC dbo.sp_executesql @statement = N'create view [loginbest].[VDates] As
select convert(datetime, ''01/01/2011'')+ (t1.num+t2.num*10+t3.num*100+t4.num*1000) as Date from 
(select 1 as num union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 0) t1
cross join
(select 1 as num union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 0) t2
cross join
(select 1 as num union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 0) t3
cross join
(select 1 as num union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 0) t4
'
GO
/****** Object:  StoredProcedure [dbo].[Best_CreateAllTriggers]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Best_CreateAllTriggers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

create proc [dbo].[Best_CreateAllTriggers]
AS
	DECLARE @name AS varchar(100)
	DECLARE tablecursor CURSOR LOCAL SCROLL FOR
		SELECT name FROM sysobjects WHERE OBJECTPROPERTY(id, N''IsUserTable'') = 1 ORDER BY name
	OPEN tablecursor
	FETCH NEXT FROM tablecursor INTO @name
	WHILE @@FETCH_STATUS = 0
	BEGIN
	if exists (	select * from syscolumns where id = object_id(N''[dbo].['' + @name + '']'') and name = ''lastChange'')
	Begin
print @name
		EXEC Best_CreateTriggers @name
	End

		FETCH NEXT FROM tablecursor INTO @name
	END
	CLOSE tablecursor
	DEALLOCATE tablecursor


' 
END
GO
/****** Object:  StoredProcedure [dbo].[Best_CreateTriggers]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Best_CreateTriggers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




--Creates triggers on the specified table to log all the changes made
create PROC [dbo].[Best_CreateTriggers]
	@tablename varchar(100)
AS

	if exists (	select * from sysobjects where id = object_id(N''[dbo].['' + @tablename + ''_Delete]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1)
	Begin
		exec(''DROP TRIGGER '' + @tablename + ''_Delete'')
	End
	if exists (	select * from sysobjects where id = object_id(N''[dbo].['' + @tablename + ''_Update]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1)
	Begin
		exec(''DROP TRIGGER '' + @tablename + ''_Update'')
	End
	if exists (	select * from sysobjects where id = object_id(N''[dbo].['' + @tablename + ''_Insert]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1)
	Begin
		exec(''DROP TRIGGER '' + @tablename + ''_Insert'')
	End
	if exists (	select * from sysobjects where id = object_id(N''[dbo].['' + @tablename + ''_InsertUpdate]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1)
	Begin
		exec(''DROP TRIGGER '' + @tablename + ''_InsertUpdate'')
	End



	declare @updsql1 varchar(8000)
	declare @updsql2 varchar(8000)
	declare @updsql3 varchar(8000)
	declare @updsql4 varchar(8000)
	set @updsql1 = ''''
	set @updsql2 = ''''
	set @updsql3 = ''''
	set @updsql4 = ''''
	
	declare @deletesql1 varchar(8000)
	declare @deletesql2 varchar(8000)
	declare @deletesql3 varchar(8000)
	declare @deletesql4 varchar(8000)
	set @deletesql1 = ''''
	set @deletesql2 = ''''
	set @deletesql3 = ''''
	set @deletesql4 = ''''
	
	declare @insertsql varchar(8000)
	declare @crlf varchar(4)
	declare @tstring varchar(3000)
	declare @tstring2 varchar(3000)
	declare @extraFields varchar(100), @extraSelect varchar(100),@extraDelete varchar(100)
	set @extraFields = '''' set @extraSelect = ''''
	set @extraDelete = ''''
			-- Determine the optional fields to put in the log
		IF EXISTS( SELECT * FROM syscolumns WHERE id = object_id(@tablename) AND name = ''CenterId'')
		BEGIN
			SET @extraFields = '',CenterId''
			SET @extraSelect = '',inserted.CenterId''
			SET @extraDelete = '',deleted.CenterId''
			IF EXISTS( SELECT * FROM syscolumns WHERE id = object_id(@tablename) AND name = ''StudentId'')
			BEGIN
				SET @extraFields = '',CenterId,StudentId''
				SET @extraSelect = '',inserted.CenterId,inserted.StudentId''
				SET @extraDelete = '',deleted.CenterId,deleted.StudentId''
			END
		END
		
    set @tstring = ''''	
	set @crlf = char(13)+char(10)
	set @updsql1 = ''CREATE TRIGGER '' + @tablename + ''_Update ON dbo.'' + @tablename + '' FOR UPDATE AS '' + @crlf + ''UPDATE '' + @tablename + '' SET '' + @tablename + ''.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM '' + @tablename + '', inserted WHERE '' + @tablename + ''.ROWGUIDCOL = inserted.ROWGUIDCOL'' + @crlf + @crlf
	set @deletesql1 = ''CREATE TRIGGER '' + @tablename + ''_DELETE ON dbo.'' + @tablename + '' FOR DELETE AS '' + @crlf 
	set @insertsql = 	''CREATE TRIGGER '' + @tablename + ''_Insert ON dbo.'' + @tablename + '' FOR INSERT AS '' + @crlf + @crlf + ''  insert into LogChanges(tablename, guidfield, changetype'' + @extraFields + '')'' + @crlf + ''   select '''''' + @tablename + '''''', inserted.ROWGUIDCOL, ''''I'''' '' + @extraSelect + '' from inserted''
	declare @fieldname sysname
	declare @fieldlen smallint
	declare @fieldtype sysname
			declare colcursor cursor local scroll for
			select syscolumns.name, syscolumns.length, systypes.name
			from syscolumns, systypes
			where syscolumns.id = object_id(@tablename) 
			and syscolumns.xtype = systypes.xusertype 
			and systypes.xtype = systypes.xusertype
			and syscolumns.name <> ''lastChange''
			and syscolumns.name <> ''lastChangeUser''
			and syscolumns.name <> ''guidfield''
			and systypes.name not in (''binary'', ''image'', ''nchar'', ''ntext'', ''nvarchar'', ''text'', ''varbinary'')
			and COLUMNPROPERTY( syscolumns.id ,syscolumns.name, ''IsComputed'') <> 1 --removes computed columns
		open colcursor
		fetch next from colcursor into @fieldname, @fieldlen, @fieldtype	
			while @@fetch_status = 0
			begin 
				if @fieldtype in (''char'', ''varchar'') and (@fieldlen > 3000 or @fieldlen = -1)
				begin
					set @tstring = 	''    if update('' + @fieldname + '')'' + @crlf + ''    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype'' + @extraFields + '') '' + @crlf + 	''    select '''''' + @tablename + '''''', inserted.ROWGUIDCOL, '''''' + @fieldname + '''''', left(deleted.'' + @fieldname + '',3000), left(inserted.'' + @fieldname + '',3000), ''''U'''' '' + @extraSelect + @crlf + ''    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL'' + @crlf + @crlf
					set @tstring2 = ''    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype'' + @extraFields + '') '' + @crlf + 
						''    select '''''' + @tablename + '''''', deleted.ROWGUIDCOL, '''''' + @fieldname + '''''', left(deleted.'' + @fieldname + '',3000), ''''D'''' ''  + @extraDelete + @crlf +
						''    from deleted '' + @crlf +
						''    where deleted.'' + @fieldname + '' is not null '' + @crlf + @crlf
				end
				else
				begin
					if @fieldtype in (''xml'') 
					begin
						set @tstring = 	''    if update('' + @fieldname + '')'' + @crlf + ''    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype'' + @extraFields + '') '' + @crlf + 	''    select '''''' + @tablename + '''''', inserted.ROWGUIDCOL, '''''' + @fieldname + '''''', left(cast(deleted.'' + @fieldname + '' as varchar(max)),3000), left(cast(inserted.'' + @fieldname + '' as varchar(max)),3000), ''''U'''' '' + @extraSelect + @crlf + ''    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL'' + @crlf + @crlf
					set @tstring2 = ''    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype'' + @extraFields + '') '' + @crlf + 
						''    select '''''' + @tablename + '''''', deleted.ROWGUIDCOL, '''''' + @fieldname + '''''', left(cast(deleted.'' + @fieldname + '' as varchar(max)),3000), ''''D'''' ''  + @extraDelete + @crlf +
						''    from deleted '' + @crlf +
						''    where deleted.'' + @fieldname + '' is not null '' + @crlf + @crlf
					end 
					else
					begin
					set @tstring = 	''    if update('' + @fieldname + '')'' + @crlf + ''    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype'' + @extraFields + '') '' + @crlf + 	''    select '''''' + @tablename + '''''', inserted.ROWGUIDCOL, '''''' + @fieldname + '''''', deleted.'' + @fieldname + '', inserted.'' + @fieldname + '', ''''U'''' '' + @extraSelect + @crlf + ''    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL'' + @crlf
					set @tstring2 = ''    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype'' + @extraFields + '') '' + @crlf + 
						''    select '''''' + @tablename + '''''', deleted.ROWGUIDCOL, '''''' + @fieldname + '''''', deleted.'' + @fieldname + '', ''''D'''' '' + @extraDelete + @crlf +
						''    from deleted '' + @crlf +
						''    where deleted.'' + @fieldname + '' is not null '' + @crlf + @crlf
					end
				end


			if (len(@updsql1) + len(@tstring)) < 7999 set @updsql1 = @updsql1 + @crlf + @tstring
			else if (len(@updsql2) + len(@tstring)) < 7999 set @updsql2 = @updsql2 + @crlf + @tstring
			else if (len(@updsql3) + len(@tstring)) < 7999 set @updsql3 = @updsql3 + @crlf + @tstring
			else if (len(@updsql4) + len(@tstring)) < 7999 set @updsql4 = @updsql4 + @crlf + @tstring
			
			if (len(@deletesql1) + len(@tstring2)) < 7999 set @deletesql1 = @deletesql1 + @crlf + @tstring2
			else if (len(@deletesql2) + len(@tstring2)) < 7999 set @deletesql2 = @deletesql2 + @crlf + @tstring2
			else if (len(@deletesql3) + len(@tstring2)) < 7999 set @deletesql3 = @deletesql3 + @crlf + @tstring2
			else if (len(@deletesql4) + len(@tstring2)) < 7999 set @deletesql4 = @deletesql4 + @crlf + @tstring2

		fetch next from colcursor into @fieldname, @fieldlen, @fieldtype	
			end
		close colcursor
		deallocate colcursor


exec(@updsql1 + @updsql2 + @updsql3 + @updsql4)
exec(@deletesql1 + @deletesql2 + @deletesql3 + @deletesql4)
exec(@insertsql)


' 
END
GO
/****** Object:  Table [dbo].[BestExportFields]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestExportFields]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestExportFields](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestExportFields_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestExportFields_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestExportFields_lastChangeUser]  DEFAULT (app_name()),
	[exportguid] [uniqueidentifier] NOT NULL,
	[fieldname] [varchar](100) NOT NULL,
	[displayname] [varchar](50) NULL,
	[ordinal] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestExports]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestExports]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestExports](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestExports_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestExports_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestExports_lastChangeUser]  DEFAULT (app_name()),
	[exportName] [varchar](50) NULL,
	[exportTitle] [varchar](50) NULL,
	[exportType] [varchar](50) NULL,
 CONSTRAINT [PK_BestExports] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestExportTables]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestExportTables]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestExportTables](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestExportTables_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestExportTables_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestExportTables_lastChangeUser]  DEFAULT (app_name()),
	[fieldname] [varchar](50) NULL,
	[aliasname] [varchar](50) NULL,
	[displayname] [varchar](50) NULL,
	[exportType] [varchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestPaymentDetails]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestPaymentDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestPaymentDetails](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_paymentDetails_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_paymentDetails_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_paymentDetails_lastChangeUser]  DEFAULT (app_name()),
	[studentGuid] [uniqueidentifier] NULL,
	[paymentTypeGuid] [uniqueidentifier] NULL,
	[paymentDate] [datetime] NULL,
	[amount] [decimal](18, 0) NULL,
	[studentId] [varchar](50) NULL,
	[centerId] [varchar](50) NULL,
	[hours] [decimal](18, 2) NULL,
 CONSTRAINT [PK_BestPaymentDetails] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestUserPrefs]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestUserPrefs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestUserPrefs](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestUserPrefs_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestUserPrefs_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestUserPrefs_lastChangeUser]  DEFAULT (app_name()),
	[name] [varchar](50) NULL,
	[value] [varchar](50) NULL,
	[userName] [varchar](128) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestCenters]    Script Date: 05/31/2012 22:08:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BestCenters]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BestCenters](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestCenters_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestCenters_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestCenters_lastChangeUser]  DEFAULT (app_name()),
	[CenterId] [varchar](50) NOT NULL,
	[address1] [varchar](50) NULL,
	[address2] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](2) NULL,
	[zip] [varchar](50) NULL,
	[contactName] [varchar](50) NULL,
	[contactEMail] [varchar](80) NULL,
	[contactPhone] [varchar](15) NULL,
 CONSTRAINT [PK_BestCenters] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [BestEMailTemplates_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestEMailTemplates_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestEMailTemplates_Update] ON [dbo].[BestEMailTemplates] FOR UPDATE AS 
UPDATE BestEMailTemplates SET BestEMailTemplates.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestEMailTemplates, inserted WHERE BestEMailTemplates.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(emialTemplateName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestEMailTemplates'', inserted.ROWGUIDCOL, ''emialTemplateName'', deleted.emialTemplateName, inserted.emialTemplateName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(templateDescription)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestEMailTemplates'', inserted.ROWGUIDCOL, ''templateDescription'', left(deleted.templateDescription,3000), left(inserted.templateDescription,3000), ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

'
GO
/****** Object:  Trigger [BestEMailTemplates_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestEMailTemplates_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestEMailTemplates_DELETE] ON [dbo].[BestEMailTemplates] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestEMailTemplates'', deleted.ROWGUIDCOL, ''emialTemplateName'', deleted.emialTemplateName, ''D'' 
    from deleted 
    where deleted.emialTemplateName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestEMailTemplates'', deleted.ROWGUIDCOL, ''templateDescription'', left(deleted.templateDescription,3000), ''D'' 
    from deleted 
    where deleted.templateDescription is not null 

'
GO
/****** Object:  Trigger [BestEMailTemplates_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestEMailTemplates_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestEMailTemplates_Insert] ON [dbo].[BestEMailTemplates] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestEMailTemplates'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  Trigger [BestPaymentTypes_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPaymentTypes_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPaymentTypes_DELETE] ON [dbo].[BestPaymentTypes] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestPaymentTypes'', deleted.ROWGUIDCOL, ''paymentType'', deleted.paymentType, ''D'' 
    from deleted 
    where deleted.paymentType is not null 

'
GO
/****** Object:  Trigger [BestPaymentTypes_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPaymentTypes_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPaymentTypes_Insert] ON [dbo].[BestPaymentTypes] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestPaymentTypes'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  Trigger [BestPaymentTypes_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPaymentTypes_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPaymentTypes_Update] ON [dbo].[BestPaymentTypes] FOR UPDATE AS 
UPDATE BestPaymentTypes SET BestPaymentTypes.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestPaymentTypes, inserted WHERE BestPaymentTypes.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(paymentType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestPaymentTypes'', inserted.ROWGUIDCOL, ''paymentType'', deleted.paymentType, inserted.paymentType, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestProgamTypes_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestProgamTypes_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestProgamTypes_Update] ON [dbo].[BestProgamTypes] FOR UPDATE AS 
UPDATE BestProgamTypes SET BestProgamTypes.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestProgamTypes, inserted WHERE BestProgamTypes.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(programType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestProgamTypes'', inserted.ROWGUIDCOL, ''programType'', deleted.programType, inserted.programType, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestProgamTypes_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestProgamTypes_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestProgamTypes_DELETE] ON [dbo].[BestProgamTypes] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestProgamTypes'', deleted.ROWGUIDCOL, ''programType'', deleted.programType, ''D'' 
    from deleted 
    where deleted.programType is not null 

'
GO
/****** Object:  Trigger [BestProgamTypes_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestProgamTypes_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestProgamTypes_Insert] ON [dbo].[BestProgamTypes] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestProgamTypes'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  Trigger [BestPrograms_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPrograms_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPrograms_Update] ON [dbo].[BestPrograms] FOR UPDATE AS 
UPDATE BestPrograms SET BestPrograms.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestPrograms, inserted WHERE BestPrograms.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(programName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestPrograms'', inserted.ROWGUIDCOL, ''programName'', deleted.programName, inserted.programName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(programType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestPrograms'', inserted.ROWGUIDCOL, ''programType'', deleted.programType, inserted.programType, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestPrograms'', inserted.ROWGUIDCOL, ''amount'', deleted.amount, inserted.amount, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amountType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestPrograms'', inserted.ROWGUIDCOL, ''amountType'', deleted.amountType, inserted.amountType, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestPrograms_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPrograms_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPrograms_DELETE] ON [dbo].[BestPrograms] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestPrograms'', deleted.ROWGUIDCOL, ''programName'', deleted.programName, ''D'' 
    from deleted 
    where deleted.programName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestPrograms'', deleted.ROWGUIDCOL, ''programType'', deleted.programType, ''D'' 
    from deleted 
    where deleted.programType is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestPrograms'', deleted.ROWGUIDCOL, ''amount'', deleted.amount, ''D'' 
    from deleted 
    where deleted.amount is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestPrograms'', deleted.ROWGUIDCOL, ''amountType'', deleted.amountType, ''D'' 
    from deleted 
    where deleted.amountType is not null 

'
GO
/****** Object:  Trigger [BestPrograms_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPrograms_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPrograms_Insert] ON [dbo].[BestPrograms] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestPrograms'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  View [dbo].[VBestPrograms]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VBestPrograms]'))
EXEC dbo.sp_executesql @statement = N'Create View [dbo].[VBestPrograms] As
select BestStudentPrograms.guidfield, BestStudentPrograms.CenterId, programname+''(''+programtype+'') $''+ltrim(str(coalesce(BestStudentPrograms.amount, BestPrograms.amount)))+''/''+amounttype as programDesc
from BestPrograms
left join BestStudentPrograms on BestStudentPrograms.programguid = BestPrograms.guidfield
'
GO
/****** Object:  View [loginbest].[VBestPrograms]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[loginbest].[VBestPrograms]'))
EXEC dbo.sp_executesql @statement = N'Create View [loginbest].[VBestPrograms] As
select BestStudentPrograms.guidfield, programname+''(''+programtype+'') $''+ltrim(str(coalesce(BestStudentPrograms.amount, BestPrograms.amount)))+''/''+amounttype as programDesc
from BestPrograms
left join BestStudentPrograms on BestStudentPrograms.programguid = BestPrograms.guidfield
'
GO
/****** Object:  View [dbo].[VBestSchedulesAndPayments]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VBestSchedulesAndPayments]'))
EXEC dbo.sp_executesql @statement = N'
CREATE View [dbo].[VBestSchedulesAndPayments] As
Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid1 as studentGuid, 
	BestSchedules.schDate,
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended1 as attendance,
	''Scheduled'' as tranType,
	1 as hours,
	BestSchedules.Amount1 as Amount,
	bsp.programGuid,
	BestSchedules.tutGuid,
	BestSchedules.note1 as note,
	BestSchedules.CenterId as centerid
 from BestSchedules left join BestStudentPrograms bsp on bsp.guidfield = BestSchedules.progGuid1
	where isdeleted=0
 union all
 Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid2, 
	BestSchedules.schDate, 
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended2,
	''Scheduled'' as tranType,
	1 as hours,
	BestSchedules.Amount2 as Amount,
	bsp.programGuid,
	BestSchedules.tutGuid,
	BestSchedules.note2,
	BestSchedules.CenterId
 from BestSchedules left join BestStudentPrograms bsp on bsp.guidfield = BestSchedules.progGuid2 
 where BestSchedules.stuGuid2 is not null and isdeleted=0
 union all
 Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid3, 
	BestSchedules.schDate, 
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended3,
	''Scheduled'' as tranType,
	1 as hours,
	BestSchedules.Amount3 as Amount,
	bsp.programGuid,
	BestSchedules.tutGuid,
	BestSchedules.note3,
	BestSchedules.CenterId
 from BestSchedules left join BestStudentPrograms bsp on bsp.guidfield = BestSchedules.progGuid3  
 where BestSchedules.stuGuid3 is not null and isdeleted=0
 union all
 Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid4, 
	BestSchedules.schDate, 
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended4,
	''Scheduled'' as tranType,
	1 as hours,
	BestSchedules.Amount4 as Amount,
	bsp.programGuid,
	BestSchedules.tutGuid,
	BestSchedules.note4,
	BestSchedules.CenterId
 from BestSchedules left join BestStudentPrograms bsp on bsp.guidfield = BestSchedules.progGuid4 
 where BestSchedules.stuGuid4 is not null and isdeleted=0
 union all
 Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid5, 
	BestSchedules.schDate, 
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended5,
	''Scheduled'' as tranType,
	1 as hours,
	BestSchedules.Amount5 as Amount,
	bsp.programGuid,
	BestSchedules.tutGuid,
	BestSchedules.note5,
	BestSchedules.CenterId
 from BestSchedules left join BestStudentPrograms bsp on bsp.guidfield = BestSchedules.progGuid5 
 where BestSchedules.stuGuid5 is not null and isdeleted=0
union all
Select
	BestPaymentDetails.guidfield,
	BestPaymentDetails.studentGuid,
	convert(varchar(10),BestPaymentDetails.paymentDate,112) as schDate,
	'''' as schfrom,
	'''' as schto,
	0 as attended,
	''Payment'' as tranType,
	-hours,
	amount,
	null as programGuid,
	null as tutorguid,
	null as note,
	CenterId
from BestPaymentDetails
union all
Select 
	BestStudentPrograms.guidfield,
	BestStudentPrograms.studentGuid,
	convert(varchar(10),BestStudentPrograms.lastchange,112) as schDate,
	'''' as schfrom,
	'''' as schto,
	0 as attended,
	''Scheduled'' as transType,
	0 as hours,
	BestStudentPrograms.amount as amount,
	BestStudentPrograms.programGuid,
	null as tutorguid,
	''One Time Program'' as note,
	BestStudentPrograms.CenterId as CenterId
from BestStudentPrograms
inner join BestPrograms on BestPrograms.guidfield = BestStudentPrograms.programGuid and BestPrograms.amounttype in (''OneTime'', ''Year'')'
GO
/****** Object:  StoredProcedure [dbo].[Best_SuspectScore]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Best_SuspectScore]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


create PROCEDURE [dbo].[Best_SuspectScore] 
@target varchar(200) as
Select isnull(sum(score),0) as TheScore from BestSuspicion 
where target = @target and logdate >= getDate() - .0417 --.0417 is roughly 1/24 = 1 hour



' 
END
GO
/****** Object:  Trigger [BestStudentReference_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentReference_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentReference_Insert] ON [dbo].[BestStudentReference] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestStudentReference'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestStudentReference_Update]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentReference_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentReference_Update] ON [dbo].[BestStudentReference] FOR UPDATE AS 
UPDATE BestStudentReference SET BestStudentReference.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestStudentReference, inserted WHERE BestStudentReference.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentguid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, inserted.studentguid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(centerId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''centerId'', deleted.centerId, inserted.centerId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(referencedby)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''referencedby'', deleted.referencedby, inserted.referencedby, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(expectedDuration)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''expectedDuration'', deleted.expectedDuration, inserted.expectedDuration, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(blcRecommend)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''blcRecommend'', deleted.blcRecommend, inserted.blcRecommend, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(proposedProg)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''proposedProg'', deleted.proposedProg, inserted.proposedProg, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(proposedHour)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''proposedHour'', deleted.proposedHour, inserted.proposedHour, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(parentComments)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''parentComments'', deleted.parentComments, inserted.parentComments, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(parentExpects)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''parentExpects'', deleted.parentExpects, inserted.parentExpects, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(emergName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''emergName'', deleted.emergName, inserted.emergName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(emergPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''emergPhone'', deleted.emergPhone, inserted.emergPhone, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(healthConditions)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', inserted.ROWGUIDCOL, ''healthConditions'', deleted.healthConditions, inserted.healthConditions, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestStudentReference_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentReference_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentReference_DELETE] ON [dbo].[BestStudentReference] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentguid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''centerId'', deleted.centerId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.centerId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''referencedby'', deleted.referencedby, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.referencedby is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''expectedDuration'', deleted.expectedDuration, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.expectedDuration is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''blcRecommend'', deleted.blcRecommend, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.blcRecommend is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''proposedProg'', deleted.proposedProg, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.proposedProg is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''proposedHour'', deleted.proposedHour, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.proposedHour is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''parentComments'', deleted.parentComments, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.parentComments is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''parentExpects'', deleted.parentExpects, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.parentExpects is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''emergName'', deleted.emergName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.emergName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''emergPhone'', deleted.emergPhone, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.emergPhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentReference'', deleted.ROWGUIDCOL, ''healthConditions'', deleted.healthConditions, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.healthConditions is not null 

'
GO
/****** Object:  Trigger [BestServices_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestServices_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestServices_Insert] ON [dbo].[BestServices] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId)
   select ''BestServices'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId from inserted'
GO
/****** Object:  Trigger [BestServices_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestServices_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestServices_DELETE] ON [dbo].[BestServices] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestServices'', deleted.ROWGUIDCOL, ''Service'', deleted.Service, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.Service is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestServices'', deleted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.CenterId is not null 

'
GO
/****** Object:  Trigger [BestServices_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestServices_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestServices_Update] ON [dbo].[BestServices] FOR UPDATE AS 
UPDATE BestServices SET BestServices.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestServices, inserted WHERE BestServices.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(Service)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestServices'', inserted.ROWGUIDCOL, ''Service'', deleted.Service, inserted.Service, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(CenterId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestServices'', inserted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, inserted.CenterId, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestSchedules_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestSchedules_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestSchedules_Insert] ON [dbo].[BestSchedules] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId)
   select ''BestSchedules'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId from inserted'
GO
/****** Object:  Trigger [BestSchedules_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestSchedules_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestSchedules_Update] ON [dbo].[BestSchedules] FOR UPDATE AS 
UPDATE BestSchedules SET BestSchedules.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestSchedules, inserted WHERE BestSchedules.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(tutGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''tutGuid'', deleted.tutGuid, inserted.tutGuid, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(stuGuid1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''stuGuid1'', deleted.stuGuid1, inserted.stuGuid1, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(stuGuid2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''stuGuid2'', deleted.stuGuid2, inserted.stuGuid2, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(stuGuid3)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''stuGuid3'', deleted.stuGuid3, inserted.stuGuid3, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(stuGuid4)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''stuGuid4'', deleted.stuGuid4, inserted.stuGuid4, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(stuGuid5)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''stuGuid5'', deleted.stuGuid5, inserted.stuGuid5, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(schDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''schDate'', deleted.schDate, inserted.schDate, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(schFrom)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''schFrom'', deleted.schFrom, inserted.schFrom, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(schTo)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''schTo'', deleted.schTo, inserted.schTo, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(isDeleted)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''isDeleted'', deleted.isDeleted, inserted.isDeleted, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(attended1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''attended1'', deleted.attended1, inserted.attended1, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(attended2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''attended2'', deleted.attended2, inserted.attended2, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(attended3)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''attended3'', deleted.attended3, inserted.attended3, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(attended4)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''attended4'', deleted.attended4, inserted.attended4, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(attended5)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''attended5'', deleted.attended5, inserted.attended5, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(note1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''note1'', deleted.note1, inserted.note1, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(note2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''note2'', deleted.note2, inserted.note2, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(note3)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''note3'', deleted.note3, inserted.note3, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(note4)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''note4'', deleted.note4, inserted.note4, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(note5)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''note5'', deleted.note5, inserted.note5, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(progGuid1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''progGuid1'', deleted.progGuid1, inserted.progGuid1, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(progGuid2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''progGuid2'', deleted.progGuid2, inserted.progGuid2, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(progGuid3)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''progGuid3'', deleted.progGuid3, inserted.progGuid3, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(progGuid4)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''progGuid4'', deleted.progGuid4, inserted.progGuid4, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(progGuid5)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''progGuid5'', deleted.progGuid5, inserted.progGuid5, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(tutorattend)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''tutorattend'', deleted.tutorattend, inserted.tutorattend, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''amount1'', deleted.amount1, inserted.amount1, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''amount2'', deleted.amount2, inserted.amount2, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount3)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''amount3'', deleted.amount3, inserted.amount3, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount4)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''amount4'', deleted.amount4, inserted.amount4, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount5)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''amount5'', deleted.amount5, inserted.amount5, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(CenterId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestSchedules'', inserted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, inserted.CenterId, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestSchedules_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestSchedules_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestSchedules_DELETE] ON [dbo].[BestSchedules] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''tutGuid'', deleted.tutGuid, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.tutGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''stuGuid1'', deleted.stuGuid1, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.stuGuid1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''stuGuid2'', deleted.stuGuid2, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.stuGuid2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''stuGuid3'', deleted.stuGuid3, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.stuGuid3 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''stuGuid4'', deleted.stuGuid4, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.stuGuid4 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''stuGuid5'', deleted.stuGuid5, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.stuGuid5 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''schDate'', deleted.schDate, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.schDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''schFrom'', deleted.schFrom, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.schFrom is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''schTo'', deleted.schTo, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.schTo is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''isDeleted'', deleted.isDeleted, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.isDeleted is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''attended1'', deleted.attended1, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.attended1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''attended2'', deleted.attended2, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.attended2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''attended3'', deleted.attended3, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.attended3 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''attended4'', deleted.attended4, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.attended4 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''attended5'', deleted.attended5, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.attended5 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''note1'', deleted.note1, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.note1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''note2'', deleted.note2, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.note2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''note3'', deleted.note3, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.note3 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''note4'', deleted.note4, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.note4 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''note5'', deleted.note5, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.note5 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''progGuid1'', deleted.progGuid1, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.progGuid1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''progGuid2'', deleted.progGuid2, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.progGuid2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''progGuid3'', deleted.progGuid3, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.progGuid3 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''progGuid4'', deleted.progGuid4, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.progGuid4 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''progGuid5'', deleted.progGuid5, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.progGuid5 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''tutorattend'', deleted.tutorattend, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.tutorattend is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''amount1'', deleted.amount1, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.amount1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''amount2'', deleted.amount2, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.amount2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''amount3'', deleted.amount3, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.amount3 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''amount4'', deleted.amount4, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.amount4 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''amount5'', deleted.amount5, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.amount5 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestSchedules'', deleted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.CenterId is not null 

'
GO
/****** Object:  View [loginbest].[VBestSchedules]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[loginbest].[VBestSchedules]'))
EXEC dbo.sp_executesql @statement = N'CREATE View [loginbest].[VBestSchedules] As
select tutguid, stuguid1, stuguid2, stuguid3, stuguid4, stuguid5, schfrom,
	convert(varchar(10),convert(datetime,schdate),101) as Date, 
	[Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday],
	stud1.firstname + '' '' + left(case when stud1.lastname is not null then stud1.lastname else '''' end,1) as stud1name,
	stud2.firstname + '' '' + left(case when stud2.lastname is not null then stud2.lastname else '''' end,1) as stud2name,
	stud3.firstname + '' '' + left(case when stud3.lastname is not null then stud3.lastname else '''' end,1) as stud3name,
	stud4.firstname + '' '' + left(case when stud4.lastname is not null then stud4.lastname else '''' end,1) as stud4name,
	stud5.firstname + '' '' + left(case when stud5.lastname is not null then stud5.lastname else '''' end,1) as stud5name
	
from (Select tutguid, stuguid1, stuguid2, stuguid3, stuguid4, stuguid5, schdate, datename(dw,convert(datetime, schdate)) as weekname, schfrom, 
	convert(numeric,schfrom) as numFrom from BestSchedules where isdeleted=0) p
PIVOT
(sum(numFrom) for weekname in ([Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday])) As pvt
left join BestStudents stud1 on stud1.guidfield = stuguid1
left join BestStudents stud2 on stud2.guidfield = stuguid2
left join BestStudents stud3 on stud3.guidfield = stuguid3
left join BestStudents stud4 on stud4.guidfield = stuguid4
left join BestStudents stud5 on stud5.guidfield = stuguid5
'
GO
/****** Object:  StoredProcedure [loginbest].[CopySchedules]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[loginbest].[CopySchedules]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Balaji Musaboyina
-- Create date: 06/23/2011
-- Modified Date: 11/26/2011
-- Description:	Copy Schedules
-- =============================================
CREATE PROCEDURE [loginbest].[CopySchedules] 
@BeginDate datetime,
@ToDate datetime,
@CopyType varchar(10)
AS
BEGIN
	SET NOCOUNT ON;
Declare @I as Int;
Declare @newSch varchar(10)
Declare @calcDate datetime;
Declare @srcSch varchar(10);
	if @CopyType = ''Week''
	Begin
		Set @I = 0;
		While (@I < 6)
		Begin
			Set @calcDate = DateAdd(dd, @I, @ToDate);
			Set @srcSch = Convert(varchar(10), DateAdd(dd, @I, @BeginDate), 112);
			Set @newSch = Convert(varchar(10), @calcDate, 112);
			insert into BestSchedules ([tutGuid] ,[stuGuid1] ,[stuGuid2] ,[stuGuid3] ,[stuGuid4] ,[stuGuid5] ,[schDate] ,[schFrom] ,[schTo],[progGuid1] ,[progGuid2] ,[progGuid3] ,[progGuid4] ,[progGuid5], amount1, amount2, amount3, amount4, amount5, centerid) (select [tutGuid] ,[stuGuid1] ,[stuGuid2] ,[stuGuid3] ,[stuGuid4] ,[stuGuid5] , @newSch ,[schFrom] ,[schTo],[progGuid1] ,[progGuid2] ,[progGuid3] ,[progGuid4] ,[progGuid5], amount1, amount2, amount3, amount4, amount5, centerid from BestSchedules Where isDeleted=0 and SchDate = @srcSch);
			Set @I = @I + 1;
		End		
	End

	if @CopyType = ''Day'' 
	Begin
		Set @newSch = Convert(varchar(10), @ToDate, 112);
		Set @srcSch = Convert(varchar(10), @BeginDate, 112);
insert into BestSchedules ([tutGuid] ,[stuGuid1] ,[stuGuid2] ,[stuGuid3] ,[stuGuid4] ,[stuGuid5] ,[schDate] ,[schFrom] ,[schTo],[progGuid1] ,[progGuid2] ,[progGuid3] ,[progGuid4] ,[progGuid5], amount1, amount2, amount3, amount4, amount5, centerid) (select [tutGuid] ,[stuGuid1] ,[stuGuid2] ,[stuGuid3] ,[stuGuid4] ,[stuGuid5] , @newSch ,[schFrom] ,[schTo],[progGuid1] ,[progGuid2] ,[progGuid3] ,[progGuid4] ,[progGuid5], amount1, amount2, amount3, amount4, amount5, centerid from BestSchedules Where isDeleted=0 and SchDate = @srcSch);
	End	
END
' 
END
GO
/****** Object:  View [loginbest].[VBestDate]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[loginbest].[VBestDate]'))
EXEC dbo.sp_executesql @statement = N'Create View [loginbest].[VBestDate] As
select date, 
	DATEADD(mm,DATEDIFF(mm,0,Date),0) As MBDate, DATEADD(dd,-1,DATEADD(mm,1,DATEADD(mm,DATEDIFF(mm,0,Date),0))) As MEDate, 
	DATEADD(dd, -1 * case DATENAME(weekday, Date) when ''Sunday'' then 0 when ''Monday'' then 1 when ''Tuesday'' then 2 when ''Wednesday'' then 3 when ''Thursday'' then 4 when ''Friday'' then 5 when ''Saturday'' then 6 end, Date) As WBDate, 
	DATEADD(dd, 6, DATEADD(dd, -1 * case DATENAME(weekday, Date) when ''Sunday'' then 0 when ''Monday'' then 1 when ''Tuesday'' then 2 when ''Wednesday'' then 3 when ''Thursday'' then 4 when ''Friday'' then 5 when ''Saturday'' then 6 end, Date)) As WEDate, 
	DATENAME(week, Date) As WeekNum
from bestdates 

'
GO
/****** Object:  Trigger [BestStudentGPA_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentGPA_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentGPA_DELETE] ON [dbo].[BestStudentGPA] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', deleted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentguid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', deleted.ROWGUIDCOL, ''assessmentDate'', deleted.assessmentDate, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.assessmentDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', deleted.ROWGUIDCOL, ''assessmentGPA'', deleted.assessmentGPA, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.assessmentGPA is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', deleted.ROWGUIDCOL, ''assessmentLevel'', deleted.assessmentLevel, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.assessmentLevel is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', deleted.ROWGUIDCOL, ''centerId'', deleted.centerId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.centerId is not null 

'
GO
/****** Object:  Trigger [BestStudentGPA_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentGPA_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentGPA_Insert] ON [dbo].[BestStudentGPA] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestStudentGPA'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestStudentGPA_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentGPA_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentGPA_Update] ON [dbo].[BestStudentGPA] FOR UPDATE AS 
UPDATE BestStudentGPA SET BestStudentGPA.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestStudentGPA, inserted WHERE BestStudentGPA.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentguid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', inserted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, inserted.studentguid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(assessmentDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', inserted.ROWGUIDCOL, ''assessmentDate'', deleted.assessmentDate, inserted.assessmentDate, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(assessmentGPA)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', inserted.ROWGUIDCOL, ''assessmentGPA'', deleted.assessmentGPA, inserted.assessmentGPA, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(assessmentLevel)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', inserted.ROWGUIDCOL, ''assessmentLevel'', deleted.assessmentLevel, inserted.assessmentLevel, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(centerId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentGPA'', inserted.ROWGUIDCOL, ''centerId'', deleted.centerId, inserted.centerId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestStudentPrograms_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPrograms_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPrograms_Insert] ON [dbo].[BestStudentPrograms] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestStudentPrograms'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted
'
GO
/****** Object:  Trigger [BestStudentPrograms_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPrograms_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPrograms_Update] ON [dbo].[BestStudentPrograms] FOR UPDATE AS 
UPDATE BestStudentPrograms SET BestStudentPrograms.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestStudentPrograms, inserted WHERE BestStudentPrograms.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentguid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', inserted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, inserted.studentguid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(programguid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', inserted.ROWGUIDCOL, ''programguid'', deleted.programguid, inserted.programguid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(centerId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', inserted.ROWGUIDCOL, ''centerId'', deleted.centerId, inserted.centerId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', inserted.ROWGUIDCOL, ''amount'', deleted.amount, inserted.amount, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestStudentPrograms_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPrograms_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPrograms_DELETE] ON [dbo].[BestStudentPrograms] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', deleted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentguid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', deleted.ROWGUIDCOL, ''programguid'', deleted.programguid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.programguid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', deleted.ROWGUIDCOL, ''centerId'', deleted.centerId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.centerId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPrograms'', deleted.ROWGUIDCOL, ''amount'', deleted.amount, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.amount is not null
'
GO
/****** Object:  Trigger [BestStudentNotes_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentNotes_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentNotes_Update] ON [dbo].[BestStudentNotes] FOR UPDATE AS 
UPDATE BestStudentNotes SET BestStudentNotes.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestStudentNotes, inserted WHERE BestStudentNotes.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentNotes'', inserted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, inserted.studentGuid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(noteDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentNotes'', inserted.ROWGUIDCOL, ''noteDate'', deleted.noteDate, inserted.noteDate, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(notes)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentNotes'', inserted.ROWGUIDCOL, ''notes'', left(deleted.notes,3000), left(inserted.notes,3000), ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL


    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentNotes'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestStudentNotes_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentNotes_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentNotes_DELETE] ON [dbo].[BestStudentNotes] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentNotes'', deleted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentNotes'', deleted.ROWGUIDCOL, ''noteDate'', deleted.noteDate, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.noteDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentNotes'', deleted.ROWGUIDCOL, ''notes'', left(deleted.notes,3000), ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.notes is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentNotes'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 

'
GO
/****** Object:  Trigger [BestStudentNotes_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentNotes_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentNotes_Insert] ON [dbo].[BestStudentNotes] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestStudentNotes'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestStudentPayment_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPayment_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPayment_Update] ON [dbo].[BestStudentPayment] FOR UPDATE AS 
UPDATE BestStudentPayment SET BestStudentPayment.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestStudentPayment, inserted WHERE BestStudentPayment.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentguid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', inserted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, inserted.studentguid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(parentemail)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', inserted.ROWGUIDCOL, ''parentemail'', deleted.parentemail, inserted.parentemail, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(name)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', inserted.ROWGUIDCOL, ''name'', deleted.name, inserted.name, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(paymethod)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', inserted.ROWGUIDCOL, ''paymethod'', deleted.paymethod, inserted.paymethod, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(centerId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', inserted.ROWGUIDCOL, ''centerId'', deleted.centerId, inserted.centerId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestStudentPayment_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPayment_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPayment_DELETE] ON [dbo].[BestStudentPayment] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', deleted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentguid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', deleted.ROWGUIDCOL, ''parentemail'', deleted.parentemail, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.parentemail is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', deleted.ROWGUIDCOL, ''name'', deleted.name, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.name is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', deleted.ROWGUIDCOL, ''paymethod'', deleted.paymethod, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.paymethod is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', deleted.ROWGUIDCOL, ''centerId'', deleted.centerId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.centerId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPayment'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 

'
GO
/****** Object:  Trigger [BestStudentPayment_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPayment_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPayment_Insert] ON [dbo].[BestStudentPayment] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestStudentPayment'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestSTPlans_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestSTPlans_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestSTPlans_Insert] ON [dbo].[BestSTPlans] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestSTPlans'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestSTPlans_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestSTPlans_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestSTPlans_Update] ON [dbo].[BestSTPlans] FOR UPDATE AS 
UPDATE BestSTPlans SET BestSTPlans.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestSTPlans, inserted WHERE BestSTPlans.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(centerId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', inserted.ROWGUIDCOL, ''centerId'', deleted.centerId, inserted.centerId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', inserted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, inserted.studentGuid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(tutorGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', inserted.ROWGUIDCOL, ''tutorGuid'', deleted.tutorGuid, inserted.tutorGuid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(schDay)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', inserted.ROWGUIDCOL, ''schDay'', deleted.schDay, inserted.schDay, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(schFrom)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', inserted.ROWGUIDCOL, ''schFrom'', deleted.schFrom, inserted.schFrom, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(schTo)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', inserted.ROWGUIDCOL, ''schTo'', deleted.schTo, inserted.schTo, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(isDeleted)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', inserted.ROWGUIDCOL, ''isDeleted'', deleted.isDeleted, inserted.isDeleted, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestSTPlans_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestSTPlans_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestSTPlans_DELETE] ON [dbo].[BestSTPlans] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', deleted.ROWGUIDCOL, ''centerId'', deleted.centerId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.centerId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', deleted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', deleted.ROWGUIDCOL, ''tutorGuid'', deleted.tutorGuid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.tutorGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', deleted.ROWGUIDCOL, ''schDay'', deleted.schDay, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.schDay is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', deleted.ROWGUIDCOL, ''schFrom'', deleted.schFrom, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.schFrom is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', deleted.ROWGUIDCOL, ''schTo'', deleted.schTo, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.schTo is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestSTPlans'', deleted.ROWGUIDCOL, ''isDeleted'', deleted.isDeleted, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.isDeleted is not null 

'
GO
/****** Object:  Trigger [BestStudentPickup_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPickup_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPickup_Insert] ON [dbo].[BestStudentPickup] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestStudentPickup'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestStudentPickup_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPickup_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPickup_Update] ON [dbo].[BestStudentPickup] FOR UPDATE AS 
UPDATE BestStudentPickup SET BestStudentPickup.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestStudentPickup, inserted WHERE BestStudentPickup.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentguid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', inserted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, inserted.studentguid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(contactName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', inserted.ROWGUIDCOL, ''contactName'', deleted.contactName, inserted.contactName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(contactPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', inserted.ROWGUIDCOL, ''contactPhone'', deleted.contactPhone, inserted.contactPhone, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(relationship)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', inserted.ROWGUIDCOL, ''relationship'', deleted.relationship, inserted.relationship, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(centerId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', inserted.ROWGUIDCOL, ''centerId'', deleted.centerId, inserted.centerId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestStudentPickup_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPickup_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPickup_DELETE] ON [dbo].[BestStudentPickup] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', deleted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentguid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', deleted.ROWGUIDCOL, ''contactName'', deleted.contactName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.contactName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', deleted.ROWGUIDCOL, ''contactPhone'', deleted.contactPhone, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.contactPhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', deleted.ROWGUIDCOL, ''relationship'', deleted.relationship, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.relationship is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPickup'', deleted.ROWGUIDCOL, ''centerId'', deleted.centerId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.centerId is not null 

'
GO
/****** Object:  Trigger [BestStudentPicture_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPicture_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPicture_Update] ON [dbo].[BestStudentPicture] FOR UPDATE AS 
UPDATE BestStudentPicture SET BestStudentPicture.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestStudentPicture, inserted WHERE BestStudentPicture.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentguid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, inserted.studentguid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(hobbies)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''hobbies'', deleted.hobbies, inserted.hobbies, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(personality)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''personality'', deleted.personality, inserted.personality, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(goals)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''goals'', deleted.goals, inserted.goals, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(learningstyle)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''learningstyle'', deleted.learningstyle, inserted.learningstyle, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(tutorpreference)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''tutorpreference'', deleted.tutorpreference, inserted.tutorpreference, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(centerId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''centerId'', deleted.centerId, inserted.centerId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(photoSize)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''photoSize'', deleted.photoSize, inserted.photoSize, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(photoName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''photoName'', deleted.photoName, inserted.photoName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestStudentPicture_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPicture_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPicture_DELETE] ON [dbo].[BestStudentPicture] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''studentguid'', deleted.studentguid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentguid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''hobbies'', deleted.hobbies, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.hobbies is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''personality'', deleted.personality, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.personality is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''goals'', deleted.goals, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.goals is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''learningstyle'', deleted.learningstyle, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.learningstyle is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''tutorpreference'', deleted.tutorpreference, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.tutorpreference is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''centerId'', deleted.centerId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.centerId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''photoSize'', deleted.photoSize, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.photoSize is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudentPicture'', deleted.ROWGUIDCOL, ''photoName'', deleted.photoName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.photoName is not null 

'
GO
/****** Object:  Trigger [BestStudentPicture_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudentPicture_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudentPicture_Insert] ON [dbo].[BestStudentPicture] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestStudentPicture'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestStudents_Update]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudents_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudents_Update] ON [dbo].[BestStudents] FOR UPDATE AS 
UPDATE BestStudents SET BestStudents.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestStudents, inserted WHERE BestStudents.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(CenterId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, inserted.CenterId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(StudentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''StudentId'', deleted.StudentId, inserted.StudentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(firstName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''firstName'', deleted.firstName, inserted.firstName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(lastName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''lastName'', deleted.lastName, inserted.lastName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(middleName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''middleName'', deleted.middleName, inserted.middleName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(parentName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''parentName'', deleted.parentName, inserted.parentName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(address1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''address1'', deleted.address1, inserted.address1, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(address2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''address2'', deleted.address2, inserted.address2, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(city)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''city'', deleted.city, inserted.city, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(state)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''state'', deleted.state, inserted.state, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(zip)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''zip'', deleted.zip, inserted.zip, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(cellPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''cellPhone'', deleted.cellPhone, inserted.cellPhone, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(homePhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''homePhone'', deleted.homePhone, inserted.homePhone, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(workPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''workPhone'', deleted.workPhone, inserted.workPhone, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(emailId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''emailId'', deleted.emailId, inserted.emailId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(gender)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''gender'', deleted.gender, inserted.gender, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(hours)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''hours'', deleted.hours, inserted.hours, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''amount'', deleted.amount, inserted.amount, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(hourType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''hourType'', deleted.hourType, inserted.hourType, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amountType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''amountType'', deleted.amountType, inserted.amountType, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(programGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''programGuid'', deleted.programGuid, inserted.programGuid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(joinDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''joinDate'', deleted.joinDate, inserted.joinDate, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(birthDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''birthDate'', deleted.birthDate, inserted.birthDate, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(guardianName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''guardianName'', deleted.guardianName, inserted.guardianName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(school)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''school'', deleted.school, inserted.school, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(grade)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', inserted.ROWGUIDCOL, ''grade'', deleted.grade, inserted.grade, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestStudents_DELETE]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudents_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudents_DELETE] ON [dbo].[BestStudents] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.CenterId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''StudentId'', deleted.StudentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.StudentId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''firstName'', deleted.firstName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.firstName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''lastName'', deleted.lastName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.lastName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''middleName'', deleted.middleName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.middleName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''parentName'', deleted.parentName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.parentName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''address1'', deleted.address1, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.address1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''address2'', deleted.address2, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.address2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''city'', deleted.city, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.city is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''state'', deleted.state, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.state is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''zip'', deleted.zip, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.zip is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''cellPhone'', deleted.cellPhone, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.cellPhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''homePhone'', deleted.homePhone, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.homePhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''workPhone'', deleted.workPhone, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.workPhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''emailId'', deleted.emailId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.emailId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''gender'', deleted.gender, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.gender is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''hours'', deleted.hours, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.hours is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''amount'', deleted.amount, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.amount is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''hourType'', deleted.hourType, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.hourType is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''amountType'', deleted.amountType, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.amountType is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''programGuid'', deleted.programGuid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.programGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''joinDate'', deleted.joinDate, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.joinDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''birthDate'', deleted.birthDate, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.birthDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''guardianName'', deleted.guardianName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.guardianName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''school'', deleted.school, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.school is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestStudents'', deleted.ROWGUIDCOL, ''grade'', deleted.grade, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.grade is not null 

'
GO
/****** Object:  Trigger [BestStudents_Insert]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestStudents_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestStudents_Insert] ON [dbo].[BestStudents] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestStudents'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  StoredProcedure [dbo].[Best_GetNextStudentId]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Best_GetNextStudentId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


create Procedure [dbo].[Best_GetNextStudentId]
	@xcenterid varchar(10), @makehigherthan varchar(10) = ''S0''
As
SET NOCOUNT ON;
DECLARE @maxid varchar(10)
set @maxid = ''S0''
SELECT TOP 1 @maxid = isnull(studentid, ''S0'') FROM BestStudents WHERE centerid = @xcenterid ORDER BY studentid DESC
if @maxid < @makehigherthan
begin
set @maxid = @makehigherthan
end
if @maxid = ''999999''
begin
	set @maxid = ''A00000''
end 
if @maxid = ''Z99999''
begin
	set @maxid = ''100000'';
end
if @maxid = ''ZZZZZZ''
begin
	set @maxid = ''100000'';
end
declare 
	@tryagain bit,
	@cix integer, 
	@lix integer, 
	@carry bit, 
	@currentcharacter char(1)
set @tryagain = 1
while @tryagain = 1
begin
	set @tryagain = 0
	set @lix = len(@maxid)
	set @carry = 1
	while @lix > 0 and @carry = 1
	begin
		set @cix = @lix
		set @lix = @lix - 1
		set @carry = 0
		set @currentcharacter = substring(@maxid, @cix, 1)
		if (@currentcharacter = '' '')
		begin
		  set @maxid = stuff(@maxid, @cix, 1, ''1'')
		  break
		end
		if (ascii(@currentcharacter) = 90)
		begin
			set @maxid = stuff(@maxid, @cix, 1, ''A'')
			set @carry = 1
			continue
		end
		if (ascii(@currentcharacter) = 122)
		begin
			set @maxid = stuff(@maxid, @cix, 1, ''a'')
			set @carry = 1
			continue
		end
		if (@currentcharacter = ''9'')
		begin
			set @maxid = stuff(@maxid, @cix, 1, ''0'')
			set @carry = 1
			continue
		end
		set @maxid = stuff(@maxid, @cix, 1, char(ascii(@currentcharacter) + 1))
 	end
	if @carry = 1
	begin
		select top 0 studentid from BestStudents
		return (1)
	end
	if EXISTS (select studentid from BestStudents where centerid = @xcenterid and studentid = @maxid)
	begin
		set @tryagain = 1
	end
	else
	begin
	select @maxid as id
select @maxid
	end
end
select ''0''





' 
END
GO
/****** Object:  StoredProcedure [dbo].[Best_GetNextTutorId]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Best_GetNextTutorId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



create Procedure [dbo].[Best_GetNextTutorId]
	@makehigherthan varchar(10) = ''T0''
As
SET NOCOUNT ON;
DECLARE @maxid varchar(10)
set @maxid = ''T0''
SELECT TOP 1 @maxid = isnull(tutorid, ''T0'') FROM BestTutors ORDER BY tutorid DESC
if @maxid < @makehigherthan
begin
set @maxid = @makehigherthan
end
if @maxid = ''999999''
begin
	set @maxid = ''A00000''
end 
if @maxid = ''Z99999''
begin
	set @maxid = ''100000'';
end
if @maxid = ''ZZZZZZ''
begin
	set @maxid = ''100000'';
end
declare 
	@tryagain bit,
	@cix integer, 
	@lix integer, 
	@carry bit, 
	@currentcharacter char(1)
set @tryagain = 1
while @tryagain = 1
begin
	set @tryagain = 0
	set @lix = len(@maxid)
	set @carry = 1
	while @lix > 0 and @carry = 1
	begin
		set @cix = @lix
		set @lix = @lix - 1
		set @carry = 0
		set @currentcharacter = substring(@maxid, @cix, 1)
		if (@currentcharacter = '' '')
		begin
		  set @maxid = stuff(@maxid, @cix, 1, ''1'')
		  break
		end
		if (ascii(@currentcharacter) = 90)
		begin
			set @maxid = stuff(@maxid, @cix, 1, ''A'')
			set @carry = 1
			continue
		end
		if (ascii(@currentcharacter) = 122)
		begin
			set @maxid = stuff(@maxid, @cix, 1, ''a'')
			set @carry = 1
			continue
		end
		if (@currentcharacter = ''9'')
		begin
			set @maxid = stuff(@maxid, @cix, 1, ''0'')
			set @carry = 1
			continue
		end
		set @maxid = stuff(@maxid, @cix, 1, char(ascii(@currentcharacter) + 1))
 	end
	if @carry = 1
	begin
		select top 0 tutorid from BestTutors
		return (1)
	end
	if EXISTS (select tutorid from BestTutors Where tutorid = @maxid)
	begin
		set @tryagain = 1
	end
	else
	begin
	select @maxid as id
select @maxid
	end
end
select ''0''






' 
END
GO
/****** Object:  Trigger [BestTutors_Insert]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestTutors_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestTutors_Insert] ON [dbo].[BestTutors] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId)
   select ''BestTutors'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId from inserted'
GO
/****** Object:  Trigger [BestTutors_Update]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestTutors_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestTutors_Update] ON [dbo].[BestTutors] FOR UPDATE AS 
UPDATE BestTutors SET BestTutors.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestTutors, inserted WHERE BestTutors.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(TutorId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''TutorId'', deleted.TutorId, inserted.TutorId, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(firstName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''firstName'', deleted.firstName, inserted.firstName, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(lastName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''lastName'', deleted.lastName, inserted.lastName, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(middleName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''middleName'', deleted.middleName, inserted.middleName, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(address1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''address1'', deleted.address1, inserted.address1, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(address2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''address2'', deleted.address2, inserted.address2, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(city)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''city'', deleted.city, inserted.city, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(state)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''state'', deleted.state, inserted.state, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(zip)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''zip'', deleted.zip, inserted.zip, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(cellPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''cellPhone'', deleted.cellPhone, inserted.cellPhone, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(homePhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''homePhone'', deleted.homePhone, inserted.homePhone, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(workPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''workPhone'', deleted.workPhone, inserted.workPhone, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(emailId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''emailId'', deleted.emailId, inserted.emailId, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(gender)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''gender'', deleted.gender, inserted.gender, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(joinDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''joinDate'', deleted.joinDate, inserted.joinDate, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(school)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''school'', deleted.school, inserted.school, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(yearGraduated)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''yearGraduated'', deleted.yearGraduated, inserted.yearGraduated, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(GPA)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''GPA'', deleted.GPA, inserted.GPA, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(Major)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''Major'', deleted.Major, inserted.Major, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(Expertise)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''Expertise'', deleted.Expertise, inserted.Expertise, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(learningStyle)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''learningStyle'', deleted.learningStyle, inserted.learningStyle, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(matchup)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''matchup'', deleted.matchup, inserted.matchup, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(gradeLevels)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''gradeLevels'', deleted.gradeLevels, inserted.gradeLevels, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(otherSkill)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''otherSkill'', deleted.otherSkill, inserted.otherSkill, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(programStyle)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''programStyle'', deleted.programStyle, inserted.programStyle, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(salary)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''salary'', deleted.salary, inserted.salary, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(perhour)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''perhour'', deleted.perhour, inserted.perhour, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(CenterId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestTutors'', inserted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, inserted.CenterId, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestTutors_DELETE]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestTutors_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestTutors_DELETE] ON [dbo].[BestTutors] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''TutorId'', deleted.TutorId, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.TutorId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''firstName'', deleted.firstName, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.firstName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''lastName'', deleted.lastName, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.lastName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''middleName'', deleted.middleName, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.middleName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''address1'', deleted.address1, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.address1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''address2'', deleted.address2, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.address2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''city'', deleted.city, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.city is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''state'', deleted.state, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.state is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''zip'', deleted.zip, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.zip is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''cellPhone'', deleted.cellPhone, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.cellPhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''homePhone'', deleted.homePhone, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.homePhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''workPhone'', deleted.workPhone, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.workPhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''emailId'', deleted.emailId, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.emailId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''gender'', deleted.gender, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.gender is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''joinDate'', deleted.joinDate, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.joinDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''school'', deleted.school, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.school is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''yearGraduated'', deleted.yearGraduated, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.yearGraduated is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''GPA'', deleted.GPA, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.GPA is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''Major'', deleted.Major, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.Major is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''Expertise'', deleted.Expertise, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.Expertise is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''learningStyle'', deleted.learningStyle, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.learningStyle is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''matchup'', deleted.matchup, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.matchup is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''gradeLevels'', deleted.gradeLevels, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.gradeLevels is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''otherSkill'', deleted.otherSkill, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.otherSkill is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''programStyle'', deleted.programStyle, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.programStyle is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''salary'', deleted.salary, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.salary is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''perhour'', deleted.perhour, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.perhour is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestTutors'', deleted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.CenterId is not null 

'
GO
/****** Object:  Trigger [BestUserRoles_Update]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUserRoles_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUserRoles_Update] ON [dbo].[BestUserRoles] FOR UPDATE AS 
UPDATE BestUserRoles SET BestUserRoles.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestUserRoles, inserted WHERE BestUserRoles.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(Service)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserRoles'', inserted.ROWGUIDCOL, ''Service'', deleted.Service, inserted.Service, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(userName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserRoles'', inserted.ROWGUIDCOL, ''userName'', deleted.userName, inserted.userName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(allowAdd)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserRoles'', inserted.ROWGUIDCOL, ''allowAdd'', deleted.allowAdd, inserted.allowAdd, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(allowView)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserRoles'', inserted.ROWGUIDCOL, ''allowView'', deleted.allowView, inserted.allowView, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(allowEdit)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserRoles'', inserted.ROWGUIDCOL, ''allowEdit'', deleted.allowEdit, inserted.allowEdit, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(allowDelete)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserRoles'', inserted.ROWGUIDCOL, ''allowDelete'', deleted.allowDelete, inserted.allowDelete, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestUserRoles_DELETE]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUserRoles_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUserRoles_DELETE] ON [dbo].[BestUserRoles] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserRoles'', deleted.ROWGUIDCOL, ''Service'', deleted.Service, ''D'' 
    from deleted 
    where deleted.Service is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserRoles'', deleted.ROWGUIDCOL, ''userName'', deleted.userName, ''D'' 
    from deleted 
    where deleted.userName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserRoles'', deleted.ROWGUIDCOL, ''allowAdd'', deleted.allowAdd, ''D'' 
    from deleted 
    where deleted.allowAdd is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserRoles'', deleted.ROWGUIDCOL, ''allowView'', deleted.allowView, ''D'' 
    from deleted 
    where deleted.allowView is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserRoles'', deleted.ROWGUIDCOL, ''allowEdit'', deleted.allowEdit, ''D'' 
    from deleted 
    where deleted.allowEdit is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserRoles'', deleted.ROWGUIDCOL, ''allowDelete'', deleted.allowDelete, ''D'' 
    from deleted 
    where deleted.allowDelete is not null 

'
GO
/****** Object:  Trigger [BestUserRoles_Insert]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUserRoles_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUserRoles_Insert] ON [dbo].[BestUserRoles] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestUserRoles'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  Trigger [BestDocuments_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestDocuments_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestDocuments_Update] ON [dbo].[BestDocuments] FOR UPDATE AS 
UPDATE BestDocuments SET BestDocuments.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestDocuments, inserted WHERE BestDocuments.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(documentTitle)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''documentTitle'', deleted.documentTitle, inserted.documentTitle, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(documentDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''documentDate'', deleted.documentDate, inserted.documentDate, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(documentExpiry)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''documentExpiry'', deleted.documentExpiry, inserted.documentExpiry, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(documentFileName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''documentFileName'', deleted.documentFileName, inserted.documentFileName, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(documentFileSize)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''documentFileSize'', deleted.documentFileSize, inserted.documentFileSize, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, inserted.studentGuid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(showToStudent)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''showToStudent'', deleted.showToStudent, inserted.showToStudent, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(CenterId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, inserted.CenterId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(StudentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', inserted.ROWGUIDCOL, ''StudentId'', deleted.StudentId, inserted.StudentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestDocuments_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestDocuments_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestDocuments_DELETE] ON [dbo].[BestDocuments] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''documentTitle'', deleted.documentTitle, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.documentTitle is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''documentDate'', deleted.documentDate, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.documentDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''documentExpiry'', deleted.documentExpiry, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.documentExpiry is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''documentFileName'', deleted.documentFileName, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.documentFileName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''documentFileSize'', deleted.documentFileSize, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.documentFileSize is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''showToStudent'', deleted.showToStudent, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.showToStudent is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.CenterId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestDocuments'', deleted.ROWGUIDCOL, ''StudentId'', deleted.StudentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.StudentId is not null 

'
GO
/****** Object:  Trigger [BestDocuments_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestDocuments_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestDocuments_Insert] ON [dbo].[BestDocuments] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestDocuments'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestUsers_Update]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUsers_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUsers_Update] ON [dbo].[BestUsers] FOR UPDATE AS 
UPDATE BestUsers SET BestUsers.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestUsers, inserted WHERE BestUsers.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(userName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''userName'', deleted.userName, inserted.userName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(password)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''password'', deleted.password, inserted.password, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(tempPwd)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''tempPwd'', deleted.tempPwd, inserted.tempPwd, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(passwordExpiration)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''passwordExpiration'', deleted.passwordExpiration, inserted.passwordExpiration, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(firstName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''firstName'', deleted.firstName, inserted.firstName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(lastName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''lastName'', deleted.lastName, inserted.lastName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(middleName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''middleName'', deleted.middleName, inserted.middleName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(address1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''address1'', deleted.address1, inserted.address1, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(address2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''address2'', deleted.address2, inserted.address2, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(city)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''city'', deleted.city, inserted.city, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(state)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''state'', deleted.state, inserted.state, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(zip)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''zip'', deleted.zip, inserted.zip, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(cellPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''cellPhone'', deleted.cellPhone, inserted.cellPhone, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(homePhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''homePhone'', deleted.homePhone, inserted.homePhone, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(workPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''workPhone'', deleted.workPhone, inserted.workPhone, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(emailId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''emailId'', deleted.emailId, inserted.emailId, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(securityQuestion1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''securityQuestion1'', deleted.securityQuestion1, inserted.securityQuestion1, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(securityQuestion2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''securityQuestion2'', deleted.securityQuestion2, inserted.securityQuestion2, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(gender)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''gender'', deleted.gender, inserted.gender, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(Centers)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''Centers'', deleted.Centers, inserted.Centers, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(userType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''userType'', deleted.userType, inserted.userType, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(passwordExpiredDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''passwordExpiredDate'', deleted.passwordExpiredDate, inserted.passwordExpiredDate, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(initialPassword)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''initialPassword'', deleted.initialPassword, inserted.initialPassword, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(logindisabled)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''logindisabled'', deleted.logindisabled, inserted.logindisabled, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, inserted.studentGuid, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(tutorGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUsers'', inserted.ROWGUIDCOL, ''tutorGuid'', deleted.tutorGuid, inserted.tutorGuid, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestUsers_DELETE]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUsers_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUsers_DELETE] ON [dbo].[BestUsers] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''userName'', deleted.userName, ''D'' 
    from deleted 
    where deleted.userName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''password'', deleted.password, ''D'' 
    from deleted 
    where deleted.password is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''tempPwd'', deleted.tempPwd, ''D'' 
    from deleted 
    where deleted.tempPwd is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''passwordExpiration'', deleted.passwordExpiration, ''D'' 
    from deleted 
    where deleted.passwordExpiration is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''firstName'', deleted.firstName, ''D'' 
    from deleted 
    where deleted.firstName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''lastName'', deleted.lastName, ''D'' 
    from deleted 
    where deleted.lastName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''middleName'', deleted.middleName, ''D'' 
    from deleted 
    where deleted.middleName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''address1'', deleted.address1, ''D'' 
    from deleted 
    where deleted.address1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''address2'', deleted.address2, ''D'' 
    from deleted 
    where deleted.address2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''city'', deleted.city, ''D'' 
    from deleted 
    where deleted.city is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''state'', deleted.state, ''D'' 
    from deleted 
    where deleted.state is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''zip'', deleted.zip, ''D'' 
    from deleted 
    where deleted.zip is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''cellPhone'', deleted.cellPhone, ''D'' 
    from deleted 
    where deleted.cellPhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''homePhone'', deleted.homePhone, ''D'' 
    from deleted 
    where deleted.homePhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''workPhone'', deleted.workPhone, ''D'' 
    from deleted 
    where deleted.workPhone is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''emailId'', deleted.emailId, ''D'' 
    from deleted 
    where deleted.emailId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''securityQuestion1'', deleted.securityQuestion1, ''D'' 
    from deleted 
    where deleted.securityQuestion1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''securityQuestion2'', deleted.securityQuestion2, ''D'' 
    from deleted 
    where deleted.securityQuestion2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''gender'', deleted.gender, ''D'' 
    from deleted 
    where deleted.gender is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''Centers'', deleted.Centers, ''D'' 
    from deleted 
    where deleted.Centers is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''userType'', deleted.userType, ''D'' 
    from deleted 
    where deleted.userType is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''passwordExpiredDate'', deleted.passwordExpiredDate, ''D'' 
    from deleted 
    where deleted.passwordExpiredDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''initialPassword'', deleted.initialPassword, ''D'' 
    from deleted 
    where deleted.initialPassword is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''logindisabled'', deleted.logindisabled, ''D'' 
    from deleted 
    where deleted.logindisabled is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, ''D'' 
    from deleted 
    where deleted.studentGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUsers'', deleted.ROWGUIDCOL, ''tutorGuid'', deleted.tutorGuid, ''D'' 
    from deleted 
    where deleted.tutorGuid is not null 

'
GO
/****** Object:  Trigger [BestUsers_Insert]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUsers_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUsers_Insert] ON [dbo].[BestUsers] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestUsers'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  Trigger [BestUserPrefs_Insert]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUserPrefs_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUserPrefs_Insert] ON [dbo].[BestUserPrefs] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestUserPrefs'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  Trigger [BestUserPrefs_DELETE]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUserPrefs_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUserPrefs_DELETE] ON [dbo].[BestUserPrefs] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserPrefs'', deleted.ROWGUIDCOL, ''name'', deleted.name, ''D'' 
    from deleted 
    where deleted.name is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserPrefs'', deleted.ROWGUIDCOL, ''value'', deleted.value, ''D'' 
    from deleted 
    where deleted.value is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestUserPrefs'', deleted.ROWGUIDCOL, ''userName'', deleted.userName, ''D'' 
    from deleted 
    where deleted.userName is not null 

'
GO
/****** Object:  Trigger [BestUserPrefs_Update]    Script Date: 05/31/2012 22:08:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestUserPrefs_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestUserPrefs_Update] ON [dbo].[BestUserPrefs] FOR UPDATE AS 
UPDATE BestUserPrefs SET BestUserPrefs.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestUserPrefs, inserted WHERE BestUserPrefs.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(name)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserPrefs'', inserted.ROWGUIDCOL, ''name'', deleted.name, inserted.name, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(value)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserPrefs'', inserted.ROWGUIDCOL, ''value'', deleted.value, inserted.value, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(userName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestUserPrefs'', inserted.ROWGUIDCOL, ''userName'', deleted.userName, inserted.userName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestExportFields_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExportFields_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExportFields_Update] ON [dbo].[BestExportFields] FOR UPDATE AS 
UPDATE BestExportFields SET BestExportFields.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestExportFields, inserted WHERE BestExportFields.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(exportguid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExportFields'', inserted.ROWGUIDCOL, ''exportguid'', deleted.exportguid, inserted.exportguid, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(fieldname)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExportFields'', inserted.ROWGUIDCOL, ''fieldname'', deleted.fieldname, inserted.fieldname, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(displayname)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExportFields'', inserted.ROWGUIDCOL, ''displayname'', deleted.displayname, inserted.displayname, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(ordinal)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExportFields'', inserted.ROWGUIDCOL, ''ordinal'', deleted.ordinal, inserted.ordinal, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestExportFields_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExportFields_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExportFields_DELETE] ON [dbo].[BestExportFields] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExportFields'', deleted.ROWGUIDCOL, ''exportguid'', deleted.exportguid, ''D'' 
    from deleted 
    where deleted.exportguid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExportFields'', deleted.ROWGUIDCOL, ''fieldname'', deleted.fieldname, ''D'' 
    from deleted 
    where deleted.fieldname is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExportFields'', deleted.ROWGUIDCOL, ''displayname'', deleted.displayname, ''D'' 
    from deleted 
    where deleted.displayname is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExportFields'', deleted.ROWGUIDCOL, ''ordinal'', deleted.ordinal, ''D'' 
    from deleted 
    where deleted.ordinal is not null 

'
GO
/****** Object:  Trigger [BestExportFields_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExportFields_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExportFields_Insert] ON [dbo].[BestExportFields] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestExportFields'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  Trigger [BestExports_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExports_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExports_Update] ON [dbo].[BestExports] FOR UPDATE AS 
UPDATE BestExports SET BestExports.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestExports, inserted WHERE BestExports.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(exportName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExports'', inserted.ROWGUIDCOL, ''exportName'', deleted.exportName, inserted.exportName, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(exportTitle)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExports'', inserted.ROWGUIDCOL, ''exportTitle'', deleted.exportTitle, inserted.exportTitle, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(exportType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExports'', inserted.ROWGUIDCOL, ''exportType'', deleted.exportType, inserted.exportType, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestExports_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExports_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExports_Insert] ON [dbo].[BestExports] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestExports'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
/****** Object:  Trigger [BestExports_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExports_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExports_DELETE] ON [dbo].[BestExports] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExports'', deleted.ROWGUIDCOL, ''exportName'', deleted.exportName, ''D'' 
    from deleted 
    where deleted.exportName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExports'', deleted.ROWGUIDCOL, ''exportTitle'', deleted.exportTitle, ''D'' 
    from deleted 
    where deleted.exportTitle is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExports'', deleted.ROWGUIDCOL, ''exportType'', deleted.exportType, ''D'' 
    from deleted 
    where deleted.exportType is not null 

'
GO
/****** Object:  Trigger [BestExportTables_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExportTables_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExportTables_Update] ON [dbo].[BestExportTables] FOR UPDATE AS 
UPDATE BestExportTables SET BestExportTables.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestExportTables, inserted WHERE BestExportTables.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(fieldname)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExportTables'', inserted.ROWGUIDCOL, ''fieldname'', deleted.fieldname, inserted.fieldname, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(aliasname)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExportTables'', inserted.ROWGUIDCOL, ''aliasname'', deleted.aliasname, inserted.aliasname, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(displayname)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExportTables'', inserted.ROWGUIDCOL, ''displayname'', deleted.displayname, inserted.displayname, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(exportType)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype) 
    select ''BestExportTables'', inserted.ROWGUIDCOL, ''exportType'', deleted.exportType, inserted.exportType, ''U'' 
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestExportTables_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExportTables_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExportTables_DELETE] ON [dbo].[BestExportTables] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExportTables'', deleted.ROWGUIDCOL, ''fieldname'', deleted.fieldname, ''D'' 
    from deleted 
    where deleted.fieldname is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExportTables'', deleted.ROWGUIDCOL, ''aliasname'', deleted.aliasname, ''D'' 
    from deleted 
    where deleted.aliasname is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExportTables'', deleted.ROWGUIDCOL, ''displayname'', deleted.displayname, ''D'' 
    from deleted 
    where deleted.displayname is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype) 
    select ''BestExportTables'', deleted.ROWGUIDCOL, ''exportType'', deleted.exportType, ''D'' 
    from deleted 
    where deleted.exportType is not null 

'
GO
/****** Object:  Trigger [BestCenters_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestCenters_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestCenters_DELETE] ON [dbo].[BestCenters] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.CenterId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''address1'', deleted.address1, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.address1 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''address2'', deleted.address2, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.address2 is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''city'', deleted.city, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.city is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''state'', deleted.state, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.state is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''zip'', deleted.zip, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.zip is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''contactName'', deleted.contactName, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.contactName is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''contactEMail'', deleted.contactEMail, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.contactEMail is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId) 
    select ''BestCenters'', deleted.ROWGUIDCOL, ''contactPhone'', deleted.contactPhone, ''D'' ,deleted.CenterId
    from deleted 
    where deleted.contactPhone is not null 

'
GO
/****** Object:  Trigger [BestCenters_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestCenters_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestCenters_Insert] ON [dbo].[BestCenters] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId)
   select ''BestCenters'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId from inserted'
GO
/****** Object:  Trigger [BestCenters_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestCenters_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestCenters_Update] ON [dbo].[BestCenters] FOR UPDATE AS 
UPDATE BestCenters SET BestCenters.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestCenters, inserted WHERE BestCenters.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(CenterId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''CenterId'', deleted.CenterId, inserted.CenterId, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(address1)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''address1'', deleted.address1, inserted.address1, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(address2)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''address2'', deleted.address2, inserted.address2, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(city)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''city'', deleted.city, inserted.city, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(state)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''state'', deleted.state, inserted.state, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(zip)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''zip'', deleted.zip, inserted.zip, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(contactName)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''contactName'', deleted.contactName, inserted.contactName, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(contactEMail)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''contactEMail'', deleted.contactEMail, inserted.contactEMail, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(contactPhone)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId) 
    select ''BestCenters'', inserted.ROWGUIDCOL, ''contactPhone'', deleted.contactPhone, inserted.contactPhone, ''U'' ,inserted.CenterId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestPaymentDetails_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPaymentDetails_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPaymentDetails_Insert] ON [dbo].[BestPaymentDetails] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype,CenterId,StudentId)
   select ''BestPaymentDetails'', inserted.ROWGUIDCOL, ''I'' ,inserted.CenterId,inserted.StudentId from inserted'
GO
/****** Object:  Trigger [BestPaymentDetails_DELETE]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPaymentDetails_DELETE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPaymentDetails_DELETE] ON [dbo].[BestPaymentDetails] FOR DELETE AS 

    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', deleted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', deleted.ROWGUIDCOL, ''paymentTypeGuid'', deleted.paymentTypeGuid, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.paymentTypeGuid is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', deleted.ROWGUIDCOL, ''paymentDate'', deleted.paymentDate, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.paymentDate is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', deleted.ROWGUIDCOL, ''amount'', deleted.amount, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.amount is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', deleted.ROWGUIDCOL, ''studentId'', deleted.studentId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.studentId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', deleted.ROWGUIDCOL, ''centerId'', deleted.centerId, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.centerId is not null 


    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', deleted.ROWGUIDCOL, ''hours'', deleted.hours, ''D'' ,deleted.CenterId,deleted.StudentId
    from deleted 
    where deleted.hours is not null 

'
GO
/****** Object:  Trigger [BestPaymentDetails_Update]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestPaymentDetails_Update]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestPaymentDetails_Update] ON [dbo].[BestPaymentDetails] FOR UPDATE AS 
UPDATE BestPaymentDetails SET BestPaymentDetails.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM BestPaymentDetails, inserted WHERE BestPaymentDetails.ROWGUIDCOL = inserted.ROWGUIDCOL


    if update(studentGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', inserted.ROWGUIDCOL, ''studentGuid'', deleted.studentGuid, inserted.studentGuid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(paymentTypeGuid)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', inserted.ROWGUIDCOL, ''paymentTypeGuid'', deleted.paymentTypeGuid, inserted.paymentTypeGuid, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(paymentDate)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', inserted.ROWGUIDCOL, ''paymentDate'', deleted.paymentDate, inserted.paymentDate, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(amount)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', inserted.ROWGUIDCOL, ''amount'', deleted.amount, inserted.amount, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(studentId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', inserted.ROWGUIDCOL, ''studentId'', deleted.studentId, inserted.studentId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(centerId)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', inserted.ROWGUIDCOL, ''centerId'', deleted.centerId, inserted.centerId, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL

    if update(hours)
    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype,CenterId,StudentId) 
    select ''BestPaymentDetails'', inserted.ROWGUIDCOL, ''hours'', deleted.hours, inserted.hours, ''U'' ,inserted.CenterId,inserted.StudentId
    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL
'
GO
/****** Object:  Trigger [BestExportTables_Insert]    Script Date: 05/31/2012 22:08:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BestExportTables_Insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[BestExportTables_Insert] ON [dbo].[BestExportTables] FOR INSERT AS 

  insert into LogChanges(tablename, guidfield, changetype)
   select ''BestExportTables'', inserted.ROWGUIDCOL, ''I''  from inserted'
GO
