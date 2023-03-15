USE HospitalManagement
GO
/****** Object:  StoredProcedure [dbo].[proc_login]    Script Date: 1/7/2023 7:05:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[proc_login](
	 @flag			VARCHAR(20)		= NULL
	,@username		VARCHAR(50)		= NULL
	,@pass			VARCHAR(100)	= NULL
	)
AS
BEGIN
	SET NOCOUNT ON;

	IF @flag = 'login'
	BEGIN

		IF EXISTS(SELECT 'x' FROM Users WHERE username = @username AND pass = @pass)
		BEGIN			
			IF EXISTS(SELECT 'x' FROM Users WHERE username = @username AND pass = @pass AND ISNULL(isactive,'Y')<>'Y') 
			BEGIN  
            	SELECT '1' errorCode, 'User Locked' msg, NULL id
				RETURN
            END
            
			SELECT '0' errorCode, 'Login Successfull' msg, NULL id

			SELECT U.id AS userId, U.fullname AS fullname, U.username AS username, U.email AS email, ec.enumDetails AS userRole 
			FROM Users U WITH(NOLOCK)
			LEFT JOIN EnumCollections ec ON U.userRole = ec.enumValue
			WHERE U.username = @username
			RETURN
		END
		ELSE
		BEGIN
			SELECT '1' errorCode, 'Invalid Credentails' msg, NULL id
			RETURN
		END	
		
	END

END
