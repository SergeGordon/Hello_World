use SSISConfig
GO

SET NOCOUNT ON
GO

---- File Mapping ScheduleBasedLogic
DECLARE @TableName VARCHAR (255) = 'Call_Interaction_Activity'
DECLARE @FileMappingName VARCHAR (255) = 'CallInteractionActivity_ScheduleBasedLogic'
DECLARE @Description VARCHAR(255) = 'Standard Framework 48 column Call Interaction Fileload; Program_id column is ignored from the file.'
DECLARE @FileMappingID	INT
DECLARE @FileMappingDetailID INT
EXEC	[cfg].[AddSSISFileLoadFileMapping] @TableName,@FileMappingName,@Description,@FileMappingID OUT

---- File Mapping Detail
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ignore',	1	,'Program_id',	1,	'Int32',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'row_date',	2	,'row_date',	2,	'Date',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'starttime',	3	,'starttime',	3,	'time',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'intrvl',	4	,'intrvl',	4,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'split',	5	,'split',	5,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'logid',	6	,'logid',	6,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_stafftime',	7	,'i_stafftime',	7,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_stafftime',	8	,'ti_stafftime',	8,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_availtime',	9	,'i_availtime',	9,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_availtime',	10	,'ti_availtime',	10,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acdtime',	11	,'i_acdtime',	11,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acwtime',	12	,'i_acwtime',	12,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acwouttime',	13	,'i_acwouttime',	13,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime',	14	,'ti_auxtime',	14,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_auxouttime',	15	,'i_auxouttime',	15,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_othertime',	16	,'i_othertime',	16,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acwoutcalls',	17	,'acwoutcalls',	17,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acwouttime',	18	,'acwouttime',	18,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'auxoutcalls',	19	,'auxoutcalls',	19,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'auxouttime',	20	,'auxouttime',	20,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acdcalls',	21	,'acdcalls',	21,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acdtime',	22	,'acdtime',	22,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acwtime',	23	,'acwtime',	23,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'holdcalls',	24	,'holdcalls',	24,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'holdtime',	25	,'holdtime',	25,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'holdabncalls',	26	,'holdabncalls',	26,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'transferred',	27	,'transferred',	27,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'conference',	28	,'conference',	28,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'abncalls',	29	,'abncalls',	29,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'abntime',	30	,'abntime',	30,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_ringtime',	31	,'i_ringtime',	31,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ringcalls',	32	,'ringcalls',	32,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ringtime',	33	,'ringtime',	33,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ansringtime',	34	,'ansringtime',	34,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'noansredir',	35	,'noansredir',	35,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acdaux_outtime',	36	,'i_acdaux_outtime',	36,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acdothertime',	37	,'i_acdothertime',	37,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_auxtime',	38	,'i_auxtime',	38,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime0',	39	,'ti_auxtime0',	39,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime1',	40	,'ti_auxtime1',	40,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime2',	41	,'ti_auxtime2',	41,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime3',	42	,'ti_auxtime3',	42,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime4',	43	,'ti_auxtime4',	43,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime5',	44	,'ti_auxtime5',	44,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime6',	45	,'ti_auxtime6',	45,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime7',	46	,'ti_auxtime7',	46,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime8',	47	,'ti_auxtime8',	47,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime9',	48	,'ti_auxtime9',	48,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,'filedate',49,'filedate',49,'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,'fileloadid',50,'fileloadid',50,'Int32',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,'appinstanceid',51,'appinstanceid',51,'Int32',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,'load_schedule_id',52,'load_schedule_id',52,'Int32',@FileMappingDetailID OUT

---- File Mapping StandardLogic
SET @FileMappingName  = 'CallInteractionActivity_StandardLogic'
SET	@Description  = 'Standard Framework 48 column Call Interaction Fileload; Program_id column is NOT ignored from the file.'
EXEC	[cfg].[AddSSISFileLoadFileMapping] @TableName,@FileMappingName,@Description,@FileMappingID OUT

---- File Mapping Detail
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'Program_id',	1	,'Program_id',	1,	'Int32',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'row_date',	2	,'row_date',	2,	'Date',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'starttime',	3	,'starttime',	3,	'time',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'intrvl',	4	,'intrvl',	4,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'split',	5	,'split',	5,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'logid',	6	,'logid',	6,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_stafftime',	7	,'i_stafftime',	7,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_stafftime',	8	,'ti_stafftime',	8,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_availtime',	9	,'i_availtime',	9,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_availtime',	10	,'ti_availtime',	10,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acdtime',	11	,'i_acdtime',	11,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acwtime',	12	,'i_acwtime',	12,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acwouttime',	13	,'i_acwouttime',	13,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime',	14	,'ti_auxtime',	14,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_auxouttime',	15	,'i_auxouttime',	15,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_othertime',	16	,'i_othertime',	16,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acwoutcalls',	17	,'acwoutcalls',	17,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acwouttime',	18	,'acwouttime',	18,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'auxoutcalls',	19	,'auxoutcalls',	19,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'auxouttime',	20	,'auxouttime',	20,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acdcalls',	21	,'acdcalls',	21,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acdtime',	22	,'acdtime',	22,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'acwtime',	23	,'acwtime',	23,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'holdcalls',	24	,'holdcalls',	24,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'holdtime',	25	,'holdtime',	25,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'holdabncalls',	26	,'holdabncalls',	26,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'transferred',	27	,'transferred',	27,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'conference',	28	,'conference',	28,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'abncalls',	29	,'abncalls',	29,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'abntime',	30	,'abntime',	30,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_ringtime',	31	,'i_ringtime',	31,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ringcalls',	32	,'ringcalls',	32,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ringtime',	33	,'ringtime',	33,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ansringtime',	34	,'ansringtime',	34,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'noansredir',	35	,'noansredir',	35,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acdaux_outtime',	36	,'i_acdaux_outtime',	36,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_acdothertime',	37	,'i_acdothertime',	37,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'i_auxtime',	38	,'i_auxtime',	38,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime0',	39	,'ti_auxtime0',	39,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime1',	40	,'ti_auxtime1',	40,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime2',	41	,'ti_auxtime2',	41,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime3',	42	,'ti_auxtime3',	42,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime4',	43	,'ti_auxtime4',	43,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime5',	44	,'ti_auxtime5',	44,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime6',	45	,'ti_auxtime6',	45,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime7',	46	,'ti_auxtime7',	46,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime8',	47	,'ti_auxtime8',	47,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,	'ti_auxtime9',	48	,'ti_auxtime9',	48,	'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,'filedate',49,'filedate',49,'String',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,'fileloadid',50,'fileloadid',50,'Int32',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,'appinstanceid',51,'appinstanceid',51,'Int32',@FileMappingDetailID OUT
EXEC [cfg].[AddSSISFileMappingDetail] @FileMappingID,'load_schedule_id',52,'load_schedule_id',52,'Int32',@FileMappingDetailID OUT

