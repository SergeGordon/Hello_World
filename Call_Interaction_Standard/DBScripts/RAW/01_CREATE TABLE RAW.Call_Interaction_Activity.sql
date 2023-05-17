USE [RAW]
GO
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Carnival.Call_Interaction_Activity') AND type in (N'U'))
	BEGIN
		PRINT 'DROP TABLE RAW.Carnival.Call_Interaction_Activity'
		DROP TABLE CCHS.Call_Interaction_Activity
		PRINT 'CREATE TABLE RAW.Carnival.Call_Interaction_Activity'
	END
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Carnival].[Call_Interaction_Activity](
	[Call_Interaction_Activity_sk] [int] IDENTITY(1,1) NOT NULL,
	Program_id	[varchar] (100)   null default (-1),
	row_date	[varchar] (100)  NULL,
	starttime	[varchar] (100)  NULL,
	intrvl	[varchar] (100)  NULL,
	split	[varchar] (100)  NULL,
	logid	[varchar] (100)  NULL,
	i_stafftime	[varchar] (100)  NULL,
	ti_stafftime	[varchar] (100)  NULL,
	i_availtime	[varchar] (100)  NULL,
	ti_availtime	[varchar] (100)  NULL,
	i_acdtime	[varchar] (100)  NULL,
	i_acwtime	[varchar] (100)  NULL,
	i_acwouttime	[varchar] (100)  NULL,
	ti_auxtime	[varchar] (100)  NULL,
	i_auxouttime	[varchar] (100)  NULL,
	i_othertime	[varchar] (100)  NULL,
	acwoutcalls	[varchar] (100)  NULL,
	acwouttime	[varchar] (100)  NULL,
	auxoutcalls	[varchar] (100)  NULL,
	auxouttime	[varchar] (100)  NULL,
	acdcalls	[varchar] (100)  NULL,
	acdtime	[varchar] (100)  NULL,
	acwtime	[varchar] (100)  NULL,
	holdcalls	[varchar] (100)  NULL,
	holdtime	[varchar] (100)  NULL,
	holdabncalls	[varchar] (100)  NULL,
	transferred	[varchar] (100)  NULL,
	conference	[varchar] (100)  NULL,
	abncalls	[varchar] (100)  NULL,
	abntime	[varchar] (100)  NULL,
	i_ringtime	[varchar] (100)  NULL,
	ringcalls	[varchar] (100)  NULL,
	ringtime	[varchar] (100)  NULL,
	ansringtime	[varchar] (100)  NULL,
	noansredir	[varchar] (100)  NULL,
	i_acdaux_outtime	[varchar] (100)  NULL,
	i_acdothertime	[varchar] (100)  NULL,
	i_auxtime	[varchar] (100)  NULL,
	ti_auxtime0	[varchar] (100)  NULL,
	ti_auxtime1	[varchar] (100)  NULL,
	ti_auxtime2	[varchar] (100)  NULL,
	ti_auxtime3	[varchar] (100)  NULL,
	ti_auxtime4	[varchar] (100)  NULL,
	ti_auxtime5	[varchar] (100)  NULL,
	ti_auxtime6	[varchar] (100)  NULL,
	ti_auxtime7	[varchar] (100)  NULL,
	ti_auxtime8	[varchar] (100)  NULL,
	ti_auxtime9	[varchar] (100)  NULL,
	[filedate] [datetime] NULL,
	[fileloadid] [int] NULL,
	[appinstanceid] [int] NULL,
	[load_schedule_id] [int] NULL,
	[created_dtm] [datetime] NOT NULL,
 CONSTRAINT [PK_Carnival_ID_Call_Interaction_Activity_SK] PRIMARY KEY CLUSTERED 
(
	[Call_Interaction_Activity_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Carnival].[Call_Interaction_Activity] ADD  CONSTRAINT [DF_Carnival_Call_Interaction_Activity_Created_dtm]  DEFAULT (getdate()) FOR [Created_dtm]
GO

