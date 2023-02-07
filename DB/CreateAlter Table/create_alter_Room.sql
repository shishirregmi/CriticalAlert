USE HospitalManagement

CREATE TABLE Room
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,capacity INT
	,roomType INT
	,isdeleted CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

CREATE TABLE Beds
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,room INT
	,inuse CHAR(1)
	,isdeleted CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)