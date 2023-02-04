USE HospitalManagement

--Adding Roles To Enum Collection
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Admin',@enumParent = 'Roles',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Moderator',@enumParent = 'Roles',@user = 'admin'

--Adding Room Types To Enum Collection
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Emergency Ward',@enumParent = 'RoomType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Special Ward',@enumParent = 'RoomType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'ICU',@enumParent = 'RoomType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Single Bed Room',@enumParent = 'RoomType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Normal Ward',@enumParent = 'RoomType',@user = 'admin'