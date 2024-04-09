CREATE TABLE [dbo].[Order]
(
	[OrderId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Description] NVARCHAR(1000) NOT NULL, 
    [CompanyId] INT NOT NULL, 
    [OrderDate] DATETIME NOT NULL, 
	[IsDeleted] BIT NOT NULL DEFAULT 0,
    [ChangeDate] DATETIME NOT NULL DEFAULT GETDATE(),
	[ChangeType] CHAR(1) NOT NULL DEFAULT 'I',
	[ChangedBy] INT,
    CONSTRAINT [FK_Order_Company] FOREIGN KEY ([CompanyId]) REFERENCES [Company]([CompanyId]),
)

GO

CREATE INDEX [IX_Order_CompanyId] ON [dbo].[Order] ([CompanyId])

GO

CREATE INDEX [IX_Order_OrderDate] ON [dbo].[Order] ([OrderDate])

GO

CREATE TRIGGER [dbo].[Trigger_Order_IU]
    ON [dbo].[Order]
    INSTEAD OF UPDATE
    AS
    BEGIN
        INSERT INTO [dbo].[AuditOrder] 
        (
            OrderId, 
            Description, 
            CompanyId,
            OrderDate,
            IsDeleted,
            ChangeDate, 
            ChangeType, 
            ChangedBy
        )
        SELECT  OrderId, 
                Description,
                CompanyId,
                OrderDate,
                IsDeleted,
                ChangeDate, 
                ChangeType, 
                ChangedBy 
        FROM deleted

        UPDATE o
        SET o.Description = i.Description,
            o.CompanyId = i.CompanyId,
            o.OrderDate = i.OrderDate,
            o.IsDeleted = i.IsDeleted,
            o.ChangeDate = GETDATE(), 
            o.ChangeType = 'U',
            o.ChangedBy = i.ChangedBy
        FROM inserted i
        INNER JOIN [dbo].[Order] o ON o.OrderId = i.OrderId
    END
GO
