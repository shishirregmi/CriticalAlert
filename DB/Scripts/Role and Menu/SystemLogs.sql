USE HospitalManagement

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '30100000' ,@parentFunctionId = '30000000' ,@details = 'System Logs Page', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '30101000' ,@parentFunctionId = '30100000' ,@details = 'View System Logs List', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '30102000' ,@parentFunctionId = '30100000' ,@details = 'Delete System Logs', @user = 'system'
EXEC proc_menu @title = 'System Logs',@details = 'contains logs of db crud attempts',@user = 'admin',@link = '/Logs/SystemLogs/List',@parentId = 3,@flag = 'addSubMenu', @functionId = '30100000'		

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '30200000' ,@parentFunctionId = '30000000' ,@details = 'Notification Logs Page', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '30201000' ,@parentFunctionId = '30200000' ,@details = 'View Notification Logs List', @user = 'system'
EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '30202000' ,@parentFunctionId = '30200000' ,@details = 'Delete Notification Logs', @user = 'system'
EXEC proc_menu @title = 'Notification Logs',@details = 'contains logs of db crud attempts',@user = 'admin',@link = '/Logs/NotificationLogs/List',@parentId = 3,@flag = 'addSubMenu', @functionId = '30200000'	