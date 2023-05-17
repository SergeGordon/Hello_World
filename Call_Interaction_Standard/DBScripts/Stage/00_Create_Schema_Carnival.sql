
USE [Stage]
GO

IF NOT EXISTS ( SELECT 1 FROM sys.schemas WITH(NOLOCK) WHERE name = 'Carnival' )
BEGIN
	PRINT 'CREATE SCHEMA Stage Carnival'
	EXEC('CREATE SCHEMA Carnival')
END
