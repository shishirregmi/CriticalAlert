USE [HospitalManagement]
GO

ALTER FUNCTION [dbo].[Fun_HasRight](     @userId VARCHAR(20)	,@functionId VARCHAR(8))RETURNS INTASBEGINDECLARE @result INT		IF EXISTS (SELECT 'X' FROM SystemRoles sr WHERE sr.functionId = @functionId AND sr.userId = @userId AND ISNULL(sr.isdeleted,'N') <>'Y')			SET @result = '0'		ELSE 			SET @result = '1'		RETURN @resultEND
GO