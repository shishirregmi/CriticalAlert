USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_rooms] (
		 @id				INT				= NULL
		,@room				INT				= NULL
		,@capacity			INT				= NULL
		,@roomType			INT				= NULL
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
	IF @flag = 'getAllRooms'
	BEGIN
		SELECT 
			 'ID' id
			,'Capacity' capacity	
			,'Room Type' roomType
			,'Bed Count' bedCount
			
		SELECT 
			 R.id AS id
			,R.capacity AS capacity	
			,Ec.enumDetails AS	roomType
			,(SELECT COUNT(id) FROM Beds B WHERE B.room = R.id AND ISNULL(isdeleted,'N') <> 'Y') AS	bedCount
		FROM Room R WITH(NOLOCK)
		LEFT JOIN EnumCollections EC ON R.roomType = EC.enumValue
		WHERE ISNULL(R.isdeleted,'N') <> 'Y'

		RETURN
	END

	IF @flag = 'getAllBeds'
	BEGIN
		SELECT 
			 'ID' id
			,'Room Number' room
			,'Room Type' roomType
			,'Patient Name' patient
			,'Doctor Name' doctor
		IF @id IS NULL
		BEGIN  
			SELECT 
				 apm.patient AS id
				,CONCAT(CAST(b.room AS VARCHAR(10)),CONCAT('-',CAST(b.id AS VARCHAR(10)))) AS room
				,ec.enumDetails AS roomType               
				,p.fullname AS patient
				,d.fullname AS doctor
			FROM Beds b WITH(NOLOCK)
			LEFT JOIN Room r ON r.id = b.room	
			LEFT JOIN EnumCollections ec ON R.roomType = ec.enumValue
			LEFT JOIN AdmitPatientMod apm ON apm.bed = b.id
			LEFT JOIN Patients p ON p.id = apm.patient
			LEFT JOIN Doctors d ON d.id = apm.doctor
			WHERE ISNULL(b.isdeleted,'N') <> 'Y' AND ISNULL(b.inuse,'N') <> 'N'
			
			RETURN
        END
		ELSE
		BEGIN
			SELECT 
				 B.id AS id
				,B.room AS room
				,Ec.enumDetails AS roomType
			FROM Beds B WITH(NOLOCK)
			LEFT JOIN Room R ON R.id = B.room	
			LEFT JOIN EnumCollections EC ON R.roomType = EC.enumValue
			WHERE ISNULL(R.isdeleted,'N') <> 'Y' AND B.room = @id   

			RETURN
		END 
	END

	IF @flag = 'i'
	BEGIN
		IF @capacity IS NULL
		BEGIN
			SELECT '0' errorCode, 'Please Specify Room Capacity' msg, NULL id
			RETURN
		END
		BEGIN TRANSACTION

		INSERT INTO Room (capacity, roomType, isdeleted, createdBy, createdDate)
		VALUES (@capacity, @roomType, 'N', @user, GETDATE());

		DECLARE @i INT = 0;
		SET @room = SCOPE_IDENTITY()
		WHILE @i < @capacity
		BEGIN
			INSERT INTO Beds (room, inuse, isdeleted, createdBy, createdDate)
			VALUES (@room, 'N', 'N', @user, GETDATE());

			SET @i = @i + 1;
		END;

		COMMIT TRANSACTION

		SELECT '0' errorCode, 'Room added successfully' msg, SCOPE_IDENTITY() id
		RETURN
	END

	IF @flag = 'deleteRoom'
	BEGIN
		BEGIN TRANSACTION

		UPDATE Room SET 
			 isdeleted			= 'Y'	
			,modifiedBy			= @user	
			,modifiedDate		= GETDATE()
		WHERE id = @id AND ISNULL(isdeleted,'N') <> 'Y'
		COMMIT TRANSACTION
		SELECT '0' errorCode, 'Room Deleted successfully' msg, null id
		RETURN
	END

	IF @flag = 'deleteBed'
	BEGIN
		BEGIN TRANSACTION

		UPDATE Beds SET 
			 isdeleted			= 'Y'	
			,modifiedBy			= @user	
			,modifiedDate		= GETDATE()
		WHERE id = @id AND ISNULL(isdeleted,'N') <> 'Y'
		COMMIT TRANSACTION
		SELECT '0' errorCode, 'Bed Deleted successfully' msg, null id
		RETURN
	END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH