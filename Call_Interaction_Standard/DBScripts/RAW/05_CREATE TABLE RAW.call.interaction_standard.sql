USE RAW
GO

IF EXISTS (SELECT * 
	FROM	sys.tables t with (Nolock)
	JOIN	sys.schemas s with (nolock) on t.schema_id = s.schema_id
	WHERE	t.name = 'call_interaction_standard'
	AND		S.name = 'Carnival')
	BEGIN
		PRINT 'DROP TABLE RAW.Carnival.call_interaction_standard'
		DROP TABLE Carnival.call_interaction_standard
		PRINT 'CREATE TABLE RAW.Carnival.call_interaction_standard'
	END
 	/*******************************************************************
	Name:			RAW.Carnival.call_interaction_standard
	Objective:		RAW table used to...
	Revision History:
	Updated By		Update Date		Description
	kanhub			03/08/2022		Initial Draft
	*******************************************************************/

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Carnival].[call_interaction_standard](
	[cis_id] [int] IDENTITY(1,1) NOT NULL,
	[program_id] [int] NULL,
	[row_date] [date] NULL,
	[starttime] [datetime] NULL,
	[starttime_utc] [datetime] NULL,
	[intrvl] [int] NULL,
	[split] [int] NULL,
	[logid] [varchar](50) NULL,
	[i_stafftime] [int] NULL,
	[ti_stafftime] [int] NULL,
	[i_availtime] [int] NULL,
	[ti_availtime] [int] NULL,
	[i_acdtime] [int] NULL,
	[i_acwtime] [int] NULL,
	[i_acwouttime] [int] NULL,
	[ti_auxtime] [int] NULL,
	[i_auxouttime] [int] NULL,
	[i_othertime] [int] NULL,
	[acwoutcalls] [int] NULL,
	[acwouttime] [int] NULL,
	[auxoutcalls] [int] NULL,
	[auxouttime] [int] NULL,
	[acdcalls] [int] NULL,
	[acdtime] [int] NULL,
	[acwtime] [int] NULL,
	[holdcalls] [int] NULL,
	[holdtime] [int] NULL,
	[holdabncalls] [int] NULL,
	[transferred] [int] NULL,
	[conference] [int] NULL,
	[abncalls] [int] NULL,
	[abntime] [int] NULL,
	[i_ringtime] [int] NULL,
	[ringcalls] [int] NULL,
	[ringtime] [int] NULL,
	[ansringtime] [int] NULL,
	[noansredir] [int] NULL,
	[i_acdaux_outtime] [int] NULL,
	[i_acdothertime] [int] NULL,
	[i_auxtime] [int] NULL,
	[ti_auxtime0] [int] NULL,
	[ti_auxtime1] [int] NULL,
	[ti_auxtime2] [int] NULL,
	[ti_auxtime3] [int] NULL,
	[ti_auxtime4] [int] NULL,
	[ti_auxtime5] [int] NULL,
	[ti_auxtime6] [int] NULL,
	[ti_auxtime7] [int] NULL,
	[ti_auxtime8] [int] NULL,
	[ti_auxtime9] [int] NULL,
	[FileDate] [datetime] NULL,
	[FileLoadID] [int] NULL,
	[AppInstanceID] [int] NULL,
	[load_schedule_id] [int] NULL,
	[created_dtm] [datetime] NOT NULL,
	[outflowcalls] [int] NULL CONSTRAINT [DF_Carnival_CIS_outflowcalls]  DEFAULT 0,
	[AltNum1] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum1] DEFAULT 0,
	[AltNum2] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum2] DEFAULT 0,
	[AltNum3] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum3] DEFAULT 0,
	[AltNum4] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum4] DEFAULT 0,
	[AltNum5] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum5] DEFAULT 0,
	[AltNum6] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum6] DEFAULT 0,
	[AltNum7] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum7] DEFAULT 0,
	[AltNum8] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum8] DEFAULT 0,
	[AltNum9] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum9] DEFAULT 0,
	[AltNum10] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum10] DEFAULT 0,
	[AltNum11] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum11] DEFAULT 0,
	[AltNum12] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum12] DEFAULT 0,
	[AltNum13] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum13] DEFAULT 0,
	[AltNum14] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum14] DEFAULT 0,
	[AltNum15] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum15] DEFAULT 0,
	[AltNum16] [int] NULL CONSTRAINT [DF_Carnival_CIS_AltNum16] DEFAULT 0,
	[AnsTime] [int] NULL  CONSTRAINT [DF_Carnival_CIS_AnsTime] DEFAULT 0 ,
	[Acceptable] [int] NULL CONSTRAINT [DF_Carnival_CIS_Acceptable] DEFAULT 0,
 CONSTRAINT [PK_call_interaction_standard] PRIMARY KEY CLUSTERED 
(
	[cis_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Carnival].[call_interaction_standard] ADD  CONSTRAINT [DF_Carnival_CIS_Created_dtm]  DEFAULT (getdate()) FOR [created_dtm]
GO


