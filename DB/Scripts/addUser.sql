USE HospitalManagement

EXEC proc_user 
			 @flag = 'i'
			,@fullname = 'Test Admin'
			,@email = 'test1@gmail.com'
			,@username = 'test1'
			,@pass = 'test@123'
			,@user = 'admin'
			,@userRole = '1'

EXEC proc_user @id = 1
			  ,@flag = 'getuser'

EXEC proc_login @flag = 'login'
			   ,@username = 'test1'
			   ,@pass = 'test@123'
