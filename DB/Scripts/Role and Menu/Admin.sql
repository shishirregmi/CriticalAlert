USE HospitalManagement

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '10100000' ,@parentFunctionId = '10000000' ,@details = 'User Page', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '10101000' ,@parentFunctionId = '10100000' ,@details = 'View User List', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '10102000' ,@parentFunctionId = '10100000' ,@details = 'Add User', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '10103000' ,@parentFunctionId = '10100000' ,@details = 'Delete User', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '10104000' ,@parentFunctionId = '10100000' ,@details = 'Lock User', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '10105000' ,@parentFunctionId = '10100000' ,@details = 'Assign Roles', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '10106000' ,@parentFunctionId = '10100000' ,@details = 'Edit User', @user = 'system'
EXEC proc_menu @title = 'User',@details = 'contains user crud',@user = 'admin',@link = '/Admin/User/List',@parentId = 1,@flag = 'addSubMenu', @functionId = '10100000'	
