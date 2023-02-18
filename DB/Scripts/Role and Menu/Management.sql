USE HospitalManagement

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20100000' ,@parentFunctionId = '20000000' ,@details = 'Doctor Page', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20101000' ,@parentFunctionId = '20100000' ,@details = 'View Doctor List', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20102000' ,@parentFunctionId = '20100000' ,@details = 'Add/Edit Doctor', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20103000' ,@parentFunctionId = '20100000' ,@details = 'Delete Doctor', @user = 'system'
EXEC proc_menu @title = 'Doctor' ,@details = 'contains link of page to add/edit/view doctors name list',@user = 'admin',@link = '/Doctor/List',@parentId = 2,@flag = 'addSubMenu', @functionId = '20100000'


EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20200000' ,@parentFunctionId = '20000000' ,@details = 'Patient Page', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20201000' ,@parentFunctionId = '20200000' ,@details = 'View Patient List', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20202000' ,@parentFunctionId = '20200000' ,@details = 'Add/Edit Patient', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20203000' ,@parentFunctionId = '20200000' ,@details = 'Delete Patient', @user = 'system'
EXEC proc_menu @title = 'Patient',@details = 'contains link of page to add/edit/view patients name list',@user = 'admin',@link = '/Patients/List',@parentId = 2,@flag = 'addSubMenu', @functionId = '20200000'

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20300000' ,@parentFunctionId = '20000000' ,@details = 'Admitted Patient Page', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20301000' ,@parentFunctionId = '20300000' ,@details = 'View Admitted Patient List', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20302000' ,@parentFunctionId = '20300000' ,@details = 'Add/Edit Admitted Patient', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20303000' ,@parentFunctionId = '20300000' ,@details = 'Delete Admitted Patient', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20304000' ,@parentFunctionId = '20300000' ,@details = 'Discharge Admitted Patient', @user = 'system'
EXEC proc_menu @title = 'Admitted Patients',@details = 'contains link of page to add/edit/view current admitted patient list',@user = 'admin',@link = '/Management/Beds/List',@parentId = 2,@flag = 'addSubMenu', @functionId = '20300000'

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20400000' ,@parentFunctionId = '20000000' ,@details = 'Discharged Patient Page', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20401000' ,@parentFunctionId = '20400000' ,@details = 'View Discharged Patient List', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20402000' ,@parentFunctionId = '20400000' ,@details = 'Add/Edit Discharged Patient', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20403000' ,@parentFunctionId = '20400000' ,@details = 'Delete Discharged Patient', @user = 'system'
EXEC proc_menu @title = 'Past Admitted Patients',@details = 'contains link of page to add/edit/view past admitted patient list',@user = 'admin',@link = '/Management/Admission/List',@parentId = 2,@flag = 'addSubMenu', @functionId = '20400000'

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20500000' ,@parentFunctionId = '20000000' ,@details = 'Room Page', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20501000' ,@parentFunctionId = '20500000' ,@details = 'View Room List', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20502000' ,@parentFunctionId = '20500000' ,@details = 'Add/Edit Room', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20503000' ,@parentFunctionId = '20500000' ,@details = 'Delete Room', @user = 'system'
EXEC proc_menu @title = 'Rooms',@details = 'contains link of page to add/edit/view room list',@user = 'admin',@link = '/Management/Rooms/List',@parentId = 2,@flag = 'addSubMenu', @functionId = '20500000'