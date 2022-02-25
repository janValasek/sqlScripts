/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [CIT].[adm].[tblStatementUser] 
	

SELECT *
  FROM [CIT].[adm].[tblUser] 
  WHERE userName LIKE 'Milan%'

  INSERT INTO [CIT].[adm].[tblStatementUser] 
  ( statementID, userID, roleID, startDate) 
  VALUES (336, 47, 1, GETDATE())
