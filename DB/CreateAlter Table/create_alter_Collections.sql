USE HospitalManagement

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