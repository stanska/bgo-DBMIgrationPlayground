﻿--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmployeeTerritories]') AND type in (N'U')) AND 
--   NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RollbacUponException' AND Object_ID = Object_ID(N'dbo.EmployeeTerritories'))
--BEGIN
ALTER TABLE [dbo].[EmployeeTerritories]  DROP COLUMN RollbacUponException;
--END;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmployeeTerritories]') AND type in (N'U')) AND 
   NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'NewColumn' AND Object_ID = Object_ID(N'dbo.EmployeeTerritories'))
BEGIN
ALTER TABLE [dbo].[EmployeeTerritories]  DROP NewColumn;
END;
