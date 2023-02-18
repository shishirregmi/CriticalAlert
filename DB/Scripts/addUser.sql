USE HospitalManagement

EXEC proc_user 
			 @flag = 'i'
			,@fullname = 'Test Admin'
			,@email = 'test1@gmail.com'
			,@username = 'test1'
			,@pass = 't8Arfe8ltKPp66CydlaF4ZhHsTmG7sdnj8DD9ZfpP58='
			,@user = 'admin'
			,@userRole = '1'

EXEC proc_user @id = 1
			  ,@flag = 'getuser'

EXEC proc_login @flag = 'login'
			   ,@username = 'test1'
			   ,@pass = 'test@123'

EXEC proc_user 
			 @flag = 'i'
			,@fullname = 'Test Moderator'
			,@email = 'test2@gmail.com'
			,@username = 'test2'
			,@pass = 't8Arfe8ltKPp66CydlaF4ZhHsTmG7sdnj8DD9ZfpP58='
			,@user = 'admin'
			,@userRole = '2'