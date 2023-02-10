USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_logs] (
		 @rowId				INT				= NULL
		,@activity			VARCHAR(75)		= NULL
		,@tableName			VARCHAR(75)		= NULL
		,@user				VARCHAR(75)		= NULL
		,@requestType		VARCHAR(20)		= NULL
		,@eventTime			DATETIME		= NULL
		,@room				VARCHAR(20)		= NULL
		,@bed				VARCHAR(20)		= NULL
		,@flag				VARCHAR(50)		= NULL
		,@errorCode			VARCHAR(1)		= NULL
		,@errorMessage		VARCHAR(MAX)	= NULL
	)
AS
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON
	IF @flag = 's-sl'
	BEGIN
		SELECT 'ID' id, 'Activity' activity, 'Table Name' tableName, 'Row Id' rowId, 'Error Code' errorCode, 'Error Message' errorMessage, 'Created By' createdBy, 'Created Date' createdDate
			
		SELECT id, activity, tableName, rowId, errorCode, errorMessage, createdBy, createdDate
		FROM SysLogs

		RETURN
	END

	IF @flag = 'i-sl'
	BEGIN
		BEGIN TRANSACTION

		INSERT INTO SysLogs
		(activity, tableName, rowId, errorCode, errorMessage, createdBy, createdDate)
		VALUES (@activity, @tableName, @rowId, @errorCode, @errorMessage, @user, GETDATE());

		COMMIT TRANSACTION

		SELECT @errorCode errorCode, @errorMessage msg, @rowId id
		RETURN
	END

	IF @flag = 's-nl'
	BEGIN
		SELECT 'ID' id, 'Request Type' requestType, 'Room' room, 'Event Time' eventTime, 'Patient' patient, 'Doctor' doctor, 'Created By' createdBy, 'Created Date' createdDate
			
		SELECT
			 nl.id AS id
			,ec.enumDetails AS requestType
			,CONCAT(CAST(b.room AS VARCHAR(10)),CONCAT('-',CAST(b.id AS VARCHAR(10)))) AS room
			,nl.eventTime AS eventTime
			,p.fullname AS patient
			,d.fullname AS doctor
			,nl.createdBy AS createdBy
			,nl.createdDate AS createdDate
		FROM NotificationLogs nl
		LEFT JOIN Beds b ON nl.bed = b.id
		LEFT JOIN Room r ON r.id = b.room
		LEFT JOIN AdmitPatientMod apm ON b.id = apm.bed
		LEFT JOIN Patients p ON p.id = apm.patient
		LEFT JOIN Doctors d ON d.id = apm.doctor
		LEFT JOIN EnumCollections ec ON ec.enumValue = nl.requestType

		RETURN
	END

	IF @flag = 'i-nl'
	BEGIN
		BEGIN TRANSACTION

		INSERT INTO NotificationLogs
		(requestType, room, bed, eventTime, createdBy, createdDate)
		VALUES (@requestType, @room, @bed, @eventTime, @user, GETDATE());

		SET @rowId = SCOPE_IDENTITY()

		COMMIT TRANSACTION 
		SELECT
			 ec.enumDetails AS requestType
			,CONCAT(CAST(b.room AS VARCHAR(10)),CONCAT('-',CAST(b.id AS VARCHAR(10)))) AS room
			,nl.eventTime AS eventTime
			,p.fullname AS patient
			,d.fullname AS doctor
		FROM NotificationLogs nl
		LEFT JOIN Beds b ON nl.bed = b.id
		LEFT JOIN Room r ON r.id = b.room
		LEFT JOIN AdmitPatientMod apm ON b.id = apm.bed
		LEFT JOIN Patients p ON p.id = apm.patient
		LEFT JOIN Doctors d ON d.id = apm.doctor
		LEFT JOIN EnumCollections ec ON ec.enumValue = nl.requestType
		WHERE nl.id = @rowId
		RETURN
	END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, @rowId id
END CATCH