USE HospitalManagement

CREATE TABLE SysLogs
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,activity VARCHAR(50)
	,tableName VARCHAR(50)
	,rowId INT
	,patient INT
	,doctor INT
	,errorCode INT
	,errorMessage VARCHAR(150)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
)
                
CREATE TABLE LoginLogs
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,username VARCHAR(75)
	,pass VARCHAR(100)
	,userRole INT
	,errorCode INT
	,errorMessage VARCHAR(150)
	,createdDate DATETIME
)

CREATE TABLE PasswordChangeLogs
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,username VARCHAR(75)
	,userId INT
	,oldpass VARCHAR(100)
	,newpass VARCHAR(100)
	,errorCode INT
	,errorMessage VARCHAR(150)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
)

CREATE TABLE NotificationLogs
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,requestType INT
	,room INT
	,bed INT
	,patient INT
	,doctor INT
	,eventTime DATETIME
	,createdBy VARCHAR(75)
	,createdDate DATETIME
)