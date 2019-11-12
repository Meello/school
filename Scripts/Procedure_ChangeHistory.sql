USE school;  
GO  
IF OBJECT_ID('Procedure_ChangeHistory', 'P') IS NOT NULL  
    DROP PROCEDURE Procedure_ChangeHistory;  
GO  
CREATE PROCEDURE Procedure_ChangeHistory  
@ChangeOperationType char, 
@TrackedEntityId tinyint,
@TrackedEntityRecordId bigint,
@Description varchar(max),
@ChangeDateUTC datetime2,
@ChangeHistoryId varchar(max) OUTPUT  
AS    
    SET NOCOUNT ON;  
	IF	
	@ChangeOperationType IS NOT NULL
	AND @TrackedEntityId IS NOT NULL
	AND @TrackedEntityRecordId IS NOT NULL
	AND @Description IS NOT NULL
	BEGIN
		INSERT 	INTO [ChangeHistory]
		(
			ChangeOperationType,
			TrackedEntityId,
			TrackedEntityRecordId,
			Description,
			ChangeDateUTC
		)
		SELECT
			@ChangeOperationType,
			@TrackedEntityId,
			@TrackedEntityRecordId,
			@Description,
			@ChangeDateUTC
	END	
	SELECT @ChangeHistoryId = ChangeHistoryId  
    FROM [ChangeHistory]
    WHERE ChangeDateUTC = @ChangeDateUTC
RETURN  
GO  