USE HospitalManagement

CREATE TABLE Users (
	id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
   ,fullname VARCHAR(150)
   ,email VARCHAR(100)
   ,username VARCHAR(75)
   ,pass VARCHAR(100)
   ,userRole INT
   ,isdeleted CHAR(1)
   ,isactive CHAR(1)
   ,createdbBy VARCHAR(75)
   ,modifiedBy VARCHAR(75)
   ,createdDate DATETIME
   ,modifiedDate DATETIME
);

CREATE TABLE EnumCollections (
	 enumValue INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,enumDetails VARCHAR(150)
	,enumParent VARCHAR(100)
	,isdeleted CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
);

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

CREATE TABLE Patients
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
	,isdeleted CHAR(1)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

CREATE TABLE AdmitPatient
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,room INT
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