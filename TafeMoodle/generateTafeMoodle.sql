USE [master]
GO
/****** Object:  Database [TafeMoodle]    Script Date: 7/06/2021 9:43:55 AM ******/
CREATE DATABASE [TafeMoodle]
-- CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'TafeMoodle', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\TafeMoodle.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'TafeMoodle_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\TafeMoodle_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
--GO
ALTER DATABASE [TafeMoodle] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TafeMoodle].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TafeMoodle] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TafeMoodle] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TafeMoodle] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TafeMoodle] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TafeMoodle] SET ARITHABORT OFF 
GO
ALTER DATABASE [TafeMoodle] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TafeMoodle] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TafeMoodle] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TafeMoodle] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TafeMoodle] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TafeMoodle] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TafeMoodle] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TafeMoodle] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TafeMoodle] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TafeMoodle] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TafeMoodle] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TafeMoodle] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TafeMoodle] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TafeMoodle] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TafeMoodle] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TafeMoodle] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TafeMoodle] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TafeMoodle] SET RECOVERY FULL 
GO
ALTER DATABASE [TafeMoodle] SET  MULTI_USER 
GO
ALTER DATABASE [TafeMoodle] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TafeMoodle] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TafeMoodle] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TafeMoodle] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TafeMoodle] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TafeMoodle] SET QUERY_STORE = OFF
GO
USE [TafeMoodle]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[studID] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](max) NOT NULL,
	[lastName] [varchar](max) NOT NULL,
	[addressFK] [int] NULL,
	[mobNum] [nchar](10) NOT NULL,
	[sex] [varchar](max) NOT NULL,
	[emailUsername] [varchar](max) NULL,
	[password] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[studID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[addressID] [int] IDENTITY(1,1) NOT NULL,
	[houseNum] [int] NOT NULL,
	[streetName] [varchar](max) NOT NULL,
	[suburb] [varchar](max) NOT NULL,
	[state] [varchar](50) NOT NULL,
	[postcode] [int] NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[addressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_studAddressFull]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_studAddressFull]
