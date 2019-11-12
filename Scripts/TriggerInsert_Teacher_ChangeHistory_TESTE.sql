/*
	create trigger tr_exemplo1 for TABELA1 after insert as
	-- CORRETO É ON, NÃO FOR
	begin
	insert into TABELA2 (Campo1, Campo2)
	values (new.CampoA, new.CampoB);
	end^
	
	
	onde ::
	
	Campo1 e Campo2 são campos da TABELA2
	CampoA e CampoB são campos da TABELA1
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
		-- Tabela inserted é criada temporariamente pelo sistema para guardar os valores inseridos
		-- Evitar de usar vários SELECT
END
GO

SELECT * FROM Teacher

SELECT * FROM [ChangeHistory]
