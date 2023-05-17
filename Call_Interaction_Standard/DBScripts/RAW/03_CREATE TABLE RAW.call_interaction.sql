	USE RAW
	GO
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Carnival.call_interaction') AND type in (N'U'))
	BEGIN
		PRINT 'DROP TABLE RAW.Carnival.call_interaction'
		DROP TABLE Carnival.call_interaction
		PRINT 'CREATE TABLE RAW.Carnival.call_interaction'
	END
	/*******************************************************************
	Name:			RAW.Carnival.call_interaction
	Objective:		RAW table used to...
	Revision History:
	Updated By		Update Date		Description
	kanhub			03/08/2022			Initial Draft
	*******************************************************************/
CREATE TABLE [Carnival].[call_interaction](
	call_interaction_sk [int] IDENTITY(1,1) NOT NULL,
	program_id INT NOT NULL CONSTRAINT DF_Carnival_CI_PROGRAM_ID DEFAULT -1,
	row_date DATE NULL,
	starttime [datetime] NULL,
	[starttime_utc] [datetime] NULL,
	Intrvl INT NOT NULL CONSTRAINT DF_Carnival_CI_intrvl DEFAULT 30,
	split INT NOT NULL CONSTRAINT DF_Carnival_CI_split DEFAULT -1,
	logid VARCHAR(50) NULL,
	i_stafftime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_stafftime DEFAULT 0,
	ti_stafftime INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_stafftime DEFAULT 0,
	i_availtime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_availtime DEFAULT 0,
	ti_availtime INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_availtime DEFAULT 0,
	i_acdtime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_acdtime DEFAULT 0,
	i_acwtime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_acwtime DEFAULT 0,
	i_acwouttime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_acwouttime DEFAULT 0,
	ti_auxtime INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime DEFAULT 0,
	i_auxouttime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_auxouttime DEFAULT 0,
	i_othertime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_othertime DEFAULT 0,
	acwoutcalls INT NOT NULL CONSTRAINT DF_Carnival_CI_acwoutcalls DEFAULT 0,
	acwouttime INT NOT NULL CONSTRAINT DF_Carnival_CI_acwouttime DEFAULT 0,
	auxoutcalls INT NOT NULL CONSTRAINT DF_Carnival_CI_auxoutcalls DEFAULT 0,
	auxouttime INT NOT NULL CONSTRAINT DF_Carnival_CI_auxouttime DEFAULT 0,
	acdcalls INT NOT NULL CONSTRAINT DF_Carnival_CI_acdcalls DEFAULT 0,
	acdtime INT NOT NULL CONSTRAINT DF_Carnival_CI_acdtime DEFAULT 0,
	acwtime INT NOT NULL CONSTRAINT DF_Carnival_CI_acwtime DEFAULT 0,
	holdcalls INT NOT NULL CONSTRAINT DF_Carnival_CI_holdcalls DEFAULT 0,
	holdtime INT NOT NULL CONSTRAINT DF_Carnival_CI_holdtime DEFAULT 0,
	holdabncalls INT NOT NULL CONSTRAINT DF_Carnival_CI_holdabncalls DEFAULT 0,
	transferred INT NOT NULL CONSTRAINT DF_Carnival_CI_transferred DEFAULT 0,
	conference INT NOT NULL CONSTRAINT DF_Carnival_CI_conference DEFAULT 0,
	abncalls INT NOT NULL CONSTRAINT DF_Carnival_CI_abncalls DEFAULT 0,
	abntime INT NOT NULL CONSTRAINT DF_Carnival_CI_abntime DEFAULT 0,
	i_ringtime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_ringtime DEFAULT 0,
	ringcalls INT NOT NULL CONSTRAINT DF_Carnival_CI_ringcalls DEFAULT 0,
	ringtime INT NOT NULL CONSTRAINT DF_Carnival_CI_ringtime DEFAULT 0,
	ansringtime INT NOT NULL CONSTRAINT DF_Carnival_CI_ansringtime DEFAULT 0,
	noansredir INT NOT NULL CONSTRAINT DF_Carnival_CI_noansredir DEFAULT 0,
	i_acdaux_outtime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_acdaux_outtime DEFAULT 0,
	i_acdothertime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_acdothertime DEFAULT 0,
	i_auxtime INT NOT NULL CONSTRAINT DF_Carnival_CI_i_auxtime DEFAULT 0,
	ti_auxtime0 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime0 DEFAULT 0,
	ti_auxtime1 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime1 DEFAULT 0,
	ti_auxtime2 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime2 DEFAULT 0,
	ti_auxtime3 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime3 DEFAULT 0,
	ti_auxtime4 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime4 DEFAULT 0,
	ti_auxtime5 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime5 DEFAULT 0,
	ti_auxtime6 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime6 DEFAULT 0,
	ti_auxtime7 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime7 DEFAULT 0,
	ti_auxtime8 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime8 DEFAULT 0,
	ti_auxtime9 INT NOT NULL CONSTRAINT DF_Carnival_CI_ti_auxtime9 DEFAULT 0,
	[filedate] [datetime] NULL,
	[fileloadid] [int] NULL,
	[appinstanceid] [int] NULL,
	[load_schedule_id] [int] NULL,
	[outflowcalls] [int] NULL  CONSTRAINT DF_Carnival_CI_outflowcalls DEFAULT 0,
	[AltNum1] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum1 DEFAULT 0,
	[AltNum2] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum2 DEFAULT 0,
	[AltNum3] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum3 DEFAULT 0,
	[AltNum4] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum4 DEFAULT 0,
	[AltNum5] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum5 DEFAULT 0,
	[AltNum6] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum6 DEFAULT 0,
	[AltNum7] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum7 DEFAULT 0,
	[AltNum8] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum8 DEFAULT 0,
	[AltNum9] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum9 DEFAULT 0,
	[AltNum10] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum10 DEFAULT 0,
	[AltNum11] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum11 DEFAULT 0,
	[AltNum12] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum12 DEFAULT 0,
	[AltNum13] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum13 DEFAULT 0,
	[AltNum14] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum14 DEFAULT 0,
	[AltNum15] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum15 DEFAULT 0,
	[AltNum16] [int] NULL  CONSTRAINT DF_Carnival_CI_AltNum16 DEFAULT 0,
	[AnsTime] [int] NULL  CONSTRAINT DF_Carnival_CI_AnsTime DEFAULT 0,
	[Acceptable] [int] NULL CONSTRAINT DF_Carnival_CI_Acceptable DEFAULT 0,
	created_dtm DATETIME NOT NULL CONSTRAINT DF_Carnival_CI_Creatd_dtm DEFAULT GETDATE(),
	
	 CONSTRAINT [PK_Carnival_CI_CALL_INTERACTION_SK] PRIMARY KEY CLUSTERED 
(
	[call_interaction_sk] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


CREATE NONCLUSTERED INDEX [IDX1_Carnival_CALL_INTERACTION] ON [Carnival].[call_interaction] 
(
	[row_date] ASC,
	[starttime] ASC,
	[split] ASC,
	[logid] ASC,
	[fileloadid] ASC
)
INCLUDE ( [filedate],
[appinstanceid],
[load_schedule_id]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

