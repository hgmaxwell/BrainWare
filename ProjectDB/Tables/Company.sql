CREATE TABLE [dbo].[Company]
(
	[CompanyId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [Name] NCHAR(128) NOT NULL,
    [IsDeleted] BIT NOT NULL DEFAULT 0,
	[ChangeDate] DATETIME NOT NULL DEFAULT GETDATE(),
	[ChangeType] CHAR(1) NOT NULL DEFAULT 'I',
	[ChangedBy] INT, 
    CONSTRAINT [UC_Company_Name] UNIQUE (Name)
)

GO

CREATE INDEX [IX_Company_Name] ON [dbo].[Company] ([Name])

GO

CREATE TRIGGER [dbo].[Trigger_Company_IU]
    ON [dbo].[Company]
    INSTEAD OF UPDATE
    AS
    BEGIN
        INSERT INTO [dbo].[AuditCompany] 
        (
            CompanyId, 
            Name, 
            IsDeleted,
            ChangeDate, 
            ChangeType, 
            ChangedBy
        )
        SELECT  CompanyId, 
                Name,
                IsDeleted,
                ChangeDate, 
                ChangeType, 
                ChangedBy 
        FROM deleted

        UPDATE c
        SET c.Name = i.Name, 
            c.IsDeleted = i.IsDeleted,
            c.ChangeDate = GETDATE(), 
            c.ChangeType = 'U',
            c.ChangedBy = i.ChangedBy
        FROM inserted i
        INNER JOIN [dbo].[Company] c ON c.CompanyId = i.CompanyId
    END
GO