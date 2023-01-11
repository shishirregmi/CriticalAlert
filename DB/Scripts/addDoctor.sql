USE HospitalManagement

TRUNCATE TABLE Doctors
EXEC proc_doctor 
				@fullname = 'Ram Prasad'
				,@phone = '9841000000'
				,@user = 'test1'
				,@flag = 'i'


