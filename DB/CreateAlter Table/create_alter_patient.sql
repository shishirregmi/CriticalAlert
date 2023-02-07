USE HospitalManagement

CREATE TABLE Patients
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,fullname VARCHAR(150)
	,phone VARCHAR(20)
	,gender INT
	,isadmitted CHAR(1)
	,isdeleted CHAR(1)
	,isactive CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)
                         
CREATE TABLE PatientAddress
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,province VARCHAR(75)
	,district VARCHAR(75)
	,street VARCHAR(150)
	,patient INT
	,isdeleted CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

