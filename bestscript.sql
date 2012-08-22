USE [Best]
GO
/****** Object:  Table [dbo].[BestCenters]    Script Date: 05/20/2011 13:00:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestCenters](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestCenters_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestCenters_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestCenters_lastChangeUser]  DEFAULT (app_name()),
	[CenterId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[address1] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[address2] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[city] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[state] [varchar](2) COLLATE Latin1_General_CI_AS NULL,
	[zip] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[contactName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[contactEMail] [varchar](80) COLLATE Latin1_General_CI_AS NULL,
	[contactPhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_BestCenters] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF


USE [Best]
GO
/****** Object:  Table [dbo].[BestEMailTemplates]    Script Date: 05/20/2011 13:00:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestEMailTemplates](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestEMailTemplates_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestEMailTemplates_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestEMailTemplates_lastChangeUser]  DEFAULT (app_name()),
	[emialTemplateName] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[templateDescription] [varchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
 CONSTRAINT [PK_BestEMailTemplates] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestLogins]    Script Date: 05/20/2011 13:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestLogins](
	[guidfield] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BestLogins_guidfield]  DEFAULT (newsequentialid()),
	[username] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
	[loginDate] [datetime] NOT NULL CONSTRAINT [DF_BestLogins_loginDate]  DEFAULT (getdate()),
	[sourceIP] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[loginvalid] [bit] NOT NULL CONSTRAINT [DF_BestLogins_loginvalid]  DEFAULT ((0)),
	[serverIP] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[sessionguid] [uniqueidentifier] NULL,
	[logoutdate] [datetime] NULL,
	[additionalInfo] [varchar](1000) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestLogs]    Script Date: 05/20/2011 13:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestLogs](
	[Logdate] [datetime] NOT NULL CONSTRAINT [DF_Table_1_logdate]  DEFAULT (getdate()),
	[Message] [varchar](max) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestPaymentDetails]    Script Date: 05/20/2011 13:01:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestPaymentDetails](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_paymentDetails_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_paymentDetails_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_paymentDetails_lastChangeUser]  DEFAULT (app_name()),
	[studentGuid] [uniqueidentifier] NULL,
	[paymentTypeGuid] [uniqueidentifier] NULL,
	[paymentDate] [datetime] NULL,
	[amount] [decimal](18, 0) NULL,
	[studentId] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[centerId] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_BestPaymentDetails] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestPaymentTypes]    Script Date: 05/20/2011 13:01:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestPaymentTypes](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestPaymentTypes_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestPaymentTypes_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestPaymentTypes_lastChangeUser]  DEFAULT (app_name()),
	[paymentType] [varchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
 CONSTRAINT [PK_BestPaymentTypes] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestProgamTypes]    Script Date: 05/20/2011 13:01:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestProgamTypes](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BProgTypes_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BProgTypes_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BProgTypes_lastChangeUser]  DEFAULT (app_name()),
	[programType] [varchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
 CONSTRAINT [PK_BestProgamTypes] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestPrograms]    Script Date: 05/20/2011 13:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestPrograms](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestPrograms_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestPrograms_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestPrograms_lastChangeUser]  DEFAULT (app_name()),
	[programName] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[programType] [varchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
	[amount] [decimal](10, 2) NULL,
	[amountType] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_BestPrograms] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per Week, Per Day, Per Hour' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BestPrograms', @level2type=N'COLUMN',@level2name=N'amountType'

USE [Best]
GO
/****** Object:  Table [dbo].[BestSchedules]    Script Date: 05/20/2011 13:02:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestSchedules](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestSchedules_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestSchedules_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestSchedules_lastChangeUser]  DEFAULT (app_name()),
	[tutGuid] [uniqueidentifier] NULL,
	[stuGuid1] [uniqueidentifier] NULL,
	[stuGuid2] [uniqueidentifier] NULL,
	[stuGuid3] [uniqueidentifier] NULL,
	[stuGuid4] [uniqueidentifier] NULL,
	[stuGuid5] [uniqueidentifier] NULL,
	[schDate] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[schFrom] [varchar](4) COLLATE Latin1_General_CI_AS NULL,
	[schTo] [varchar](4) COLLATE Latin1_General_CI_AS NULL,
	[isDeleted] [bit] NOT NULL CONSTRAINT [DF_BestSchedules_isDeleted]  DEFAULT ((0)),
	[attended1] [bit] NOT NULL CONSTRAINT [DF_BestSchedules_attended]  DEFAULT ((0)),
	[attended2] [bit] NOT NULL CONSTRAINT [DF_BestSchedules_attended2]  DEFAULT ((0)),
	[attended3] [bit] NOT NULL CONSTRAINT [DF_BestSchedules_attended3]  DEFAULT ((0)),
	[attended4] [bit] NOT NULL CONSTRAINT [DF_BestSchedules_attended4]  DEFAULT ((0)),
	[attended5] [bit] NOT NULL CONSTRAINT [DF_BestSchedules_attended5]  DEFAULT ((0)),
	[note1] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[note2] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[note3] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[note4] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[note5] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_BestSchedules] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestServices]    Script Date: 05/20/2011 13:02:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestServices](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestServices_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestServices_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestServices_lastChangeUser]  DEFAULT (app_name()),
	[Service] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
	[CenterId] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_BestServices] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestStudentGPA]    Script Date: 05/20/2011 13:02:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestStudentGPA](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentGPA_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentGPA_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestStudentGPA_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[assessmentDate] [datetime] NULL,
	[assessmentGPA] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[assessmentLevel] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[studentId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[centerId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestStudentNotes]    Script Date: 05/20/2011 13:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestStudentNotes](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentNotes_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentNotes_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestStudentNotes_lastChangeUser]  DEFAULT (app_name()),
	[studentGuid] [uniqueidentifier] NOT NULL,
	[noteDate] [datetime] NOT NULL,
	[notes] [varchar](max) COLLATE Latin1_General_CI_AS NULL,
	[studentId] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[centerId] [nchar](10) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_BestStudentNotes] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestStudentPayment]    Script Date: 05/20/2011 13:02:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestStudentPayment](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentPayment_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentPayment_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestStudentPayment_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NULL,
	[parentemail] [varchar](128) COLLATE Latin1_General_CI_AS NULL,
	[name] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[paymethod] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[centerId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[studentId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestStudentPickup]    Script Date: 05/20/2011 13:02:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestStudentPickup](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentPickup_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentPickup_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestStudentPickup_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[contactName] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[contactPhone] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[relationship] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[studentId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[centerId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestStudentPicture]    Script Date: 05/20/2011 13:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestStudentPicture](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentPicture_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentPicture_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestStudentPicture_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[picture] [image] NULL,
	[photoSize] [decimal](18, 0) NULL,
	[photoName] [varchar](200) COLLATE Latin1_General_CI_AS NULL,
	[hobbies] [varchar](500) COLLATE Latin1_General_CI_AS NULL,
	[personality] [varchar](500) COLLATE Latin1_General_CI_AS NULL,
	[goals] [varchar](500) COLLATE Latin1_General_CI_AS NULL,
	[learningstyle] [varchar](500) COLLATE Latin1_General_CI_AS NULL,
	[tutorpreference] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[studentId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[centerId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestStudentPrograms]    Script Date: 05/20/2011 13:02:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestStudentPrograms](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestStudentPrograms_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentPrograms_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestStudentPrograms_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[programguid] [uniqueidentifier] NOT NULL,
	[studentId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[centerId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestStudentReference]    Script Date: 05/20/2011 13:03:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestStudentReference](
	[guidfield] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BestStudentReference_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestStudentReference_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestStudentReference_lastChangeUser]  DEFAULT (app_name()),
	[studentguid] [uniqueidentifier] NOT NULL,
	[studentId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[centerId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[referencedby] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[expectedDuration] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[blcRecommend] [varchar](500) COLLATE Latin1_General_CI_AS NULL,
	[proposedProg] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[proposedHour] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[parentComments] [varchar](500) COLLATE Latin1_General_CI_AS NULL,
	[parentExpects] [varchar](500) COLLATE Latin1_General_CI_AS NULL,
	[emergName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[emergPhone] [varchar](50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestStudents]    Script Date: 05/20/2011 13:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestStudents](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BStudents_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BStudents_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BStudents_lastChangeUser]  DEFAULT (app_name()),
	[CenterId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[StudentId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[firstName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[lastName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[middleName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[parentName] [varchar](80) COLLATE Latin1_General_CI_AS NULL,
	[address1] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[address2] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[city] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[state] [varchar](2) COLLATE Latin1_General_CI_AS NULL,
	[zip] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[cellPhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[homePhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[workPhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[emailId] [varchar](200) COLLATE Latin1_General_CI_AS NULL,
	[gender] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[hours] [decimal](18, 2) NULL,
	[amount] [decimal](18, 2) NULL,
	[hourType] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[amountType] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[programGuid] [uniqueidentifier] NULL,
	[joinDate] [datetime] NULL,
	[birthDate] [datetime] NULL,
	[guardianName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_BestStudents] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestSuspicion]    Script Date: 05/20/2011 13:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestSuspicion](
	[guidfield] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BestSuspicion_guidfield]  DEFAULT (newid()),
	[target] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[score] [int] NULL,
	[logdate] [datetime] NULL CONSTRAINT [DF_BestSuspicion_logdate]  DEFAULT (getdate()),
	[reasonCode] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestTutors]    Script Date: 05/20/2011 13:03:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestTutors](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BTutors_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BTutors_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BTutors_lastChangeUser]  DEFAULT (app_name()),
	[TutorId] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[firstName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[lastName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[middleName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[address1] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[address2] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[city] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[state] [varchar](2) COLLATE Latin1_General_CI_AS NULL,
	[zip] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[cellPhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[homePhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[workPhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[emailId] [varchar](200) COLLATE Latin1_General_CI_AS NULL,
	[gender] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[joinDate] [datetime] NULL,
 CONSTRAINT [PK_BestTutors] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestUserRoles]    Script Date: 05/20/2011 13:03:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestUserRoles](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestUserRoles_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestUserRoles_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestUserRoles_lastChangeUser]  DEFAULT (app_name()),
	[Service] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
	[userName] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
	[allowAdd] [bit] NOT NULL CONSTRAINT [DF_BestUserRoles_allowAdd]  DEFAULT ((0)),
	[allowView] [bit] NOT NULL CONSTRAINT [DF_BestUserRoles_allowView]  DEFAULT ((0)),
	[allowEdit] [bit] NOT NULL CONSTRAINT [DF_BestUserRoles_allowEdit]  DEFAULT ((0)),
	[allowDelete] [bit] NOT NULL CONSTRAINT [DF_BestUserRoles_allowDelete]  DEFAULT ((0)),
 CONSTRAINT [PK_BestUserRoles] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

USE [Best]
GO
/****** Object:  Table [dbo].[BestUsers]    Script Date: 05/20/2011 13:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestUsers](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestUsers_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestUsers_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_BestUsers_lastChangeUser]  DEFAULT (app_name()),
	[userName] [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
	[password] [varchar](128) COLLATE Latin1_General_CI_AS NULL,
	[tempPwd] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[passwordExpiration] [datetime] NULL,
	[firstName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[lastName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[middleName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[address1] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[address2] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[city] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[state] [varchar](2) COLLATE Latin1_General_CI_AS NULL,
	[zip] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[cellPhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[homePhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[workPhone] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[emailId] [varchar](200) COLLATE Latin1_General_CI_AS NULL,
	[securityQuestion1] [varchar](300) COLLATE Latin1_General_CI_AS NULL,
	[answer1] [nchar](10) COLLATE Latin1_General_CI_AS NULL,
	[securityQuestion2] [varchar](300) COLLATE Latin1_General_CI_AS NULL,
	[answer2] [nchar](10) COLLATE Latin1_General_CI_AS NULL,
	[gender] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Centers] [varchar](1000) COLLATE Latin1_General_CI_AS NULL,
	[userType] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[passwordExpiredDate] [datetime] NULL,
	[initialPassword] [bit] NOT NULL CONSTRAINT [DF_BestUsers_initialPassword]  DEFAULT ((1)),
	[lolgindisabled] [bit] NOT NULL CONSTRAINT [DF_BestUsers_lolgindisabled]  DEFAULT ((0)),
 CONSTRAINT [PK_BestUsers] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF


USE [Best]
GO
/****** Object:  Table [dbo].[LogChanges]    Script Date: 05/20/2011 13:03:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogChanges](
	[tablename] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[guidfield] [uniqueidentifier] NOT NULL,
	[fieldname] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_LogChangesS1_fieldName]  DEFAULT (''),
	[oldValue] [varchar](6000) COLLATE Latin1_General_CI_AS NULL,
	[newValue] [varchar](6000) COLLATE Latin1_General_CI_AS NULL,
	[changeDate] [datetime] NOT NULL CONSTRAINT [DF_LogChangesS1_changeDate]  DEFAULT (getdate()),
	[changedBy] [varchar](228) COLLATE Latin1_General_CI_AS NULL CONSTRAINT [DF_LogChangesS1_changedBy]  DEFAULT (app_name()),
	[changeType] [char](1) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_LogChangesS1_changeType]  DEFAULT ('?'),
	[CenterId] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[StudentId] [varchar](50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF



USE [Best]
GO
/****** Object:  View [dbo].[VBestSchedulesAndPayments]    Script Date: 05/20/2011 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[VBestSchedulesAndPayments] As
Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid1 as studentGuid, 
	BestSchedules.schDate,
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended1,
	'Scheduled' as tranType
 from BestSchedules
 union all
 Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid2, 
	BestSchedules.schDate, 
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended2,
	'Scheduled' as tranType
 from BestSchedules where BestSchedules.stuGuid2 is not null
 union all
 Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid3, 
	BestSchedules.schDate, 
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended3,
	'Scheduled' as tranType
 from BestSchedules where BestSchedules.stuGuid3 is not null
 union all
 Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid4, 
	BestSchedules.schDate, 
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended4,
	'Scheduled' as tranType
 from BestSchedules where BestSchedules.stuGuid4 is not null
 union all
 Select 
	BestSchedules.guidfield,
	BestSchedules.stuGuid5, 
	BestSchedules.schDate, 
	BestSchedules.schFrom, 
	BestSchedules.schTo,
	BestSchedules.attended5,
	'Scheduled' as tranType
 from BestSchedules where BestSchedules.stuGuid5 is not null
union all
Select
	BestPaymentDetails.guidfield,
	BestPaymentDetails.studentGuid,
	str(year(BestPaymentDetails.paymentDate),4) + 
	case when len(ltrim(str(month(BestPaymentDetails.paymentDate))))=1 then '0'+str(month(BestPaymentDetails.paymentDate),1) else str(month(BestPaymentDetails.paymentDate),2) end + 
	case when len(ltrim(str(day(BestPaymentDetails.paymentDate))))=1 then '0'+str(day(BestPaymentDetails.paymentDate),1) else str(day(getDate()),2) end as schDate,
	'' as schfrom,
	'' as schto,
	1 as attended,
	'Payment' as tranType
from BestPaymentDetails	
	 
 

 USE [Best]
GO
/****** Object:  StoredProcedure [dbo].[Best_CreateTriggers]    Script Date: 05/20/2011 13:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--Creates triggers on the specified table to log all the changes made
CREATE PROC [dbo].[Best_CreateTriggers]
	@tablename varchar(100)
AS

	if exists (	select * from sysobjects where id = object_id(N'[dbo].[' + @tablename + '_Delete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
	Begin
		exec('DROP TRIGGER ' + @tablename + '_Delete')
	End
	if exists (	select * from sysobjects where id = object_id(N'[dbo].[' + @tablename + '_Update]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
	Begin
		exec('DROP TRIGGER ' + @tablename + '_Update')
	End
	if exists (	select * from sysobjects where id = object_id(N'[dbo].[' + @tablename + '_Insert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
	Begin
		exec('DROP TRIGGER ' + @tablename + '_Insert')
	End
	if exists (	select * from sysobjects where id = object_id(N'[dbo].[' + @tablename + '_InsertUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
	Begin
		exec('DROP TRIGGER ' + @tablename + '_InsertUpdate')
	End



	declare @updsql1 varchar(8000)
	declare @updsql2 varchar(8000)
	declare @updsql3 varchar(8000)
	declare @updsql4 varchar(8000)
	set @updsql1 = ''
	set @updsql2 = ''
	set @updsql3 = ''
	set @updsql4 = ''
	
	declare @deletesql1 varchar(8000)
	declare @deletesql2 varchar(8000)
	declare @deletesql3 varchar(8000)
	declare @deletesql4 varchar(8000)
	set @deletesql1 = ''
	set @deletesql2 = ''
	set @deletesql3 = ''
	set @deletesql4 = ''
	
	declare @insertsql varchar(8000)
	declare @crlf varchar(4)
	declare @tstring varchar(3000)
	declare @tstring2 varchar(3000)
	declare @extraFields varchar(100), @extraSelect varchar(100),@extraDelete varchar(100)
	set @extraFields = '' set @extraSelect = ''
	set @extraDelete = ''
			-- Determine the optional fields to put in the log
		IF EXISTS( SELECT * FROM syscolumns WHERE id = object_id(@tablename) AND name = 'CenterId')
		BEGIN
			SET @extraFields = ',CenterId'
			SET @extraSelect = ',inserted.CenterId'
			SET @extraDelete = ',deleted.CenterId'
			IF EXISTS( SELECT * FROM syscolumns WHERE id = object_id(@tablename) AND name = 'StudentId')
			BEGIN
				SET @extraFields = ',CenterId,StudentId'
				SET @extraSelect = ',inserted.CenterId,inserted.StudentId'
				SET @extraDelete = ',deleted.CenterId,deleted.StudentId'
			END
		END
		
    set @tstring = ''	
	set @crlf = char(13)+char(10)
	set @updsql1 = 'CREATE TRIGGER ' + @tablename + '_Update ON dbo.' + @tablename + ' FOR UPDATE AS ' + @crlf + 'UPDATE ' + @tablename + ' SET ' + @tablename + '.lastChange = GETDATE(), lastChangeUser = APP_NAME() FROM ' + @tablename + ', inserted WHERE ' + @tablename + '.ROWGUIDCOL = inserted.ROWGUIDCOL' + @crlf + @crlf
	set @deletesql1 = 'CREATE TRIGGER ' + @tablename + '_DELETE ON dbo.' + @tablename + ' FOR DELETE AS ' + @crlf 
	set @insertsql = 	'CREATE TRIGGER ' + @tablename + '_Insert ON dbo.' + @tablename + ' FOR INSERT AS ' + @crlf + @crlf + '  insert into LogChanges(tablename, guidfield, changetype' + @extraFields + ')' + @crlf + '   select ''' + @tablename + ''', inserted.ROWGUIDCOL, ''I'' ' + @extraSelect + ' from inserted'
	declare @fieldname sysname
	declare @fieldlen smallint
	declare @fieldtype sysname
			declare colcursor cursor local scroll for
			select syscolumns.name, syscolumns.length, systypes.name
			from syscolumns, systypes
			where syscolumns.id = object_id(@tablename) 
			and syscolumns.xtype = systypes.xusertype 
			and systypes.xtype = systypes.xusertype
			and syscolumns.name <> 'lastChange'
			and syscolumns.name <> 'lastChangeUser'
			and syscolumns.name <> 'guidfield'
			and systypes.name not in ('binary', 'image', 'nchar', 'ntext', 'nvarchar', 'text', 'varbinary')
			and COLUMNPROPERTY( syscolumns.id ,syscolumns.name, 'IsComputed') <> 1 --removes computed columns
		open colcursor
		fetch next from colcursor into @fieldname, @fieldlen, @fieldtype	
			while @@fetch_status = 0
			begin 
				if @fieldtype in ('char', 'varchar') and (@fieldlen > 3000 or @fieldlen = -1)
				begin
					set @tstring = 	'    if update(' + @fieldname + ')' + @crlf + '    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype' + @extraFields + ') ' + @crlf + 	'    select ''' + @tablename + ''', inserted.ROWGUIDCOL, ''' + @fieldname + ''', left(deleted.' + @fieldname + ',3000), left(inserted.' + @fieldname + ',3000), ''U'' ' + @extraSelect + @crlf + '    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL' + @crlf + @crlf
					set @tstring2 = '    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype' + @extraFields + ') ' + @crlf + 
						'    select ''' + @tablename + ''', deleted.ROWGUIDCOL, ''' + @fieldname + ''', left(deleted.' + @fieldname + ',3000), ''D'' '  + @extraDelete + @crlf +
						'    from deleted ' + @crlf +
						'    where deleted.' + @fieldname + ' is not null ' + @crlf + @crlf
				end
				else
				begin
					if @fieldtype in ('xml') 
					begin
						set @tstring = 	'    if update(' + @fieldname + ')' + @crlf + '    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype' + @extraFields + ') ' + @crlf + 	'    select ''' + @tablename + ''', inserted.ROWGUIDCOL, ''' + @fieldname + ''', left(cast(deleted.' + @fieldname + ' as varchar(max)),3000), left(cast(inserted.' + @fieldname + ' as varchar(max)),3000), ''U'' ' + @extraSelect + @crlf + '    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL' + @crlf + @crlf
					set @tstring2 = '    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype' + @extraFields + ') ' + @crlf + 
						'    select ''' + @tablename + ''', deleted.ROWGUIDCOL, ''' + @fieldname + ''', left(cast(deleted.' + @fieldname + ' as varchar(max)),3000), ''D'' '  + @extraDelete + @crlf +
						'    from deleted ' + @crlf +
						'    where deleted.' + @fieldname + ' is not null ' + @crlf + @crlf
					end 
					else
					begin
					set @tstring = 	'    if update(' + @fieldname + ')' + @crlf + '    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, newvalue, changetype' + @extraFields + ') ' + @crlf + 	'    select ''' + @tablename + ''', inserted.ROWGUIDCOL, ''' + @fieldname + ''', deleted.' + @fieldname + ', inserted.' + @fieldname + ', ''U'' ' + @extraSelect + @crlf + '    from inserted, deleted where inserted.ROWGUIDCOL = deleted.ROWGUIDCOL' + @crlf
					set @tstring2 = '    insert into LogChanges(tablename, guidfield, fieldname, oldvalue, changetype' + @extraFields + ') ' + @crlf + 
						'    select ''' + @tablename + ''', deleted.ROWGUIDCOL, ''' + @fieldname + ''', deleted.' + @fieldname + ', ''D'' ' + @extraDelete + @crlf +
						'    from deleted ' + @crlf +
						'    where deleted.' + @fieldname + ' is not null ' + @crlf + @crlf
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



 
 USE [Best]
GO
/****** Object:  StoredProcedure [dbo].[Best_CreateAllTriggers]    Script Date: 05/20/2011 13:04:17 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[Best_CreateAllTriggers]
AS
	DECLARE @name AS varchar(100)
	DECLARE tablecursor CURSOR LOCAL SCROLL FOR
		SELECT name FROM sysobjects WHERE OBJECTPROPERTY(id, N'IsUserTable') = 1 ORDER BY name
	OPEN tablecursor
	FETCH NEXT FROM tablecursor INTO @name
	WHILE @@FETCH_STATUS = 0
	BEGIN
	if exists (	select * from syscolumns where id = object_id(N'[dbo].[' + @name + ']') and name = 'lastChange')
	Begin
print @name
		EXEC Best_CreateTriggers @name
	End

		FETCH NEXT FROM tablecursor INTO @name
	END
	CLOSE tablecursor
	DEALLOCATE tablecursor


USE [Best]
GO
/****** Object:  StoredProcedure [dbo].[Best_GetNextStudentId]    Script Date: 05/20/2011 13:04:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[Best_GetNextStudentId]
	@xcenterid varchar(10), @makehigherthan varchar(10) = 'S0'
As
SET NOCOUNT ON;
DECLARE @maxid varchar(10)
set @maxid = 'S0'
SELECT TOP 1 @maxid = isnull(studentid, 'S0') FROM BestStudents WHERE centerid = @xcenterid ORDER BY studentid DESC
if @maxid < @makehigherthan
begin
set @maxid = @makehigherthan
end
if @maxid = '999999'
begin
	set @maxid = 'A00000'
end 
if @maxid = 'Z99999'
begin
	set @maxid = '100000';
end
if @maxid = 'ZZZZZZ'
begin
	set @maxid = '100000';
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
		if (@currentcharacter = ' ')
		begin
		  set @maxid = stuff(@maxid, @cix, 1, '1')
		  break
		end
		if (ascii(@currentcharacter) = 90)
		begin
			set @maxid = stuff(@maxid, @cix, 1, 'A')
			set @carry = 1
			continue
		end
		if (ascii(@currentcharacter) = 122)
		begin
			set @maxid = stuff(@maxid, @cix, 1, 'a')
			set @carry = 1
			continue
		end
		if (@currentcharacter = '9')
		begin
			set @maxid = stuff(@maxid, @cix, 1, '0')
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
select '0'




USE [Best]
GO
/****** Object:  StoredProcedure [dbo].[Best_GetNextTutorId]    Script Date: 05/20/2011 13:04:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[Best_GetNextTutorId]
	@makehigherthan varchar(10) = 'T0'
As
SET NOCOUNT ON;
DECLARE @maxid varchar(10)
set @maxid = 'T0'
SELECT TOP 1 @maxid = isnull(tutorid, 'T0') FROM BestTutors ORDER BY tutorid DESC
if @maxid < @makehigherthan
begin
set @maxid = @makehigherthan
end
if @maxid = '999999'
begin
	set @maxid = 'A00000'
end 
if @maxid = 'Z99999'
begin
	set @maxid = '100000';
end
if @maxid = 'ZZZZZZ'
begin
	set @maxid = '100000';
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
		if (@currentcharacter = ' ')
		begin
		  set @maxid = stuff(@maxid, @cix, 1, '1')
		  break
		end
		if (ascii(@currentcharacter) = 90)
		begin
			set @maxid = stuff(@maxid, @cix, 1, 'A')
			set @carry = 1
			continue
		end
		if (ascii(@currentcharacter) = 122)
		begin
			set @maxid = stuff(@maxid, @cix, 1, 'a')
			set @carry = 1
			continue
		end
		if (@currentcharacter = '9')
		begin
			set @maxid = stuff(@maxid, @cix, 1, '0')
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
select '0'



USE [Best]
GO
/****** Object:  StoredProcedure [dbo].[Best_SuspectScore]    Script Date: 05/20/2011 13:04:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Best_SuspectScore] 
@target varchar(200) as
Select isnull(sum(score),0) as TheScore from BestSuspicion 
where target = @target and logdate >= getDate() - .0417 --.0417 is roughly 1/24 = 1 hour





	
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','1.Programs',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','2.Students',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','3.Tutors',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','4.Payments',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','5.Schedules',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','6.Setup',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Payment - Details',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Payment - Reports',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Payment - Types',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Program - Information',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Program - Types',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Schedules - Attendance',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Setup - Center Information',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Setup - EMail Template',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Setup - Services',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Setup - User Roles',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Setup - Users',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Student - Information',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Student - Notes',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Student - Reports',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Tutor - Information',1,1,1,1);
insert into BestUserRoles (username,service,allowadd,allowview,allowedit,allowdelete) values ('Balaji','Tutor - Reports',1,1,1,1);

	