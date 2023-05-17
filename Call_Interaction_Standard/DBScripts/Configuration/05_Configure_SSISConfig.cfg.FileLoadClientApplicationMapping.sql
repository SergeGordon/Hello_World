USE SSISConfig
GO
SET NOCOUNT ON
GO
DECLARE @FileLoadID INT

--------------------------------------------------------------------------------------------------------------------------------------------------------------
---FileLoadID - 62
SELECT @FileLoadID = idfl.FileLoadID
FROM	SSISConfig.cfg.InteractionDataFileLoad idfl with (nolock)
where	idfl.FileLoadName in ('Carnival CSP Call Interaction File Load 218')

----- FINAL INSERT 
IF NOT EXISTS(SELECT * FROM cfg.FileLoadClientApplicationMapping flcam with (nolock) WHERE flcam.FileLoadID = @FileLoadID AND flcam.application_id = 218)
BEGIN
	PRINT 'Insert into SSISConfig.cfg.FileLoadClientApplicationMapping for Fileload Name = "Carnival CSP Call Interaction File Load 218" and application Name = "Carnival Travel Agent Sales"' 
	INSERT INTO SSISConfig.cfg.FileLoadClientApplicationMapping(FileLoadID,client_id,application_id,ActiveRowInd,CreatedDtm)
	SELECT  @FileLoadID, a.client_id,a.application_id,1,getdate()
	FROM	LS_DRE.Integration.dbo.Application a (nolock)
	-- applications to be identified and configured,
	JOIN	LS_DRE.Integration.dbo.Client c with (nolock) on a.client_id = c.client_id
	where	a.application_id IN (218)
			AND a.PF_application_ind=0 
			AND a.application_status_id=1
	ORDER BY a.client_id,a.application_id
END

ELSE 

BEGIN
	PRINT 'The Fileload Name = "Carnival CSP Call Interaction File Load 218" configuration for FileLoadClientApplicationMapping, already exists.' 
END

--------------------------------------------------------------------------------------------------------------------------------------------------------------
--- FileLoadID - 63
SELECT @FileLoadID = idfl.FileLoadID
FROM	SSISConfig.cfg.InteractionDataFileLoad idfl with (nolock)
where	idfl.FileLoadName in ('Carnival CSP Call Interaction File Load 435')

----- FINAL INSERT 
IF NOT EXISTS(SELECT * FROM cfg.FileLoadClientApplicationMapping flcam with (nolock) WHERE flcam.FileLoadID = @FileLoadID AND flcam.application_id = 435)
BEGIN
	PRINT 'Insert into SSISConfig.cfg.FileLoadClientApplicationMapping for Fileload Name = "Carnival CSP Call Interaction File Load 435" and application Name = "Carnival Direct Sales"' 
	INSERT INTO SSISConfig.cfg.FileLoadClientApplicationMapping(FileLoadID,client_id,application_id,ActiveRowInd,CreatedDtm)
	SELECT  @FileLoadID, a.client_id,a.application_id,1,getdate()
	FROM	LS_DRE.Integration.dbo.Application a (nolock)
	-- applications to be identified and configured,
	JOIN	LS_DRE.Integration.dbo.Client c with (nolock) on a.client_id = c.client_id
	where	a.application_id IN (435)
			AND a.PF_application_ind=0 
			AND a.application_status_id=1
	ORDER BY a.client_id,a.application_id
END

ELSE 

BEGIN
	PRINT 'The Fileload Name = "Carnival CSP Call Interaction File Load 435" and application Name = "Carnival Direct Sales MAX" configuration for FileLoadClientApplicationMapping, already exists.' 
END

