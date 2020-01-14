---''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
---  SQL SCRIPT: Demo2_DataVirtualization_Polybase.sql
---
--- Description: Demo of data virtualization - 
---		 
---
--- Parameters :   
---
---
--- Date               Developer            Action
--- ---------------------------------------------------------------------
--- Nov 05, 2019       Steve Young          Writing And Development
---
---
---
/*

*/

--================================================================
--     References
--================================================================
-- Grant limited access to Azure Storage resources using shared access signatures (SAS)
-- https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview
-- CREATE DATABASE SCOPED CREDENTIAL (Transact-SQL)
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/create-database-scoped-credential-transact-sql?view=sql-server-2017
-- Create Database Scoped Credential: 
-- https://msdn.microsoft.com/library/mt270260.aspx
-- Shared Access Signatures cannot be used with Polybase
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/create-database-scoped-credential-transact-sql?view=sql-server-2017 
-- Manage anonymous read access to containers and blobs
-- https://docs.microsoft.com/en-us/azure/storage/blobs/storage-manage-access-to-resources
-- Use PolyBase to read Blob Storage in Azure SQL DW
-- https://microsoft-bitools.blogspot.com/2017/08/use-polybase-to-read-blob-storage-in.html

--================================================================
--     SQL 2019
--================================================================
--Configure PolyBase to access external data in Azure Blob Storage
-- https://docs.microsoft.com/en-us/sql/relational-databases/polybase/polybase-configure-azure-blob-storage?view=sql-server-ver15

/*
This script is given "As Is" with no warranties and plenty of caveats. Use at your own risk!

*/
-----------------------------------------------------------------------
-- User-defined variables
----------------------------------------------------------------------- 

-- Step 1: Restore the Wide Importers datbase
--==============================================
-- This notebook uses the sample WideWorldImporters sample database in SQL 2019. 
-- The database can be downloaded at the GitHub repository SQL Server Demos - World Wide Importers.
--  https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
-- How to restore bacpac file to Azure SQL
--	https://docs.microsoft.com/en-us/azure/sql-database/sql-database-import?tabs=azure-powershell#using-azure-portal


-- Step 2: Create a database in Azure SQL, table, and add data
-- Create a database in Azure SQL called AzureDemoDB. Execute the following T-SQL to create a table and insert data into the database.

-- Note that the "USE" is not supported in Azure, noted here to make sure you run these commands in the correct DB

Use [AzureDemoDB]
GO


DROP TABLE IF EXISTS [ModernStockItems]
GO
CREATE TABLE [dbo].[ModernStockItems](
	[StockItemID] [int] NOT NULL,
	[StockItemName] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ColorID] [int] NULL,
	[UnitPackageID] [int] NOT NULL,
	[OuterPackageID] [int] NOT NULL,
	[Brand] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[Size] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NULL,
	[LeadTimeDays] [int] NOT NULL,
	[QuantityPerOuter] [int] NOT NULL,
	[IsChillerStock] [bit] NOT NULL,
	[Barcode] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[RecommendedRetailPrice] [decimal](18, 2) NULL,
	[TypicalWeightPerUnit] [decimal](18, 3) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
CONSTRAINT [PK_Warehouse_StockItems] PRIMARY KEY CLUSTERED 
(
	[StockItemID] ASC
)
)
GO
-- Now insert some data. We don't coordinate with unique keys in WWI on SQL Server
-- so pick numbers way larger than exist in the current StockItems in WWI which is only 227
INSERT INTO [dbo].[ModernStockItems] VALUES
(100000,
'Dallas Cowboys Jersey',
5,
4, -- Blue
4, -- Box
4, -- Bob
'Under Armour',
'L',
30,
1,
0,
'123456789',
2.0,
50,
75,
2.0,
1
)
GO
INSERT INTO [dbo].[ModernStockItems] VALUES
(100001,
'Toronto Maple Leafs Jersey',
5,
4, -- Blue
4, -- Box
4, -- Bob
'Under Armour',
'L',
30,
1,
0,
'123456789',
2.0,
50,
75,
2.0,
1
)
GO


INSERT INTO [dbo].[ModernStockItems] VALUES
(100002,
'Vancouver Canucks Jersey',
5,
4, -- Blue
4, -- Box
4, -- Bob
'Under Armour',
'L',
30,
1,
0,
'123456789',
2.0,
50,
75,
2.0,
1
)
GO


INSERT INTO [dbo].[ModernStockItems] VALUES
(100003,
'Calgary Flames Jersey',
5,
4, -- Blue
4, -- Box
4, -- Bob
'Under Armour',
'L',
30,
1,
0,
'123456789',
2.0,
50,
75,
2.0,
1
)
GO


INSERT INTO [dbo].[ModernStockItems] VALUES
(100004,
'Ottawa Senitors Jersey',
5,
4, -- Blue
4, -- Box
4, -- Bob
'Under Armour',
'L',
30,
1,
0,
'123456789',
2.0,
50,
75,
2.0,
1
)
GO


-- show that the values are in 
Select * From  [dbo].[ModernStockItems] 
GO

-- Step 3 Create a user to access the Azure SQL DB
-- For ease of demo use, we will use a SQL Login. The following commands need to be 
-- run against the master and the AzureSQLDB in order to create a new user
-- At this time you cannot use a Shared Access Signature with Polybase.  
--  Think of accessing other databases, such as Oracle, there will need to be a use and PW
--	https://docs.microsoft.com/en-us/sql/t-sql/statements/create-database-scoped-credential-transact-sql?view=sql-server-ver15
--   https://docs.microsoft.com/en-us/sql/t-sql/statements/create-database-scoped-credential-transact-sql?view=sql-server-ver15

