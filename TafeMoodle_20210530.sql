USE [master]
GO
/****** Object:  Database [TafeMoodle]    Script Date: 30/05/2021 10:51:11 AM ******/
CREATE DATABASE [TafeMoodle]
-- CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'TafeMoodle', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\TafeMoodle.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'TafeMoodle_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\TafeMoodle_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
--GO
ALTER DATABASE [TafeMoodle] SET COMPATIBILITY_LEVEL = 150
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
/****** Object:  Table [dbo].[Course]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[EnrolledCourseList]    Script Date: 30/05/2021 10:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnrolledCourseList](
	[enrolledCourseListID] [int] IDENTITY(1,1) NOT NULL,
	[courseFK] [int] NOT NULL,
	[studFK] [int] NOT NULL,
 CONSTRAINT [PK_EnrolledCourseList] PRIMARY KEY CLUSTERED 
(
	[enrolledCourseListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  View [dbo].[vw_EnrolledStudents]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[Address]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[Assessment]    Script Date: 30/05/2021 10:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessment](
	[assessmentID] [int] IDENTITY(1,1) NOT NULL,
	[assessmentName] [varchar](max) NOT NULL,
	[dueDate] [date] NOT NULL,
	[assessmentType] [varchar](max) NOT NULL,
	[isPassResult] [bit] NOT NULL,
 CONSTRAINT [PK_Assessment] PRIMARY KEY CLUSTERED 
(
	[assessmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseList]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[CourseLocation]    Script Date: 30/05/2021 10:51:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseLocation](
	[courseLocationID] [int] IDENTITY(1,1) NOT NULL,
	[courseFK] [int] NOT NULL,
	[addressFK] [int] NOT NULL,
	[contactNum] [int] NOT NULL,
 CONSTRAINT [PK_CourseLocation] PRIMARY KEY CLUSTERED 
(
	[courseLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseSemesters]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[CourseSubjects]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[Payment]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[Semester]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[Subject]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[SubjectTeachers]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[SubjectUnits]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[Teacher]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[Unit]    Script Date: 30/05/2021 10:51:11 AM ******/
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
/****** Object:  Table [dbo].[UnitAssessments]    Script Date: 30/05/2021 10:51:11 AM ******/
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
SET IDENTITY_INSERT [dbo].[Address] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([courseID], [courseName], [durationWeeks], [fee], [mode]) VALUES (1, N'Diploma of Software Development', 18, 4999.99, N'Full-Time')
INSERT [dbo].[Course] ([courseID], [courseName], [durationWeeks], [fee], [mode]) VALUES (2, N'Diploma of IT', 18, 4999.99, N'Full-Time')
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseLocation] ON 

INSERT [dbo].[CourseLocation] ([courseLocationID], [courseFK], [addressFK], [contactNum]) VALUES (1, 1, 2, 96969696)
INSERT [dbo].[CourseLocation] ([courseLocationID], [courseFK], [addressFK], [contactNum]) VALUES (2, 1, 1, 96109610)
INSERT [dbo].[CourseLocation] ([courseLocationID], [courseFK], [addressFK], [contactNum]) VALUES (3, 2, 2, 9876123)
SET IDENTITY_INSERT [dbo].[CourseLocation] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseSemesters] ON 

INSERT [dbo].[CourseSemesters] ([courseSemID], [courseFK], [semFK]) VALUES (1, 1, 1)
INSERT [dbo].[CourseSemesters] ([courseSemID], [courseFK], [semFK]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[CourseSemesters] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseSubjects] ON 

INSERT [dbo].[CourseSubjects] ([courseSubID], [courseFK], [subFK]) VALUES (1, 1, 1)
INSERT [dbo].[CourseSubjects] ([courseSubID], [courseFK], [subFK]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[CourseSubjects] OFF
GO
SET IDENTITY_INSERT [dbo].[EnrolledCourseList] ON 

INSERT [dbo].[EnrolledCourseList] ([enrolledCourseListID], [courseFK], [studFK]) VALUES (1, 1, 1003)
SET IDENTITY_INSERT [dbo].[EnrolledCourseList] OFF
GO
SET IDENTITY_INSERT [dbo].[Semester] ON 

INSERT [dbo].[Semester] ([semID], [semName], [semStartDate], [semFinishDate]) VALUES (1, N'1', CAST(N'2021-02-01' AS Date), CAST(N'2021-06-18' AS Date))
INSERT [dbo].[Semester] ([semID], [semName], [semStartDate], [semFinishDate]) VALUES (2, N'2', CAST(N'2021-07-12' AS Date), CAST(N'2021-11-29' AS Date))
SET IDENTITY_INSERT [dbo].[Semester] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([studID], [firstName], [lastName], [addressFK], [mobNum], [sex], [emailUsername], [password]) VALUES (1003, N'Julie', N'Lam', 1005, N'402999888 ', N'Male', N'Julie.Lam1003@tafe.com', N'1234')
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Subject] ON 

INSERT [dbo].[Subject] ([subID], [subName]) VALUES (1, N'Advanced C#')
INSERT [dbo].[Subject] ([subID], [subName]) VALUES (2, N'Advanced Java')
SET IDENTITY_INSERT [dbo].[Subject] OFF
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([teacherID], [firstName], [lastName], [addressFK], [mobNum], [sex], [emailUsername], [password]) VALUES (1, N'John', N'Best', 1006, N'405123123 ', N'Male', N'John.Best1@tafe.com', N'1234')
SET IDENTITY_INSERT [dbo].[Teacher] OFF
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
/****** Object:  StoredProcedure [dbo].[sp_EnrolledStudentsByCourseID]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getCourseLocations]    Script Date: 30/05/2021 10:51:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getCourseLocations] @varCourseID int
AS
SELECT courseFK, adrs.houseNum, adrs.suburb, adrs.streetName, adrs.suburb, adrs.postcode, crsLoc.contactNum   
FROM CourseLocation crsLoc
INNER JOIN Address adrs ON crsLoc.addressFK = adrs.addressID 
WHERE courseFK = @varCourseID
GO
/****** Object:  StoredProcedure [dbo].[sp_getCourseSem]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getCourseSubjects]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getRecentStudID]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getRecentTeacherID]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertAStudent]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertATeacher]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateStudentAfterSP]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateStudentEmailAfterSP]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateTeacherAfterSP]    Script Date: 30/05/2021 10:51:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateTeacherEmailAfterSP]    Script Date: 30/05/2021 10:51:12 AM ******/
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
USE [master]
GO
ALTER DATABASE [TafeMoodle] SET  READ_WRITE 
GO
