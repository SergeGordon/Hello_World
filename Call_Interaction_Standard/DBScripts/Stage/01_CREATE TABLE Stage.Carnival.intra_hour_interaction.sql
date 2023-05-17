	USE Stage
	GO
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = object_id(N'Carnival.intra_hour_interaction') AND type in (N'U'))
	BEGIN
		PRINT 'DROP TABLE Carnival.intra_hour_interaction'
		DROP TABLE Carnival.intra_hour_interaction
	END
	GO
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	SET ANSI_PADDING ON
	PRINT 'CREATE TABLE Stage.Carnival.intra_hour_interaction'
	GO
	/*******************************************************************
	Name:			stage.Carnival.intra_hour_interaction
	Objective:		stage table used to load the schema specific data
					and match the _id and sk values.
	Revision History:
	Updated By		Update Date		Description
	kanhub			08-03-2022		Initial Draft
	*******************************************************************/
	CREATE TABLE Carnival.intra_hour_interaction(
		intra_hour_interaction_sk int IDENTITY(1,1) NOT NULL,
		abn_call_cnt INT NULL,
		abn_second_cnt INT NULL,
		acd_release_tot_cnt INT NOT NULL,
		acd_aux_out_call_cnt INT NOT NULL,
		acd_call_cnt INT NULL,
		acd_tot_second_count INT NULL,
		acp_id INT NOT NULL,
		acp_first_nm VARCHAR(100) NULL,
		acp_last_nm VARCHAR(100) NULL,
		acw_in_call_cnt INT NOT NULL,
		acw_in_tot_second_cnt INT NOT NULL,
		acw_out_call_cnt INT NULL,
		acw_out_off_call_cnt INT NOT NULL,
		acw_out_off_tot_second_cnt INT NOT NULL,
		acw_out_tot_second_cnt INT NULL,
		acw_tot_second_cnt INT NULL,
		ans_ring_tot_second_cnt INT NULL,
		application_id INT NOT NULL,
		aux_in_call_cnt INT NOT NULL,
		aux_in_tot_second_cnt INT NOT NULL,
		aux_out_call_cnt INT NULL,
		aux_out_off_call_cnt INT NOT NULL,
		aux_out_off_tot_second_cnt INT NOT NULL,
		aux_tot_out_second_cnt INT NULL,
		client_id INT NOT NULL,
		company_nm VARCHAR(100) NULL,
		call_conference_cnt INT NULL,
		hold_abn_call_cnt INT NULL,
		hold_acd_second_cnt INT NOT NULL,
		hold_call_cnt INT NULL,
		hold_second_cnt INT NULL,
		acd_aux_int_out_second_cnt INT NULL,
		acd_aux_in_int_second_cnt INT NOT NULL,
		i_acd_other_second_cnt INT NULL,
		acd_int_second_cnt INT NULL,
		acw_int_in_second_cnt INT NOT NULL,
		acw_int_out_second_cnt INT NULL,
		acw_int_second_cnt INT NULL,
		aux_int_in_second_cnt INT NOT NULL,
		aux_int_out_second_cnt INT NULL,
		aux_int_second_cnt INT NULL,
		acp_available_second_cnt INT NULL,
		other_int_second_cnt INT NOT NULL,
		ring_int_second_cnt INT NULL,
		skill_staff_second_cnt INT NULL,
		incomplete_cnt INT NOT NULL,
		interval_second_cnt INT NULL,
		client_login_id varchar(100) NOT NULL,
		noan_call_cnt INT NULL,
		ring_call_cnt INT NULL,
		ring_tot_second_cnt INT NULL,
		data_collection_dt datetime NOT NULL,
		split_desc INT NOT NULL,
		skill_nm VARCHAR(100) NULL,
		interval_start_dtm datetime NOT NULL,
		interval_start_tm INT NULL,
		interval_start_utc_dtm datetime NULL,
		aux_total_second_cnt INT NULL,
		aux0_tot_second_cnt INT NULL,
		aux1_tot_second_cnt INT NULL,
		aux2_tot_second_cnt INT NULL,
		aux3_tot_second_cnt INT NULL,
		aux4_tot_second_cnt INT NULL,
		aux5_tot_second_cnt INT NULL,
		aux6_tot_second_cnt INT NULL,
		aux7_tot_second_cnt INT NULL,
		aux8_tot_second_cnt INT NULL,
		aux9_tot_second_cnt INT NULL,
		tot_avail_second_cnt INT NULL,
		other_total_second_cnt INT NOT NULL,
		total_staff_second_cnt INT NULL,
		call_transfer_cnt INT NULL,
		contract_found_ind BIT NOT NULL,
		agreement_id INT NOT NULL,
		agreement_sk INT NOT NULL,
		acp_sk INT NOT NULL,
		application_sk INT NOT NULL,
		application_nm VARCHAR(100) NULL,
		skill_sk INT NOT NULL,
		error_row_ind BIT NOT NULL,
		error_type_ind INT NOT NULL,
		client_sk INT NOT NULL,
		ib_id INT NOT NULL,
		ib_sk INT NOT NULL,
		FileLoadID INT NOT NULL,
		AppInstanceID INT NOT NULL,
		load_schedule_id INT NULL,
		created_dtm DATETIME NOT NULL,
		modified_dtm DATETIME NOT NULL,
		[AltNum1] [int] NULL,
	[AltNum2] [int] NULL,
	[AltNum3] [int] NULL,
	[AltNum4] [int] NULL,
	[AltNum5] [int] NULL,
	[AltNum6] [int] NULL,
	[AltNum7] [int] NULL,
	[AltNum8] [int] NULL,
	[AltNum9] [int] NULL,
	[AltNum10] [int] NULL,
	[AltNum11] [int] NULL,
	[AltNum12] [int] NULL,
	[AltNum13] [int] NULL,
	[AltNum14] [int] NULL,
	[AltNum15] [int] NULL,
	[AltNum16] [int] NULL,
	[outflowcalls] [int] NULL,
	[AnsTime] [int] NULL,
	[Acceptable] [int] NULL,
 CONSTRAINT [PK_Carnival_intra_hour_interaction] PRIMARY KEY CLUSTERED 
(
	[data_collection_dt] ASC,
	[split_desc] ASC,
	[interval_start_dtm] ASC,
	[client_login_id] ASC,
	[FileLoadID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acd_aux_out_call_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acd_aux_out_call_cnt  DEFAULT ((0)) FOR acd_aux_out_call_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acp_id'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acp_id DEFAULT ((-1)) FOR acp_id

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acw_in_call_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acw_in_call_cnt  DEFAULT ((0)) FOR acw_in_call_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acw_in_tot_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acw_in_tot_second_cnt DEFAULT ((0)) FOR acw_in_tot_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acw_out_off_call_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acw_out_off_call_cnt  DEFAULT ((0)) FOR acw_out_off_call_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acw_out_off_tot_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acw_out_off_tot_second_cnt  DEFAULT ((0)) FOR acw_out_off_tot_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_application_id'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_application_id  DEFAULT ((-1)) FOR application_id

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_aux_in_call_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_aux_in_call_cnt DEFAULT ((0)) FOR aux_in_call_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_aux_in_tot_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_aux_in_tot_second_cnt DEFAULT ((0)) FOR aux_in_tot_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_aux_out_off_call_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_aux_out_off_call_cnt DEFAULT ((0)) FOR aux_out_off_call_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_aux_out_off_tot_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_aux_out_off_tot_second_cnt DEFAULT ((0)) FOR aux_out_off_tot_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_client_id'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_client_id  DEFAULT ((-1)) FOR client_id

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_hold_acd_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_hold_acd_second_cnt DEFAULT ((0)) FOR hold_acd_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acd_aux_in_int_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acd_aux_in_int_second_cnt  DEFAULT ((0)) FOR acd_aux_in_int_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acw_int_in_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acw_int_in_second_cnt  DEFAULT ((0)) FOR acw_int_in_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_aux_int_in_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_aux_int_in_second_cnt  DEFAULT ((0)) FOR aux_int_in_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_other_int_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_other_int_second_cnt  DEFAULT ((0)) FOR other_int_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_incomplete_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_incomplete_cnt  DEFAULT ((0)) FOR incomplete_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_client_login_id'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_client_login_id  DEFAULT ((0)) FOR client_login_id

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_other_total_second_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_other_total_second_cnt  DEFAULT ((0)) FOR other_total_second_cnt

	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_AppInstanceID'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_AppInstanceID  DEFAULT ((-1)) FOR AppInstanceID
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_contract_found_ind'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_contract_found_ind  DEFAULT ((0)) FOR contract_found_ind
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_agreement_id'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_agreement_id DEFAULT ((-1)) FOR agreement_id
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_agreement_sk'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_agreement_sk DEFAULT ((-1)) FOR agreement_sk
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acp_sk'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acp_sk  DEFAULT ((-1)) FOR acp_sk
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_application_sk'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_application_sk  DEFAULT ((-1)) FOR application_sk
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_skill_sk'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_skill_sk  DEFAULT ((-1)) FOR skill_sk
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_error_row_ind'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_error_row_ind  DEFAULT ((1)) FOR error_row_ind
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_error_type_ind'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_error_type_ind  DEFAULT ((0)) FOR error_type_ind
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_client_sk'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_client_sk  DEFAULT ((-1)) FOR client_sk
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_ib_id'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_ib_id DEFAULT ((-1)) FOR ib_id
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_ib_sk'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_ib_sk DEFAULT ((-1)) FOR ib_sk
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_created_dtm'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_created_dtm  DEFAULT (getdate()) FOR created_dtm
	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_modified_dtm'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_modified_dtm  DEFAULT (getdate()) FOR modified_dtm

	ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum1]  DEFAULT ((0)) FOR [AltNum1]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum2]  DEFAULT ((0)) FOR [AltNum2]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum3]  DEFAULT ((0)) FOR [AltNum3]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum4]  DEFAULT ((0)) FOR [AltNum4]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum5]  DEFAULT ((0)) FOR [AltNum5]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum6]  DEFAULT ((0)) FOR [AltNum6]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum7]  DEFAULT ((0)) FOR [AltNum7]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum8]  DEFAULT ((0)) FOR [AltNum8]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum9]  DEFAULT ((0)) FOR [AltNum9]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum10]  DEFAULT ((0)) FOR [AltNum10]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum11]  DEFAULT ((0)) FOR [AltNum11]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum12]  DEFAULT ((0)) FOR [AltNum12]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum13]  DEFAULT ((0)) FOR [AltNum13]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum14]  DEFAULT ((0)) FOR [AltNum14]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum15]  DEFAULT ((0)) FOR [AltNum15]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AltNum16]  DEFAULT ((0)) FOR [AltNum16]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_AnsTime]  DEFAULT ((0)) FOR [AnsTime]
GO

ALTER TABLE Carnival.[intra_hour_interaction] ADD  CONSTRAINT [DF_Carnival_IHI_Zero_Acceptable]  DEFAULT ((0)) FOR [Acceptable]
GO



	
	PRINT 'ADD CONSTRAINT DF_Carnival_IHI_acd_release_tot_cnt'
	ALTER TABLE Carnival.intra_hour_interaction ADD CONSTRAINT DF_Carnival_IHI_acd_release_tot_cnt DEFAULT ((0)) FOR acd_release_tot_cnt
	GO


CREATE NONCLUSTERED INDEX [IDX_Carnival_INTRA_HOUR_INTERACTION] ON [Carnival].[intra_hour_interaction] 
(
	[client_id] ASC,
	[FileLoadID] ASC,
	[data_collection_dt] ASC,
	[split_desc] ASC,
	[interval_start_dtm] ASC,
	[acp_id] ASC
)
INCLUDE ( [acp_first_nm],
[acp_last_nm],
[company_nm],
[application_nm],
[error_row_ind]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


