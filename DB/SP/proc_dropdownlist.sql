USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_dropdownlist] (
		 @id				INT				= NULL

		,@flag				NVARCHAR(50)	= NULL
		,@errorCode			VARCHAR(1)		= NULL
		,@errorMessage		VARCHAR(MAX)	= NULL
	)
AS
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON
IF @flag = 'gender'
BEGIN
	SELECT ec.enumValue, ec.enumDetails
	FROM EnumCollections ec WITH(NOLOCK)
	WHERE ec.enumParent = 'Gender'
	RETURN
END
IF @flag = 'roomType'
BEGIN
	SELECT ec.enumValue, ec.enumDetails
	FROM EnumCollections ec WITH(NOLOCK)
	WHERE ec.enumParent = 'RoomType'
	RETURN
END
IF @flag = 'p-Type' --patient Type
BEGIN
	SELECT ec.enumValue, ec.enumDetails
	FROM EnumCollections ec WITH(NOLOCK)
	WHERE ec.enumParent = 'PatientType'
	RETURN
END	
IF @flag = 'ua-patient' --un appointed patients
BEGIN
	SELECT p.id AS enumValue, p.fullname AS enumDetails FROM Patients p WITH(NOLOCK)
	WHERE ISNULL(p.isdeleted, 'N') <> 'Y' AND ISNULL(p.isactive, 'Y') <> 'N' AND ISNULL(p.isadmitted, 'N') <> 'Y'
	RETURN
END	
IF @flag = 'f-doctor' --free doctors
BEGIN
	SELECT d.id AS enumValue, d.fullname AS enumDetails
	FROM Doctors d WITH(NOLOCK)
	WHERE ISNULL(d.isdeleted, 'N') <> 'Y' AND ISNULL(d.isactive, 'Y') <> 'N' 
	AND (SELECT COUNT(id) FROM AdmitPatientMod apm WHERE apm.doctor = d.id AND ISNULL(isdeleted,'N') <> 'Y' AND ISNULL(apm.isactive, 'Y') <> 'N') < 5
	RETURN
END	
IF @flag = 'f-bed' --free beds
BEGIN
	SELECT b.id AS enumValue, CONCAT(CAST(b.room AS VARCHAR(10)),CONCAT('-',CAST(b.id AS VARCHAR(10)))) AS enumDetails
	FROM Beds b WITH(NOLOCK)
	WHERE ISNULL(b.isdeleted, 'N') <> 'Y' AND ISNULL(b.inuse, 'N') <> 'Y'
	RETURN
END	

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH