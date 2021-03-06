USE [Best]
GO
/****** Object:  User [loginbest]    Script Date: 03/08/2012 14:57:38 ******/
CREATE USER [loginbest] FOR LOGIN [loginbest] WITH DEFAULT_SCHEMA=[loginbest]
GO
/****** Object:  Schema [loginbest]    Script Date: 03/08/2012 14:57:38 ******/
CREATE SCHEMA [loginbest] AUTHORIZATION [loginbest]
GO
/****** Object:  Table [dbo].[BestServices]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestSTPlans]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentGPA]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentNotes]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentPayment]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentPickup]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentPicture]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudentReference]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestStudents]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestSuspicion]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestSuspicion](
	[guidfield] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BestSuspicion_guidfield]  DEFAULT (newid()),
	[target] [varchar](200) NULL,
	[score] [int] NULL,
	[logdate] [datetime] NULL CONSTRAINT [DF_BestSuspicion_logdate]  DEFAULT (getdate()),
	[reasonCode] [varchar](20) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestTutors]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestExports]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestUserRoles]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestTutorNotes]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestTutorNotes](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestTutorNotes_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestTutorNotes_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestTutorNotes_lastChangeUser]  DEFAULT (app_name()),
	[tutorGuid] [uniqueidentifier] NOT NULL,
	[noteDate] [datetime] NOT NULL,
	[notes] [varchar](max) NULL,
	[centerId] [varchar](50) NULL,
 CONSTRAINT [PK_BestTutorNotes] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestExportTables]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestExportTables](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestExportTables_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestExportTables_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestExportTables_lastChangeUser]  DEFAULT (app_name()),
	[fieldname] [varchar](50) NULL,
	[aliasname] [varchar](50) NULL,
	[displayname] [varchar](50) NULL,
	[exportType] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestUsers]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestExportFields]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestExportFields](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestExportFields_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestExportFields_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestExportFields_lastChangeUser]  DEFAULT (app_name()),
	[exportguid] [uniqueidentifier] NOT NULL,
	[fieldname] [varchar](100) NOT NULL,
	[displayname] [varchar](50) NULL,
	[ordinal] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestCenters]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestMessages]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestEMailTemplates]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestPaymentTypes]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestDates]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BestDates](
	[date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BestStudentPrograms]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestProgamTypes]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestPrograms]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per Week, Per Day, Per Hour' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BestPrograms', @level2type=N'COLUMN',@level2name=N'amountType'
GO
/****** Object:  Table [dbo].[BestSchedules]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
	[centerId] [varchar](50) NULL,
 CONSTRAINT [PK_BestSchedules] PRIMARY KEY CLUSTERED 
(
	[guidfield] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestUserPrefs]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestUserPrefs](
	[guidfield] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_BestUserPrefs_guidfield]  DEFAULT (newsequentialid()),
	[lastChange] [datetime] NOT NULL CONSTRAINT [DF_BestUserPrefs_lastChange]  DEFAULT (getdate()),
	[lastChangeUser] [varchar](128) NOT NULL CONSTRAINT [DF_BestUserPrefs_lastChangeUser]  DEFAULT (app_name()),
	[name] [varchar](50) NULL,
	[value] [varchar](50) NULL,
	[userName] [varchar](128) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestPaymentDetails]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[VDates]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VDates] As
select convert(datetime, '01/01/2011')+ (t1.num+t2.num*10+t3.num*100+t4.num*1000) as Date from 
(select 1 as num union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 0) t1
cross join
(select 1 as num union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 0) t2
cross join
(select 1 as num union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 0) t3
cross join
(select 1 as num union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 0) t4
GO
/****** Object:  Table [dbo].[BestLogins]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BestDocuments]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Best_CreateTriggers]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Creates triggers on the specified table to log all the changes made
create PROC [dbo].[Best_CreateTriggers]
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
GO
/****** Object:  Table [dbo].[BestLogs]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BestLogs](
	[Logdate] [datetime] NOT NULL CONSTRAINT [DF_Table_1_logdate]  DEFAULT (getdate()),
	[Message] [varchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogChanges]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Best_GetNextStudentId]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[Best_GetNextStudentId]
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
GO
/****** Object:  StoredProcedure [dbo].[Best_SuspectScore]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Best_SuspectScore] 
@target varchar(200) as
Select isnull(sum(score),0) as TheScore from BestSuspicion 
where target = @target and logdate >= getDate() - .0417 --.0417 is roughly 1/24 = 1 hour
GO
/****** Object:  StoredProcedure [dbo].[Best_GetNextTutorId]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[Best_GetNextTutorId]
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
GO
/****** Object:  View [dbo].[VBestSchedulesAndPayments]    Script Date: 03/08/2012 14:57:38 ******/
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
	BestSchedules.attended1 as attendance,
	'Scheduled' as tranType,
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
	'Scheduled' as tranType,
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
	'Scheduled' as tranType,
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
	'Scheduled' as tranType,
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
	'Scheduled' as tranType,
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
	'' as schfrom,
	'' as schto,
	0 as attended,
	'Payment' as tranType,
	hours,
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
	'' as schfrom,
	'' as schto,
	0 as attended,
	'Scheduled' as transType,
	0 as hours,
	BestStudentPrograms.amount as amount,
	BestStudentPrograms.programGuid,
	null as tutorguid,
	'One Time Program' as note,
	BestStudentPrograms.CenterId as CenterId
from BestStudentPrograms
GO
/****** Object:  View [dbo].[VBestSchedules]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[VBestSchedules] As
select tutguid, stuguid1, stuguid2, stuguid3, stuguid4, stuguid5, schfrom,
	convert(varchar(10),convert(datetime,schdate),101) as Date, 
	[Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday]
from (Select tutguid, stuguid1, stuguid2, stuguid3, stuguid4, stuguid5, schdate, datename(dw,convert(datetime, schdate)) as weekname, schfrom, 
	convert(numeric,schfrom) as numFrom from BestSchedules where isdeleted=0) p
PIVOT
(sum(numFrom) for weekname in ([Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday])) As pvt
GO
/****** Object:  StoredProcedure [dbo].[CopySchedules]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Balaji Musaboyina
-- Create date: 06/23/2011
-- Modified Date: 11/26/2011
-- Description:	Copy Schedules
-- =============================================
CREATE PROCEDURE [dbo].[CopySchedules] 
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
	if @CopyType = 'Week'
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

	if @CopyType = 'Day' 
	Begin
		Set @newSch = Convert(varchar(10), @ToDate, 112);
		Set @srcSch = Convert(varchar(10), @BeginDate, 112);
insert into BestSchedules ([tutGuid] ,[stuGuid1] ,[stuGuid2] ,[stuGuid3] ,[stuGuid4] ,[stuGuid5] ,[schDate] ,[schFrom] ,[schTo],[progGuid1] ,[progGuid2] ,[progGuid3] ,[progGuid4] ,[progGuid5], amount1, amount2, amount3, amount4, amount5, centerid) (select [tutGuid] ,[stuGuid1] ,[stuGuid2] ,[stuGuid3] ,[stuGuid4] ,[stuGuid5] , @newSch ,[schFrom] ,[schTo],[progGuid1] ,[progGuid2] ,[progGuid3] ,[progGuid4] ,[progGuid5], amount1, amount2, amount3, amount4, amount5, centerid from BestSchedules Where isDeleted=0 and SchDate = @srcSch);
	End	
END
GO
/****** Object:  View [dbo].[VBestDate]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[VBestDate] As
select date, 
	DATEADD(mm,DATEDIFF(mm,0,Date),0) As MBDate, DATEADD(dd,-1,DATEADD(mm,1,DATEADD(mm,DATEDIFF(mm,0,Date),0))) As MEDate, 
	DATEADD(dd, -1 * case DATENAME(weekday, Date) when 'Sunday' then 0 when 'Monday' then 1 when 'Tuesday' then 2 when 'Wednesday' then 3 when 'Thursday' then 4 when 'Friday' then 5 when 'Saturday' then 6 end, Date) As WBDate, 
	DATEADD(dd, 6, DATEADD(dd, -1 * case DATENAME(weekday, Date) when 'Sunday' then 0 when 'Monday' then 1 when 'Tuesday' then 2 when 'Wednesday' then 3 when 'Thursday' then 4 when 'Friday' then 5 when 'Saturday' then 6 end, Date)) As WEDate, 
	DATENAME(week, Date) As WeekNum
from bestdates
GO
/****** Object:  View [dbo].[VBestPrograms]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[VBestPrograms] As
select BestStudentPrograms.guidfield, BestStudentPrograms.CenterId, programname+'('+programtype+') $'+ltrim(str(coalesce(BestStudentPrograms.amount, BestPrograms.amount)))+'/'+amounttype as programDesc
from BestPrograms
left join BestStudentPrograms on BestStudentPrograms.programguid = BestPrograms.guidfield
GO
/****** Object:  StoredProcedure [dbo].[Best_CreateAllTriggers]    Script Date: 03/08/2012 14:57:38 ******/
SET ANSI_NULLS ON
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
GO