AS
SELECT studID, addressID, houseNum, streetName, suburb, state, postcode
FROM Student stud
INNER JOIN Address adr ON adr.addressID = stud.addressFK
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[subID] [int] IDENTITY(1,1) NOT NULL,
	[subName] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[subID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubjectUnits]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectUnits](
	[subUnitID] [int] IDENTITY(1,1) NOT NULL,
	[subFK] [int] NOT NULL,
	[unitFK] [int] NOT NULL,
 CONSTRAINT [PK_SubjectUnits] PRIMARY KEY CLUSTERED 
(
	[subUnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[unitID] [int] IDENTITY(1,1) NOT NULL,
	[unitName] [varchar](max) NOT NULL,
	[type] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[unitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_subUnits]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_subUnits]
AS
SELECT subID, subName, unitFK, unitName, type
FROM Subject sub
LEFT JOIN SubjectUnits subUnit ON subUnit.subFK = sub.subID
LEFT JOIN Unit unit ON unit.unitID = subUnit.unitFK
GO
/****** Object:  View [dbo].[vw_nextSubID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_nextSubID]
AS
SELECT TOP 1 subID + 1 AS 'NextSubID'
FROM Subject 
ORDER BY subID DESC
GO
/****** Object:  Table [dbo].[Assessment]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessment](
	[assessmentID] [int] IDENTITY(1,1) NOT NULL,
	[assessmentName] [varchar](max) NOT NULL,
	[dueDate] [varchar](max) NOT NULL,
	[assessmentType] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Assessment] PRIMARY KEY CLUSTERED 
(
	[assessmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitAssessments]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitAssessments](
	[unitAssID] [int] IDENTITY(1,1) NOT NULL,
	[unitFK] [int] NOT NULL,
	[assessmentFK] [int] NOT NULL,
 CONSTRAINT [PK_UnitAssessments] PRIMARY KEY CLUSTERED 
(
	[unitAssID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_unitAssessments]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_unitAssessments]
AS 
SELECT unitID, unitName, assessmentID, assessmentName, dueDate, assessmentType
FROM UnitAssessments unitAss 
INNER JOIN Unit unit ON unit.unitID = unitAss.unitFK
INNER JOIN Assessment ass ON ass.assessmentID = unitAss.unitAssID
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[courseID] [int] IDENTITY(1,1) NOT NULL,
	[courseName] [varchar](max) NOT NULL,
	[durationWeeks] [int] NOT NULL,
	[fee] [float] NOT NULL,
	[mode] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[courseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseList]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseList](
	[courseListID] [int] IDENTITY(1,1) NOT NULL,
	[courseFK] [int] NOT NULL,
	[teacherFK] [int] NOT NULL,
 CONSTRAINT [PK_CourseList] PRIMARY KEY CLUSTERED 
(
	[courseListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[teacherID] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](max) NOT NULL,
	[lastName] [varchar](max) NOT NULL,
	[addressFK] [int] NULL,
	[mobNum] [nchar](10) NOT NULL,
	[sex] [varchar](max) NOT NULL,
	[emailUsername] [varchar](max) NULL,
	[password] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[teacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_TeacherCourseList]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_TeacherCourseList]
AS
SELECT courseID, courseName, teacherID, firstName, lastName
FROM CourseList crsList
INNER JOIN Course crs ON crs.courseID = crsList.courseFK
INNER JOIN Teacher teach ON teach.teacherID = crsList.teacherFK
GO
/****** Object:  View [dbo].[vw_teachAddressFull]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_teachAddressFull]
AS
SELECT teacherID, addressID, houseNum, streetName, suburb, state, postcode
FROM Teacher teach
INNER JOIN Address adr ON adr.addressID = teach.addressFK
GO
/****** Object:  Table [dbo].[EnrolledCourseList]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnrolledCourseList](
	[courseFK] [int] NOT NULL,
	[studFK] [int] NOT NULL,
	[amountPaid] [float] NULL,
 CONSTRAINT [PK_EnrolledCourseList_1] PRIMARY KEY CLUSTERED 
(
	[courseFK] ASC,
	[studFK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_enrolledCourseList]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_enrolledCourseList]
AS
SELECT courseID AS 'Course ID', courseName AS 'Course Name', studFK, fee AS 'Fee', amountPaid AS 'Amount Paid'
FROM EnrolledCourseList enrCrs
LEFT JOIN Course crs ON crs.courseID = enrCrs.courseFK 
GO
/****** Object:  View [dbo].[vw_EnrolledStudents]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_EnrolledStudents] 
AS 
SELECT courseID, courseName, studID, firstName, lastName 
FROM EnrolledCourseList enr
INNER JOIN Student stud ON stud.studID = enr.studFK
INNER JOIN Course crs ON crs.courseID = enr.courseFK
GO
/****** Object:  View [dbo].[vw_studAddress]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_studAddress]
AS 
SELECT studID, firstName, lastName, CONCAT(houseNum, ' ',streetName, ' ',suburb, ' ',state, ' ',postcode) AS 'Address', 
mobNum, sex, emailUsername 
FROM Student stud
INNER JOIN Address addrs ON addrs.addressID = stud.addressFK
GO
/****** Object:  Table [dbo].[CourseSemesters]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseSemesters](
	[courseSemID] [int] IDENTITY(1,1) NOT NULL,
	[courseFK] [int] NOT NULL,
	[semFK] [int] NOT NULL,
 CONSTRAINT [PK_CourseSemesters] PRIMARY KEY CLUSTERED 
(
	[courseSemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Semester]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Semester](
	[semID] [int] IDENTITY(1,1) NOT NULL,
	[semName] [varchar](max) NOT NULL,
	[semStartDate] [date] NOT NULL,
	[semFinishDate] [date] NOT NULL,
 CONSTRAINT [PK_Semester] PRIMARY KEY CLUSTERED 
(
	[semID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_courseSems]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_courseSems]
AS 
SELECT courseID, courseName, semName, semStartDate, semFinishDate
FROM CourseSemesters crsSem
INNER JOIN Course crs on crs.courseID = crsSem.courseFK
INNER JOIN Semester sem on sem.semID = crsSem.semFK
GO
/****** Object:  View [dbo].[vw_allSemesters]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_allSemesters]
AS
SELECT semID, semStartDate, semFinishDate 
FROM Semester
GO
/****** Object:  Table [dbo].[CourseLocation]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseLocation](
	[courseLocationID] [int] IDENTITY(1,1) NOT NULL,
	[courseFK] [int] NOT NULL,
	[addressFK] [int] NOT NULL,
 CONSTRAINT [PK_CourseLocation] PRIMARY KEY CLUSTERED 
(
	[courseLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_allCourseLocs]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_allCourseLocs] 
AS
SELECT DISTINCT addressID, CONCAT(houseNum, ' ', streetName, ' ', suburb, ' ', state, ' ', postcode) AS 'Address'   
FROM CourseLocation crsLoc
INNER JOIN Course crs ON crs.courseID = crsLoc.courseFK
INNER JOIN Address addrs ON addrs.addressID = crsLoc.addressFK
GO
/****** Object:  View [dbo].[vw_nextStudID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_nextStudID]
AS
SELECT TOP 1 studID+1 AS 'Next StudID' 
FROM Student
ORDER BY studID DESC
GO
/****** Object:  View [dbo].[vw_nextCourseID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_nextCourseID]
AS 
SELECT TOP 1 (courseID+1) AS 'NextCourseID' 
FROM Course
ORDER BY courseID DESC
GO
/****** Object:  Table [dbo].[CourseSubjects]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseSubjects](
	[courseSubID] [int] IDENTITY(1,1) NOT NULL,
	[courseFK] [int] NOT NULL,
	[subFK] [int] NOT NULL,
 CONSTRAINT [PK_CourseSubjects] PRIMARY KEY CLUSTERED 
(
	[courseSubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[paymentID] [int] IDENTITY(1,1) NOT NULL,
	[paymentDate] [date] NOT NULL,
	[studFK] [int] NOT NULL,
	[courseFK] [int] NOT NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubjectTeachers]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectTeachers](
	[subTeachID] [int] IDENTITY(1,1) NOT NULL,
	[subFK] [int] NOT NULL,
	[teacherFK] [int] NOT NULL,
 CONSTRAINT [PK_SubjectTeachers] PRIMARY KEY CLUSTERED 
(
	[subTeachID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (1, 10, N'William Street', N'Granville', N'NSW', 2176)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (2, 15, N'George Street', N'Mount Druitt', N'NSW', 2047)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (3, 10, N'Minx Street', N'Penrith', N'NSW', 2170)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (4, 10, N'Fake Street', N'Edensor Park', N'NSW', 2176)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (5, 1, N'Pokemon Street', N'Blacktown', N'NSW', 2177)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (6, 99, N'Chocolate Street', N'WonkaLand', N'NSW', 9999)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (7, 123, N'Hillbilly Street', N'Edensor Park', N'NSW', 2121)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (1004, 10, N'Cadet Street', N'Edensor Park', N'NSW', 2176)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (1005, 10, N'Jigsaw Street', N'Mount Druitt', N'NSW', 2176)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (1006, 11, N'Jigsaw Street', N'Mount Druitt', N'NSW', 2177)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (1007, 1, N'Princess Street', N'Sydney', N'NSW', 2000)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (1008, 1, N'Pleasant Street', N'Rooty Hill', N'NSW', 2190)
INSERT [dbo].[Address] ([addressID], [houseNum], [streetName], [suburb], [state], [postcode]) VALUES (1009, 15, N'William Street', N'Rooty Hill', N'NSW', 2190)
SET IDENTITY_INSERT [dbo].[Address] OFF
GO
SET IDENTITY_INSERT [dbo].[Assessment] ON 

INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (1, N'Event 1 of 3', N'2021-12-12', N'Knowledge')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (2, N'what am i?', N'Knowledge', N'25/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (3, N'Building a house', N'Project', N'26/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (4, N'Raising pigs', N'Skill', N'26/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (5, N'Dig a hole', N'Project', N'30/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (6, N'Can anybody grow?', N'Knowledge', N'28/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (7, N'Can anybody shrink?', N'Knowledge', N'28/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (8, N'ass 1', N'Knowledge', N'19/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (9, N'ass 2', N'Knowledge', N'19/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (10, N'ass1', N'Knowledge', N'21/06/2021')
INSERT [dbo].[Assessment] ([assessmentID], [assessmentName], [dueDate], [assessmentType]) VALUES (11, N'ass2', N'Knowledge', N'21/06/2021')
SET IDENTITY_INSERT [dbo].[Assessment] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([courseID], [courseName], [durationWeeks], [fee], [mode]) VALUES (1, N'Diploma of Software Development', 18, 4999.99, N'Full-Time')
INSERT [dbo].[Course] ([courseID], [courseName], [durationWeeks], [fee], [mode]) VALUES (2, N'Diploma of IT', 18, 8999.85, N'Full-Time')
INSERT [dbo].[Course] ([courseID], [courseName], [durationWeeks], [fee], [mode]) VALUES (5, N'Tupperware Containership', 10, 1100, N' Part-Time')
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseList] ON 

INSERT [dbo].[CourseList] ([courseListID], [courseFK], [teacherFK]) VALUES (1, 1, 1)
INSERT [dbo].[CourseList] ([courseListID], [courseFK], [teacherFK]) VALUES (2, 2, 1)
SET IDENTITY_INSERT [dbo].[CourseList] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseLocation] ON 

INSERT [dbo].[CourseLocation] ([courseLocationID], [courseFK], [addressFK]) VALUES (1, 1, 2)
INSERT [dbo].[CourseLocation] ([courseLocationID], [courseFK], [addressFK]) VALUES (2, 1, 1)
INSERT [dbo].[CourseLocation] ([courseLocationID], [courseFK], [addressFK]) VALUES (3, 2, 2)
INSERT [dbo].[CourseLocation] ([courseLocationID], [courseFK], [addressFK]) VALUES (8, 5, 1)
INSERT [dbo].[CourseLocation] ([courseLocationID], [courseFK], [addressFK]) VALUES (9, 5, 2)
SET IDENTITY_INSERT [dbo].[CourseLocation] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseSemesters] ON 

INSERT [dbo].[CourseSemesters] ([courseSemID], [courseFK], [semFK]) VALUES (1, 1, 1)
INSERT [dbo].[CourseSemesters] ([courseSemID], [courseFK], [semFK]) VALUES (2, 1, 2)
INSERT [dbo].[CourseSemesters] ([courseSemID], [courseFK], [semFK]) VALUES (6, 5, 1)
SET IDENTITY_INSERT [dbo].[CourseSemesters] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseSubjects] ON 

INSERT [dbo].[CourseSubjects] ([courseSubID], [courseFK], [subFK]) VALUES (1, 1, 1)
INSERT [dbo].[CourseSubjects] ([courseSubID], [courseFK], [subFK]) VALUES (2, 1, 2)
INSERT [dbo].[CourseSubjects] ([courseSubID], [courseFK], [subFK]) VALUES (6, 5, 1)
SET IDENTITY_INSERT [dbo].[CourseSubjects] OFF
GO
INSERT [dbo].[EnrolledCourseList] ([courseFK], [studFK], [amountPaid]) VALUES (1, 1003, 0)
INSERT [dbo].[EnrolledCourseList] ([courseFK], [studFK], [amountPaid]) VALUES (2, 1003, 0)
GO
SET IDENTITY_INSERT [dbo].[Semester] ON 

INSERT [dbo].[Semester] ([semID], [semName], [semStartDate], [semFinishDate]) VALUES (1, N'1', CAST(N'2021-02-01' AS Date), CAST(N'2021-06-18' AS Date))
INSERT [dbo].[Semester] ([semID], [semName], [semStartDate], [semFinishDate]) VALUES (2, N'2', CAST(N'2021-07-12' AS Date), CAST(N'2021-11-29' AS Date))
SET IDENTITY_INSERT [dbo].[Semester] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([studID], [firstName], [lastName], [addressFK], [mobNum], [sex], [emailUsername], [password]) VALUES (1003, N'Julie', N'Lam', 1009, N'402999888 ', N'Female', N'Julie.Lam1003@tafe.com', N'1234')
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Subject] ON 

INSERT [dbo].[Subject] ([subID], [subName]) VALUES (1, N'Advanced C#')
INSERT [dbo].[Subject] ([subID], [subName]) VALUES (2, N'Advanced Java')
SET IDENTITY_INSERT [dbo].[Subject] OFF
GO
SET IDENTITY_INSERT [dbo].[SubjectTeachers] ON 

INSERT [dbo].[SubjectTeachers] ([subTeachID], [subFK], [teacherFK]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [dbo].[SubjectTeachers] OFF
GO
SET IDENTITY_INSERT [dbo].[SubjectUnits] ON 

INSERT [dbo].[SubjectUnits] ([subUnitID], [subFK], [unitFK]) VALUES (1, 1, 1)
INSERT [dbo].[SubjectUnits] ([subUnitID], [subFK], [unitFK]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[SubjectUnits] OFF
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([teacherID], [firstName], [lastName], [addressFK], [mobNum], [sex], [emailUsername], [password]) VALUES (1, N'John', N'Best', 1006, N'405123123 ', N'Male', N'John.Best1@tafe.com', N'1234')
INSERT [dbo].[Teacher] ([teacherID], [firstName], [lastName], [addressFK], [mobNum], [sex], [emailUsername], [password]) VALUES (2, N'John', N'Worst', 1009, N'402123987 ', N'Male', N'John.Best2@tafe.com', N'123')
INSERT [dbo].[Teacher] ([teacherID], [firstName], [lastName], [addressFK], [mobNum], [sex], [emailUsername], [password]) VALUES (3, N'Raj', N'Baldev', 1009, N'1111111111', N'Male', N'Raj.Baldev3@tafe.com', N'123')
SET IDENTITY_INSERT [dbo].[Teacher] OFF
GO
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([unitID], [unitName], [type]) VALUES (1, N'Software Methodologies', N'Core')
INSERT [dbo].[Unit] ([unitID], [unitName], [type]) VALUES (2, N'Advanced OOP', N'Core')
INSERT [dbo].[Unit] ([unitID], [unitName], [type]) VALUES (3, N'I am not a unit', N'Core')
INSERT [dbo].[Unit] ([unitID], [unitName], [type]) VALUES (4, N'A real fun one', N'Core')
INSERT [dbo].[Unit] ([unitID], [unitName], [type]) VALUES (6, N'Basic Farming', N'Core')
INSERT [dbo].[Unit] ([unitID], [unitName], [type]) VALUES (8, N'Why why why', N'Core')
INSERT [dbo].[Unit] ([unitID], [unitName], [type]) VALUES (9, N'Constructive Feeling', N'Core')
INSERT [dbo].[Unit] ([unitID], [unitName], [type]) VALUES (10, N'Being better', N'Core')
SET IDENTITY_INSERT [dbo].[Unit] OFF
GO
SET IDENTITY_INSERT [dbo].[UnitAssessments] ON 

INSERT [dbo].[UnitAssessments] ([unitAssID], [unitFK], [assessmentFK]) VALUES (1, 1, 1)
INSERT [dbo].[UnitAssessments] ([unitAssID], [unitFK], [assessmentFK]) VALUES (2, 3, 1)
INSERT [dbo].[UnitAssessments] ([unitAssID], [unitFK], [assessmentFK]) VALUES (3, 4, 1)
INSERT [dbo].[UnitAssessments] ([unitAssID], [unitFK], [assessmentFK]) VALUES (7, 8, 1)
INSERT [dbo].[UnitAssessments] ([unitAssID], [unitFK], [assessmentFK]) VALUES (8, 8, 1)
INSERT [dbo].[UnitAssessments] ([unitAssID], [unitFK], [assessmentFK]) VALUES (9, 10, 1)
INSERT [dbo].[UnitAssessments] ([unitAssID], [unitFK], [assessmentFK]) VALUES (10, 10, 1)
SET IDENTITY_INSERT [dbo].[UnitAssessments] OFF
GO
ALTER TABLE [dbo].[CourseList]  WITH CHECK ADD  CONSTRAINT [FK_CourseList_Course] FOREIGN KEY([courseFK])
REFERENCES [dbo].[Course] ([courseID])
GO
ALTER TABLE [dbo].[CourseList] CHECK CONSTRAINT [FK_CourseList_Course]
GO
ALTER TABLE [dbo].[CourseList]  WITH CHECK ADD  CONSTRAINT [FK_CourseList_Teacher] FOREIGN KEY([teacherFK])
REFERENCES [dbo].[Teacher] ([teacherID])
GO
ALTER TABLE [dbo].[CourseList] CHECK CONSTRAINT [FK_CourseList_Teacher]
GO
ALTER TABLE [dbo].[CourseLocation]  WITH CHECK ADD  CONSTRAINT [FK_CourseLocation_Address] FOREIGN KEY([addressFK])
REFERENCES [dbo].[Address] ([addressID])
GO
ALTER TABLE [dbo].[CourseLocation] CHECK CONSTRAINT [FK_CourseLocation_Address]
GO
ALTER TABLE [dbo].[CourseLocation]  WITH CHECK ADD  CONSTRAINT [FK_CourseLocation_Course] FOREIGN KEY([courseFK])
REFERENCES [dbo].[Course] ([courseID])
GO
ALTER TABLE [dbo].[CourseLocation] CHECK CONSTRAINT [FK_CourseLocation_Course]
GO
ALTER TABLE [dbo].[CourseSemesters]  WITH CHECK ADD  CONSTRAINT [FK_CourseSemesters_Course] FOREIGN KEY([courseFK])
REFERENCES [dbo].[Course] ([courseID])
GO
ALTER TABLE [dbo].[CourseSemesters] CHECK CONSTRAINT [FK_CourseSemesters_Course]
GO
ALTER TABLE [dbo].[CourseSemesters]  WITH CHECK ADD  CONSTRAINT [FK_CourseSemesters_Semester] FOREIGN KEY([semFK])
REFERENCES [dbo].[Semester] ([semID])
GO
ALTER TABLE [dbo].[CourseSemesters] CHECK CONSTRAINT [FK_CourseSemesters_Semester]
GO
ALTER TABLE [dbo].[CourseSubjects]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubjects_Course] FOREIGN KEY([courseFK])
REFERENCES [dbo].[Course] ([courseID])
GO
ALTER TABLE [dbo].[CourseSubjects] CHECK CONSTRAINT [FK_CourseSubjects_Course]
GO
ALTER TABLE [dbo].[CourseSubjects]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubjects_Subject] FOREIGN KEY([subFK])
REFERENCES [dbo].[Subject] ([subID])
GO
ALTER TABLE [dbo].[CourseSubjects] CHECK CONSTRAINT [FK_CourseSubjects_Subject]
GO
ALTER TABLE [dbo].[EnrolledCourseList]  WITH CHECK ADD  CONSTRAINT [FK_EnrolledCourseList_Course] FOREIGN KEY([courseFK])
REFERENCES [dbo].[Course] ([courseID])
GO
ALTER TABLE [dbo].[EnrolledCourseList] CHECK CONSTRAINT [FK_EnrolledCourseList_Course]
GO
ALTER TABLE [dbo].[EnrolledCourseList]  WITH CHECK ADD  CONSTRAINT [FK_EnrolledCourseList_Student] FOREIGN KEY([studFK])
REFERENCES [dbo].[Student] ([studID])
GO
ALTER TABLE [dbo].[EnrolledCourseList] CHECK CONSTRAINT [FK_EnrolledCourseList_Student]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Course] FOREIGN KEY([courseFK])
REFERENCES [dbo].[Course] ([courseID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Course]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Student] FOREIGN KEY([studFK])
REFERENCES [dbo].[Student] ([studID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Student]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Address] FOREIGN KEY([addressFK])
REFERENCES [dbo].[Address] ([addressID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Address]
GO
ALTER TABLE [dbo].[SubjectTeachers]  WITH CHECK ADD  CONSTRAINT [FK_SubjectTeachers_Subject] FOREIGN KEY([subFK])
REFERENCES [dbo].[Subject] ([subID])
GO
ALTER TABLE [dbo].[SubjectTeachers] CHECK CONSTRAINT [FK_SubjectTeachers_Subject]
GO
ALTER TABLE [dbo].[SubjectTeachers]  WITH CHECK ADD  CONSTRAINT [FK_SubjectTeachers_Teacher] FOREIGN KEY([teacherFK])
REFERENCES [dbo].[Teacher] ([teacherID])
GO
ALTER TABLE [dbo].[SubjectTeachers] CHECK CONSTRAINT [FK_SubjectTeachers_Teacher]
GO
ALTER TABLE [dbo].[SubjectUnits]  WITH CHECK ADD  CONSTRAINT [FK_SubjectUnits_Subject] FOREIGN KEY([subFK])
REFERENCES [dbo].[Subject] ([subID])
GO
ALTER TABLE [dbo].[SubjectUnits] CHECK CONSTRAINT [FK_SubjectUnits_Subject]
GO
ALTER TABLE [dbo].[SubjectUnits]  WITH CHECK ADD  CONSTRAINT [FK_SubjectUnits_Unit] FOREIGN KEY([unitFK])
REFERENCES [dbo].[Unit] ([unitID])
GO
ALTER TABLE [dbo].[SubjectUnits] CHECK CONSTRAINT [FK_SubjectUnits_Unit]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Address] FOREIGN KEY([addressFK])
REFERENCES [dbo].[Address] ([addressID])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_Address]
GO
ALTER TABLE [dbo].[UnitAssessments]  WITH CHECK ADD  CONSTRAINT [FK_UnitAssessments_Assessment] FOREIGN KEY([assessmentFK])
REFERENCES [dbo].[Assessment] ([assessmentID])
GO
ALTER TABLE [dbo].[UnitAssessments] CHECK CONSTRAINT [FK_UnitAssessments_Assessment]
GO
ALTER TABLE [dbo].[UnitAssessments]  WITH CHECK ADD  CONSTRAINT [FK_UnitAssessments_Unit] FOREIGN KEY([unitFK])
REFERENCES [dbo].[Unit] ([unitID])
GO
ALTER TABLE [dbo].[UnitAssessments] CHECK CONSTRAINT [FK_UnitAssessments_Unit]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCourseByCourseID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteCourseByCourseID] @courseID int
AS 
DELETE  
FROM CourseLocation
WHERE CourseFK = @courseID

DELETE  
FROM CourseSemesters
WHERE CourseFK = @courseID

DELETE 
FROM CourseSubjects
WHERE CourseFK = @courseID

DELETE FROM Course WHERE courseID = @courseID
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteStudByStudID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_DeleteStudByStudID] @studID int
AS
DELETE FROM Student
WHERE studID = @studID
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteSubBySubID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteSubBySubID] @subID int
AS
DELETE FROM SubjectTeachers 
WHERE subFK = @subID 

DELETE FROM SubjectUnits
WHERE subFK = @subID

DELETE FROM Subject
Where subID = @subID
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteTeacherByTeacherID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteTeacherByTeacherID] @teacherID int
AS 
DELETE FROM Teacher
WHERE teacherID = @teacherID
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUnitByUnitID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteUnitByUnitID] @unitID int
AS

DELETE FROM UnitAssessments
WHERE unitFK = @unitID

DELETE FROM SubjectUnits
WHERE unitFK = @unitID

DELETE FROM Unit 
WHERE unitID = @unitID
GO
/****** Object:  StoredProcedure [dbo].[sp_EnrolledStudentsByCourseID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EnrolledStudentsByCourseID] 
@courseID int 
AS
SELECT * 
FROM vw_EnrolledStudents 
WHERE courseID = @courseID
GO
/****** Object:  StoredProcedure [dbo].[sp_enrollStud]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_enrollStud] @courseID int, @studID int
AS
INSERT INTO EnrolledCourseList
VALUES (@courseID, @studID, 0)
GO
/****** Object:  StoredProcedure [dbo].[sp_getCourseLocations_ByCourseID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getCourseLocations_ByCourseID] @varCourseID int 
AS
SELECT courseID, addressID, CONCAT(houseNum, ' ', streetName, ' ', suburb, ' ', state, ' ', postcode) AS 'Address' 
FROM CourseLocation crsLoc 
INNER JOIN Course crs ON crs.courseID = crsLoc.courseFK
INNER JOIN Address adrss ON adrss.addressID = crsLoc.addressFK
WHERE courseID = @varCourseID
GO
/****** Object:  StoredProcedure [dbo].[sp_getCourseSem]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getCourseSem] @varCourseID int
AS
SELECT courseName, semName, semStartDate, semFinishDate  
FROM CourseSemesters crsSem
INNER JOIN Course crs ON crsSem.courseFK = crs.courseID
INNER JOIN Semester sem ON crsSem.semFK = sem.semID
GO
/****** Object:  StoredProcedure [dbo].[sp_getCourseSubjects]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getCourseSubjects] @varCourseID int
AS
SELECT  crs.courseName, subName
FROM CourseSubjects crsSub
INNER JOIN Subject sub ON crsSub.subFK = sub.subID
INNER JOIN Course crs ON crsSub.courseFK = crs.courseID
WHERE CourseFK = 1; 
GO
/****** Object:  StoredProcedure [dbo].[sp_getRecentStudID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getRecentStudID]
AS
SELECT TOP 1 studID
FROM Student
ORDER BY studID DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_getRecentTeacherID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getRecentTeacherID]
AS
SELECT TOP 1 teacherID
FROM Teacher
ORDER BY teacherID DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAStudent]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertAStudent]
@firstName varchar(max), 
@lastName varchar(max), 
@mobNum nchar(10), 
@sex varchar(MAX), 
@password varchar(MAX), 

@houseNum int, 
@streetName varchar(MAX), 
@suburb varchar(MAX), 
@state varchar(50), 
@postcode int
AS

INSERT INTO Address
VALUES (@houseNum, @streetName, @suburb, @state, @postcode)

INSERT INTO Student (firstName, lastName, mobNum, sex, password)
VALUES (@firstName, @lastName, @mobNum, @sex, @password)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertATeacher]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertATeacher] 
@firstName varchar(max), 
@lastName varchar(max), 
@mobNum nchar(10), 
@sex varchar(MAX), 
@password varchar(MAX),

@houseNum int, 
@streetName varchar(MAX), 
@suburb varchar(MAX), 
@state varchar(50), 
@postcode int
 
AS
INSERT INTO Address
VALUES (@houseNum, @streetName, @suburb, @state, @postcode)

INSERT INTO Teacher (firstName, lastName, mobNum, sex, password)
VALUES (@firstName, @lastName, @mobNum, @sex, @password)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertCourse1]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertCourse1] @courseName varchar(max), @duration int, @fee float, @mode varchar(max) 
AS 
INSERT INTO Course
VALUES(@courseName, @duration, @fee, @mode) 
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertCourse2]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertCourse2] @semID int
AS
DECLARE @courseID int = (SELECT TOP 1 courseID 
						 FROM Course 
						 ORDER BY courseID DESC)
INSERT INTO CourseSemesters
VALUES (@courseID, @semID)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertCourse3]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertCourse3] @addrssID int
AS
DECLARE @courseID int = (SELECT TOP 1 courseID 
						 FROM Course 
						 ORDER BY courseID DESC)
INSERT INTO CourseLocation
VALUES (@courseID, @addrssID)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertCourse4]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertCourse4] @subID int
AS
DECLARE @courseID int = (SELECT TOP 1 courseID 
						 FROM Course 
						 ORDER BY courseID DESC)

INSERT INTO CourseSubjects
VALUES (@courseID, @subID)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertSubject1]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_InsertSubject1] @subName varchar(max)
AS
INSERT INTO Subject
VALUES (@subName)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertSubject2]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertSubject2] @unitID int
AS
DECLARE @SubjectID int = (SELECT TOP 1 subID 
						  FROM Subject
						  ORDER BY subID DESC)
INSERT INTO SubjectUnits
VALUES(@SubjectID, @unitID)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertSubject3]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertSubject3] @teacherID int
AS
DECLARE @SubjectID int = (SELECT TOP 1 subID 
						  FROM Subject
						  ORDER BY subID DESC)
INSERT INTO SubjectTeachers
VALUES(@SubjectID, @teacherID)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUnit1]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertUnit1] @unitName varchar(max), @unitType varchar(max) 
AS
INSERT INTO Unit 
VALUES(@unitName, @unitType)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUnit2]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertUnit2] @assName varchar(max), @assDueDate varchar(max), @assType varchar(max)
AS
INSERT INTO Assessment 
VALUES (@assName, @assDueDate, @assType)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUnit3]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertUnit3] 
AS 
DECLARE @recentUnitID int = (SELECT TOP 1 unitID
							 FROM Unit 
							 ORDER BY unitID DESC)
DECLARE @recentAssID int = (SELECT TOP 1 assessmentID	
							FROM Assessment
						    ORDER BY assessmentID)
INSERT INTO UnitAssessments
VALUES (@recentUnitID, @recentAssID)
GO
/****** Object:  StoredProcedure [dbo].[sp_payEnrolledCourse]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_payEnrolledCourse] @payment float, @studID int, @courseID int
AS
UPDATE vw_enrolledCourseList
SET [Amount Paid] += @payment 
WHERE studFK = @studID AND [Course ID] = @courseID
GO
/****** Object:  StoredProcedure [dbo].[sp_unenroll]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_unenroll] @courseID int, @studID int
AS
DELETE FROM enrolledCourseList
WHERE courseFK = @courseID AND studFK = @studID
GO
/****** Object:  StoredProcedure [dbo].[sp_updateCourseByID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateCourseByID] @courseID int, @name varchar(MAX), @duration int, @fee float
AS 
UPDATE Course
SET courseName = @name, 
	durationWeeks = @duration, 
	fee = @fee
WHERE courseID = @courseID
GO
/****** Object:  StoredProcedure [dbo].[sp_updateStudByID_1]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateStudByID_1] @addressID int, @houseNum int, @streetName varchar(max), 
									 @suburb varchar(MAX), @state varchar(50), @postcode int
AS
UPDATE Address
SET houseNum = @houseNum, 
	streetName = @streetName, 
	suburb = @suburb, 
	state = @state, 
	postcode = @postcode
WHERE addressID = @addressID
GO
/****** Object:  StoredProcedure [dbo].[sp_updateStudByID_2]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateStudByID_2] @studID int, @firstName varchar(max), @lastName varchar(max), @mobNum nchar(10), @sex varchar(max)
AS 
DECLARE @recentAddressFK int = (SELECT TOP 1 addressID
								FROM Address
								ORDER BY addressID DESC)
UPDATE Student 
SET firstName = @firstName, 
	lastName = @lastName, 
	mobNum = @mobNum, 
	addressFK = @recentAddressFK,
	sex = @sex
WHERE studID = @studID
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateStudentAfterSP]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateStudentAfterSP]
AS 
UPDATE Student
SET addressFK = (SELECT TOP 1 addressID
				 FROM Address
		         ORDER BY addressID DESC)
WHERE studID = (SELECT TOP 1 studID 
				FROM Student
				ORDER BY studID DESC)
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateStudentEmailAfterSP]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateStudentEmailAfterSP] @emailUsername varchar(MAX), @studID int
AS 
UPDATE Student
SET emailUsername = @emailUsername
WHERE studID = @studID
GO
/****** Object:  StoredProcedure [dbo].[sp_updateSubByID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateSubByID] @subID int, @subName varchar(MAX)
AS 
UPDATE Subject
SET subName = @subName
WHERE subID = @subID
GO
/****** Object:  StoredProcedure [dbo].[sp_updateTeachByID_1]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateTeachByID_1] @addressID int, @houseNum int, @streetName varchar(max), 
									 @suburb varchar(MAX), @state varchar(50), @postcode int
AS
UPDATE Address
SET houseNum = @houseNum, 
	streetName = @streetName, 
	suburb = @suburb, 
	state = @state, 
	postcode = @postcode
WHERE addressID = @addressID
GO
/****** Object:  StoredProcedure [dbo].[sp_updateTeachByID_2]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateTeachByID_2] @teacherID int, @firstName varchar(max), @lastName varchar(max), @mobNum nchar(10), @sex varchar(max)
AS 
DECLARE @recentAddressFK int = (SELECT TOP 1 addressID
								FROM Address
								ORDER BY addressID DESC)
UPDATE Teacher 
SET firstName = @firstName, 
	lastName = @lastName, 
	mobNum = @mobNum, 
	addressFK = @recentAddressFK,
	sex = @sex
WHERE teacherID = @teacherID
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTeacherAfterSP]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateTeacherAfterSP]
AS
UPDATE Teacher
SET addressFK = (SELECT TOP 1 addressID
				 FROM Address
		         ORDER BY addressID DESC)
WHERE teacherID = (SELECT TOP 1 teacherID 
				FROM Teacher
				ORDER BY teacherID DESC)
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTeacherEmailAfterSP]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateTeacherEmailAfterSP] 
@emailUsername varchar(MAX), 
@teacherID int
AS 
UPDATE Teacher
SET emailUsername = @emailUsername
WHERE teacherID = @teacherID
GO
/****** Object:  StoredProcedure [dbo].[sp_vw_courseSems_byCourseID]    Script Date: 7/06/2021 9:43:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_vw_courseSems_byCourseID] @courseID int 
AS 
SELECT * FROM vw_courseSems
WHERE @courseID = courseID
GO
USE [master]
GO
ALTER DATABASE [TafeMoodle] SET  READ_WRITE 
GO
