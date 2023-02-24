USE [Northwind]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Territories]') AND type in (N'U'))
ALTER TABLE [dbo].[Territories] DROP CONSTRAINT IF EXISTS [FK_Territories_Region]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
ALTER TABLE [dbo].[Products] DROP CONSTRAINT IF EXISTS [FK_Products_Suppliers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
ALTER TABLE [dbo].[Products] DROP CONSTRAINT IF EXISTS [FK_Products_Categories]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT IF EXISTS [FK_Orders_Shippers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT IF EXISTS [FK_Orders_Employees]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT IF EXISTS [FK_Orders_Customers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order Details]') AND type in (N'U'))
ALTER TABLE [dbo].[Order Details] DROP CONSTRAINT IF EXISTS [FK_Order_Details_Products]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order Details]') AND type in (N'U'))
ALTER TABLE [dbo].[Order Details] DROP CONSTRAINT IF EXISTS [FK_Order_Details_Orders]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmployeeTerritories]') AND type in (N'U'))
ALTER TABLE [dbo].[EmployeeTerritories] DROP CONSTRAINT IF EXISTS [FK_EmployeeTerritories_Territories]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmployeeTerritories]') AND type in (N'U'))
ALTER TABLE [dbo].[EmployeeTerritories] DROP CONSTRAINT IF EXISTS [FK_EmployeeTerritories_Employees]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
ALTER TABLE [dbo].[Employees] DROP CONSTRAINT IF EXISTS [FK_Employees_Employees]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerCustomerDemo]') AND type in (N'U'))
ALTER TABLE [dbo].[CustomerCustomerDemo] DROP CONSTRAINT IF EXISTS [FK_CustomerCustomerDemo_Customers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerCustomerDemo]') AND type in (N'U'))
ALTER TABLE [dbo].[CustomerCustomerDemo] DROP CONSTRAINT IF EXISTS [FK_CustomerCustomerDemo]
GO
/****** Object:  Table [dbo].[Territories]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Territories]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Suppliers]
GO
/****** Object:  Table [dbo].[Shippers]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Shippers]
GO
/****** Object:  Table [dbo].[SchemaVersions]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[SchemaVersions]
GO
/****** Object:  Table [dbo].[Region]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Region]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Products]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Orders]
GO
/****** Object:  Table [dbo].[Order Details]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Order Details]
GO
/****** Object:  Table [dbo].[EmployeeTerritories]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[EmployeeTerritories]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Employees]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Customers]
GO
/****** Object:  Table [dbo].[CustomerDemographics]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[CustomerDemographics]
GO
/****** Object:  Table [dbo].[CustomerCustomerDemo]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[CustomerCustomerDemo]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2/23/2023 11:29:23 AM ******/
DROP TABLE IF EXISTS [dbo].[Categories]
GO
/****** Object:  StoredProcedure [dbo].[Ten Most Expensive Products]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[Ten Most Expensive Products]
GO
/****** Object:  StoredProcedure [dbo].[SalesByCategory]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[SalesByCategory]
GO
/****** Object:  StoredProcedure [dbo].[Sales by Year]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[Sales by Year]
GO
/****** Object:  StoredProcedure [dbo].[Employee Sales by Country]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[Employee Sales by Country]
GO
/****** Object:  StoredProcedure [dbo].[CustOrdersOrders]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[CustOrdersOrders]
GO
/****** Object:  StoredProcedure [dbo].[CustOrdersDetail]    Script Date: 2/23/2023 10:22:34 AM ******/DROP PROCEDURE IF EXISTS [dbo].[CustOrdersDetail]
GO
/****** Object:  StoredProcedure [dbo].[CustOrderHist]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[CustOrderHist]
GO
/****** Object:  View [dbo].[Quarterly Orders]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Quarterly Orders]
GO
/****** Object:  View [dbo].[Products by Category]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Products by Category]
GO
/****** Object:  View [dbo].[Products Above Average Price]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Products Above Average Price]
GO
/****** Object:  View [dbo].[Orders Qry]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Orders Qry]
GO
/****** Object:  View [dbo].[Invoices]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Invoices]
GO
/****** Object:  View [dbo].[Customer and Suppliers by City]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Customer and Suppliers by City]
GO
/****** Object:  View [dbo].[Current Product List]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Current Product List]
GO
/****** Object:  View [dbo].[Alphabetical list of products]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Alphabetical list of products]
GO
/****** Object:  View [dbo].[Summary of Sales by Year]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Summary of Sales by Year]
GO
/****** Object:  View [dbo].[Summary of Sales by Quarter]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Summary of Sales by Quarter]
GO
/****** Object:  View [dbo].[Sales Totals by Amount]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Sales Totals by Amount]
GO
/****** Object:  View [dbo].[Order Subtotals]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Order Subtotals]
GO
/****** Object:  View [dbo].[Sales by Category]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Sales by Category]
GO
/****** Object:  View [dbo].[Order Details Extended]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Order Details Extended]
GO
/****** Object:  View [dbo].[Category Sales for 1997]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Category Sales for 1997]
GO
/****** Object:  View [dbo].[Product Sales for 1997]    Script Date: 2/23/2023 10:22:34 AM ******/
DROP VIEW IF EXISTS [dbo].[Product Sales for 1997]
GO
