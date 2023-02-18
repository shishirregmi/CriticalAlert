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
		,@parentFunctionId	INT				= NULL
		,@user				VARCHAR(75)		= NULL
		,@details			VARCHAR(150)	= NULL

		,@flag				VARCHAR(50)		= NULL
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

IF @flag = 'addFunctionId'
BEGIN
	IF EXISTS(SELECT 'X' FROM SystemFunctions sf WHERE sf.functionId = @functionId)
	BEGIN
		SELECT '1' errorCode, 'Function Id already exists' msg, @userId id
		RETURN
	END

	INSERT INTO SystemFunctions (functionId, parentFunctionId, details, isdeleted, isactive, createdBy, createdDate)
	VALUES (@functionId, @parentFunctionId, @details, 'N', 'Y', @user, GETDATE());

	SELECT '0' errorCode, 'Function Id added Successfully' msg, @userId id
END

IF @flag = 'addSystemRoles'
BEGIN
	IF EXISTS(SELECT 'X' FROM SystemRoles sr WHERE sr.functionId = @functionId AND sr.userId = @userId)
	BEGIN
		DELETE SystemRoles WHERE functionId = @functionId AND userId = @userId
	END
	ELSE
	BEGIN
		INSERT INTO SystemRoles (userId, functionId, isdeleted, isactive, createdBy, createdDate)
		VALUES (@userId, @functionId, 'N', 'Y', @user, GETDATE());
	END
	SELECT '0' errorCode, 'System Role modified Successfully' msg, @userId id
END

IF @flag = 'getSystemRoles'
BEGIN
	IF NOT EXISTS(SELECT * FROM Users u WHERE U.id=@userId) 
    	RETURN
    
	SELECT
		*, dbo.Fun_HasRight(@userId,sf.functionId) AS isAssigned
	FROM SystemFunctions sf
	WHERE sf.functionId LIKE '%0000000'
END

IF @flag = 'getSystemRolesPages'
BEGIN
	IF NOT EXISTS(SELECT * FROM Users u WHERE U.id=@userId) 
    	RETURN
	SELECT
		*, dbo.Fun_HasRight(@userId,sf.functionId) AS isAssigned
	FROM SystemFunctions sf
	WHERE sf.parentFunctionId = @functionId AND sf.functionId LIKE '%00000' AND sf.functionId NOT LIKE '%0000000'
END

IF @flag = 'getSystemRolesSub'
BEGIN
	IF NOT EXISTS(SELECT * FROM Users u WHERE U.id=@userId) 
    	RETURN
	SELECT 
		*, dbo.Fun_HasRight(@userId,sf.functionId) AS isAssigned
	FROM SystemFunctions sf
	WHERE sf.parentFunctionId = @functionId AND sf.functionId LIKE '%000' AND sf.functionId NOT LIKE '%00000'
	
END

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH