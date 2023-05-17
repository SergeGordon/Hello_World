use SSISConfig
GO
SET NOCOUNT ON
GO
DECLARE @FileLoadID INT
DECLARE @ApplicationID INT  
DECLARE @ApplicationName VARCHAR(255) = 'Carnival_Call_Interaction_Standard'
DECLARE @AppPackageID INT  
DECLARE @ConnectionName VARCHAR(255) = 'Connection.ADONet'
DECLARE @ConnectionString VARCHAR(max)
DECLARE @DBConnectionID INT  
DECLARE @DBTransferID INT
DECLARE @Description VARCHAR(255) = 'Carnival Call_Interaction_Standard configuration.'
DECLARE @Direction VARCHAR(20) = 'inbound'
DECLARE @ExecutionOrder INT 

------------------------------------
DECLARE @InitialCatalog VARCHAR(100)
DECLARE @ObjectName VARCHAR(255) 
DECLARE @ObjectType VARCHAR(20) 
DECLARE @PackageConnectionID INT  
DECLARE @PackageFolder VARCHAR(255) = 'F:\Data Repository\SSIS\DataTransfer\' 
DECLARE @PackageID INT  
DECLARE @PackageName VARCHAR(255) = 'FileLoadDataTransfer.dtsx'
DECLARE @PackageType VARCHAR(255) = 'Import Package'  
DECLARE @PackageTypeID INT
DECLARE @Schema VARCHAR(255) 
DECLARE @ServerID INT  
DECLARE @ServerName VARCHAR(255) = 'app.dre.db.qa.arisevs.net\dev'
DECLARE @TargetName VARCHAR(255) 
DECLARE @LoadType VARCHAR(30)
-------------------------------------------------------------
IF NOT EXISTS(SELECT TOP 1 1 FROM cfg.Servers s (Nolock) WHERE s.ServerName = @ServerName)
BEGIN
	print 'Insert into cfg.servers - ' + @ServerName
	INSERT INTO cfg.Servers (ServerName,ActiveRowInd,CreatedDtm)
	VALUES (@ServerName,1,getdate())
	SELECT @ServerID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	print 'The server ' + @ServerName + ' has already been configured.'
	SELECT TOP 1 @ServerID  = s.ServerID FROM cfg.Servers s (Nolock) WHERE s.ServerName = @ServerName
END

SELECT TOP 1 @ApplicationID = a.ApplicationID FROM cfg.Applications a with (nolock) WHERE a.ApplicationName = @ApplicationName

EXEC cfg.AddSSISPackageType @PackageType,@PackageTypeID OUTPUT

EXEC cfg.AddSSISPackage @PackageName,@PackageFolder,@PackageTypeID,@PackageID OUTPUT

DECLARE CR_ApplicationName CURSOR READ_ONLY
FOR

SELECT 62 AS FileLoadID, 'StandardLogic' AS LoadType
UNION
SELECT 63 AS FileLoadID, 'ScheduleBasedLogic' 
UNION
SELECT 64 AS FileLoadID, 'ScheduleBasedLogic' 
UNION
SELECT 89 AS FileLoadID, 'StandardLogic' 
UNION
SELECT 101 AS FileLoadID, 'StandardLogic' 


OPEN CR_ApplicationName
FETCH NEXT FROM CR_ApplicationName INTO @FileLoadID, @LoadType
WHILE @@FETCH_STATUS = 0

BEGIN

-------------------------------------------------------------------------------------------------------------------------
---- Application Package Xref
SET @ExecutionOrder = 2
IF Not Exists(   
 SELECT top 1 1  
 FROM cfg.AppPackagesXRef x WITH (NOLOCK)  
 WHERE x.ApplicationID = @ApplicationID  
 AND x.PackageID = @PackageID  
 AND x.ExecutionOrder = @ExecutionOrder
 AND x.FileLoadID = @FileLoadID 
 )  
 BEGIN  
  --PRINT char(9) +  ' - Insert AppPackage for (' + @Application + '/' + @Package + '/' + @FileLoadID + ').'  
    INSERT INTO cfg.AppPackagesXRef (ApplicationID,PackageID ,ExecutionOrder,FileLoadID)  
    VALUES (@ApplicationID, @PackageID, @ExecutionOrder,@FileLoadID)  
      
    SET @AppPackageID = SCOPE_IDENTITY()  
 END  
 ELSE  
 BEGIN  
  --PRINT char(9) +  ' - The AppPackage for (' + @Application + '/' + @Package + '/' + @FileLoadID + ') already exists.'  
  SELECT @AppPackageID = x.AppPackageID  
  FROM cfg.AppPackagesXRef x WITH (NOLOCK)  
  WHERE x.ApplicationID = @ApplicationID  
  AND  x.PackageID = @PackageID  
  AND  x.ExecutionOrder = @ExecutionOrder
  AND  x.FileLoadID = @FileLoadID 
 END 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET		@InitialCatalog  = 'RAW'
SELECT @ConnectionString = 'Data Source= ' + @ServerName + ';Initial Catalog=' + @InitialCatalog+ ';Integrated Security=True;Application Name='+@ConnectionName+';'

IF NOT EXISTS(SELECT TOP 1 1 FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @ServerID AND dc.InitialCatalog = @InitialCatalog)
BEGIN
	INSERT INTO cfg.DbConnections(ServerID,ConnectionName,Connectionstring,InitialCatalog,ActiveRowInd,CreatedDtm)
	VALUES(@ServerID,@ConnectionName,@ConnectionString,@InitialCatalog,1,getdate())
	SELECT	@dbConnectionID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	SELECT TOP 1 @dbConnectionID = dc.DbConnectionID FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @ServerID AND dc.InitialCatalog = @InitialCatalog
END

SET		@ObjectName  = 'usp_Insert_Call_Interaction'
SET		@ObjectType = 'stored procedure'
SET		@PackageFolder = 'F:\Data Repository\SSIS\DataTransfer\' 
SET		@PackageName  = 'FileLoadDataTransfer.dtsx'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'Carnival'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 1
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT


-- DB Transfer 
SET		@Direction = 'inbound'
SET		@ObjectName = 'usp_Convert_Call_Interaction_Timezone'
SET		@ObjectType = 'stored procedure'
SET		@Schema			= 'genz'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'
SET		@ExecutionOrder = 2
EXEC	cfg.AddSSISDBTransfer @dbConnectionID, @AppPackageID,@Direction, @ObjectName, @ObjectType,@Schema, @TargetName,@ExecutionOrder,@DBTransferID OUTPUT

-- DB Transfer 
SET		@Direction = 'inbound'
SET		@ObjectName = 'usp_Insert_Call_Interaction_Merge'
SET		@ObjectType = 'stored procedure'
SET		@Schema			= 'genz'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'
SET		@ExecutionOrder = 3
EXEC	cfg.AddSSISDBTransfer @dbConnectionID, @AppPackageID,@Direction, @ObjectName, @ObjectType,@Schema, @TargetName,@ExecutionOrder,@DBTransferID OUTPUT

-- DB Transfer 
SET		@Direction = 'inbound'
SET		@ObjectName = 'usp_Insert_Call_Interaction_Standard'
SET		@ObjectType = 'stored procedure'
SET		@Schema			= 'genz'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'
SET		@ExecutionOrder = 4
EXEC	cfg.AddSSISDBTransfer @dbConnectionID, @AppPackageID,@Direction, @ObjectName, @ObjectType,@Schema, @TargetName,@ExecutionOrder,@DBTransferID OUTPUT

-------------------------------------------------------------------------------------------------------------

SET	@InitialCatalog  = 'Stage'
SELECT @ConnectionString = 'Data Source= ' + @ServerName + ';Initial Catalog=' + @InitialCatalog+ ';Integrated Security=True;Application Name='+@ConnectionName+';'

IF NOT EXISTS(SELECT TOP 1 1 FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @ServerID AND dc.InitialCatalog = @InitialCatalog)
BEGIN
	INSERT INTO cfg.DbConnections(ServerID,ConnectionName,Connectionstring,InitialCatalog,ActiveRowInd,CreatedDtm)
	VALUES(@ServerID,@ConnectionName,@ConnectionString,@InitialCatalog,1,getdate())
	SELECT	@dbConnectionID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	SELECT TOP 1 @dbConnectionID = dc.DbConnectionID FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @ServerID AND dc.InitialCatalog = @InitialCatalog
END

SET		@ObjectName  = 'usp_Import_RAW_Call_Interaction_Standard' 
SET		@ObjectType = 'stored procedure'
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 5
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
SET		@ObjectName  = 'usp_Update_IHI_ACP'
SET		@ObjectType = 'stored procedure'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 6
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
IF @LoadType = 'ScheduleBasedLogic'
BEGIN
SET		@ObjectName  = 'usp_Update_IHI_App_ScheduleBased'
END
ELSE
BEGIN
SET		@ObjectName  = 'usp_Update_IHI_App_Standard'
END

SET		@ObjectType = 'stored procedure'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 7
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
SET		@ObjectName  = 'usp_Update_IHI_Client'
SET		@ObjectType = 'stored procedure'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 8
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
SET		@ObjectName  = 'usp_Update_IHI_Skills'
SET		@ObjectType = 'stored procedure'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 9
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
SET		@ObjectName  = 'usp_Update_IHI_ErrorInd'
SET		@ObjectType = 'stored procedure'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 10
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
SET		@InitialCatalog  = 'Integration'
SELECT @ConnectionString = 'Data Source= ' + @ServerName + ';Initial Catalog=' + @InitialCatalog+ ';Integrated Security=True;Application Name='+@ConnectionName+';'

IF NOT EXISTS(SELECT TOP 1 1 FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @ServerID AND dc.InitialCatalog = @InitialCatalog)
BEGIN
	INSERT INTO cfg.DbConnections(ServerID,ConnectionName,Connectionstring,InitialCatalog,ActiveRowInd,CreatedDtm)
	VALUES(@ServerID,@ConnectionName,@ConnectionString,@InitialCatalog,1,getdate())
	SELECT	@dbConnectionID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	SELECT TOP 1 @dbConnectionID = dc.DbConnectionID FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @ServerID AND dc.InitialCatalog = @InitialCatalog
END

SET		@ObjectName  = 'usp_Import_Stage_to_IHI'
SET		@ObjectType = 'stored procedure'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 11
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
SET		@InitialCatalog  = 'AriseDM'
SELECT @ConnectionString = 'Data Source= ' + @ServerName + ';Initial Catalog=' + @InitialCatalog+ ';Integrated Security=True;Application Name='+@ConnectionName+';'

IF NOT EXISTS(SELECT TOP 1 1 FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @ServerID AND dc.InitialCatalog = @InitialCatalog)
BEGIN
	INSERT INTO cfg.DbConnections(ServerID,ConnectionName,Connectionstring,InitialCatalog,ActiveRowInd,CreatedDtm)
	VALUES(@ServerID,@ConnectionName,@ConnectionString,@InitialCatalog,1,getdate())
	SELECT	@dbConnectionID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	SELECT TOP 1 @dbConnectionID = dc.DbConnectionID FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @ServerID AND dc.InitialCatalog = @InitialCatalog
END

SET		@ObjectName  = 'usp_Import_Stage_to_Hagent'
SET		@ObjectType = 'stored procedure'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 12
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
SET		@ObjectName  = 'usp_Import_Stage_to_Hsplit'
SET		@ObjectType = 'stored procedure'
SET		@PackageType  = 'Import Package'  
SET		@Schema  = 'GenZ'
SET		@TargetName  = 'ESQL_Run_Stored_Procedure'

SET	@ExecutionOrder = 13
EXEC	cfg.AddSSISDBTransfer @DBConnectionID,@AppPackageID,@Direction,@ObjectName,@ObjectType,@Schema,@TargetName,@ExecutionOrder, @DBTransferID OUTPUT
---------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
FETCH NEXT FROM CR_ApplicationName INTO @FileLoadID, @LoadType
END
CLOSE CR_ApplicationName
DEALLOCATE CR_ApplicationName
