/*
-- Criando a tabela com a mesma estrutura da original, mas adicionando colunas de controle
IF (OBJECT_ID('Testes.dbo.Cliente_Log') IS NOT NULL) DROP TABLE Testes.dbo.Cliente_Log
CREATE TABLE Testes.dbo.Cliente_Log (
    Id INT IDENTITY(1, 1),
    Dt_Atualizacao DATETIME DEFAULT GETDATE(),
    [Login] VARCHAR(100),
    Hostname VARCHAR(100),
    Operacao VARCHAR(20),

    -- Dados da tabela original
    Id_Cliente INT,
    Nome VARCHAR(100),
    Data_Nascimento DATETIME,
    Salario FLOAT
)
GO
IF ((SELECT COUNT(*) FROM sys.triggers WHERE name = 'trgHistorico_Cliente' AND parent_id = OBJECT_ID('Testes.dbo.Cliente')) > 0) DROP TRIGGER trgHistorico_Cliente
GO
CREATE TRIGGER trgHistorico_Cliente ON Testes.dbo.Cliente -- Tabela que a trigger será associada
AFTER INSERT, UPDATE, DELETE AS
BEGIN
   SET NOCOUNT ON
    DECLARE 
        @Login VARCHAR(100) = SYSTEM_USER, 
        @HostName VARCHAR(100) = HOST_NAME(),
        @Data DATETIME = GETDATE()  
    IF (EXISTS(SELECT * FROM Inserted) AND EXISTS (SELECT * FROM Deleted))
    BEGIN     
        INSERT INTO Testes.dbo.Cliente_Log
        SELECT @Data, @Login, @HostName, 'UPDATE', *
        FROM Inserted
    END
    ELSE BEGIN
        IF (EXISTS(SELECT * FROM Inserted))
        BEGIN
            INSERT INTO Testes.dbo.Cliente_Log
            SELECT @Data, @Login, @HostName, 'INSERT', *
            FROM Inserted
        END
        ELSE BEGIN
            INSERT INTO Testes.dbo.Cliente_Log
            SELECT @Data, @Login, @HostName, 'DELETE', *
            FROM Deleted
        END
	END
END
GO
*/

USE school;
GO
IF OBJECT_ID('Procedure_Insert_ChangeHIstory','P') IS NOT NULL
-- Procedimento armazenado SQL --> P
	DROP PROCEDURE Procedure_Insert_ChangeHistory;
GO
CREATE PROCEDURE Procedure_Insert_ChangeHistory
@ChangeHistoryId_Update UNIQUEIDENTIFIER OUTPUT
AS
	SET NOCOUNT ON;
	IF (EXISTS(SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED))
		BEGIN     
			INSERT 	INTO [ChangeHistory]
			(
				ChangeOperationType,
				TrackedEntityId,
				TrackedEntityRecordId,
				[Description]
			)
			SELECT
				'I',
				2,
				I.TeacherId,
				'The teacher ' + CAST((I.TeacherId) AS VARCHAR(MAX))+ ' was updated'
			FROM
				INSERTED I
			SELECT ChangeHistoryId_Update = ChangeHistoryId
			FROM [ChangeHistory]
		END
	ELSE BEGIN
		IF (EXISTS(SELECT * FROM INSERTED))
			BEGIN
				INSERT 	INTO [ChangeHistory]
				(
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
				SELECT ChangeHistoryId_Update = ChangeHistoryId
				FROM [ChangeHistory]
			END
		ELSE BEGIN
			INSERT 	INTO [ChangeHistory]
			(
				ChangeOperationType,
				TrackedEntityId,
				TrackedEntityRecordId,
				[Description]
			)
			SELECT
				'I',
				2,
				D.TeacherId,
				'The teacher ' + CAST((D.TeacherId) AS VARCHAR(MAX))+ ' was deleted'
			FROM
				INSERTED D
			SELECT ChangeHistoryId_Update = ChangeHistoryId
			FROM [ChangeHistory]
		END
	END
RETURN