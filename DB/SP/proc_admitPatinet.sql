USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_admitPatinet] (
		 @id				INT				= NULL	
		,@bed				INT				= NULL
		,@doctor			INT				= NULL
		,@patient			INT				= NULL
		,@type				INT				= NULL
		,@details			NVARCHAR(MAX)	= NULL
		,@user				VARCHAR(75)		= NULL

		,@flag				NVARCHAR(50)	= NULL
		,@errorCode			VARCHAR(1)		= NULL
		,@errorMessage		VARCHAR(MAX)	= NULL
	)
AS
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON

IF @flag = 'admit'
BEGIN
	BEGIN TRANSACTION

	INSERT INTO AdmitPatientMod (bed, doctor, patient, [type], details, isdeleted, isactive, createdBy, createdDate)
	VALUES (@bed, @doctor, @patient, @type, @details, 'N', 'Y', @user, GETDATE());

	UPDATE Beds SET inuse = 'Y' WHERE id = @bed;
	UPDATE Patients SET isadmitted = 'Y' WHERE id = @patient;
	COMMIT TRANSACTION

	SELECT '0' errorCode, 'Admitted successfully' msg, SCOPE_IDENTITY() id
	RETURN
END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH