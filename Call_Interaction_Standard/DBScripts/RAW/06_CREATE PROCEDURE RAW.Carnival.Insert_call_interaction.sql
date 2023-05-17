USE [RAW]
SET ANSI_NULLS ON
GO
IF EXISTS(SELECT * FROM sys.procedures p with (nolock) 
	join	sys.schemas s with (nolock)on p.schema_id = s.schema_id
	where	s.name = 'Carnival' 
	and    p.name = 'usp_Insert_Call_Interaction'
	)
	BEGIN
		PRINT 'DROP PROCEDURE Carnival.usp_Insert_Call_Interaction'
		DROP PROCEDURE Carnival.usp_Insert_Call_Interaction
	END
SET QUOTED_IDENTIFIER ON
GO

/**********************************************************************************************************************
Name:              [Carnival].[usp_Insert_Call_Interaction] 62                                  
Objective:         Inserts data in the call_interaction table from Carnival.Call_Interaction_Activity
Objects Affected:  [None]
Author:            KBiswal
Creatiom Date:     08-03-2022
Revision History:
Updated By                        Update Date                      Description

**********************************************************************************************************************/

Create PROCEDURE [Carnival].[usp_Insert_Call_Interaction]
@FileLoadID INT
AS
SET NOCOUNT ON

DECLARE	@RowCount INT = 0

--Truncate Call interaction before loading new data
Delete from [Carnival].[call_interaction]
where fileloadid = @FileLoadID

-- Insert data into Call Interaction Table
INSERT INTO [Carnival].[call_interaction](
program_id	,row_date	,starttime	,Intrvl	,split	,logid	,i_stafftime	,ti_stafftime	,i_availtime	,ti_availtime	,i_acdtime	,
i_acwtime	,i_acwouttime	,ti_auxtime	,i_auxouttime	,i_othertime	,acwoutcalls	,acwouttime	,auxoutcalls	,auxouttime	,
acdcalls	,acdtime	,acwtime	,holdcalls	,holdtime	,holdabncalls	,transferred	,conference	,abncalls	,abntime	,
i_ringtime	,ringcalls	,ringtime	,ansringtime	,noansredir	,i_acdaux_outtime	,i_acdothertime	,i_auxtime	,ti_auxtime0	,
ti_auxtime1	,ti_auxtime2	,ti_auxtime3	,ti_auxtime4	,ti_auxtime5	,ti_auxtime6	,ti_auxtime7	,ti_auxtime8	,
ti_auxtime9	,filedate	,fileloadid	,appinstanceid	,load_schedule_id)

SELECT  
CONVERT(int,CONVERT(float,CI.Program_id)),CI.row_date,CONCAT(CI.row_date,' ',CI.starttime) AS starttime,CONVERT(int,CONVERT(float,CI.intrvl)),CONVERT(int,CONVERT(float,CI.split)),CI.logid,CONVERT(int,CONVERT(float,CI.i_stafftime)),CONVERT(int,CONVERT(float,CI.ti_stafftime)),CONVERT(int,CONVERT(float,CI.i_availtime)),CONVERT(int,CONVERT(float,CI.ti_availtime)),CONVERT(int,CONVERT(float,CI.i_acdtime)),  
CONVERT(int,CONVERT(float,CI.i_acwtime)),CONVERT(int,CONVERT(float,CI.i_acwouttime)),CONVERT(int,CONVERT(float,CI.ti_auxtime)),CONVERT(int,CONVERT(float,CI.i_auxouttime)),CONVERT(int,CONVERT(float,CI.i_othertime)),CONVERT(int,CONVERT(float,CI.acwoutcalls)),CONVERT(int,CONVERT(float,CI.acwouttime)),CONVERT(int,CONVERT(float,CI.auxoutcalls)),CONVERT(int,CONVERT(float,CI.auxouttime)),  
CONVERT(int,CONVERT(float,CI.acdcalls)),CONVERT(int,CONVERT(float,CI.acdtime)),CONVERT(int,CONVERT(float,CI.acwtime)),CONVERT(int,CONVERT(float,CI.holdcalls)),CONVERT(int,CONVERT(float,CI.holdtime)),CONVERT(int,CONVERT(float,CI.holdabncalls)),CONVERT(int,CONVERT(float,CI.transferred)),CONVERT(int,CONVERT(float,CI.conference)),CONVERT(int,CONVERT(float,CI.abncalls)),CONVERT(int,CONVERT(float,CI.abntime)),  
CONVERT(int,CONVERT(float,CI.i_ringtime)),CONVERT(int,CONVERT(float,CI.ringcalls)),CONVERT(int,CONVERT(float,CI.ringtime)),CONVERT(int,CONVERT(float,CI.ansringtime)),CONVERT(int,CONVERT(float,CI.noansredir)),CONVERT(int,CONVERT(float,CI.i_acdaux_outtime)),CONVERT(int,CONVERT(float,CI.i_acdothertime)),CONVERT(int,CONVERT(float,CI.i_auxtime)),CONVERT(int,CONVERT(float,CI.ti_auxtime0)),  
CONVERT(int,CONVERT(float,CI.ti_auxtime1)),CONVERT(int,CONVERT(float,CI.ti_auxtime2)),CONVERT(int,CONVERT(float,CI.ti_auxtime3)),CONVERT(int,CONVERT(float,CI.ti_auxtime4)),CONVERT(int,CONVERT(float,CI.ti_auxtime5)),CONVERT(int,CONVERT(float,CI.ti_auxtime6)),CONVERT(int,CONVERT(float,CI.ti_auxtime7)),CONVERT(int,CONVERT(float,CI.ti_auxtime8)),  
CONVERT(int,CONVERT(float,CI.ti_auxtime9)),CI.[filedate],CONVERT(int,CONVERT(float,CI.[fileloadid])),CONVERT(int,CONVERT(float,CI.[appinstanceid])) ,CONVERT(int,CONVERT(float,CI.[load_schedule_id])) 
FROM [RAW].[Carnival].[Call_Interaction_Activity] CI WITH(NOLOCK)   
WHERE CI.fileloadid = @FileLoadID
  AND LEN(CI.row_date)>0
     
SELECT @Rowcount = @@ROWCOUNT;

SELECT @RowCount AS TotalRecords

GO
