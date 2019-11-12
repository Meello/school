IF OBJECT_ID('Procedure_ChangeHistoryDetail', 'P') IS NOT NULL  
    DROP PROCEDURE Procedure_ChangeHistoryDetail;  
GO  
CREATE PROCEDURE Procedure_ChangeHistoryDetail
@Previous_TeacherId bigint,
@Previous_Name varchar(20),
@Previous_LevelId char(1),
@Previous_Salary decimal(10,2),
@Previous_AdmitionDate date,
@New_TeacherId bigint,
@New_Name varchar(20),
@New_LevelId char(1),
@New_Salary decimal(10,2),
@New_AdmitionDate date,
@P_ChangeHistoryId varchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	IF(@Previous_TeacherId <> @New_TeacherId) 
	BEGIN
		INSERT INTO [ChangeHistoryDetail]
		(
			ChangeHistoryId,
			PropertyName,
			PreviousValue,
			NewValue
		)
		VALUES
		(
			@P_ChangeHistoryId,
			'TeacherId',
			@Previous_TeacherId,
			@New_TeacherId
		)
	END

	IF(@Previous_Name <> @New_Name) 
	BEGIN
		INSERT INTO [ChangeHistoryDetail]
		(
			ChangeHistoryId,
			PropertyName,
			PreviousValue,
			NewValue
		)
		VALUES
		(
			@P_ChangeHistoryId,
			'Name',
			@Previous_Name,
			@New_Name
		)
	END

	IF(@Previous_LevelId <> @New_LevelId) 
	BEGIN
		INSERT INTO [ChangeHistoryDetail]
		(
			ChangeHistoryId,
			PropertyName,
			PreviousValue,
			NewValue
		)
		VALUES
		(
			@P_ChangeHistoryId,
			'LevelId',
			@Previous_LevelId,
			@New_LevelId
		)
	END

	IF(@Previous_Salary <> @New_Salary) 
	BEGIN
		INSERT INTO [ChangeHistoryDetail]
		(
			ChangeHistoryId,
			PropertyName,
			PreviousValue,
			NewValue
		)
		VALUES
		(
			@P_ChangeHistoryId,
			'Salary',
			@Previous_Salary,
			@New_Salary
		)
	END

	IF(@Previous_AdmitionDate <> @New_AdmitionDate) 
	BEGIN
		INSERT INTO [ChangeHistoryDetail]
		(
			ChangeHistoryId,
			PropertyName,
			PreviousValue,
			NewValue
		)
		VALUES
		(
			@P_ChangeHistoryId,
			'AdmitionDate',
			@Previous_AdmitionDate,
			@New_AdmitionDate
		)
	END
END
RETURN
GO