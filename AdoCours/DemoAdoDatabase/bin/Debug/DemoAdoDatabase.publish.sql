/*
Script de déploiement pour DemoADO

Ce code a été généré par un outil.
Les modifications apportées à ce fichier peuvent entraîner un comportement incorrect et seront perdues si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DemoADO"
:setvar DefaultFilePrefix "DemoADO"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.TFTIC\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.TFTIC\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l’exécution de script si le mode SQLCMD n’est pas pris en charge.
Pour réactiver le script après l’activation du mode SQLCMD, exécutez ce qui suit : 
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'L''opération de refactorisation de changement de nom avec la clé 67fca3c2-4134-4246-9c85-2429f16c3379 est ignorée, l''élément [dbo].[User].[UpDate] (SqlSimpleColumn) ne sera pas renommé en UpdateAt';


GO
PRINT N'L''opération de refactorisation de changement de nom avec la clé 253bc717-b4e0-4856-b5d3-f4385ded4e19 est ignorée, l''élément [dbo].[User].[email] (SqlSimpleColumn) ne sera pas renommé en Email';


GO
PRINT N'L''opération de refactorisation de changement de nom avec la clé de096a9b-2bf2-4ce1-bb37-55c13c763872 est ignorée, l''élément [dbo].[User].[Created] (SqlSimpleColumn) ne sera pas renommé en CreatedAt';


GO
PRINT N'L''opération de refactorisation de changement de nom avec la clé 563fcc33-160d-4c1a-99dc-8debcd388f78 est ignorée, l''élément [dbo].[User].[UpDate] (SqlSimpleColumn) ne sera pas renommé en UpDateAt';


GO
PRINT N'L''opération de refactorisation de changement de nom avec la clé c7648cac-a21c-45f7-b1bc-bf7dcd531f01 est ignorée, l''élément [dbo].[User].[Pssword] (SqlSimpleColumn) ne sera pas renommé en Password';


GO
PRINT N'Création de Table [dbo].[Todo]...';


GO
CREATE TABLE [dbo].[Todo] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Title]       NVARCHAR (100) NOT NULL,
    [DESCRIPTION] NVARCHAR (MAX) NULL,
    [STATUS]      NVARCHAR (20)  NULL,
    [CreatedAt]   DATETIME2 (7)  NULL,
    [UpDateAt]    DATETIME2 (7)  NULL,
    [IsActive]    BIT            NULL,
    [UserId]      INT            NOT NULL,
    CONSTRAINT [PK_Todo] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [Email]     NVARCHAR (100) NOT NULL,
    [Password]  NVARCHAR (255) NOT NULL,
    [LastName]  NVARCHAR (50)  NULL,
    [FirstName] NVARCHAR (50)  NULL,
    [CreatedAt] DATETIME2 (7)  NULL,
    [UpDateAt]  DATETIME2 (7)  NULL,
    [IsActive]  BIT            NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Todo]...';


GO
ALTER TABLE [dbo].[Todo]
    ADD DEFAULT [GETDATE]() FOR [CreatedAt];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Todo]...';


GO
ALTER TABLE [dbo].[Todo]
    ADD DEFAULT [GETDATE]() FOR [UpDateAt];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Todo]...';


GO
ALTER TABLE [dbo].[Todo]
    ADD DEFAULT 1 FOR [IsActive];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT [GETDATE]() FOR [CreatedAt];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT [GETDATE]() FOR [UpDateAt];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT 1 FOR [IsActive];


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Todo_User]...';


GO
ALTER TABLE [dbo].[Todo] WITH NOCHECK
    ADD CONSTRAINT [FK_Todo_User] FOREIGN KEY ([Id]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_User_Email]...';


GO
ALTER TABLE [dbo].[User] WITH NOCHECK
    ADD CONSTRAINT [CK_User_Email] CHECK (Email LIKE '%__@%__.%__');


GO
PRINT N'Création de Déclencheur [dbo].[TR_Todo_UpdateAt]...';


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
PRINT N'Création de Déclencheur [dbo].[TR_Todo_IsActive]...';


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
GO
PRINT N'Création de Déclencheur [dbo].[TR_User_UpdateAt]...';


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
PRINT N'Création de Déclencheur [dbo].[TR_User_IsActive]...';


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
GO
PRINT N'Création de Vue [dbo].[V_User]...';


GO
CREATE VIEW [dbo].[V_User]
	AS
	SELECT [Id], [Email], [LastName], [FirstName]
	FROM [User]
	WHERE [IsActive] = 1
GO
PRINT N'Création de Procédure [dbo].[PS_Todo_AddTodo]...';


GO
CREATE PROCEDURE [dbo].[PS_Todo_AddTodo]
	@Title NVARCHAR (100),
	@Description NVARCHAR (MAX) = NULL,
	@UserId INT,
	@TodoId INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM [dbo].[User] WHERE [Id] = @UserId)
		BEGIN
			RAISERROR('User doesn''t exists.', 16, 10)
		END

		INSERT INTO [dbo].[Todo] (Title, Description, Status, UserId)
		OUTPUT inserted.Id INTO @TodoId
		VALUES (@Title, @Description, 'To do', @UserId)
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
PRINT N'Création de Procédure [dbo].[SP_User_AddUser]...';


GO
CREATE PROCEDURE [dbo].[SP_User_AddUser]
	@Email NVARCHAR (100),
	@Password NVARCHAR (255),
	@Lastname NVARCHAR (50) = NULL,
	@Firstname NVARCHAR (50) NULL,
	@UserId INT
AS
BEGIN
	
	SET NOCOUNT ON

	IF NOT EXISTS (SELECT 1 FROM [dbo].[User] WHERE [Email] = @Email)
	BEGIN
		RAISERROR('Email already exists.', 16, 1)
		RETURN -1
	END

	INSERT INTO [dbo].[User] (Email, Password, Lastname, Firstname)
	VALUES (@Email, HASHBYTES('SHA2_256', @Password), @Lastname, @Firstname)

	SET NOCOUNT OFF

END
GO
-- Étape de refactorisation pour mettre à jour le serveur cible avec des journaux de transactions déployés

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '253bc717-b4e0-4856-b5d3-f4385ded4e19')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('253bc717-b4e0-4856-b5d3-f4385ded4e19')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'de096a9b-2bf2-4ce1-bb37-55c13c763872')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('de096a9b-2bf2-4ce1-bb37-55c13c763872')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '67fca3c2-4134-4246-9c85-2429f16c3379')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('67fca3c2-4134-4246-9c85-2429f16c3379')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '563fcc33-160d-4c1a-99dc-8debcd388f78')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('563fcc33-160d-4c1a-99dc-8debcd388f78')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c7648cac-a21c-45f7-b1bc-bf7dcd531f01')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c7648cac-a21c-45f7-b1bc-bf7dcd531f01')

GO

GO
/*
Modèle de script de post-déploiement							
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.		
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.			
 Exemple :      :r .\monfichier.sql								
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.		
 Exemple :      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--Gestion des users

EXEC SP_User_AddUser 'quentin.geerts@bstorm.be', 'Test1234=', 'Geerts', 'Quentin'
EXEC SP_User_AddUser 'tierry.morre@cognitic.be', 'Test1234?'
EXEC SP_User_AddUser 'michael.person@cognitic.be', 'Test1234!'
EXEC SP_User_AddUser 'samuel.legrain@cognitic.be', 'Test1234-', 'Legrain', 'Samuel'

--Gestion des Todos

EXEC SP_Todo_AddTodo 'Aller travaille', 'Oui, faut bien gagner sa croute'
EXEC SP_Todo_AddTodo 'Faire la lessive', 'Plus rien à se mettre'
EXEC SP_Todo_AddTodo 'Changer la littière', 'Ca commence à sentir'
EXEC SP_Todo_AddTodo 'Manger viande', 'Pour bien gradir mange ta viande'
GO

GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Todo] WITH CHECK CHECK CONSTRAINT [FK_Todo_User];

ALTER TABLE [dbo].[User] WITH CHECK CHECK CONSTRAINT [CK_User_Email];


GO
PRINT N'Mise à jour terminée.';


GO
