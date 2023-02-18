USE HospitalManagement

CREATE TABLE SidebarMenu(
	 id	INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,title VARCHAR(80)
	,details VARCHAR(500)
	,isdeleted CHAR(1)
	,isactive CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

CREATE TABLE SidebarSubMenu(
	 id	INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,title VARCHAR(80)
	,details VARCHAR(500)
	,parentId INT
	,link VARCHAR(MAX)
	,isdeleted CHAR(1)
	,isactive CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

ALTER TABLE SidebarMenu
	ADD functionId VARCHAR(8) NULL 	

ALTER TABLE SidebarSubMenu
	ADD functionId VARCHAR(8) NULL
