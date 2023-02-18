USE HospitalManagement

CREATE TABLE SystemFunctions(
	 id	INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,functionId VARCHAR(8)
	,parentFunctionId VARCHAR(8)
	,details VARCHAR(500)
	,isdeleted CHAR(1)
	,isactive CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

CREATE TABLE SystemRoles(
	 id	INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,userId INT
	,functionId INT
	,isdeleted CHAR(1)
	,isactive CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)