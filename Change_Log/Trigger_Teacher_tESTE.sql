IF OBJECT_ID('Trigger_Teacher') IS NOT NULL  
    DROP TRIGGER Trigger_Teacher;  
GO
CREATE TRIGGER Trigger_Teacher 
ON [Teacher]
AFTER INSERT, DELETE, UPDATE AS
BEGIN
	DECLARE @ChangeOperationType char
	DECLARE @TrackedEntityId INT = 2
	DECLARE @TrackedEntityRecordId varchar(max)
	DECLARE @Description varchar(max)
	DECLARE @ChangeDateUTC datetime2
	DECLARE @T_ChangeHistoryId varchar(max)
	DECLARE @TeacherId varchar(max)
	
	DECLARE @ChangeHistoryId varchar(max)
	DECLARE @PropertyName varchar(20)
	DECLARE @PreviousValue varchar(max)
	DECLARE @NewValue varchar(max)
	/*
	DECLARE @Previous_Name varchar(20)
	DECLARE @Previous_LevelId char(1)
	DECLARE @Previous_Salary decimal(10,2)
	DECLARE @Previous_AdmitionDate date

	DECLARE @New_Name varchar(20)
	DECLARE @New_LevelId char(1)
	DECLARE @New_Salary decimal(10,2)
	DECLARE @New_AdmitionDate date
	*/
	SET @ChangeDateUTC = GETUTCDATE()	
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
		SET @Description = CONCAT('The teacher ',@TrackedEntityRecordId,' was updated')
	END
	ELSE
	BEGIN
		IF (EXISTS(SELECT 1 FROM INSERTED))
		BEGIN
			SELECT @TrackedEntityRecordId = TeacherId
			FROM INSERTED
			SET @ChangeOperationType = 'I'
			SET @Description = CONCAT('The teacher ',@TrackedEntityRecordId,' was created')
		END
		IF (EXISTS (SELECT 1 FROM DELETED)) 
		BEGIN
			SELECT @TrackedEntityRecordId = TeacherId
			FROM DELETED
			SET @ChangeOperationType = 'D'
			SET @Description = CONCAT('The teacher ',@TrackedEntityRecordId,' was deleted')
		END
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
			@TeacherId = TeacherId
		FROM INSERTED

		IF UPDATE(Name)
		BEGIN
			SELECT @NewValue = Name FROM INSERTED
			SELECT @PreviousValue = Name FROM DELETED
			SET @PropertyName = 'Name'
			EXEC Procedure_ChangeHistoryDetail
				@ChangeHistoryId,
				@PropertyName,
				@PreviousValue,
				@NewValue
		END

		IF UPDATE(LevelId)
		BEGIN
			SELECT @NewValue = LevelId FROM INSERTED
			SELECT @PreviousValue = LevelId FROM DELETED
			SET @PropertyName = 'LevelId'
			EXEC Procedure_ChangeHistoryDetail
				@ChangeHistoryId,
				@PropertyName,
				@PreviousValue,
				@NewValue
		END

		IF UPDATE(Salary)
		BEGIN
			SELECT @NewValue = Salary FROM INSERTED
			SELECT @PreviousValue = Salary FROM DELETED
			SET @PropertyName = 'Salary'
			EXEC Procedure_ChangeHistoryDetail
				@ChangeHistoryId,
				@PropertyName,
				@PreviousValue,
				@NewValue
		END

		IF UPDATE(AdmitionDate)
		BEGIN
			SELECT @NewValue = AdmitionDate FROM INSERTED
			SELECT @PreviousValue = AdmitionDate FROM DELETED
			SET @PropertyName = 'AdmitionDate'
			EXEC Procedure_ChangeHistoryDetail
				@ChangeHistoryId,
				@PropertyName,
				@PreviousValue,
				@NewValue
		END
/*
		SELECT 
			@TeacherId = TeacherId,
			@New_Name = Name,
			@New_LevelId = LevelId,
			@New_Salary = Salary,
			@New_AdmitionDate = AdmitionDate
		FROM INSERTED
		SELECT 
			@Previous_Name = Name,
			@Previous_LevelId = LevelId,
			@Previous_Salary = Salary,
			@Previous_AdmitionDate = AdmitionDate
		FROM DELETED
		SET @ChangeHistoryId = @T_ChangeHistoryId
		
		IF(@Previous_Name <> @New_Name) 
		BEGIN
			SET @PropertyName = 'Name'
			SET @PreviousValue = @Previous_Name
			SET @NewValue = @New_Name
			EXEC Procedure_ChangeHistoryDetail
				@ChangeHistoryId,
				@PropertyName,
				@PreviousValue,
				@NewValue
		END
		IF(@Previous_LevelId <> @New_LevelId) 
		BEGIN
			SET @PropertyName = 'LevelId'
			SET @PreviousValue = @Previous_LevelId
			SET @NewValue = @New_LevelId
			EXEC Procedure_ChangeHistoryDetail
				@ChangeHistoryId,
				@PropertyName,
				@PreviousValue,
				@NewValue
		END
		IF(@Previous_Salary <> @New_Salary) 
		BEGIN
			SET @PropertyName = 'Salary'
			SET @PreviousValue = @Previous_Salary
			SET @NewValue = @New_Salary
			EXEC Procedure_ChangeHistoryDetail
				@ChangeHistoryId,
				@PropertyName,
				@PreviousValue,
				@NewValue
		END
		IF(@Previous_AdmitionDate <> @New_AdmitionDate) 
		BEGIN
			SET @PropertyName = 'AdmitionDate'
			SET @PreviousValue = @Previous_AdmitionDate
			SET @NewValue = @New_AdmitionDate
			EXEC Procedure_ChangeHistoryDetail
				@ChangeHistoryId,
				@PropertyName,
				@PreviousValue,
				@NewValue
		END
	END
	*/
	PRINT @T_ChangeHistoryId
END
GO