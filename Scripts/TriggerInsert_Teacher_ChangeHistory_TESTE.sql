/*
	create trigger tr_exemplo1 for TABELA1 after insert as
	-- CORRETO � ON, N�O FOR
	begin
	insert into TABELA2 (Campo1, Campo2)
	values (new.CampoA, new.CampoB);
	end^
	
	
	onde ::
	
	Campo1 e Campo2 s�o campos da TABELA2
	CampoA e CampoB s�o campos da TABELA1
*/

drop trigger TriggerInsert_Teacher_ChangeHistory
go
CREATE TRIGGER TriggerInsert_Teacher_ChangeHistory
ON [Teacher]
AFTER INSERT AS
BEGIN
	INSERT 	INTO [ChangeHistory] (
			ChangeOperationType,
			TrackedEntityId,
			TrackedEntityRecordId,
			[Description]
		)
	SELECT
			'I',
			2,
			I.TeacherId,
			'The teacher ' + CAST((I.TeacherId) AS VARCHAR(MAX))+ ' was created'
	FROM
		INSERTED I
		-- Tabela inserted � criada temporariamente pelo sistema para guardar os valores inseridos
		-- Evitar de usar v�rios SELECT
END
GO

SELECT * FROM Teacher

SELECT * FROM [ChangeHistory]
