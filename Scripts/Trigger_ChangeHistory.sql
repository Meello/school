CREATE TRIGGER Trigger_ChangeHistory ON [Teacher]
	AFTER INSERT 
	AS
	BEGIN
		[ChangeHistory].ChangeOperationType = '1', --N�o lembro o que fazer
		[ChangeHistory].Id_TrackedEntity
	END