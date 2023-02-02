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
		
		,@qualification		NVARCHAR(MAX)	= NULL
		,@ixml				XML				= NULL
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
		SET @ixml = @qualification
		SELECT
			detailId = t.r.value('(detailId/text())[1]', 'INT'),
			title = t.r.value('(title/text())[1]', 'VARCHAR(50)'),
			details = t.r.value('(details/text())[1]', 'VARCHAR(50)'),
			college = t.r.value('(college/text())[1]', 'VARCHAR(50)')
		INTO #TEMP
		FROM @ixml.nodes('/ArrayOfDoctorQualification/DoctorQualification') AS t(r)		

		INSERT INTO DoctorAddress (province, district, street, doctor, isdeleted, createdBy, createdDate)
		VALUES (@province, @district, @street, @doctor, 'N', @user, GETDATE());

		INSERT INTO DoctorQualifications (title, details, college, doctor, isdeleted, createdBy, createdDate)
		SELECT p.title, p.details, p.college, @doctor, 'N', @user, GETDATE() FROM #TEMP p WITH(NOLOCK)

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

		UPDATE DoctorAddress SET 
			province = @province
			,district = @district
			,street = @street
			,modifiedBy = @user
			,modifiedDate = GETDATE()
		WHERE doctor = @id;

		SET @ixml = @qualification
		SELECT
			detailId = t.r.value('(detailId/text())[1]', 'INT'),
			title = t.r.value('(title/text())[1]', 'VARCHAR(50)'),
			details = t.r.value('(details/text())[1]', 'VARCHAR(50)'),
			college = t.r.value('(college/text())[1]', 'VARCHAR(50)')
		INTO #TEMPU 
		FROM @ixml.nodes('/ArrayOfDoctorQualification/DoctorQualification') AS t(r)		

		UPDATE DoctorQualifications SET 
			isdeleted = 'Y'
			,modifiedBy = @user
			,modifiedDate = GETDATE()
		WHERE doctor = @id;

		INSERT INTO DoctorQualifications (title, details, college, doctor, isdeleted, createdBy, createdDate)
		SELECT p.title, p.details, p.college, @id, 'N', @user, GETDATE() FROM #TEMPU p WITH(NOLOCK)

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

	IF @flag = 'a'
	BEGIN
		SELECT d.fullname, d.phone, da.province, da.district, da.street 
		FROM Doctors d WITH(NOLOCK) 
		LEFT JOIN DoctorAddress da WITH(NOLOCK) ON da.doctor = d.id
		WHERE d.id=@id
		SELECT dq.title, dq.details, dq.college FROM DoctorQualifications dq WITH(NOLOCK)
		WHERE dq.doctor = @id AND ISNULL(dq.isdeleted,'N') <> 'Y'
		RETURN
	END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH