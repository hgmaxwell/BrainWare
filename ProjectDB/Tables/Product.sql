CREATE TABLE [dbo].[Product]
(
	[ProductId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(128) NOT NULL, 
    [Price] DECIMAL(18, 2) NOT NULL,
	[IsDeleted] BIT NOT NULL DEFAULT 0,
	[ChangeDate] DATETIME NOT NULL DEFAULT GETDATE(),
	[ChangeType] CHAR(1) NOT NULL DEFAULT 'I',
	[ChangedBy] INT,
    CONSTRAINT [UC_Product_Name] UNIQUE (Name)
)

GO

CREATE INDEX [IX_Product_Name] ON [dbo].[Product] ([Name])

GO

CREATE TRIGGER [dbo].[Trigger_Product_IU]
    ON [dbo].[Product]
    INSTEAD OF UPDATE
    AS
    BEGIN
        INSERT INTO [dbo].[AuditProduct] 
        (
            ProductId, 
            Name, 
            Price,
            IsDeleted,
            ChangeDate, 
            ChangeType, 
            ChangedBy
        )
        SELECT  ProductId, 
                Name,
                Price,
                IsDeleted,
                ChangeDate, 
                ChangeType, 
                ChangedBy 
        FROM deleted

        UPDATE p
        SET p.Name = i.Name, 
            p.Price = i.Price,
            p.IsDeleted = i.IsDeleted,
            p.ChangeDate = GETDATE(), 
            p.ChangeType = 'U',
            p.ChangedBy = i.ChangedBy
        FROM inserted i
        INNER JOIN [dbo].[Product] p ON p.ProductId = i.ProductId
    END
GO