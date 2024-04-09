CREATE TABLE [dbo].[OrderProduct]
(
    [OrderProductId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[OrderId] INT NOT NULL,
	[ProductId] INT NOT NULL,
	[SalePrice] DECIMAL(18,2) NOT NULL,
	[Quantity] INT NOT NULL, 
    [IsDeleted] BIT NOT NULL DEFAULT 0,
    [ChangeDate] DATETIME NOT NULL DEFAULT GETDATE(),
	[ChangeType] CHAR(1) NOT NULL DEFAULT 'I',
	[ChangedBy] INT,
    CONSTRAINT [UC_OrderProduct] UNIQUE ([OrderId], [ProductId]), 
    CONSTRAINT [FK_OrderProduct_Product] FOREIGN KEY ([ProductId]) REFERENCES [Product]([ProductId]), 
    CONSTRAINT [FK_OrderProduct_Order] FOREIGN KEY ([OrderId]) REFERENCES [Order]([OrderId])
)
GO

CREATE INDEX [IX_OrderProduct_OrderId] ON [dbo].[OrderProduct] ([OrderId])

GO

CREATE INDEX [IX_OrderProduct_ProductId] ON [dbo].[OrderProduct] ([ProductId])

GO

CREATE TRIGGER [dbo].[Trigger_OrderProduct_IU]
    ON [dbo].[OrderProduct]
    INSTEAD OF UPDATE
    AS
    BEGIN
        INSERT INTO [dbo].[AuditOrderProduct] 
        (
            OrderProductId,
            OrderId, 
            ProductId,
            SalePrice,
            Quantity,
            IsDeleted,
            ChangeDate, 
            ChangeType, 
            ChangedBy
        )
        SELECT  OrderProductId,
                OrderId, 
                ProductId,
                SalePrice,
                Quantity,
                IsDeleted,
                ChangeDate, 
                ChangeType, 
                ChangedBy 
        FROM deleted

        UPDATE op
        SET op.OrderId = i.OrderId,
            op.ProductId = i.ProductId,
            op.SalePrice = i.SalePrice,
            op.Quantity = i.Quantity,
            op.IsDeleted = i.IsDeleted,
            op.ChangeDate = GETDATE(), 
            op.ChangeType = 'U',
            op.ChangedBy = i.ChangedBy
        FROM inserted i
        INNER JOIN [dbo].[OrderProduct] op ON op.OrderProductId = i.OrderProductId
    END
GO

