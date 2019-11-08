CREATE TRIGGER Trigger_ChangeHistory ON [Teacher]
	AFTER INSERT 
	AS
	BEGIN
		[ChangeHistory].ChangeOperationType = '1', --Não lembro o que fazer
		[ChangeHistory].Id_TrackedEntity
	END