IF NOT EXISTS(SELECT * FROM cfg.FileLoadClientApplicationMapping flcam with (nolock) WHERE flcam.FileLoadID = @FileLoadID AND flcam.application_id = 3521)
BEGIN
	PRINT 'Insert into SSISConfig.cfg.FileLoadClientApplicationMapping for Fileload Name = "Carnival CSP Call Interaction File Load 435" and application Name = "Carnival Direct Sales MAX"' 
	INSERT INTO SSISConfig.cfg.FileLoadClientApplicationMapping(FileLoadID,client_id,application_id,ActiveRowInd,CreatedDtm)
	SELECT  @FileLoadID, a.client_id,a.application_id,1,getdate()
	FROM	LS_DRE.Integration.dbo.Application a (nolock)
	-- applications to be identified and configured,
	JOIN	LS_DRE.Integration.dbo.Client c with (nolock) on a.client_id = c.client_id
	where	a.application_id IN (3521)
			AND a.PF_application_ind=0 
			AND a.application_status_id=1
	ORDER BY a.client_id,a.application_id
END

ELSE 

BEGIN
	PRINT 'The Fileload Name = "Carnival CSP Call Interaction File Load 435" and application Name = "Carnival Direct Sales MAX" configuration for FileLoadClientApplicationMapping, already exists.' 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
------ FileLoadID - 64
SELECT @FileLoadID = idfl.FileLoadID
FROM	SSISConfig.cfg.InteractionDataFileLoad idfl with (nolock)
where	idfl.FileLoadName in ('Carnival CSP Call Interaction File Load 440')

----- FINAL INSERT 
IF NOT EXISTS(SELECT * FROM cfg.FileLoadClientApplicationMapping flcam with (nolock) WHERE flcam.FileLoadID = @FileLoadID AND flcam.application_id = 440)
BEGIN
	PRINT 'Insert into SSISConfig.cfg.FileLoadClientApplicationMapping for Fileload Name = "Carnival CSP Call Interaction File Load 440" and application Name = "Carnival Customer Service"' 
	INSERT INTO SSISConfig.cfg.FileLoadClientApplicationMapping(FileLoadID,client_id,application_id,ActiveRowInd,CreatedDtm)
	SELECT  @FileLoadID, a.client_id,a.application_id,1,getdate()
	FROM	LS_DRE.Integration.dbo.Application a (nolock)
	-- applications to be identified and configured,
	JOIN	LS_DRE.Integration.dbo.Client c with (nolock) on a.client_id = c.client_id
	where	a.application_id IN (440)
			AND a.PF_application_ind=0 
			AND a.application_status_id=1
	ORDER BY a.client_id,a.application_id
END

ELSE 

BEGIN
	PRINT 'The Fileload Name = "Carnival CSP Call Interaction File Load 440" and application Name = "Carnival Customer Service" configuration for FileLoadClientApplicationMapping, already exists.' 
END

IF NOT EXISTS(SELECT * FROM cfg.FileLoadClientApplicationMapping flcam with (nolock) WHERE flcam.FileLoadID = @FileLoadID AND flcam.application_id = 3520)
BEGIN
	PRINT 'Insert into SSISConfig.cfg.FileLoadClientApplicationMapping for Fileload Name = "Carnival CSP Call Interaction File Load 440" and application Name = "Carnival Customer Service MAX"' 
	INSERT INTO SSISConfig.cfg.FileLoadClientApplicationMapping(FileLoadID,client_id,application_id,ActiveRowInd,CreatedDtm)
	SELECT  @FileLoadID, a.client_id,a.application_id,1,getdate()
	FROM	LS_DRE.Integration.dbo.Application a (nolock)
	-- applications to be identified and configured,
	JOIN	LS_DRE.Integration.dbo.Client c with (nolock) on a.client_id = c.client_id
	where	a.application_id IN (3520)
			AND a.PF_application_ind=0 
			AND a.application_status_id=1
	ORDER BY a.client_id,a.application_id
END

ELSE 

BEGIN
	PRINT 'The Fileload Name = "Carnival CSP Call Interaction File Load 440" and application Name = "Carnival Customer Service MAX" configuration for FileLoadClientApplicationMapping, already exists.' 
END

