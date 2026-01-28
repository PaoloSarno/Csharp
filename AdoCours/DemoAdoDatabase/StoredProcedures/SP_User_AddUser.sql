CREATE PROCEDURE [dbo].[SP_User_AddUser]
	@Email NVARCHAR (100),
	@Password NVARCHAR (255),
	@Lastname NVARCHAR (50) = NULL,
	@Firstname NVARCHAR (50) = NULL
AS
BEGIN
	
	SET NOCOUNT ON

	IF EXISTS (SELECT 1 FROM [dbo].[User] WHERE [Email] = @Email)
	BEGIN
		RAISERROR('Email already exists.', 16, 1)
	END

	INSERT INTO [dbo].[User] (Email, Password, Lastname, Firstname)
	VALUES (@Email, HASHBYTES('SHA2_256', @Password), @Lastname, @Firstname)

	SET NOCOUNT OFF

END

