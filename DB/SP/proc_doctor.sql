USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_doctor] (
		 @id				INT				= NULL

		,@fullname			VARCHAR(150)	= NULL
		,@phone				VARCHAR(100)	= NULL

		,@province			VARCHAR(100)	= NULL
		,@district			VARCHAR(100)	= NULL
		,@street			VARCHAR(100)	= NULL
		,@doctor			VARCHAR(100)	= NULL	
		
		,@title				VARCHAR(100)	= NULL
		,@details			VARCHAR(100)	= NULL
		,@college			VARCHAR(100)	= NULL

		,@isdeleted			VARCHAR(75)		= NULL
		,@isactive			VARCHAR(100)	= NULL	
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
		SELECT 'ID' id, 'Full Name' fullname, 'Phone Number' phone, 'Created By' createdBy, 'Created Date' createdDate ,'Modified By' modifiedBy, 'Modified Date' modifiedDate
			
		SELECT id, fullname, phone, createdBy, createdDate ,modifiedBy, modifiedDate
		FROM Doctors WITH(NOLOCK) WHERE ISNULL(isdeleted,'N') <> 'Y' AND ISNULL(isactive,'Y') <> 'N'
	END

	IF @flag = 'i'
	BEGIN
		IF EXISTS (SELECT 'X' FROM Doctors WITH(NOLOCK) WHERE phone = @phone)
		BEGIN
			SELECT '1' errorCode, 'Phone Number already in use' msg, NULL id
			RETURN
		END		
		BEGIN TRANSACTION

		INSERT INTO Doctors(fullname, phone, isactive, isdeleted, createdBy, createdDate)
		VALUES(@fullname,@phone,'Y','N',@User,GETDATE())

		SET @doctor = SCOPE_IDENTITY()

		INSERT INTO DoctorAddress (province, district, street, doctor, isdeleted, createdBy, createdDate)
		VALUES (@province, @district, @street, @doctor, 'N', @user, GETDATE());

		INSERT INTO DoctorQualifications (title, details, college, doctor, isdeleted, createdBy, createdDate)
		VALUES (@title, @details, @college, @doctor, 'N', @user, GETDATE());

		COMMIT TRANSACTION

		SELECT '0' errorCode, 'Doctor registered successfully' msg, SCOPE_IDENTITY() id
		RETURN
	END

	IF @flag = 'u'
	BEGIN
		IF EXISTS (SELECT 'X' FROM Doctors WITH(NOLOCK) WHERE phone = @phone AND id <> @id)
		BEGIN
			SELECT '1' errorCode, 'Phone Number already in use' msg, NULL id
			RETURN
		END		
		BEGIN TRANSACTION

		UPDATE Doctors Set
			 fullname			= @fullname	
			,phone				= @phone		
			,isactive			= @isactive		
			,modifiedBy			= @user	
			,modifiedDate		= GETDATE()
		WHERE id = @id AND ISNULL(isdeleted,'N') <> 'Y'
		COMMIT TRANSACTION
		SELECT '0' errorCode, 'Doctor Updated successfully' msg, null id
		RETURN
	END

	IF @flag = 'd'
	BEGIN
		BEGIN TRANSACTION

		UPDATE Doctors SET 
			 isdeleted			= 'Y'	
			,modifiedBy			= @user	
			,modifiedDate		= GETDATE()
		WHERE id = @id AND ISNULL(isdeleted,'N') <> 'Y'
		COMMIT TRANSACTION
		SELECT '0' errorCode, 'Doctor Deleted successfully' msg, null id
		RETURN
	END

	IF @flag = 'getdoctor'
	BEGIN
		SELECT USR.id
			,USR.fullname
			,USR.email
			,ENM.enumDetails AS userRole
		FROM Users USR WITH(NOLOCK)
		LEFT JOIN EnumCollections ENM ON ENM.enumValue = USR.userRole
		WHERE USR.id = @id AND ISNULL(USR.isdeleted,'N') <> 'Y'
		
		RETURN
	END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH