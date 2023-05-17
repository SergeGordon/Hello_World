USE SSISConfig
GO

SELECT  x.*,p.PackageName,f.Mask,dt.ObjectName,dt.[Schema],dt.TargetName,fm.TableName,idfl.FileLoadName,idfl.[Schema]
FROM	cfg.Applications a with (nolock)
join	cfg.AppPackagesXRef x with (nolock) on a.ApplicationID = x.ApplicationID
join	cfg.Packages p with (nolock)on x.PackageID = p.PackageID
left join	cfg.FileTransfers ft (nolock) on ft.AppPackageID = x.AppPackageID
left join cfg.FileLoadFileTransfer flft with (nolock) on flft.FileTransferID = ft.FileTransferID
left join	cfg.FileMapping fm with (nolock) on flft.FileMappingID = fm.FileMappingID
left join	cfg.Files f with (nolock) on ft.FileID = f.FileID
left join	cfg.DBTransfers dt with (nolock) on dt.AppPackageID = x.AppPackageID
left join cfg.InteractionDataFileLoad idfl with (nolock) on idfl.FileLoadID = flft.FileLoadID

where	a.ApplicationName = 'Carnival_Call_Interaction_Standard'