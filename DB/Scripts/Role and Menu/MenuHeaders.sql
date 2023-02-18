USE HospitalManagement

--MainMenu : 10###### Admin: 10 | Management: 20 | System : 30
--SubMenu: ##10#### 
--Page: ####10##
--Function: ######10

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '10000000' ,@parentFunctionId = '10000000' ,@details = 'Admin', @user = 'system'
EXEC proc_menu @title = 'Admin' ,@details = 'contains menu item for adding and removing hospital related assets' ,@user = 'admin' ,@flag = 'addMenu', @functionId = '10000000'

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '20000000' ,@parentFunctionId = '20000000' ,@details = 'Management', @user = 'system'
EXEC proc_menu @title = 'Management' ,@details = 'contains menu item for managing physical assets', @user = 'admin',@flag = 'addMenu', @functionId = '20000000'

EXEC proc_roles @flag = 'addFunctionId' ,@functionId = '30000000' ,@parentFunctionId = '30000000' ,@details = 'System Logs', @user = 'system'
EXEC proc_menu @title = 'Logs' ,@details = 'System related Views',@user = 'admin',@flag = 'addMenu', @functionId = '30000000'		  