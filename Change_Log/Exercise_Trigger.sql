CREATE TABLE [TrackedEntity]
(
	TrackedEntityId tinyint not null identity(1,1),
	Name char(10) not null,
	CONSTRAINT PK_TrackedEntity PRIMARY KEY(TrackedEntityId)
);
INSERT INTO
	[TrackedEntity]
	(Name)
VALUES
('Course'),
('Teacher'),
('Student'),
('Class');

CREATE TABLE [ChangeHistory]
(
	ChangeHistoryId UNIQUEIDENTIFIER DEFAULT NEWID(),
	[User] nchar(50) DEFAULT SYSTEM_USER,
	/*
		Por que com DEFAULT funciona e sem, não?
	*/
	ChangeOperationType char not null,
	TrackedEntityId tinyint not null,
	TrackedEntityRecordId bigint not null,
	Description varchar(max) not null,
	ChangeDateUTC datetime2 not null,
	CONSTRAINT PK_ChangeHistory PRIMARY KEY(ChangeHistoryId),
	CONSTRAINT FK_ChangeHistory_TrackedEntity FOREIGN KEY(TrackedEntityId)
	REFERENCES [TrackedEntity]
);

CREATE TABLE [ChangeHistoryDetail]
(
	ChangeHistoryDetailId tinyint not null identity(1,1),
	ChangeHistoryId UNIQUEIDENTIFIER,
	PropertyName char(100) not null,
	PreviousValue varchar(MAX) not null,
	NewValue varchar(MAX) not null,
	CONSTRAINT FK_ChangeHistoryDetail_ChangeHistory FOREIGN KEY(ChangeHistoryId)
	REFERENCES [ChangeHistory]
);