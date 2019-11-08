CREATE TABLE [Profile] 
(
	ProfileId tinyint not null,
	Name varchar(20) not null,
	CONSTRAINT PK_Profile PRIMARY KEY(ProfileId),
	CONSTRAINT UN_Profile_Name UNIQUE(Name)
);

CREATE TABLE [Level] 
(
	LevelId char(1) not null,
	Name varchar(10) not null,
	CONSTRAINT PK_Level PRIMARY KEY(LevelId),
	CONSTRAINT UN_Level_Name UNIQUE(Name)
);

CREATE TABLE [Teacher]
(
	TeacherId bigint not null,
	Name varchar(20) not null,
	Gender char(1) not null,
	LevelId char(1) not null,
	Salary decimal(10,2) not null,
	AdmitionDate date not null,
	CONSTRAINT PK_Teachers PRIMARY KEY(TeacherId),
	CONSTRAINT FK_Teacher_Level FOREIGN KEY (LevelId)
	REFERENCES [Level],
	CONSTRAINT CK_Teacher_Gender CHECK (Gender IN ('M','F'))
);

CREATE TABLE [Student]
(
	StudentId bigint not null,   /*StudentId = CPF*/
	Name varchar(20) not null,
	Gender char(1) not null,
	BirthDate date not null,
	City varchar(20) not null,
	CreatedAt datetime2 not null,
/*
	DateTime
	From January 1, 1753 to December 31, 9999 with an accuracy of 3.33 milliseconds
	DateTime2
	From January 1, 0001 to December 31, 9999 with an accuracy of 100 nanoseconds
*/
	Active bit not null,
	CONSTRAINT PK_Student PRIMARY KEY(StudentId),
	CONSTRAINT CK_Student_Gender CHECK (Gender IN('M','F'))
);

CREATE TABLE [TeacherProfile]
(
	TeacherId bigint not null,
	ProfileId tinyint not null,
	CONSTRAINT PK_TeacherProfile PRIMARY KEY(TeacherId,ProfileId),
	CONSTRAINT FK_TeacherProfile_Profile FOREIGN KEY(ProfileId)
	REFERENCES [Profile],
	CONSTRAINT FK_TeacherProfile_Teacher FOREIGN KEY (TeacherId)
	REFERENCES [Teacher]
);

CREATE TABLE [InformationArea]
(
	AreaId smallint not null,
	Name varchar(20) not null,
	CONSTRAINT PK_InformationArea PRIMARY KEY(AreaId),
	CONSTRAINT UN_InformationArea_Name UNIQUE(Name)
);

CREATE TABLE [Course]
(
	CourseId tinyint not null identity(1,1),
	AreaId smallint not null,
	Name varchar(30) not null,
	Workload smallint not null,
	CONSTRAINT PK_Course PRIMARY KEY(CourseId),
	CONSTRAINT FK_Course_InformationArea FOREIGN KEY (AreaId)
	REFERENCES [InformationArea]
);

CREATE TABLE [Class]
(
	ClassId tinyint not null identity(10,10),
	Local varchar(40),
	CourseId tinyint not null,
	TeacherId bigint not null,
	[Shift] char(1) not null,
	StartDate date not null,
	EndDate date not null,
	StartTime time not null,
	EndTime time not null,
	CONSTRAINT PK_Class PRIMARY KEY(ClassId),
	CONSTRAINT FK_Class_Teacher FOREIGN KEY (TeacherId)
	REFERENCES [Teacher],
	CONSTRAINT FK_Class_Course FOREIGN KEY (CourseId)
	REFERENCES [Course],
	CONSTRAINT CK_Class_Shift CHECK ([Shift] IN ('M','T','N')),
	CONSTRAINT CK_StartDate_EndDate CHECK (StartDate < EndDate),
	CONSTRAINT CK_StartTime_EndTime CHECK (StartTime < EndTime)
/*
	Testar o check
*/
	
);

CREATE TABLE [Subscription]
(
	StudentId bigint not null,
	ClassId tinyint not null,
	CONSTRAINT PK_Sub PRIMARY KEY(StudentId,ClassId),
	CONSTRAINT FK_Subscription_Student FOREIGN KEY(StudentId)
	REFERENCES [Student],
	CONSTRAINT FK_Subscription_Class FOREIGN KEY (ClassId)
	REFERENCES [Class]
);

SELECT * FROM [Student];