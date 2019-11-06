CREATE TABLE [Profile] 
(
	ProfileId tinyint not null,
	Name varchar(20) not null,
	CONSTRAINT PK_Profile PRIMARY KEY(ProfileId)
);

CREATE TABLE [Level] 
(
	LevelId char(1) not null,
	Name varchar(10) not null,
	CONSTRAINT PK_Level PRIMARY KEY(LevelId)
);

CREATE TABLE [Teacher]
(
	TeacherId bigint not null,
	Name varchar(20) not null,
	Gender char(1) not null,
	LevelId char(1) not null,
	Salary smallmoney not null,
	AdmitionDate date not null,
	CONSTRAINT PK_Teachers PRIMARY KEY(TeacherId),
	CONSTRAINT FK_LevelTeachers FOREIGN KEY (LevelId)
	REFERENCES [Level](LevelID)
);

CREATE TABLE [Student]
(
	CPF bigint not null,
	Name varchar(20) not null,
	Gender char(1) not null,
	BornDate date not null,
	City varchar(20) not null,
	RegisterDate datetime not null,
	Active char(3) not null,
	CONSTRAINT PK_Student PRIMARY KEY(CPF)
);

CREATE TABLE [TeacherProfile]
(
	TeacherId bigint not null,
	ProfileId tinyint not null,
	CONSTRAINT PK_TP PRIMARY KEY(TeacherId,ProfileId),
	CONSTRAINT FK_ProfilesTeachers FOREIGN KEY(ProfileId)
	REFERENCES [Profiles](ProfileId),
	CONSTRAINT FK_TeachersProfiles FOREIGN KEY (TeacherId)
	REFERENCES [Teachers](TeacherID)
);

CREATE TABLE [InformationArea]
(
	AreaId smallint not null,
	Name varchar(20) not null,
	CONSTRAINT PK_InformationArea PRIMARY KEY(AreaId)
);

CREATE TABLE [Course]
(
	CourseId tinyint not null identity(1,1),
	AreaId smallint not null,
	Name varchar(30) not null,
	Workload smallint not null,
	CONSTRAINT PK_Course PRIMARY KEY(CourseId),
	CONSTRAINT FK_AreaCourse FOREIGN KEY (AreaId)
	REFERENCES [InformationArea](AreaId)
);

CREATE TABLE [Class]
(
	ClassId tinyint not null identity(10,10),
	Local varchar(40),
	CourseId tinyint not null,
	TeacherId bigint not null,
	[Shift] char(1) not null,
	BeginningDate date not null,
	EndDate date not null,
	BeginnigTime datetime not null,
	EndTime datetime not null,
	CONSTRAINT PK_Class PRIMARY KEY(ClassId),
	CONSTRAINT FK_TeachersClass FOREIGN KEY (TeacherId)
	REFERENCES [Teachers](TeacherId),
	CONSTRAINT FK_CourseClass FOREIGN KEY (CourseId)
	REFERENCES [Course](CourseId)
);

CREATE TABLE [Subscription]
(
	StudentId bigint not null,
	ClassId tinyint not null,
	CONSTRAINT PK_Sub PRIMARY KEY(StudentId,ClassId),
	CONSTRAINT FK_StudentClass FOREIGN KEY(StudentId)
	REFERENCES [Student](CPF),
	CONSTRAINT FK_ClassStudent FOREIGN KEY (ClassId)
	REFERENCES [Class](ClassId)
);

ALTER TABLE [Teachers]
ADD CONSTRAINT Check_GenderTeacher CHECK (Gender = 'M' OR Gender = 'F');

ALTER TABLE [Student]
ADD CONSTRAINT Check_GenderStudent CHECK (Gender = 'M' OR Gender = 'F');

ALTER TABLE [Class]
ADD CONSTRAINT Check_Shift CHECK ([Shift] = 'M' OR [Shift] = 'T' OR [Shift] = 'N');
