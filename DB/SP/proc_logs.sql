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
		,@flag				NVARCHAR(50)	= NULL
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

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, @rowId id
END CATCH