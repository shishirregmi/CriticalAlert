USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_roles] (
		 @id				INT				= NULL	
		,@userId			INT				= NULL
		,@roleId			INT				= NULL
		,@functionId		INT				= NULL
		,@user				VARCHAR(75)		= NULL

		,@flag				NVARCHAR(50)	= NULL
		,@errorCode			VARCHAR(1)		= NULL
		,@errorMessage		VARCHAR(MAX)	= NULL
	)
AS
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON

IF @flag = 'checkRole'
BEGIN
	SELECT @roleId = u.userRole FROM Users u WITH(NOLOCK) 
	WHERE u.id = @userId

	IF @roleId = 1 
	BEGIN  
		SELECT '0' errorCode, 'Success' msg, @userId id	
    END
	ELSE   
	BEGIN
		IF EXISTS(SELECT 'X' FROM SystemRoles sr WHERE sr.functionId = @functionId AND sr.userId = @userId)
			SELECT '0' errorCode, 'Success' msg, @userId id	
		ELSE
			SELECT '1' errorCode, 'Failure' msg, @userId id	
	END

END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH