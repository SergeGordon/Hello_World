use SSISConfig
GO

SET NOCOUNT ON
GO
----- run this section if a new Fileload id is required.
DECLARE	@FileLoadID INT 
DECLARE @Application_ID int = -1
DECLARE	@Applicatin_Nm varchar(255) = 'NA'
DECLARE @FileLoadName varchar(244)  
DECLARE @Control_Load_Nm varchar(225) 
DECLARE @RootFolder varchar(255) = '\\ssis.files.smb.dev.arisevs.net\DRE_Inbound\Carnival\Carnival_CSP_Call_Interaction'
DECLARE @FileName varchar(255) 
DECLARE @ProcessStartTime time(7) =  '01:10:00'
DECLARE @ExpectedFileTime time(7) =  '01:10:00'
DECLARE @AllowableDelay int = 16
DECLARE @BusLogicUSPName varchar(255) = 'N/A'
DECLARE @BusLogicUSPName_AriseDM varchar(255) ='N/A'
DECLARE @DoesAppendData bit 
DECLARE @AppendCompletePercent decimal(18,2)
DECLARE @IsAlert bit = 1
---- Application
DECLARE @ApplicationName VARCHAR(255) = 'Carnival_Call_Interaction_Standard'
DECLARE @Description VARCHAR(255) = 'Carnival Call_Interaction_Standard configuration.'
DECLARE @Frequency VARCHAR(50) = 'Day'
DECLARE @Increment INT = 1
DECLARE @TimeZoneID INT = 77
DECLARE @ApplicationID INT

--@AlertContactEmail - TBD
DECLARE @AlertContactEmail varchar(255)  = 'sgordon@arise.com'
DECLARE @FileConvertNeeded bit = 0
DECLARE @FileConvertPkgName varchar(255) = NULL
DECLARE @FileConvertPKGPath varchar(255) = NULL
DECLARE @ConversionPackageID int
--@ErrorContactEmail - TBD
DECLARE @ErrorContactEmail varchar(255)  = 'sgordon@arise.com' --'zpagan@arise.com;fimposimato@arise.com;carias@arise.com'
DECLARE @Active bit = 1
DECLARE @ClientID int = 98

DECLARE @TimeZone_id varchar(10)
DECLARE @FileTypeID int
DECLARE @AppendFileFrequency int = 1
DECLARE @AppendFileCount int 
DECLARE @Source_System_ID int=11
DECLARE	@DateFileMask VARCHAR(20) = 'yyyyMMdd'
DECLARE	@Schema VARCHAR(255) = 'Carnival'
---- db Server
DECLARE @dbServerName VARCHAR(255) = 'app.dre.db.qa.arisevs.net\dev'
DECLARE @dbServerID INT

-------- Get the timezone id --------------------------------------
SELECT	@TimeZone_id = 77

---- File
DECLARE	@MaxAllowedRows INT = NULL
DECLARE	@Delimiter VARCHAR(255) = ','
DECLARE	@Has_File_Header BIT = 1
DECLARE @Extension VARCHAR(10) = '.csv'
DECLARE @DateMask VARCHAR(25) = 'yyyyMMdd'
DECLARE @FileID INT

---- File Transfer
DECLARE @SourcePath VARCHAR(255) = NULL
DECLARE @DestinationPath VARCHAR(255) =  '\\ssis.files.smb.dev.arisevs.net\DRE_Inbound\Carnival\Carnival_CSP_Call_Interaction\'
DECLARE @Direction VARCHAR(20) = 'inbound'
DECLARE @ArchiveFileInd BIT = 1
DECLARE @FileTransferID INT
DECLARE	@RemoveFileInd BIT = 0

--- fileload file transfer
DECLARE	@BatchSize INT = 25000
DECLARE @FileLoadFileTransferID	INT

--- FileMapping
DECLARE @FileMappingID	INT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT TOP 1 @ApplicationID = A.ApplicationID FROM cfg.Applications a WITH (NOLOCK) where A.ApplicationName = @ApplicationName

---- Package Type
DECLARE @PackageType VARCHAR(255) = 'Import Package' 
DECLARE @PackageID INT 
DECLARE @PackageTypeID INT
EXEC cfg.AddSSISPackageType @PackageType,@PackageTypeID OUTPUT

---- Intuit RAW Package
DECLARE @PackageName varchar(255)= 'Genz_Call_Interaction_To_Raw.dtsx'
DECLARE @PackageFolder varchar(255) = 'F:\Data Repository\SSIS\DataTransfer\'
EXEC cfg.AddSSISPackage @PackageName,@PackageFolder,@PackageTypeID,@PackageID OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----db ServerID
IF NOT EXISTS(SELECT TOP 1 1 FROM cfg.Servers s (Nolock) WHERE s.ServerName = @dbServerName)
BEGIN
	print 'Insert into cfg.servers - ' + @dbServerName
	INSERT INTO cfg.Servers (ServerName,ActiveRowInd,CreatedDtm)
	VALUES (@dbServerName,1,getdate())
	SELECT @dbServerID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	print 'The server ' + @dbServerName + ' has already been configured.'
	SELECT TOP 1 @dbServerID  = s.ServerID FROM cfg.Servers s (Nolock) WHERE s.ServerName = @dbServerName
END

---- db Connection
DECLARE @ConnectionName VARCHAR(255)= 'RAWDB.ADONet'
DECLARE @InitialCatalog VARCHAR(100) = 'RAW'
DECLARE @ConnectionString VARCHAR(max) = 'Data Source= ' + @dbServerName + ';Initial Catalog=' + @InitialCatalog + ';Integrated Security=True;Application Name=' + @ConnectionName + ';'
DECLARE @dbConnectionID INT

IF NOT EXISTS(SELECT TOP 1 1 FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @dbServerID)
BEGIN
	INSERT INTO cfg.DbConnections(ServerID,ConnectionName,Connectionstring,InitialCatalog,ActiveRowInd,CreatedDtm)
	VALUES(@dbServerID,@ConnectionName,@ConnectionString,@InitialCatalog,1,getdate())
	SELECT	@dbConnectionID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	SELECT TOP 1 @dbConnectionID = dc.DbConnectionID FROM cfg.DbConnections dc WITH (NOLOCK) WHERE dc.ConnectionName = @ConnectionName AND DC.ServerID = @dbServerID
END

---- Package Connection
select @PackageName,@PackageID,@dbConnectionID

DECLARE @PackageConnectionID INT
EXEC cfg.AddSSISPackageConnection @PackageID,@dbConnectionID,@PackageConnectionID OUTPUT
select @PackageConnectionID

---- File Server
DECLARE @Protocol VARCHAR(100) = 'UNC'
DECLARE @FileConnectionID INT

IF NOT EXISTS(SELECT TOP 1 1 FROM cfg.FileConnections fc WITH (NOLOCK) WHERE fc.ServerID = @dbServerID AND fc.Protocol = @Protocol)
BEGIN
	INSERT INTO cfg.FileConnections(ServerID,SshHostKey,UserName,Password,Protocol,ExecutablePath,Port,ActiveRowInd,CreatedDtm)
	VALUES (@dbServerID,NULL,NULL,NULL,@Protocol,NULL,NULL,1,GETDATE())
	SELECT @FileConnectionID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	PRINT 'The file connection ' + @dbServerName + ' has already been configured.'
	SELECT TOP 1 @FileConnectionID = fc.FileConnectionID FROM cfg.FileConnections fc WITH (NOLOCK) WHERE fc.ServerID = @dbServerID AND fc.Protocol = @Protocol
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE CR_ApplicationName CURSOR READ_ONLY
FOR

SELECT 62 AS FileLoadID, 
'Carnival CSP Call Interaction File Load 218' AS FileLoadName, 
'Carnival CSP Call Interaction File Load 218' AS Control_Load_Nm, 
'Arise_CSP_Call_Interaction_Report_218_yyyyMMdd' AS [FileName],
(SELECT fm.FileMappingID from cfg.FileMapping fm with(nolock) where fm.TableName = 'Call_Interaction_Activity' and fm.FileMappingName = 'CallInteractionActivity_StandardLogic') AS FileMappingID

UNION
SELECT 63 , 
'Carnival CSP Call Interaction File Load 435' , 
'Carnival CSP Call Interaction File Load 435' , 
'Arise_CSP_Call_Interaction_Report_435_yyyyMMdd' ,
(SELECT fm.FileMappingID from cfg.FileMapping fm with(nolock) where fm.TableName = 'Call_Interaction_Activity' and fm.FileMappingName = 'CallInteractionActivity_ScheduleBasedLogic') 

UNION
SELECT 64 , 
'Carnival CSP Call Interaction File Load 440' , 
'Carnival CSP Call Interaction File Load 440' , 
'Arise_CSP_Call_Interaction_Report_440_yyyyMMdd' ,
(SELECT fm.FileMappingID from cfg.FileMapping fm with(nolock) where fm.TableName = 'Call_Interaction_Activity' and fm.FileMappingName = 'CallInteractionActivity_ScheduleBasedLogic') 

UNION
SELECT 89 , 
'Carnival CSP Call Interaction File Load 970' , 
'Carnival CSP Call Interaction File Load 970' , 
'Arise_CSP_Call_Interaction_Report_970_yyyyMMdd' ,
(SELECT fm.FileMappingID from cfg.FileMapping fm with(nolock) where fm.TableName = 'Call_Interaction_Activity' and fm.FileMappingName = 'CallInteractionActivity_StandardLogic') 

UNION
SELECT 101 , 
'Carnival CSP Call Interaction File Load 1081' , 
'Carnival CSP Call Interaction File Load 1081' , 
'Arise_CSP_Call_Interaction_Report_1081_yyyyMMdd' ,
(SELECT fm.FileMappingID from cfg.FileMapping fm with(nolock) where fm.TableName = 'Call_Interaction_Activity' and fm.FileMappingName = 'CallInteractionActivity_StandardLogic') 

OPEN CR_ApplicationName
FETCH NEXT FROM CR_ApplicationName INTO @FileLoadID, @FileLoadName, @Control_Load_Nm, @FileName, @FileMappingID
WHILE @@FETCH_STATUS = 0
    BEGIN

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- FileLoad
IF EXISTS (SELECT 1 FROM cfg.InteractionDataFileLoad fl WITH(NOLOCK) WHERE fl.FileLoadID = @FileLoadID)
/*Updates the schema name and filetypeid as null for genz framework*/
BEGIN
	UPDATE fl
	SET fl.[Schema] = @Schema
	,fl.FileTypeID = null
	FROM cfg.InteractionDataFileLoad fl
	WHERE fl.FileLoadID = @FileLoadID
END
ELSE
BEGIN
EXECUTE [SSISConfig].[cfg].AddSSISFileLoad_Identity_Insert 
	@FileLoadID = @FileLoadID, 
	@ClientID = @ClientID,
	@Source_System_ID = @Source_System_ID,
	@Application_ID = @Application_ID,
	@FileLoadName = @FileLoadName,
	@Control_Load_Nm = @Control_Load_Nm,
	@RootFolder = @RootFolder,
	@FileName = @FileName,
	@FileTypeID = @FileTypeID,
	@ProcessStartTime = @ProcessStartTime,
	@ExpectedFileTime =@ExpectedFileTime,
	@AllowableDelay = @AllowableDelay,
	@BusLogicUSPName = @BusLogicUSPName,
	@BusLogicUSPName_AriseDM = @BusLogicUSPName_AriseDM,
	@FileTimeZone = @TimeZone_id,
	@DoesAppendData = @DoesAppendData,
	@AppendFileFrequency = @AppendFileFrequency,
	@AppendFileCount = @AppendFileCount,
	@AppendCompletePercent = @AppendCompletePercent,
	@IsAlert = @IsAlert,
	@AlertContactEmail = @AlertContactEmail,
	@FileConvertNeeded = 0,
	@FileConvertPkgName = NULL,
	@FileConvertPKGPath = NULL,
	@ErrorContactEmail = @ErrorContactEmail,
	@Active = 1,
	@ProcessHagent = 1,
	@ProcessIHI =  1,
	@DebugMode = 0,
	@ConversionPackageID = NULL,
	@DateFileMask = @DateFileMask ,
	@FileRetentionDays = 90,
	@Schema = @Schema
END
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- Application Package Xref
DECLARE @ExecutionOrder INT = 1
DECLARE @AppPackageID INT
IF Not Exists(   
 SELECT top 1 1  
 FROM cfg.AppPackagesXRef x WITH (NOLOCK)  
 WHERE x.ApplicationID = @ApplicationID  
 AND x.PackageID = @PackageID  
 AND x.ExecutionOrder = @ExecutionOrder
 AND x.FileLoadID = @FileLoadID 
 )  
 BEGIN  
  PRINT char(9) +  ' - Insert AppPackage for (' + @ApplicationName + '/' + @PackageName + '/' + @FileLoadName + ').'   
    INSERT INTO cfg.AppPackagesXRef (ApplicationID,PackageID ,ExecutionOrder,FileLoadID)  
    VALUES (@ApplicationID, @PackageID, @ExecutionOrder,@FileLoadID)  
      
    SET @AppPackageID = SCOPE_IDENTITY()  
 END  
 ELSE  
 BEGIN  
  PRINT char(9) +  ' - Insert AppPackage for (' + @ApplicationName + '/' + @PackageName + '/' + @FileLoadName + ') already exists.'  
  SELECT @AppPackageID = x.AppPackageID  
  FROM cfg.AppPackagesXRef x WITH (NOLOCK)  
  WHERE x.ApplicationID = @ApplicationID  
  AND  x.PackageID = @PackageID  
  AND  x.ExecutionOrder = @ExecutionOrder
  AND  x.FileLoadID = @FileLoadID 
 END 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FileID
EXEC cfg.AddSSISFile @Extension,@DateMask,@FileName,@MaxAllowedRows,@Delimiter,@Has_File_Header, @FileID OUTPUT

---- File Transfer
EXEC cfg.AddSSISFileTransfer @AppPackageID,@FileConnectionID,@FileID,@SourcePath,@DestinationPath,@Direction,@ArchiveFileInd,@RemoveFileInd,@TimeZoneID,@FileTransferID OUTPUT

--- fileload file transfer
EXEC	cfg.AddSSISFileLoadFileTransfer @FileLoadID, @FileTransferID, @FileMappingID ,@BatchSize, @DBConnectionID, @FileLoadFileTransferID OUTPUT

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

	  FETCH NEXT FROM CR_ApplicationName INTO @FileLoadID, @FileLoadName, @Control_Load_Nm, @FileName, @FileMappingID
	END
CLOSE CR_ApplicationName
DEALLOCATE CR_ApplicationName








