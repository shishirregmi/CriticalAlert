USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_user] (
		 @id						INT							= NULL
		,@fullname					VARCHAR(150)				= NULL
		,@email						VARCHAR(100)				= NULL
		,@username					VARCHAR(75)					= NULL
		,@pass						VARCHAR(100)				= NULL	
		,@user						VARCHAR(75)					= NULL
		,@userRole					VARCHAR(10)					= NULL
		,@profile_pic				VARCHAR(1000)				= NULL
		,@pass1						VARCHAR(100)				= NULL
		,@pass2						VARCHAR(100)				= NULL
		,@flag						NVARCHAR(50)				= NULL
		,@errorCode					VARCHAR(1)					= NULL
		,@errorMessage				VARCHAR(MAX)				= NULL
	)
AS
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON

	EXEC proc_userValidation @flag				=         @flag 
							,@id				=         @id			
							,@fullname	    	=         @fullname	    
							,@email				=         @email	
							,@errorCode			=		  @errorCode				OUTPUT
							,@errorMessage		=		  @errorMessage				OUTPUT

	IF @errorCode =  '1'
	BEGIN
		SELECT @errorCode errorCode, @errorMessage msg, NULL id
		RETURN
	END

	IF @flag='s'
	BEGIN
			SELECT 'ID' id
				  ,'Full Name' fullname
				  ,'Email' email
				  ,'Username' username
				  ,'User Type' userRole
				  ,'Active' isactive

			SELECT id			=	u.id
				  ,fullname		=	u.fullname
				  ,email		=	u.email
				  ,username		=	u.username
				  ,userRole		=	ec.enumDetails
				  ,isactive		=	u.isactive
			FROM Users u
			LEFT JOIN EnumCollections ec ON ec.enumValue = u.userRole
			WHERE ISNULL(u.isdeleted,'N')<>'Y'
	END

	IF @flag = 'i'
	BEGIN
		
		IF EXISTS (SELECT 'X' FROM Users WITH(NOLOCK) WHERE username = @username)
		BEGIN
			SELECT '1' errorCode, 'Username already in use' msg, NULL id
			RETURN
		END
		IF EXISTS (SELECT 'X' FROM Users WITH(NOLOCK) WHERE email = @email)
		BEGIN
			SELECT '1' errorCode, 'Email already in use' msg, NULL id
			RETURN
		END		

		BEGIN TRANSACTION

		INSERT INTO Users(
			 fullname	
			,email		
			,username	
			,pass		
			,userRole	
			,isactive
			,isdeleted
			,createdbBy		
			,createdDate)
		VALUES(			
			@fullname	
			,@email		
			,@username	
			,@pass		
			,@userRole	
			,'Y'
			,'N'
			,@User	
			,GETDATE()	
			)

		COMMIT TRANSACTION

		SELECT '0' errorCode, 'User registered successfully' msg, SCOPE_IDENTITY() id
		RETURN
	END

	IF @flag = 'u'
	BEGIN
		IF EXISTS (SELECT 'X' FROM Users WITH(NOLOCK) WHERE email = @email)
			BEGIN
				SELECT '1' errorCode, 'Email already in use' msg, NULL id
				RETURN
			END		
		BEGIN TRANSACTION

		Update Users SET 
			 fullname			= @fullname		
			,userRole			= @userRole	
			,modifiedBy			= @user	
			,modifiedDate		= GETDATE()
		WHERE id = @id AND ISNULL(isdeleted,'N') <> 'Y'
		COMMIT TRANSACTION
		SELECT '0' errorCode, 'User Updated successfully' msg, null id
		RETURN
	END

	IF @flag = 'getuser'
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

	IF @flag = 'pc'
	BEGIN
		IF EXISTS(SELECT 'x' FROM Users WITH(NOLOCK) WHERE username = @username AND pass = @pass AND ISNULL(isdeleted,'N') <> 'Y' AND ISNULL(isactive,'Y') <> 'N')
		BEGIN			
			IF @pass1 = @pass2
			BEGIN
				IF @pass1 = @pass
				BEGIN
					SELECT '1' errorCode, 'Old Password and new Password cannot be same' msg, NULL 
					RETURN
				END
				ELSE
				BEGIN
					BEGIN TRANSACTION
					UPDATE Users SET 
						 pass = @pass1
						,modifiedBy = @user
						,modifiedDate = GETDATE()
					WHERE username = @username
					SELECT '0' errorCode, 'Password changed successfully' msg, NULL 
					COMMIT TRANSACTION
					RETURN
				END
			END
			ELSE
			BEGIN
				SELECT '1' errorCode, 'Passwords dont match' msg, NULL 
				RETURN
			END
		END
		ELSE
		BEGIN
			SELECT '1' errorCode, 'Invalid Credentails' msg, NULL id
			RETURN
		END	
		
	END
END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
     ROLLBACK TRANSACTION
     SELECT '1' errorCode, ERROR_MESSAGE() msg, NULL id
END CATCH