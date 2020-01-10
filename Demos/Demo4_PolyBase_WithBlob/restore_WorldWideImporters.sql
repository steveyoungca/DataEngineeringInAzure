USE [master]
RESTORE DATABASE [WideWorldImporters] FROM  DISK = N'F:\WideWorldImporters-Full.bak' WITH  FILE = 1,  MOVE N'WWI_Primary' TO N'F:\data\WideWorldImporters.mdf',  MOVE N'WWI_UserData' TO N'F:\data\WideWorldImporters_UserData.ndf',  MOVE N'WWI_Log' TO N'F:\log\WideWorldImporters.ldf',  MOVE N'WWI_InMemory_Data_1' TO N'F:\data\WideWorldImporters_InMemory_Data_1',  NOUNLOAD,  STATS = 5
