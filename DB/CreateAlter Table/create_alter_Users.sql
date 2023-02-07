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