IF NOT EXISTS(SELECT * FROM cfg.FileLoadClientApplicationMapping flcam with (nolock) WHERE flcam.FileLoadID = @FileLoadID AND flcam.application_id = 3546)
BEGIN
	PRINT 'Insert into SSISConfig.cfg.FileLoadClientApplicationMapping for Fileload Name = "Carnival CSP Call Interaction File Load 440" and application Name = "Carnival Customer Service NS"' 
	INSERT INTO SSISConfig.cfg.FileLoadClientApplicationMapping(FileLoadID,client_id,application_id,ActiveRowInd,CreatedDtm)
	SELECT  @FileLoadID, a.client_id,a.application_id,1,getdate()
	FROM	LS_DRE.Integration.dbo.Application a (nolock)
	-- applications to be identified and configured,
	JOIN	LS_DRE.Integration.dbo.Client c with (nolock) on a.client_id = c.client_id
	where	a.application_id IN (3546)
			AND a.PF_application_ind=0 
			AND a.application_status_id=1
	ORDER BY a.client_id,a.application_id
END

ELSE 

BEGIN
	PRINT 'The Fileload Name = "Carnival CSP Call Interaction File Load 440" and application Name = "Carnival Customer Service NS" configuration for FileLoadClientApplicationMapping, already exists.' 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
------ FileLoadID - 89
SELECT @FileLoadID = idfl.FileLoadID
FROM	SSISConfig.cfg.InteractionDataFileLoad idfl with (nolock)
where	idfl.FileLoadName in ('Carnival CSP Call Interaction File Load 970')

----- FINAL INSERT 
IF NOT EXISTS(SELECT * FROM cfg.FileLoadClientApplicationMapping flcam with (nolock) WHERE flcam.FileLoadID = @FileLoadID AND flcam.application_id = 970)
BEGIN
	PRINT 'Insert into SSISConfig.cfg.FileLoadClientApplicationMapping for Fileload Name = "Carnival CSP Call Interaction File Load 970"' 
	INSERT INTO SSISConfig.cfg.FileLoadClientApplicationMapping(FileLoadID,client_id,application_id,ActiveRowInd,CreatedDtm)
	SELECT  @FileLoadID, a.client_id,a.application_id,1,getdate()
	FROM	LS_DRE.Integration.dbo.Application a (nolock)
	-- applications to be identified and configured,
	JOIN	LS_DRE.Integration.dbo.Client c with (nolock) on a.client_id = c.client_id
	where	a.application_id IN (970)
			AND a.PF_application_ind=0 
			AND a.application_status_id=1
	ORDER BY a.client_id,a.application_id
END

ELSE 

BEGIN
	PRINT 'The Fileload Name = "Carnival CSP Call Interaction File Load 970" configuration for FileLoadClientApplicationMapping, already exists.' 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
------ FileLoadID - 101
SELECT @FileLoadID = idfl.FileLoadID
FROM	SSISConfig.cfg.InteractionDataFileLoad idfl with (nolock)
where	idfl.FileLoadName in ('Carnival CSP Call Interaction File Load 1081')

----- FINAL INSERT 
IF NOT EXISTS(SELECT * FROM cfg.FileLoadClientApplicationMapping flcam with (nolock) WHERE flcam.FileLoadID = @FileLoadID AND flcam.application_id = 1081)
BEGIN
	PRINT 'Insert into SSISConfig.cfg.FileLoadClientApplicationMapping for Fileload Name = "Carnival CSP Call Interaction File Load 1081"' 
	INSERT INTO SSISConfig.cfg.FileLoadClientApplicationMapping(FileLoadID,client_id,application_id,ActiveRowInd,CreatedDtm)
	SELECT  @FileLoadID, a.client_id,a.application_id,1,getdate()
	FROM	LS_DRE.Integration.dbo.Application a (nolock)
	-- applications to be identified and configured,
	JOIN	LS_DRE.Integration.dbo.Client c with (nolock) on a.client_id = c.client_id
	where	a.application_id IN (1081)
			AND a.PF_application_ind=0 
			AND a.application_status_id=1
	ORDER BY a.client_id,a.application_id
END

ELSE 

BEGIN
	PRINT 'The Fileload Name = "Carnival CSP Call Interaction File Load 1081" configuration for FileLoadClientApplicationMapping, already exists.' 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------