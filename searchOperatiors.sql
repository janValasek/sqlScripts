-- Procedures 
SELECT ROUTINE_NAME, ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_DEFINITION LIKE '%KEYWORD%' 
AND ROUTINE_TYPE='PROCEDURE'
ORDER BY ROUTINE_NAME
This is the equivalent of running the following query directly against the system tables/views:

SELECT sys.sysobjects.name, sys.syscomments.text
FROM sys.sysobjects INNER JOIN syscomments 
ON sys.sysobjects.id = sys.syscomments.id
WHERE sys.syscomments.text LIKE '%KEYWORD%' 
AND sys.sysobjects.type = 'P'
ORDER BY sys.sysobjects.NAME
The INFORMATION_SCHEMA.ROUTINES view can be used to search for content of functions as well.  Simply alter your WHERE clause as follows, substituting your search string in place of "KEYWORD" once again:

SELECT ROUTINE_NAME, ROUTINE_DEFINITION 
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_DEFINITION LIKE '%KEYWORD%' 
AND ROUTINE_TYPE='FUNCTION'
ORDER BY ROUTINE_NAME
To highlight the fact that this process is backward-compatible to Microsoft SQL Server 2000, I've run the following query against the Northwind database.  I'm interested in finding all the stored procedures that utilize the ROUND() function:

USE Northwind
GO

SELECT ROUTINE_NAME, ROUTINE_DEFINITION 
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_DEFINITION LIKE '%ROUND%' 
AND ROUTINE_TYPE='PROCEDURE'
ORDER BY ROUTINE_NAME
GO
From this I am able to determine that there are two stored procedures utilizing that function.

query results
Here is another example to find code that contains a string.  This is an example provided by one of our readers.  With this code you can specify the type of object you want to search:

TR - trigger
FN - scalar function
IF - table valued function
V - view
P - procedure
DECLARE @ObjectType VARCHAR(25)= 'P'; -- TR, FN, IF, V, P
DECLARE @Code VARCHAR(25)= 'customer';
SELECT 
     s.name + '.' + o.name, m.definition
FROM
   sys.sql_modules AS m
   INNER JOIN sys.objects AS o ON m.object_id = o.object_id
   INNER JOIN sys.schemas AS s ON o.schema_id = s.schema_id
WHERE o.type = @ObjectType
      AND o.name NOT LIKE 'sp_%'
      AND m.definition LIKE '%' + @Code + '%'
ORDER BY
     s.name
   , o.name;
