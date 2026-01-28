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

EXEC SP_Todo_AddTodo 'Aller travaille', 'Oui, faut bien gagner sa croute', 1
EXEC SP_Todo_AddTodo 'Faire la lessive', 'Plus rien à se mettre', 2
EXEC SP_Todo_AddTodo 'Changer la littière', 'Ca commence à sentir', 1
EXEC SP_Todo_AddTodo 'Manger viande', 'Pour bien gradir mange ta viande', 1
GO
