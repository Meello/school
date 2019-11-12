/*
-- CRIANDO A ENTIDADE EMPRESA
CREATE TABLE Empresa
(
	Cd_Empresa INT IDENTITY(1,1)
	,NoEmpresa VARCHAR(30)
	,DaCadastro DATETIME
	DEFAULT(GETDATE())
)
GO

-- CRIANDO A ENTIDADE EMPRESA
CREATE TABLE Cad_Alteracoes
(
	Cod_Item_Origem INT
	,Dt_Alt_Cadastro_Origem DATETIME
	,Cod_Cad_Status_Import BIT
	,Cod_Cad_Tabelas INT
)
GO

-- CRIANDO A TRIGGER
CREATE TRIGGER Tb_Alteracoes
ON Empresa
AFTER UPDATE
AS
	BEGIN
		SET NOCOUNT ON
		INSERT INTO Cad_Alteracoes(Cod_Item_Origem, Dt_Alt_Cadastro_Origem, Cod_Cad_Status_Import, Cod_Cad_Tabelas)
		SELECT Cd_Empresa, GETDATE(), 0, 39
		FROM INSERTED   
	END
GO

-- INSERINDO DADOS
INSERT INTO Empresa( NoEmpresa)
VALUES('Parmalat')
GO

-- ATUALIZADO REGISTRO
UPDATE Empresa
SET NoEmpresa = 'Microsoft'
WHERE Cd_Empresa = 1
GO

-- CONSULTA
SELECT * FROM Cad_Alteracoes
*/

drop trigger TriggerUpdate_Teacher_ChangeHistory
go
CREATE TRIGGER TriggerUpdate_Teacher_ChangeHistory
ON [Teacher]
AFTER UPDATE AS
BEGIN
	INSERT 	INTO [ChangeHistory]
		(
			ChangeOperationType,
			TrackedEntityId,
			TrackedEntityRecordId,
			[Description]
		)
	SELECT
		'U',
		2,
		I.TeacherId,
		'The teacher ' + CAST((I.TeacherId) AS VARCHAR(MAX)) + ' was updated'
	FROM
		INSERTED I
	EXECUTE Procedure_ChangeHistoryDetail
END
GO

SELECT * FROM Teacher

SELECT * FROM [ChangeHistory]
ORDER BY [ChangeHistory].TrackedEntityRecordId
