
/* 

Create a new database named AssignmentDB. After creating the same, execute the below script.
This scripts contains:
	-Table
	-Mock data
	-Insert,Update,Delete,Select procedures

*/
USE [AssignmentDB]
GO

/****** Object:  Table [dbo].[Contact]    Script Date: 05/08/2018 11:47:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Contact](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Email] [varchar](30) NULL,
	[PhoneNumber] [varchar](30) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [AssignmentDB]
GO

INSERT INTO [dbo].[Contact]([FirstName], [LastName], [Email], [PhoneNumber], [IsActive], [IsDeleted], [CreatedDate],[UpdatedDate])
     VALUES('Chinmay','Kanitkar','chinmay.kanitkar@gmail.com','+919823286364',1,0,GETDATE(),GETDATE())
GO
INSERT INTO [dbo].[Contact]([FirstName], [LastName], [Email], [PhoneNumber], [IsActive], [IsDeleted], [CreatedDate],[UpdatedDate])
     VALUES('Ganesh','Nagarale','ganesh.nagarale@yahoo.com','9923494244',1,0,GETDATE(),GETDATE())
GO
INSERT INTO [dbo].[Contact]([FirstName], [LastName], [Email], [PhoneNumber], [IsActive], [IsDeleted], [CreatedDate],[UpdatedDate])
     VALUES('Ajay','Gote','gote.ajay@yahoo.com','+918877956478',1,0,GETDATE(),GETDATE())
GO
INSERT INTO [dbo].[Contact]([FirstName], [LastName], [Email], [PhoneNumber], [IsActive], [IsDeleted], [CreatedDate],[UpdatedDate])
     VALUES('Kabir','Kharade','kg.kharade@hotmail.com','+917894758622',1,0,GETDATE(),GETDATE())
GO
INSERT INTO [dbo].[Contact]([FirstName], [LastName], [Email], [PhoneNumber], [IsActive], [IsDeleted], [CreatedDate],[UpdatedDate])
     VALUES('Santosh','Belvi','santosh.belvi@gmail.com','+918874123977',1,0,GETDATE(),GETDATE())
GO

USE [AssignmentDB]
GO

/****** Object:  StoredProcedure [dbo].[spContact_Upsert]    Script Date: 05/08/2018 11:51:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Nirav Halbe>
-- Create date: <28th July 2018>
-- Description:	This stored procedure is used to INSERT/UDPATE/ contact data.
-- =============================================
CREATE PROCEDURE [dbo].[spContact_Upsert] 
	@Id          INT, 
	@FirstName   VARCHAR(100), 
	@LastName    VARCHAR(100), 
	@Email       VARCHAR(50) = NULL, 
	@PhoneNumber VARCHAR(50) = NULL, 
	@IsActive    BIT 
AS 
  BEGIN 
      IF( @Id > 0 ) 
        BEGIN 
            UPDATE Contact 
            SET    FirstName	= @FirstName, 
                   LastName		= @LastName, 
                   Email		= @Email, 
                   PhoneNumber	= @PhoneNumber, 
                   isactive		= @IsActive,
				   UpdatedDate	= GETDATE() 
            WHERE  id = @Id 
        END 
      ELSE 
        BEGIN 
            INSERT INTO Contact 
            (
				FirstName, 
				LastName, 
				Email, 
				PhoneNumber, 
                IsActive,
				IsDeleted,
				CreatedDate
			) 
            VALUES      
			(	@FirstName, 
                @LastName, 
                @Email, 
                @PhoneNumber, 
                @IsActive,
				0,
				GETDATE()
			) 
        END 
  END
GO


USE [AssignmentDB]
GO

/****** Object:  StoredProcedure [dbo].[spContact_Get]    Script Date: 05/08/2018 11:52:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Nirav Halbe>
-- Create date: <28th July 2018>
-- Description:	This stored procedure is used to SELECT contact data.
-- =============================================
CREATE PROCEDURE [dbo].[spContact_Get]
AS
BEGIN
	SELECT	Id,
			FirstName,
			LastName,
			Email,
			PhoneNumber,
			IsActive AS 'Status'
	FROM	Contact
	WHERE	IsDeleted = 0
END
GO


USE [AssignmentDB]
GO

/****** Object:  StoredProcedure [dbo].[spContact_GetById]    Script Date: 05/08/2018 11:52:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Nirav Halbe>
-- Create date: <28th July 2018>
-- Description:	This stored procedure is used to SELECT Contact data by Contact Id.
-- =============================================
CREATE PROCEDURE [dbo].[spContact_GetById]
	@Id INT
AS
BEGIN
	SELECT	Id,
			FirstName,
			LastName,
			Email,
			PhoneNumber,
			IsActive AS 'Status'
	FROM	Contact
	WHERE	Id			= @Id
	AND		IsDeleted	= 0
END
GO


USE [AssignmentDB]
GO

/****** Object:  StoredProcedure [dbo].[spContact_DeleteById]    Script Date: 05/08/2018 11:52:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Nirav Halbe>
-- Create date: <28th July 2018>
-- Description:	This stored procedure is used to DELETE contact data.
-- =============================================
CREATE PROCEDURE [dbo].[spContact_DeleteById] 
	@Id INT
AS
BEGIN

    UPDATE	Contact
	SET		IsDeleted	= 1,
			DeletedDate = GETDATE()
	WHERE	Id = @Id
	
END
GO


