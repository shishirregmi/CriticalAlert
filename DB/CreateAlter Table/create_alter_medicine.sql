USE HospitalManagement

CREATE TABLE Medicines
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,[name] VARCHAR(50)
	,company VARCHAR(50)
	,dose INT
	,mrp VARCHAR(75)
	,expiryDate DATETIME
	,mnfDate DATETIME
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)
                
CREATE TABLE PatientMedicines
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,patient INT
	,medicine INT
	,quantity VARCHAR(75)
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

CREATE TABLE PatientMedicinesOld
(
	 id INT NOT NULL PRIMARY KEY IDENTITY (1, 1)
	,patient INT
	,medicine VARCHAR(75)
	,prescribedBy VARCHAR(75)
	,startDate DATETIME
	,endDate DATETIME
	,createdBy VARCHAR(75)
	,createdDate DATETIME
	,modifiedBy VARCHAR(75)
	,modifiedDate DATETIME
)

