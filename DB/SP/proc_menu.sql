USE [HospitalManagement]
GO
/****** Object:  StoredProcedure [dbo].[proc_user]    Script Date: 1/7/2023 3:04:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_menu] (
		 @id						VARCHAR(150)				= NULL
		,@title						VARCHAR(100)				= NULL
		,@details					VARCHAR(500)				= NULL
		,@user						VARCHAR(75)					= NULL
		,@link						VARCHAR(200)				= NULL
		,@parentId					INT							= NULL	
		,@flag						NVARCHAR(50)				= NULL
		,@errorCode					VARCHAR(1)					= NULL
		,@errorMessage				VARCHAR(MAX)				= NULL
	)
	AS
BEGIN
	SET NOCOUNT ON;

	IF @flag = 'getAll'
	BEGIN
		SELECT 
			SM.title
			,(SELECT SSM.title, SSM.link FROM SidebarSubMenu SSM WHERE ISNULL(isdeleted,'N')<>'Y' AND SSM.parentId = SM.id FOR JSON AUTO) AS submenus
			FROM SidebarMenu SM
		WHERE ISNULL(isdeleted,'N') <> 'Y'
		RETURN	
	END

	IF @flag = 'addMenu'
	BEGIN
		
		IF EXISTS (SELECT 'X' FROM SidebarMenu WHERE title = @title AND ISNULL(isdeleted,'N') <> 'Y')
		BEGIN
			SELECT '1' errorCode, 'Menu name already in use' msg, NULL id
			RETURN
		END			
		
		INSERT INTO SidebarMenu(title,details,isdeleted,createdBy,createdDate)	
		VALUES(@title,@details,'N',@user,GETDATE())

		SELECT '0' errorCode, 'Menu added successfully' msg, SCOPE_IDENTITY() id
		RETURN
	END

	IF @flag = 'addSubMenu'
	BEGIN
		
		IF EXISTS (SELECT 'X' FROM SidebarSubMenu WHERE title = @title AND ISNULL(isdeleted,'N') <> 'Y' AND parentId=@parentID)
		BEGIN
			SELECT '1' errorCode, 'Sub Menu name already in use' msg, NULL id
			RETURN
		END			
		
		INSERT INTO SidebarSubMenu(title, details, parentId, link, isdeleted,createdBy,createdDate)	
		VALUES(@title,@details,@parentId,@link ,'N',@user,GETDATE())

		SELECT '0' errorCode, 'Sub Menu added successfully' msg, SCOPE_IDENTITY() id
		RETURN
	END

	IF @flag = 'updateMenu'
	BEGIN
		IF EXISTS (SELECT 'X' FROM SidebarMenu WHERE title = @title AND ISNULL(isdeleted,'N') <> 'Y')
		BEGIN
			SELECT '1' errorCode, 'Menu name already in use' msg, NULL id
			RETURN
		END

		Update SidebarMenu SET
			 title				= @title	
			,details			= @details		
			,modifiedBy			= @user
			,modifiedDate		= GETDATE()
		WHERE id = @id
		
		SELECT '0' errorCode, 'Menu Updated successfully' msg, null id
		RETURN
	END	

	IF @flag = 'updateSubMenu'
	BEGIN
		IF EXISTS (SELECT 'X' FROM SidebarSubMenu WHERE title = @title AND ISNULL(isdeleted,'N') <> 'Y')
		BEGIN
			SELECT '1' errorCode, 'Sub Menu name already in use' msg, NULL id
			RETURN
		END

		Update SidebarSubMenu SET
			 title				= @title	
			,details			= @details
			,parentId			= @parentId
			,link				= @link
			,modifiedBy			= @user
			,modifiedDate		= GETDATE()
		WHERE id = @id
		
		SELECT '0' errorCode, 'Sub Menu Updated successfully' msg, null id
		RETURN
	END	

	IF @flag = 'deleteMenu'
	BEGIN
		Update SidebarMenu Set
			 isdeleted			= 'Y'		
			 ,modifiedBy		= @user
			,modifiedDate		= GETDATE()
		WHERE id = @id
		
		SELECT '0' errorCode, 'Menu Deleted successfully' msg, null id
		RETURN
	END	

	IF @flag = 'deleteSubMenu'
	BEGIN
		Update SidebarSubMenu Set
			 isdeleted			= 'Y'		
			 ,modifiedBy		= @user
			,modifiedDate		= GETDATE()
		WHERE id = @id
		
		SELECT '0' errorCode, 'Sub Menu Deleted successfully' msg, null id
		RETURN
	END	
END