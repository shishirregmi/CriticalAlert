USE HospitalManagement

--Adding Roles To Enum Collection
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Admin',@enumParent = 'Roles',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Moderator',@enumParent = 'Roles',@user = 'admin'
