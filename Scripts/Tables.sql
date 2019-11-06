CREATE TABLE [Profile] 
(
	ProfileId tinyint not null,
	Name varchar(20) not null,
	CONSTRAINT PK_Profile PRIMARY KEY(ProfileId),
	CONSTRAINT UC_ProfileName UNIQUE(Name)
);

CREATE TABLE [Level] 
(
	LevelId char(1) not null,
	Name varchar(10) not null,
	CONSTRAINT PK_Level PRIMARY KEY(LevelId),
	CONSTRAINT UC_LevelName UNIQUE(Name)
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
	CONSTRAINT FK_TeacherLevel FOREIGN KEY (LevelId)
	REFERENCES [Level],
	CONSTRAINT Check_GenderTeacher CHECK (Gender IN ('M','F'))
);

CREATE TABLE [Student]
(
	StudentId bigint not null,   /*StudentId = CPF*/
	Name varchar(20) not null,
	Gender char(1) not null,
	BirthDate date not null,
	City varchar(20) not null,
	CreatedAt datetime not null,
	Active char(3) not null,
	CONSTRAINT PK_Student PRIMARY KEY(StudentId),
	CONSTRAINT Check_GenderStudent CHECK (Gender IN('M','F'))
);

CREATE TABLE [TeacherProfile]
(
	TeacherId bigint not null,
	ProfileId tinyint not null,
	CONSTRAINT PK_TeacherProfile PRIMARY KEY(TeacherId,ProfileId),
	CONSTRAINT FK_TeacherProfileProfile FOREIGN KEY(ProfileId)
	REFERENCES [Profile],
	CONSTRAINT FK_TeacherProfileTeacher FOREIGN KEY (TeacherId)
	REFERENCES [Teacher]
);

CREATE TABLE [InformationArea]
(
	AreaId smallint not null,
	Name varchar(20) not null,
	CONSTRAINT PK_InformationArea PRIMARY KEY(AreaId),
	CONSTRAINT UC_InformationAreaName UNIQUE(Name)
);

CREATE TABLE [Course]
(
	CourseId tinyint not null identity(1,1),
	AreaId smallint not null,
	Name varchar(30) not null,
	Workload smallint not null,
	CONSTRAINT PK_Course PRIMARY KEY(CourseId),
	CONSTRAINT FK_CourseArea FOREIGN KEY (AreaId)
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
	CONSTRAINT FK_ClassTeacher FOREIGN KEY (TeacherId)
	REFERENCES [Teacher],
	CONSTRAINT FK_ClassCourse FOREIGN KEY (CourseId)
	REFERENCES [Course],
	CONSTRAINT Check_Shift CHECK ([Shift] IN ('M','T','N'))

);

CREATE TABLE [Subscription]
(
	StudentId bigint not null,
	ClassId tinyint not null,
	CONSTRAINT PK_Sub PRIMARY KEY(StudentId,ClassId),
	CONSTRAINT FK_SubscriptionStudent FOREIGN KEY(StudentId)
	REFERENCES [Student],
	CONSTRAINT FK_SubscriptionClass FOREIGN KEY (ClassId)
	REFERENCES [Class]
);