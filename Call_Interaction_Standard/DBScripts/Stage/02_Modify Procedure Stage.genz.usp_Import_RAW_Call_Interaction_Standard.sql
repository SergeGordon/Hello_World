USE [Stage]
GO

/****** Object:  StoredProcedure [genz].[usp_Import_RAW_Call_Interaction_Standard]    Script Date: 3/21/2022 8:30:39 AM ******/
DROP PROCEDURE IF EXISTS [genz].[usp_Import_RAW_Call_Interaction_Standard];  
GO 

/****** Object:  StoredProcedure [genz].[usp_Import_RAW_Call_Interaction_Standard]    Script Date: 3/21/2022 8:30:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	/*******************************************************************
	Description: Used to insert the Fileload data to Stage schema table from the schema based  raw table.
	How to use:  EXEC GenZ.usp_Import_RAW_Call_Interaction_Standard 63
	Revision History:
	Updated By		Update Date		Description
	sgordon			4/7/2017			Initial Draft
	sgordon			6/12/2020       create a GenZ version for Timezone
	KBiswal			03/21/2022		Added FileloadID in the last delete statement of Stage.IHI table
	*******************************************************************/
	CREATE PROCEDURE [genz].[usp_Import_RAW_Call_Interaction_Standard]
	-- GenZ.usp_Import_RAW_Call_Interaction_Standard
	@FileLoadID	INT 
	AS
	SET NOCOUNT ON
	DECLARE	@RowCount INT = 0
	DECLARE	@Schema NVARCHAR(50)
	DECLARE	@nSQL NVARCHAR(MAX)
	DECLARE	@TZ_ID_FROM NVARCHAR(15)
	DECLARE	@TZ_ID_TO NVARCHAR(15) = '77'
	DECLARE	@nFileLoadID nvarchar(50) = convert(nvarchar(50),@FileLoadID)
	DECLARE	@procedure_name VARCHAR(100) =OBJECT_NAME(@@procid)
	DECLARE @procedure_section varchar(100)
	DECLARE @object_called varchar(100)= 'none'
	
	BEGIN TRY
		SELECT	 @TZ_ID_FROM = fl.Time_Zone_ID
				,@Schema = fl.[Schema]					
		FROM	LS_SSIS.SSISConfig.cfg.InteractionDataFileLoad fl WITH (NOLOCK)
		WHERE	fl.FileLoadID = @FileLoadID

		--------- delete the records in stage that are not in error.
		SET	@procedure_section = 'delete stage database data.'
		SET @nSQL = N'
		IF EXISTS(	select top 1 1	
		FROM	stage.' + @Schema + '.Intra_hour_interaction as T 
		WHERE	t.FileLoadID= ' + @nFileLoadID + ' AND	t.error_row_ind = 0)
		DELETE	T
		FROM	stage.' + @Schema + '.Intra_hour_interaction as T 
		WHERE	t.FileLoadID=' + @nFileLoadID + ' AND t.error_row_ind = 0
		SELECT @Rowcount = @@ROWCOUNT'
		--PRINT @nsql
		EXEC SP_EXECUTESQL @nSQL,N'@Rowcount INT OUTPUT',@Rowcount = @Rowcount OUTPUT
			
		-- delete the existing data from stage.	
		SET	@procedure_section = 'delete stage database data.'
		SET @nSQL = N'
		IF EXISTS(	select top 1 1	
		FROM	stage.' + @Schema + '.Intra_hour_interaction as T 
		JOIN	RAW.' + @Schema + '.call_interaction_standard S (nolock) on t.FileLoadID = s.FileLoadID AND t.data_collection_dt = s.row_date
		WHERE	t.FileLoadID= ' + @nFileLoadID + ')
		DELETE	T
		FROM	stage.' + @Schema + '.Intra_hour_interaction as T 
		JOIN	RAW.' + @Schema + '.call_interaction_standard S (nolock) on t.FileLoadID = s.FileLoadID AND t.data_collection_dt = s.row_date
		WHERE	t.FileLoadID=' + @nFileLoadID + '
		SELECT @Rowcount = @@ROWCOUNT'
		--PRINT @nsql
		EXEC SP_EXECUTESQL @nSQL,N'@Rowcount INT OUTPUT',@Rowcount = @Rowcount OUTPUT

		-- delete the duplicate data from stage.	
		SET	@procedure_section = 'delete stage database data.'
		SET @nSQL = N'
		IF EXISTS(	select top 1 1	
		FROM	stage.' + @Schema + '.Intra_hour_interaction as T 
		JOIN	RAW.' + @Schema + '.call_interaction_standard S (nolock) on t.client_login_id = s.logid AND t.split_desc = s.split 
		and t.interval_start_utc_dtm = s.starttime_utc
		AND t.FileLoadID = s.FileLoadID
		AND t.FileLoadID = ' + @nFileLoadID + ')
		DELETE	T
		FROM	stage.' + @Schema + '.Intra_hour_interaction as T 
		JOIN	RAW.' + @Schema + '.call_interaction_standard S (nolock) on t.client_login_id = s.logid AND t.split_desc = s.split 
		and t.interval_start_utc_dtm = s.starttime_utc
		AND t.FileLoadID = s.FileLoadID
		AND t.FileLoadID = ' + @nFileLoadID +'
		SELECT @Rowcount = @@ROWCOUNT'
		--PRINT @nsql
		EXEC SP_EXECUTESQL @nSQL,N'@Rowcount INT OUTPUT',@Rowcount = @Rowcount OUTPUT

			
		SET	@procedure_section = 'insert the data from call_interaction_standard into stage IHI table.'

		SET @nSQL = N'
			INSERT INTO Stage.' + @Schema + '.Intra_Hour_Interaction(abn_call_cnt,abn_second_cnt,acd_aux_int_out_second_cnt,acd_call_cnt,acd_int_second_cnt,acd_tot_second_count
				,acp_available_second_cnt,acw_int_out_second_cnt,acw_int_second_cnt,acw_out_call_cnt,acw_out_tot_second_cnt,acw_tot_second_cnt,ans_ring_tot_second_cnt,application_id
				,aux_int_out_second_cnt,aux_int_second_cnt,aux_out_call_cnt,aux_tot_out_second_cnt,aux_total_second_cnt
				,aux0_tot_second_cnt,aux1_tot_second_cnt,aux2_tot_second_cnt,aux3_tot_second_cnt,aux4_tot_second_cnt
				,aux5_tot_second_cnt,aux6_tot_second_cnt,aux7_tot_second_cnt,aux8_tot_second_cnt,aux9_tot_second_cnt,call_conference_cnt,call_transfer_cnt,client_login_id
				,data_collection_dt,hold_abn_call_cnt,hold_call_cnt,hold_second_cnt,i_acd_other_second_cnt,interval_second_cnt,noan_call_cnt
				,other_int_second_cnt,ring_call_cnt,ring_int_second_cnt,ring_tot_second_cnt,skill_staff_second_cnt,split_desc,tot_avail_second_cnt,total_staff_second_cnt
				,AppInstanceID,FileLoadID,load_schedule_id,created_dtm
				,interval_start_dtm,interval_start_utc_dtm,interval_start_tm,outflowcalls
				,AnsTime,Acceptable,AltNum1,AltNum2,AltNum3,AltNum4,AltNum5,AltNum6,AltNum7,AltNum8
			    ,AltNum9,AltNum10,AltNum11,AltNum12,AltNum13,AltNum14,AltNum15,AltNum16)	
				
			SELECT s.abncalls,s.abntime,s.i_acdaux_outtime,s.acdcalls,s.i_acdtime,s.acdtime
				,s.i_availtime,s.i_acwouttime,s.i_acwtime,s.acwoutcalls,s.acwouttime,s.acwtime,s.ansringtime,s.program_id
				,s.i_auxouttime,s.i_auxtime,s.auxoutcalls,s.auxouttime,s.ti_auxtime
				,s.ti_auxtime0,s.ti_auxtime1,s.ti_auxtime2,s.ti_auxtime3,s.ti_auxtime4
				,s.ti_auxtime5,s.ti_auxtime6,s.ti_auxtime7,s.ti_auxtime8,s.ti_auxtime9,s.conference,s.transferred,s.logid
				,s.row_date,s.holdabncalls,s.holdcalls,s.holdtime,s.i_acdothertime,s.intrvl,s.noansredir
				,s.i_othertime,s.ringcalls,s.i_ringtime,s.ringtime,s.i_stafftime,s.split,s.ti_availtime,s.ti_stafftime
				,s.AppInstanceID,s.FileLoadID,s.load_schedule_id,s.created_dtm
				,s.starttime, s.starttime_utc,CONVERT(int,REPLACE(CONVERT(varchar(5),CONVERT(TIME,s.starttime)),'':'',''''))
				,s.outflowcalls,s.AnsTime,s.Acceptable,s.AltNum1,s.AltNum2,s.AltNum3,s.AltNum4,s.AltNum5,s.AltNum6,s.AltNum7,s.AltNum8
			    ,s.AltNum9,s.AltNum10,s.AltNum11,s.AltNum12,s.AltNum13,s.AltNum14,s.AltNum15,s.AltNum16
			FROM	RAW.'+ @Schema + '.call_interaction_standard S WITH (NOLOCK)
			WHERE	s.FileLoadID = ' + @nFileLoadID + '
			SELECT @Rowcount = @@ROWCOUNT;'
		PRINT @nsql
		EXEC SP_EXECUTESQL @nSQL,N'@Rowcount INT OUTPUT',@Rowcount = @Rowcount OUTPUT

		SELECT @Rowcount TotalRecords
	END TRY
	-- Raise any error encountered during the process.		 
	BEGIN CATCH
		EXEC Integration.alert.ThrowError @procedure_name, @procedure_section, @object_called
	END CATCH





GO


