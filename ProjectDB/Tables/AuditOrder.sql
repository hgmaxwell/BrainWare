CREATE TABLE [dbo].[AuditOrder]
(
	[AuditOrderId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[OrderId] INT,
	[Description] NVARCHAR(1000), 
    [CompanyId] INT, 
    [OrderDate] DATETIME, 
	[IsDeleted] BIT,
    [ChangeDate] DATETIME,
	[ChangeType] CHAR(1),
	[ChangedBy] INT
)
