 IF OBJECT_ID('Trigger_Teacher') IS NOT NULL  
    DROP TRIGGER Trigger_Teacher;  
GO
CREATE TRIGGER Trigger_Teacher 
ON [Teacher]
AFTER INSERT, DELETE, UPDATE AS
BEGIN
	DECLARE @ChangeOperationType char
	DECLARE @TrackedEntityId tinyint = 2
	DECLARE @TrackedEntityRecordId bigint
	DECLARE @Description varchar(max)
	DECLARE @ChangeDateUTC datetime2
	DECLARE @T_ChangeHistoryId varchar(max)

	DECLARE @Previous_TeacherId bigint
	DECLARE @Previous_Name varchar(20)
	DECLARE @Previous_LevelId char(1)
	DECLARE @Previous_Salary decimal(10,2)
	DECLARE @Previous_AdmitionDate date

	DECLARE @New_TeacherId bigint
	DECLARE @New_Name varchar(20)
	DECLARE @New_LevelId char(1)
	DECLARE @New_Salary decimal(10,2)
	DECLARE @New_AdmitionDate date

	IF (
		EXISTS(SELECT 1 FROM INSERTED)
		AND EXISTS (SELECT 1 FROM DELETED)
		AND NOT EXISTS
			(	
			SELECT * FROM INSERTED
			INTERSECT
			SELECT * FROM DELETED
			)
		)
	BEGIN     
		SELECT @TrackedEntityRecordId = TeacherId
		FROM INSERTED
		SET @ChangeOperationType = 'U'
		SET @Description = 'The teacher ' + CAST(@TrackedEntityRecordId AS VARCHAR(MAX)) + ' was updated'
		SET @ChangeDateUTC = GETUTCDATE()
	END
	IF (EXISTS(SELECT 1 FROM INSERTED) AND NOT EXISTS(SELECT 1 FROM DELETED))
	BEGIN
		SELECT @TrackedEntityRecordId = TeacherId
		FROM INSERTED
		SET @ChangeOperationType = 'I'
		SET @Description = 'The teacher ' + CAST(@TrackedEntityRecordId AS VARCHAR(MAX)) + ' was created'
		SET @ChangeDateUTC = GETUTCDATE()
	END
	IF (EXISTS (SELECT 1 FROM DELETED) AND NOT EXISTS(SELECT 1 FROM INSERTED)) 
	BEGIN
		SELECT @TrackedEntityRecordId = TeacherId
		FROM DELETED
		SET @ChangeOperationType = 'D'
		SET @Description = 'The teacher ' + CAST(@TrackedEntityRecordId AS VARCHAR(MAX)) + ' was deleted'
		SET @ChangeDateUTC = GETUTCDATE()
	END
	EXEC Procedure_ChangeHistory 
		@ChangeOperationType,
		@TrackedEntityId,
		@TrackedEntityRecordId,
		@Description,
		@ChangeDateUTC,
		@ChangeHistoryId = @T_ChangeHistoryId OUTPUT
	
	IF (@ChangeOperationType = 'U')
	BEGIN	
		SELECT 
			@New_TeacherId = TeacherId,
			@New_Name = Name,
			@New_LevelId = LevelId,
			@New_Salary = Salary,
			@New_AdmitionDate = AdmitionDate
		FROM INSERTED
		SELECT 
			@Previous_TeacherId = TeacherId,
			@Previous_Name = Name,
			@Previous_LevelId = LevelId,
			@Previous_Salary = Salary,
			@Previous_AdmitionDate = AdmitionDate
		FROM DELETED
	END
	EXEC Procedure_ChangeHistoryDetail
		@Previous_TeacherId,
		@Previous_Name,
		@Previous_LevelId, 
		@Previous_Salary, 
		@Previous_AdmitionDate,
		@New_TeacherId, 
		@New_Name, 
		@New_LevelId,
		@New_Salary,
		@New_AdmitionDate,
		@T_ChangeHistoryId
	PRINT @T_ChangeHistoryId
END
GO