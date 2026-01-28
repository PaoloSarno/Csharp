CREATE TABLE [dbo].[User]
(
	[Id] INT IDENTITY, 
    [Email] NVARCHAR(100) NOT NULL, 
    [Password] NVARCHAR(255) NOT NULL, 
    [LastName] NVARCHAR(50) NULL, 
    [FirstName] NVARCHAR(50) NULL, 
    [CreatedAt] DATETIME2 NULL DEFAULT GETDATE(), 
    [UpDateAt] DATETIME2 NULL DEFAULT GETDATE(), 
    [IsActive] BIT NULL DEFAULT 1, 
    CONSTRAINT [PK_User] PRIMARY KEY ([Id]),
    CONSTRAINT [CK_User_Email] CHECK (Email LIKE '%__@%__.%__')
)

GO

CREATE TRIGGER [dbo].[TR_User_UpdateAt]
    ON [dbo].[User]
    AFTER UPDATE
    AS
    BEGIN
        SET NoCount ON
        UPDATE [dbo].[User]
        set [UpDateAt] = GETDATE()
        WHERE [Id] = (SELECT [Id] FROM inserted)
    END
GO

CREATE TRIGGER [dbo].[TR_User_IsActive]
    ON [dbo].[User]
    INSTEAD OF DELETE
    AS
    BEGIN
        SET NoCount ON
        UPDATE [dbo].[User]
        SET [IsActive] = 0
        WHERE [Id] = (SELECT [Id] FROM deleted)
    END