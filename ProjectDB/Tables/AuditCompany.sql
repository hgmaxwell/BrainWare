CREATE TABLE [dbo].[AuditCompany]
(
	[AuditCompanyId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[CompanyId] INT, 
    [Name] NCHAR(128),
	[IsDeleted] BIT,
	[ChangeDate] DATETIME,
	[ChangeType] CHAR(1),
	[ChangedBy] INT
)
