CREATE TABLE [dbo].[Todo]
(
	[Id] INT IDENTITY,
    [Title] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [Status] NVARCHAR(20),
	[CreatedAt] DATETIME2 NULL DEFAULT GETDATE(), 
    [UpDateAt] DATETIME2 NULL DEFAULT GETDATE(), 
    [IsActive] BIT NULL DEFAULT 1, 

    [UserId] INT NOT NULL,

    CONSTRAINT [PK_Todo] PRIMARY KEY (Id),
    CONSTRAINT [FK_Todo_User] FOREIGN KEY ([Id]) REFERENCES [User]([Id])
)

GO

CREATE TRIGGER [dbo].[TR_Todo_UpdateAt]
    ON [dbo].[Todo]
    AFTER UPDATE
    AS
    BEGIN
        SET NoCount ON
        UPDATE [dbo].[Todo]
        set [UpDateAt] = GETDATE()
        WHERE [Id] = (SELECT [Id] FROM inserted)
    END
GO

CREATE TRIGGER [dbo].[TR_Todo_IsActive]
    ON [dbo].[Todo]
    INSTEAD OF DELETE
    AS
    BEGIN
        SET NoCount ON
        UPDATE [dbo].[Todo]
        SET [IsActive] = 0
        WHERE [Id] = (SELECT [Id] FROM deleted)
    END