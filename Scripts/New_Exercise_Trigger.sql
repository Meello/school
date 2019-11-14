/*
--> GUID (NewId)
	NOME_DA_COLUNA UNIQUEIDENTIFIER DEFAULT NEWID()

--> Trigger
	CREATE TRIGGER [NOME DO TRIGGER]
	ON [NOME DA TABELA]
	[FOR/AFTER/INSTEAD OF] [INSERT/UPDATE/DELETE]
	AS
	    --CORPO DO TRIGGER
	-->Exemplo
	CREATE TRIGGER TGR_VENDAS_AI
	ON VENDAS
	FOR INSERT
	AS
	BEGIN
	    DECLARE
	    @VALOR  DECIMAL(10,2),
	    @DATA   DATETIME
	 
	    SELECT @DATA = DATA, @VALOR = VALOR FROM INSERTED
	 
	    UPDATE CAIXA SET SALDO_FINAL = SALDO_FINAL + @VALOR
	    WHERE DATA = @DATA
	END
	GO
*/

CREATE TABLE [TrackedEntity]
(
	TrackedEntityId tinyint not null,
	Name char(10) not null,
	CONSTRAINT PK_TrackedEntity PRIMARY KEY(TrackedEntityId)
);
INSERT INTO
	[TrackedEntity]
	(
		TrackedEntityId,
		Name
	)
VALUES
(1,'Course'),
(2,'Teacher'),
(3,'Student'),
(4,'Class');

CREATE TABLE [ChangeHistory]
(
	ChangeHistoryId UNIQUEIDENTIFIER NEWID(),
	[User] nchar(50) DEFAULT SYSTEM_USER,
	/*
		Por que com DEFAULT funciona e sem, não?
	*/
	ChangeOperationType char(1) not null,
	TrackedEntityId tinyint not null,
	TrackedEntityRecordId bigint not null,
	Description varchar(max) not null,
	ChangeDateUTC datetime2 not null,
	CONSTRAINT CK_ChangeHistory_ChangeOperationType CHECK(ChangeOperationType IN ('I','U','D')),
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

INSERT INTO [Teacher]
VALUES
(13843917701,'Bruno','M','S',2500,'2000-01-29');

UPDATE [Teacher]
	SET Name = 'Bruno M',
		Salary = 3000,
		AdmitionDate = '2019-10-10'
	WHERE TeacherId = 13843917701;

DELETE [Teacher]
WHERE [Teacher].Name = 'Bruno M';

DELETE [ChangeHistory]

SELECT * FROM [ChangeHistory]
ORDER BY ChangeDateUTC DESC;

SELECT * FROM [ChangeHistoryDetail]

DROP TABLE [ChangeHistoryDetail];
-- Verificar triggers
select * from sys.triggers; 
DROP TRIGGER TriggerInsert_Teacher_ChangeHistory;

