USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_enum] (
		 @enumValue					VARCHAR(150)				= NULL
		,@enumDetails				VARCHAR(100)				= NULL
		,@enumParent				VARCHAR(75)					= NULL
		,@user						VARCHAR(75)					= NULL

		,@flag						NVARCHAR(50)				= NULL
		,@errorCode					VARCHAR(1)					= NULL
		,@errorMessage				VARCHAR(MAX)				= NULL
	)
	AS
BEGIN
	SET NOCOUNT ON;

	IF @flag='getEnum'
	BEGIN
			SELECT enumValue, enumDetails
			FROM EnumCollections WITH(NOLOCK)		
			WHERE enumParent = @enumParent AND ISNULL(isdeleted,'N') <> 'Y'
	END

	IF @flag = 'addEnum'
	BEGIN
		
		IF EXISTS (SELECT 'X' FROM EnumCollections WHERE enumDetails = @enumDetails AND ISNULL(isdeleted,'N') <> 'Y')
		BEGIN
			SELECT '1' errorCode, 'Enum already in use' msg, NULL id
			RETURN
		END			
		
		INSERT INTO EnumCollections(enumDetails	,enumParent,isdeleted,createdBy,createdDate)	
		VALUES(@enumDetails	,@enumParent,'N',@user,GETDATE())

		SELECT '0' errorCode, 'Enum created successfully' msg, SCOPE_IDENTITY() id
		RETURN
	END

	IF @flag = 'updateEnum'
	BEGIN
		IF EXISTS (SELECT 'X' FROM EnumCollections WHERE enumDetails = @enumDetails AND ISNULL(isdeleted,'N') <> 'Y')
		BEGIN
			SELECT '1' errorCode, 'Enum already in use' msg, NULL id
			RETURN
		END	

		Update EnumCollections Set
			 enumDetails		= @enumDetails	
			,enumParent			= @enumParent		
			,modifiedBy			= @user
			,modifiedDate		= GETDATE()
		WHERE enumValue = @enumValue
		
		SELECT '0' errorCode, 'Enum Updated successfully' msg, null id
		RETURN
	END	
	IF @flag = 'deleteEnum'
	BEGIN
		Update EnumCollections Set
			 isdeleted			= 'Y'		
			 ,modifiedBy		= @user
			,modifiedDate		= GETDATE()
		WHERE enumValue = @enumValue
		
		SELECT '0' errorCode, 'Enum Updated successfully' msg, null id
		RETURN
	END	
END