---''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
---  SQL SCRIPT:CreateSQLObjects.sql
---
--- Description: Create Azure Data Factory Sliding Window
---		 
---
--- Parameters :   
---
---
--- Date               Developer            Action
--- ---------------------------------------------------------------------
--- Dec 06, 2019       Steve Young          Writing And Development
---
---
---
/*

*/

--================================================================
--     References
--================================================================
-- My Blog Article on this topic
-- https://5minutebi.com/2018/06/03/how-to-use-azure-data-factory-v2-sliding-windows-for-sql-exports-to-azure-data-lake/
-- Create a trigger that runs a pipeline on a tumbling window
-- https://docs.microsoft.com/en-us/azure/data-factory/how-to-create-tumbling-window-trigger
-- Incrementally copy new files based on time partitioned file name by using the Copy Data tool
-- https://docs.microsoft.com/en-us/azure/data-factory/tutorial-incremental-copy-partitioned-file-name-copy-data-tool
--================================================================
--     SQL 2019
--================================================================
--

/*
This script is given "As Is" with no warranties and plenty of caveats. Use at your own risk!

*/
-----------------------------------------------------------------------
-- User-defined variables
----------------------------------------------------------------------- 

-- Step 1: Create a 
--==============================================
-- This notebook uses the sample WideWorldImporters sample database in SQL 2019. 
-- The database can be downloaded at the GitHub repository SQL Server Demos - World Wide Importers.
--  https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0


CREATE TABLE [dbo].[FactWindowHour](
     [FactKey] [int] IDENTITY(1,1) NOT NULL,
     [DateTimeEvent] [datetime] NOT NULL,
     [Dimension1Key] [int] NOT NULL,
     [Dimension2Key] [int] NOT NULL,
     [MyNotes] [varchar](50) NOT NULL
) ON [PRIMARY]

USE [AdventureworksLT]
GO

INSERT INTO [dbo].[FactWindowHour] ([DateTimeEvent],[Dimension1Key],[Dimension2Key],[MyNotes])
     VALUES (getdate(),1,2,'FirstLoad1')
INSERT INTO [dbo].[FactWindowHour] ([DateTimeEvent],[Dimension1Key],[Dimension2Key],[MyNotes])
     VALUES (getdate(),1,2,'FirstLoad1')
GO

Select * from [dbo].[FactWindowHour]
GO

USE [AdventureworksLT]
GO

SELECT [FactKey],[DateTimeEvent],[Dimension1Key],[Dimension2Key],[MyNotes] FROM [dbo].[FactWindowHour]
GO

