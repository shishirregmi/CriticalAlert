USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_patient] (
		 @id				INT				= NULL
		,@fullname			VARCHAR(150)	= NULL
		,@phone				VARCHAR(100)	= NULL
		,@gender			VARCHAR(75)		= NULL	

		,@province			VARCHAR(100)	= NULL
		,@district			VARCHAR(100)	= NULL
		,@street			VARCHAR(100)	= NULL
		,@patient			VARCHAR(100)	= NULL	

		,@user				VARCHAR(75)		= NULL

		,@flag				NVARCHAR(50)	= NULL
		,@errorCode			VARCHAR(1)		= NULL
		,@errorMessage		VARCHAR(MAX)	= NULL
	)
AS
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON
	IF @flag='s'
	BEGIN
			SELECT 'ID' id, 'Full Name' fullname, 'Phone Number' phone, 'Gender' gender, 'Created By' createdBy, 'Created Date' createdDate ,'Modified By' modifiedBy, 'Modified Date' modifiedDate

			SELECT p.id, p.fullname, p.phone, ec.enumDetails AS gender, p.createdBy, p.createdDate , p.modifiedBy, p.modifiedDate
			FROM Patients p WITH(NOLOCK)
			LEFT JOIN EnumCollections ec ON ec.enumValue = p.gender
			WHERE ISNULL(p.isdeleted,'N') <> 'Y' AND ISNULL(p.isactive,'Y') <> 'N'
	END

	IF @flag = 'i'
	BEGIN
		IF EXISTS (SELECT 'X' FROM Patients WITH(NOLOCK) WHERE phone = @phone)
			BEGIN
				EXEC proc_logs @rowId = @id ,@activity = 'Insert' ,@tableName = 'Patients' ,@user = @user ,@flag = 'i-sl' ,@patient = @id, @doctor = NULL ,@errorCode = '1' ,@errorMessage = 'Phone Number already in use'
				RETURN
			END		
		BEGIN TRANSACTION

		INSERT INTO Patients(fullname, phone, gender, isadmitted, isactive, isdeleted, createdBy, createdDate)
		VALUES(@fullname,@phone, @gender, 'N', 'Y','N',@User,GETDATE())

		SET @patient = SCOPE_IDENTITY()

		INSERT INTO PatientAddress (province, district, street, patient, isdeleted, createdBy, createdDate)
		VALUES (@province, @district, @street, @patient, 'N', @user, GETDATE());

		COMMIT TRANSACTION

		EXEC proc_logs @rowId = @patient ,@activity = 'Insert' ,@tableName = 'Patient' ,@user = @user ,@flag = 'i-sl' ,@patient = @patient, @doctor = NULL ,@errorCode = '0' ,@errorMessage = 'Patient registered successfully'

		RETURN
	END

	IF @flag = 'u'
	BEGIN
		IF EXISTS (SELECT 'X' FROM Patients WITH(NOLOCK) WHERE phone = @phone AND id <> @id)
			BEGIN
				EXEC proc_logs @rowId = @id ,@activity = 'Update' ,@tableName = 'Patients' ,@user = @user ,@flag = 'i-sl' ,@patient = @id, @doctor = NULL ,@errorCode = '1' ,@errorMessage = 'Phone Number already in use'
				RETURN
			END		
		BEGIN TRANSACTION

		UPDATE Patients SET 
			 fullname			= @fullname	
			,phone				= @phone	
			,gender				= @gender	
			,modifiedBy			= @user	
			,modifiedDate		= GETDATE()
		WHERE id = @id AND ISNULL(isdeleted,'N') <> 'Y'

		UPDATE PatientAddress SET 
			province = @province
			,district = @district
			,street = @street
			,modifiedBy = @user
			,modifiedDate = GETDATE()
		WHERE patient = @id;

		COMMIT TRANSACTION
		EXEC proc_logs @rowId = @id ,@activity = 'Update' ,@tableName = 'Patient' ,@user = @user ,@flag = 'i-sl' ,@patient = @id, @doctor = NULL ,@errorCode = '0' ,@errorMessage = 'Patient updated successfully'
		RETURN
	END

	IF @flag = 'd'
	BEGIN
		BEGIN TRANSACTION

		UPDATE Patients SET 
			 isdeleted			= 'Y'	
			,modifiedBy			= @user	
			,modifiedDate		= GETDATE()
		WHERE id = @id AND ISNULL(isdeleted,'N') <> 'Y'
		COMMIT TRANSACTION
		EXEC proc_logs @rowId = @patient ,@activity = 'Delete' ,@tableName = 'Patient' ,@user = @user ,@flag = 'i-sl' ,@patient = @patient, @doctor = NULL ,@errorCode = '0' ,@errorMessage = 'Patient deleted successfully'

		RETURN
	END

	IF @flag = 'a'
	BEGIN
		SELECT p.fullname, p.phone, pa.province, pa.district, pa.street, p.gender
		FROM Patients p WITH(NOLOCK) 
		LEFT JOIN PatientAddress pa WITH(NOLOCK) ON pa.patient = p.id
		WHERE p.id=@id		
		RETURN
	END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH