USE HospitalManagement

EXEC proc_menu 
			  @title = 'Admin'
			  ,@details = 'contains menu item for adding and removing hospital related assets'
			  ,@user = 'admin'
			  ,@flag = 'addMenu'

EXEC proc_menu 
			  @title = 'Doctor'
			  ,@details = 'contains link of page to add/edit/view doctors name list'
			  ,@user = 'admin'
			  ,@link = '/Doctor/List'
			  ,@parentId = 1
			  ,@flag = 'addSubMenu'

EXEC proc_menu 
			  @title = 'Patient'
			  ,@details = 'contains link of page to add/edit/view patients name list'
			  ,@user = 'admin'
			  ,@link = '/Patients/List'
			  ,@parentId = 1
			  ,@flag = 'addSubMenu'

---------------------------------------------------------------------------------------------

EXEC proc_menu 
			  @title = 'Management'
			  ,@details = 'contains menu item for managing physical assets'
			  ,@user = 'admin'
			  ,@flag = 'addMenu'

EXEC proc_menu 
			  @title = 'Admitted Patients'
			  ,@details = 'contains link of page to add/edit/view current admitted patient list'
			  ,@user = 'admin'
			  ,@link = '/Management/Beds/List'
			  ,@parentId = 2
			  ,@flag = 'addSubMenu'

EXEC proc_menu 
			  @title = 'Past Admitted Patients'
			  ,@details = 'contains link of page to add/edit/view past admitted patient list'
			  ,@user = 'admin'
			  ,@link = '/Management/Admission/List'
			  ,@parentId = 2
			  ,@flag = 'addSubMenu'

EXEC proc_menu 
			  @title = 'Rooms'
			  ,@details = 'contains link of page to add/edit/view room list'
			  ,@user = 'admin'
			  ,@link = '/Management/Rooms/List'
			  ,@parentId = 2
			  ,@flag = 'addSubMenu'

---------------------------------------------------------------------------------------------

EXEC proc_menu 
			  @title = 'Logs'
			  ,@details = 'Log related Views'
			  ,@user = 'admin'
			  ,@flag = 'addMenu'


EXEC proc_menu 
			  @title = 'System Logs'
			  ,@details = 'contains logs of db crud attempts'
			  ,@user = 'admin'
			  ,@link = '/Logs/SystemLogs/List'
			  ,@parentId = 3
			  ,@flag = 'addSubMenu'		
			  