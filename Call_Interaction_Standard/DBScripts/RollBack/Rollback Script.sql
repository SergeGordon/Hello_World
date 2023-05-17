USE SSISConfig
GO
DECLARE @Application_Name varchar(255) = 'Carnival_Call_Interaction_Standard'
--DECLARE @FileLoadName     varchar(255) = 'Carnival CSP Call Interaction File Load 435'

DELETE	dt
FROM	cfg.Applications a
join	cfg.AppPackagesXRef x on a.ApplicationID = x.ApplicationID
join	cfg.DBTransfers dt with (nolock) on x.AppPackageID = dt.AppPackageID
WHERE	a.ApplicationName = @Application_Name
PRINT 'DELETE (' + convert(VARCHAR(10),@@Rowcount)  + ') rows for DBTransfers: '  + @Application_Name

DELETE	flft
FROM	cfg.Applications a
join	cfg.AppPackagesXRef x on a.ApplicationID = x.ApplicationID
join	cfg.FileTransfers ft with (nolock) on ft.AppPackageID = x.AppPackageID
join	cfg.FileLoadFileTransfer flft with (nolock) on flft.FileTransferID = ft.FileTransferID
WHERE	a.ApplicationName = @Application_Name
PRINT 'DELETE (' + convert(VARCHAR(10),@@Rowcount)  + ') rows for FileLoadFileTransfer: '  + @Application_Name

DELETE	ft
FROM	cfg.Applications a
join	cfg.AppPackagesXRef x on a.ApplicationID = x.ApplicationID
join	cfg.FileTransfers ft with (nolock) on ft.AppPackageID = x.AppPackageID
WHERE	a.ApplicationName = @Application_Name
PRINT 'DELETE (' + convert(VARCHAR(10),@@Rowcount)  + ') rows for FileTransfer:  ' + @Application_Name
--select f.*
DELETE	f
FROM	cfg.Files f with (nolock) 
WHERE	f.Mask in ('Arise Call Interaction Report')
PRINT 'DELETE (' + convert(VARCHAR(10),@@Rowcount)  + ') rows for File(s): ' + @Application_Name

DELETE	x
FROM	cfg.Applications a
join	cfg.AppPackagesXRef x on a.ApplicationID = x.ApplicationID
WHERE	a.ApplicationName = @Application_Name
PRINT 'DELETE (' + convert(VARCHAR(10),@@Rowcount)  + ') rows for AppPackagesXRef: '  + @Application_Name

DELETE	a
FROM	cfg.Applications a
WHERE	a.ApplicationName = @Application_Name
PRINT 'DELETE (' + convert(VARCHAR(10),@@Rowcount)  + ') rows for Applications: '  + @Application_Name

/*
DELETE	flcam
FROM	SSISConfig.cfg.InteractionDataFileLoad idfl with (nolock)
JOIN	SSISConfig.cfg.FileLoadClientApplicationMapping flcam with (Nolock) on idfl.FileLoadID = flcam.FileLoadID
WHERE	idfl.FileLoadName = @FileLoadName
PRINT 'DELETE (' + convert(VARCHAR(10),@@Rowcount)  + ') rows for FileLoadClientApplicationMapping: ' + @FileLoadName

DELETE	idfl
FROM	cfg.InteractionDataFileLoad idfl with (nolock) 
WHERE	idfl.FileLoadName = @FileLoadName
PRINT 'DELETE (' + convert(VARCHAR(10),@@Rowcount)  + ') rows for InteractionDataFileLoad: ' + @FileLoadName

*/