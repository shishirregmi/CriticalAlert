USE HospitalManagement

CREATE TABLE AdmitPatient
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,bed INT
	,doctor INT
	,patient INT
	,[type] INT
	,details VARCHAR(MAX)
	,isdeleted CHAR(1)
	,isactive CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

CREATE TABLE AdmitPatientMod
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,bed INT
	,doctor INT
	,patient INT
	,[type] INT
	,details VARCHAR(MAX)
	,isdeleted CHAR(1)
	,isactive CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)