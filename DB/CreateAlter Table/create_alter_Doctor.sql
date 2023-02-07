CREATE TABLE Doctors
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,fullname VARCHAR(150)
	,phone VARCHAR(20)
	,isdeleted CHAR(1)
    ,isactive CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

CREATE TABLE DoctorQualifications
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,title VARCHAR(150)
	,details VARCHAR(200)
	,college VARCHAR(200)
	,doctor INT
	,isdeleted CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

CREATE TABLE DoctorAddress
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,province VARCHAR(75)
	,district VARCHAR(75)
	,street VARCHAR(150)
	,doctor INT
	,isdeleted CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)