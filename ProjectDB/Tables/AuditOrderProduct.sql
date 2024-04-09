CREATE TABLE [dbo].[AuditOrderProduct]
(
	[AuditOrderProductId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[OrderProductId] INT,
	[OrderId] INT,
	[ProductId] INT,
	[SalePrice] DECIMAL(18,2),
	[Quantity] INT, 
    [IsDeleted] BIT,
    [ChangeDate] DATETIME,
	[ChangeType] CHAR(1),
	[ChangedBy] INT,
)
