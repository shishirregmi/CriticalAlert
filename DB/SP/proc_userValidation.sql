USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_userValidation]    Script Date: 1/7/2023 3:08:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_userValidation] (
	  @id							int						= NULL
	 ,@fullname						VARCHAR(255)			= NULL
	 ,@email						VARCHAR(255)			= NULL 
	 ,@flag							NVARCHAR(50)			= NULL
	 ,@errorCode					VARCHAR(1)				OUTPUT	
	 ,@errorMessage					VARCHAR(MAX)			OUTPUT	
	)
	AS
BEGIN
	SET NOCOUNT ON;
	
	IF @flag IS NULL
	BEGIN		
		SELECT @errorCode = '1', @errorMessage = 'Flag is required.'
		RETURN;
	END

	IF @fullname IS NOT NULL AND @fullname LIKE '%[0-9]%'
	BEGIN		
		SELECT @errorCode = '1', @errorMessage = 'Invalid full name.'
		RETURN;
	END

	IF @email IS NOT NULL AND NOT ( CHARINDEX(' ',LTRIM(RTRIM(@email))) = 0 
				AND  LEFT(LTRIM(@email),1) <> '@' 
				AND  RIGHT(RTRIM(@email),1) <> '.' 
				AND  CHARINDEX('.',@email ,CHARINDEX('@',@email)) - CHARINDEX('@',@email ) > 1 
				AND  LEN(LTRIM(RTRIM(@email ))) - LEN(REPLACE(LTRIM(RTRIM(@email)),'@','')) = 1 
				AND  CHARINDEX('.',REVERSE(LTRIM(RTRIM(@email)))) >= 3 
				AND  (CHARINDEX('.@',@email ) = 0 AND CHARINDEX('..',@email ) = 0)
			)
	BEGIN
		SELECT @errorCode = '1', @errorMessage = 'Invalid email address.'
		RETURN;
	END	
END