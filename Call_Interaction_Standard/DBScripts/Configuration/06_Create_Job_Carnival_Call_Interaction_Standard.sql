USE [msdb]
GO

BEGIN TRANSACTION
IF EXISTS (SELECT job_id 
            FROM msdb.dbo.sysjobs_view 
            WHERE name = N'Carnival_Call_Interaction_Standard')
/****** Object:  Job [Export_Instacart_Schedule_Info_DailyLookAhead]    Script Date: 1/12/2021 5:24:40 AM ******/
EXEC msdb.dbo.sp_delete_job @job_name=N'Carnival_Call_Interaction_Standard', @delete_unused_schedule=1
GO


/****** Object:  Job [Signet_Call_Interaction_Standard]    Script Date: 10/1/2020 7:25:19 AM ******/

DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [GEO]    Script Date: 10/1/2020 7:25:19 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'GEO' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'GEO'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Carnival_Call_Interaction_Standard', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Carnival Job', 
		@category_name=N'GEO', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Check if AG is Primary]    Script Date: 10/1/2020 7:25:19 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Check if AG is Primary', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=1, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.VerifyIsPrimaryNode', 
		@database_name=N'SSISConfig', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Signet_Call_Interaction_Standard]    Script Date: 10/1/2020 7:25:19 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Carnival_Call_Interaction_Standard', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/FILE "\"F:\Data Repository\SSIS\DataTransfer\FileLoadTransferMain.dtsx\"" /CONFIGFILE "\"F:\Data Repository\SSIS\Carnival\Carnival_Serialization\Call_Interaction_Standard\Configuration Files\Call_Interaction_Standard.dtsConfig\"" /CHECKPOINTING OFF /REPORTING E', 
		@database_name=N'master', 
		@flags=0, 
		@proxy_name=N'SSIS_proxy'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Quit Job Email Notification Failure]    Script Date: 10/1/2020 7:25:19 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Quit Job Email Notification Failure', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=2, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'---     Job Failure Notification
	Declare @msgSubject varchar(150) ,@msgBody varchar(500)
	DECLARE	@NJobName varchar(100) = ''Carnival_Call_Interaction_Standard''
	SET @msgSubject =''Job Failed - '' + @NJobName + '' on '' + @@SERVERNAME
	SET @msgBody   = ''Job Failed - '' + @NJobName + '' on '' + @@SERVERNAME
	EXEC SSISConfig.alert.spSend_Email_Failure  @msgSubject,@msgBody', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Carnival_Call_Interaction_Standard', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190919, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=80000--, 
		--@schedule_uid=N'44577544-d3fb-4f9f-bbcc-7c9c7438d785'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