-- Created these in the Azure SQL Database AzureDemoDB

DROP LOGIN [usgsloader]
go

-- For the sake of the demo, use your current password

Create Login usgsloader with PASSWORD = '<<Strongpassword>>'  -- create a password

----Open another query window connected to [WideWorldImporters] and execute the following commands:

----Drop User usgsloader
--go

Create user usgsloader from login usgsloader 
go
EXEC sp_addrolemember 'db_owner', 'usgsloader'
go


-- ==============================================================================
--   Run in the SQL 2019 Local Instance Master database 
-- ==============================================================================


-- Step 4: Validate that Polybase is enabled.
exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE;

--Confirm Run the following command. If PolyBase is installed, the return is 1. Otherwise, it's 0.
SELECT SERVERPROPERTY ('IsPolyBaseInstalled') AS IsPolyBaseInstalled;




-- ==============================================================================
--   Run the rest in the SQL 2019 Local Instance WideWorldImporters database 
-- ==============================================================================

-- Step 5: Create a database credential.
-- =========================================


-- This should already be completed by default, but just to make sure.
-- Create a master key to encrypt the database credential
--==============================================
USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Thisisa@password'
GO


-- The database credential contains the IDENTITY (login) and SECRET (password) of the 
-- remote Azure SQL Database server or Managed Instance. Change this to the login and 
-- password for your server.
-- IDENTITY = login
-- SECRET = password

--CREATE DATABASE SCOPED CREDENTIAL AzureSQLDatabaseCredentials2   
--WITH IDENTITY = '<<user>>', SECRET = '<<ComplexPassword!1234>>'
--GO

--Drop DATABASE SCOPED CREDENTIAL AzureSQLDatabaseCredentials3   

-- User and PW from above step
CREATE DATABASE SCOPED CREDENTIAL AzureSQLDatabaseCredentials3  
WITH IDENTITY = 'usgsloader', SECRET = '<<Strongpassword>>'
GO

-- Step 6: Create an external data source

/*
--Drop the existing for demo if required

DROP EXTERNAL TABLE azuresqldb.ModernStockItems
go
DROP EXTERNAL DATA SOURCE AzureSQLDatabaseDemo
GO
*/


-- sqlserver is a keyword meaning the data source is a SQL Server, Azure SQL Database, or Azure SQL Data Warehouse
-- The name after :// is the Azure SQL Server Database server. Your SQL Server must be on the same vnet as the Azure SQL Server Database or must pass through its firewall rules
CREATE EXTERNAL DATA SOURCE AzureSQLDatabaseDemo
WITH ( 
LOCATION = 'sqlserver://sql2019labssey.database.windows.net',
PUSHDOWN = ON,
CREDENTIAL = AzureSQLDatabaseCredentials3
)
GO

-- Step 7: Create a schema in the WideWorldImporters for the external table
CREATE SCHEMA azuresqldb
GO

-- Step 8: Create the EXTERNAL TABLE
-- The columns names must match the names in the remote table
-- Notice the character columns use a collation that is compatible with the target table
-- The WITH clause includes the name of the remote [database].[schema].[table] and the external database source
CREATE EXTERNAL TABLE azuresqldb.ModernStockItems
(
	[StockItemID] [int] NOT NULL,
	[StockItemName] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ColorID] [int] NULL,
	[UnitPackageID] [int] NOT NULL,
	[OuterPackageID] [int] NOT NULL,
	[Brand] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[Size] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NULL,
	[LeadTimeDays] [int] NOT NULL,
	[QuantityPerOuter] [int] NOT NULL,
	[IsChillerStock] [bit] NOT NULL,
	[Barcode] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[RecommendedRetailPrice] [decimal](18, 2) NULL,
	[TypicalWeightPerUnit] [decimal](18, 3) NOT NULL,
	[LastEditedBy] [int] NOT NULL
)
 WITH (
 LOCATION='AzureDemoDB.dbo.ModernStockItems',
 DATA_SOURCE=AzureSQLDatabaseDemo
)
GO

-- Step 9: Create local statistics on columns you will use for filters
CREATE STATISTICS ModernStockItemsStats ON azuresqldb.ModernStockItems ([StockItemID]) WITH FULLSCAN
GO

-- Step 10: Just try to scan the remote table
SELECT * FROM azuresqldb.ModernStockItems
GO

-- Step 11: Try to find just a specific StockItemID
SELECT * FROM azuresqldb.ModernStockItems WHERE StockItemID = 100000
GO

-- Step 12: Use a UNION to find all stockitems for a specific supplier both locally and in the Azure table
SELECT msi.StockItemName, msi.Brand, c.ColorName
FROM azuresqldb.ModernStockItems msi
JOIN [Purchasing].[Suppliers] s
ON msi.SupplierID = s.SupplierID
and s.SupplierName = 'Graphic Design Institute'
JOIN [Warehouse].[Colors] c
ON msi.ColorID = c.ColorID
UNION
SELECT si.StockItemName, si.Brand, c.ColorName
FROM [Warehouse].[StockItems] si
JOIN [Purchasing].[Suppliers] s
ON si.SupplierID = s.SupplierID
and s.SupplierName = 'Graphic Design Institute'
JOIN [Warehouse].[Colors] c
ON si.ColorID = c.ColorID
GO