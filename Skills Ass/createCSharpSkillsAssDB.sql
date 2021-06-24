create DATABASE cSharpSkillsDB

create TABLE Course (
	Courseid smallint NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	Coursename varchar(40) NOT NULL,
	Courseduration smallint NOT NULL, 
)

create TABLE Unit (
	Unitid smallint NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	Unitname varchar(40) NOT NULL, 
	Unitduration smallint NOT NULL
)

CREATE TABLE CourseUnit (
	CourseFK smallint NOT NULL, 
	UnitFK smallint NOT NULL, 
	PRIMARY KEY (CourseFK, UnitFK), 
	FOREIGN KEY (CourseFK) REFERENCES Course(Courseid), 
	FOREIGN KEY (UnitFK) REFERENCES Unit(Unitid)
)

SELECT * FROM Course