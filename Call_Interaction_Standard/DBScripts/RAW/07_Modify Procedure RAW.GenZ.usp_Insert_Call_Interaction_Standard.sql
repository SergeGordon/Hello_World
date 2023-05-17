USE [RAW]
GO

/****** Object:  StoredProcedure [GenZ].[usp_Insert_Call_Interaction_Standard]    Script Date: 3/11/2022 11:18:48 AM ******/
DROP PROCEDURE IF EXISTS [GenZ].[usp_Insert_Call_Interaction_Standard];  
GO 

/****** Object:  StoredProcedure [GenZ].[usp_Insert_Call_Interaction_Standard]    Script Date: 3/11/2022 11:18:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	/*******************************************************************
	Description: Used to insert the data from the truncate and load schema based
			     call_interaction table to the schema based call_interaction_merge table.
	How to use:  EXEC GenZ.usp_Insert_Call_Interaction_Standard 62
	Revision History:
	Updated By		Update Date		Description
	sgordon			4/7/2017			Initial Draft
	cheldx			8/19/2019			changed filedate to row_date	
	cheldx			10/09/2019			added outflowcalls US68691
	cheldx			10/16/2019			removed outflowcalls from GenZ schema SP as it will be added to Five9
	kbiswal			03/11/2022			Used Delete cmd instead of Truncate to clean the table for Serialization loads.
	*******************************************************************/
	CREATE Procedure [GenZ].[usp_Insert_Call_Interaction_Standard]
	  @FileLoadID INT
       AS
       SET NOCOUNT ON
       DECLARE       @Schema NVARCHAR(50)
       DECLARE       @nSQL NVARCHAR(MAX)
       DECLARE       @nFileLoadID nvarchar(50) = convert(nvarchar(50),@FileLoadID)
      -- DECLARE       @nFileDate NVARCHAR(255) = CONVERT(NVARCHAR(255), @FileDate)
       DECLARE       @RowCount INT =0
       DECLARE       @procedure_name VARCHAR(100) =OBJECT_NAME(@@procid)
       DECLARE @procedure_section varchar(100)= 'insert into the RAW call_interaction_standard.'
       DECLARE @object_called varchar(100)= 'none'
       
       BEGIN TRY
              -- get the schema name from the Fileloads configuration table.
              SELECT @Schema = fl.[Schema]                                  
              FROM   LS_SSIS.SSISConfig.cfg.InteractionDataFileLoad fl WITH (NOLOCK)
              WHERE  fl.FileLoadID = @FileLoadID

			  -- delete the data first from call_interaction_standard table.
              SET @nSQL = N'
			  DELETE FROM ' + @Schema + '.call_interaction_standard WHERE FileLoadID = '+ @nFileLoadID
			  PRINT @nsql
              EXEC SP_EXECUTESQL @nSQL,N'@Rowcount INT OUTPUT',@Rowcount = @Rowcount OUTPUT

              -- insert into call_interaction_standard table.
              SET @nSQL = N'
				INSERT INTO ' + @Schema + '.call_interaction_standard
				(program_id,row_date,starttime,starttime_utc,intrvl,split,logid,i_stafftime,ti_stafftime,i_availtime,ti_availtime,i_acdtime,i_acwtime
				,i_acwouttime,ti_auxtime,i_auxouttime,i_othertime,acwoutcalls,acwouttime,auxoutcalls,auxouttime,acdcalls,acdtime,acwtime,holdcalls,holdtime
				,holdabncalls,transferred,conference,abncalls,abntime,i_ringtime,ringcalls,ringtime,ansringtime,noansredir,i_acdaux_outtime,i_acdothertime
				,i_auxtime,ti_auxtime0,ti_auxtime1,ti_auxtime2,ti_auxtime3,ti_auxtime4,ti_auxtime5,ti_auxtime6,ti_auxtime7,ti_auxtime8,ti_auxtime9
				,FileDate,AppInstanceID,load_schedule_id,FileLoadID
				 ,outflowcalls,AnsTime,Acceptable
				   ,AltNum1,AltNum2,AltNum3,AltNum4,AltNum5,AltNum6,AltNum7,AltNum8
				   ,AltNum9,AltNum10,AltNum11,AltNum12,AltNum13,AltNum14,AltNum15,AltNum16)
				
				SELECT cim.program_id,cim.row_date,cim.starttime,cim.starttime_utc,cim.intrvl,cim.split,cim.logid,cim.i_stafftime,cim.ti_stafftime,cim.i_availtime,cim.ti_availtime,cim.i_acdtime,cim.i_acwtime
				,cim.i_acwouttime,cim.ti_auxtime,cim.i_auxouttime,cim.i_othertime,cim.acwoutcalls,cim.acwouttime,cim.auxoutcalls,cim.auxouttime,cim.acdcalls,cim.acdtime,cim.acwtime,cim.holdcalls,cim.holdtime
				,cim.holdabncalls,cim.transferred,cim.conference,cim.abncalls,cim.abntime,cim.i_ringtime,cim.ringcalls,cim.ringtime,cim.ansringtime,cim.noansredir,cim.i_acdaux_outtime,cim.i_acdothertime
				,cim.i_auxtime,cim.ti_auxtime0,cim.ti_auxtime1,cim.ti_auxtime2,cim.ti_auxtime3,cim.ti_auxtime4,cim.ti_auxtime5,cim.ti_auxtime6,cim.ti_auxtime7,cim.ti_auxtime8,cim.ti_auxtime9,cim.FileDate,cim.AppInstanceID,cim.load_schedule_id,cim.FileLoadID
				,cim.outflowcalls,cim.AnsTime,cim.Acceptable
			    ,cim.AltNum1,cim.AltNum2,cim.AltNum3,cim.AltNum4,cim.AltNum5,cim.AltNum6,cim.AltNum7,cim.AltNum8
			    ,cim.AltNum9,cim.AltNum10,cim.AltNum11,cim.AltNum12,cim.AltNum13,cim.AltNum14,cim.AltNum15,cim.AltNum16
				FROM   ' + @Schema + '.call_interaction_merge cim WITH (NOLOCK)
				--changed filedate to row_date
				WHERE    cim.FileLoadID = ' + @nFileLoadID  + '
						AND	exists(	select TOP 1 1  from ' + @Schema + '.call_interaction ci WITH (NOLOCK) 
						WHERE ci.fileloadid = cim.FileLoadID and ci.row_date = cim.row_date
						)

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


