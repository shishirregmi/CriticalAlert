USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_admitPatient] (
		 @id				INT				= NULL	
		,@rowId				INT				= NULL
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
	VALUES (@bed, @doctor, @patient, @type, @details, 'N', 'Y', @user, GETDATE())

	SET @id = SCOPE_IDENTITY()

	UPDATE Beds SET inuse = 'Y' WHERE id = @bed
	UPDATE Patients SET isadmitted = 'Y' WHERE id = @patient
	COMMIT TRANSACTION

	EXEC proc_logs @rowId = @id ,@activity = 'Admit' ,@tableName = 'AdmitPatientMod' ,@user = @user ,@flag = 'i-sl' ,@patient = @patient, @doctor = @doctor ,@errorCode = '0' ,@errorMessage = 'Patient admitted successfully'
	RETURN
END

IF @flag = 'a'
BEGIN	
	SELECT TOP 1
		 p.fullname																					AS fullname
		,p.phone																					AS phone
		,ec.enumDetails																				AS gender
		,CONCAT(pa.street,CONCAT(', ',CONCAT(pa.district,CONCAT(', ',pa.province))))				AS patientAddress
		,ISNULL(CAST(apm.createdDate AS VARCHAR(11)),ap.createdDate)								AS admittedOn
		,CASE WHEN p.isadmitted = 'Y' THEN  '-' ELSE CAST(ap.modifiedDate AS VARCHAR(11)) END		AS dischargedOn
		,CONCAT(CAST(b.room AS VARCHAR(10)),CONCAT('-',CAST(b.id AS VARCHAR(10))))					AS bed
	FROM Patients p
	LEFT JOIN PatientAddress pa ON pa.patient = P.id
	LEFT JOIN EnumCollections ec ON ec.enumValue = p.gender
	LEFT JOIN AdmitPatient ap ON p.id = ap.patient
	LEFT JOIN AdmitPatientMod apm ON p.id = apm.patient
	LEFT JOIN EnumCollections ec1 ON ec1.enumValue = ap.[type]
	LEFT JOIN Beds b ON b.id = apm.bed
	WHERE apm.id = @id
	ORDER BY ap.createdDate DESC

	RETURN
END

IF @flag = 'discharge'
BEGIN
	BEGIN TRANSACTION
	
	SELECT 
		 @bed = apm.bed
		,@patient = apm.patient
		,@doctor = apm.doctor
	FROM AdmitPatientMod apm
	WHERE apm.id = @id

	INSERT INTO AdmitPatient (bed, doctor, patient, [type], details, [status], isdeleted, isactive, createdBy, createdDate, modifiedBy, modifiedDate)
	SELECT apm.bed, apm.doctor, apm.patient, apm.[type], apm.details, 'C', apm.isdeleted, apm.isactive, apm.createdBy, apm.createdDate, @user, GETDATE() FROM AdmitPatientMod apm
	WHERE apm.id = @id

	SET @rowId = SCOPE_IDENTITY()

	DELETE AdmitPatientMod WHERE id = @id

	UPDATE Beds SET inuse = 'N' WHERE id = @bed;
	UPDATE Patients SET isadmitted = 'N' WHERE id = @patient;
	COMMIT TRANSACTION

	EXEC proc_logs @rowId = @rowId ,@activity = 'Discharge' ,@tableName = 'AdmitPatient' ,@user = @user ,@patient = @patient, @doctor = @doctor ,@flag = 'i-sl' ,@errorCode = '0' ,@errorMessage = 'Patient discharged successfully'
	RETURN
END

IF @flag = 'getpastpatients'
	BEGIN
		SELECT 
			 'ID' id
			,'Room Number' room
			,'Room Type' roomType
			,'Patient Name' patient
			,'Doctor Name' doctor
			,'Description' details
		
		SELECT 
			 apm.id AS id
			,CONCAT(CAST(b.room AS VARCHAR(10)),CONCAT('-',CAST(b.id AS VARCHAR(10)))) AS room
			,ec.enumDetails AS roomType               
			,p.fullname AS patient
			,d.fullname AS doctor
			,apm.details AS details
		FROM AdmitPatient apm WITH(NOLOCK)
		LEFT JOIN Beds b ON apm.bed = b.id
		LEFT JOIN Room r ON r.id = b.room	
		LEFT JOIN EnumCollections ec ON R.roomType = ec.enumValue
		LEFT JOIN Patients p ON p.id = apm.patient
		LEFT JOIN Doctors d ON d.id = apm.doctor
		WHERE ISNULL(apm.isdeleted,'N') <> 'Y' AND ISNULL(apm.status,'D') = 'C'
			
		RETURN
	END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH