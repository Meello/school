 IF OBJECT_ID('Trigger_Teacher') IS NOT NULL  
    DROP TRIGGER Trigger_Teacher;  
GO
CREATE TRIGGER Trigger_Teacher 
ON [Teacher]
AFTER INSERT, DELETE, UPDATE AS
BEGIN
	-- Declare the variable to receive the output value of the procedure.  
	DECLARE @Trigger_ChangeOperationType char
	DECLARE @Trigger_TrackedEntityId tinyint = 2
	DECLARE @Trigger_TrackedEntityRecordId bigint
	DECLARE @Trigger_Description varchar(max)
	DECLARE @Trigger_ChangeDateUTC datetime2
	DECLARE @Trigger_ChangeHistoryId varchar(max)

	IF (EXISTS(SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED))
		BEGIN     
			SELECT @Trigger_TrackedEntityRecordId = TeacherId
			FROM INSERTED
			SET @Trigger_ChangeOperationType = 'U'
			SET @Trigger_Description = 'The teacher ' + CAST(@Trigger_TrackedEntityRecordId AS VARCHAR(MAX)) + ' was updated'
			SET @Trigger_ChangeDateUTC = GETUTCDATE()
			SELECT *
			FROM DELETED
		END
	ELSE BEGIN
		IF (EXISTS(SELECT * FROM INSERTED))
			BEGIN
				SELECT @Trigger_TrackedEntityRecordId = TeacherId
				FROM INSERTED
				SET @Trigger_ChangeOperationType = 'I'
				SET @Trigger_Description = 'The teacher ' + CAST(@Trigger_TrackedEntityRecordId AS VARCHAR(MAX)) + ' was created'
				SET @Trigger_ChangeDateUTC = GETUTCDATE()
			END
		ELSE BEGIN
			SELECT @Trigger_TrackedEntityRecordId = TeacherId
			FROM DELETED
			SET @Trigger_ChangeOperationType = 'D'
			SET @Trigger_Description = 'The teacher ' + CAST(@Trigger_TrackedEntityRecordId AS VARCHAR(MAX)) + ' was deleted'
			SET @Trigger_ChangeDateUTC = GETUTCDATE()
		END
	END
	EXEC Procedure_ChangeHistory 
		@Trigger_ChangeOperationType,
		@Trigger_TrackedEntityId,
		@Trigger_TrackedEntityRecordId,
		@Trigger_Description,
		@Trigger_ChangeDateUTC,
		@ChangeHistoryId = @Trigger_ChangeHistoryId OUTPUT
	PRINT @Trigger_ChangeHistoryId
END
GO  

