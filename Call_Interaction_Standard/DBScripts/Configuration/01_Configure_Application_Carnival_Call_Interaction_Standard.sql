use SSISConfig
GO

SET NOCOUNT ON


DECLARE	@ApplicationName varchar(255)= 'Carnival_Call_Interaction_Standard'
DECLARE	@ApplicationID int
DECLARE	@Company_nm	VARCHAR(255) = 'Carnival Cruise Line'
DECLARE	@ClientID		int = 98
DECLARE	@Description VARCHAR(255)= 'Carnival Call_Interaction_Standard configuration.'
DECLARE	@TimeZoneID int = 77
DECLARE	@Debug bit = 0
DECLARE	@Frequency varchar(50)  = 'Day'
DECLARE	@Increment int = 1

IF @ApplicationName IS NOT NULL
BEGIN
	EXEC cfg.AddSSISApplication @ApplicationName,@ClientID,@Description,@Frequency,@Increment,null,@TimeZoneID,@ApplicationID OUTPUT
END
