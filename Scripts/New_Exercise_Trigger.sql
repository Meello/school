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
	Id_TrackedEntity tinyint not null identity(1,1),
	Name char(10) not null,
	CONSTRAINT PK_TrackedEntity PRIMARY KEY(Id_TrackedEntity)
);
CREATE TABLE [ChangeHistory]
(
	Id_ChangeHistory UNIQUEIDENTIFIER DEFAULT NEWID(),
	[User] nchar(50) DEFAULT SYSTEM_USER,
	/*
		Por que com DEFAULT funciona e sem, não?
	*/
	ChangeOperationType char not null,
	Id_TrackedEntity tinyint not null,
	Description varchar(300) not null,
	ChangeDateUTC TIMESTAMP not null,
	CONSTRAINT PK_ChangeHistory PRIMARY KEY(Id_ChangeHistory),
	CONSTRAINT FK_ChangeHistory_TrackedEntity FOREIGN KEY(Id_TrackedEntity)
	REFERENCES [TrackedEntity]
);

INSERT INTO [ChangeHistory](teste)
VALUES ('A'),('B');

SELECT * FROM [ChangeHistory];
DROP TABLE [ChangeHistory];