USE HospitalManagement

CREATE TABLE SysLogs
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,activity VARCHAR(50)
	,tableName VARCHAR(50)
	,rowId INT
	,success INT
	,createdBy VARCHAR(75)
	,createdDate DATETIME
)
                         
CREATE TABLE LoginLogs
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,username VARCHAR(75)
	,pass VARCHAR(100)
	,userRole INT
	,success INT
	,createdDate DATETIME
)

CREATE TABLE PasswordChangeLogs
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,username VARCHAR(75)
	,userId INT
	,oldpass VARCHAR(100)
	,newpass VARCHAR(100)
	,success INT
	,faliureMessage VARCHAR(100)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
)