CREATE TABLE [dbo].[AuditProduct]
(
	[AuditProductId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ProductId] INT,
	[Name] NVARCHAR(128), 
    [Price] DECIMAL(18, 2),
	[IsDeleted] BIT,
	[ChangeDate] DATETIME,
	[ChangeType] CHAR(1),
	[ChangedBy] INT
)
