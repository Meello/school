drop trigger TriggerDelete_Teacher_ChangeHistory
go
CREATE TRIGGER TriggerDelete_Teacher_ChangeHistory
ON [Teacher]
AFTER DELETE AS
BEGIN
	INSERT 	INTO [ChangeHistory] (
			ChangeOperationType,
			TrackedEntityId,
			TrackedEntityRecordId,
			[Description]
		)
	SELECT
			'D',
			2,
			D.TeacherId,
			'The teacher ' + CAST((D.TeacherId) AS VARCHAR(MAX))+ ' was deleted'
	FROM
		DELETED D
		-- Tabela deleted é criada temporariamente pelo sistema para guardar os valores deletados
END
GO

SELECT * FROM Teacher

SELECT * FROM [ChangeHistory]
