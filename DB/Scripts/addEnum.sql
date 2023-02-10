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

--Adding Patinet Types To Enum Collection
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Minor Injury',@enumParent = 'PatientType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Severe Injury',@enumParent = 'PatientType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Operation',@enumParent = 'PatientType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Delivery',@enumParent = 'PatientType',@user = 'admin'

--Adding Gender To Enum Collection
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Male',@enumParent = 'Gender',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Female',@enumParent = 'Gender',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Third',@enumParent = 'Gender',@user = 'admin'

--Adding Gender To Enum Collection
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Patient Eye Closed',@enumParent = 'NotificationRequestType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Patient Eye Open',@enumParent = 'NotificationRequestType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Patient Excessive Movement Start',@enumParent = 'NotificationRequestType',@user = 'admin'
EXEC proc_enum @flag = 'addEnum', @enumDetails = 'Patient Excessive Movement End',@enumParent = 'NotificationRequestType',@user = 'admin'
