USE [Practicle]
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllData]    Script Date: 17-03-2024 00:32:22 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_GetAllData]
GO
/****** Object:  StoredProcedure [dbo].[USP_AddSortData]    Script Date: 17-03-2024 00:32:22 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_AddSortData]
GO
/****** Object:  Table [dbo].[Tbl_SortData]    Script Date: 17-03-2024 00:32:22 ******/
DROP TABLE IF EXISTS [dbo].[Tbl_SortData]
GO
USE [master]
GO
/****** Object:  Database [Practicle]    Script Date: 17-03-2024 00:32:22 ******/
DROP DATABASE IF EXISTS [Practicle]
GO
/****** Object:  Database [Practicle]    Script Date: 17-03-2024 00:32:22 ******/
CREATE DATABASE [Practicle]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Practicle', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Practicle.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Practicle_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Practicle_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Practicle] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Practicle].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Practicle] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Practicle] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Practicle] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Practicle] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Practicle] SET ARITHABORT OFF 
GO
ALTER DATABASE [Practicle] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Practicle] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Practicle] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Practicle] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Practicle] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Practicle] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Practicle] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Practicle] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Practicle] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Practicle] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Practicle] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Practicle] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Practicle] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Practicle] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Practicle] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Practicle] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Practicle] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Practicle] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Practicle] SET  MULTI_USER 
GO
ALTER DATABASE [Practicle] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Practicle] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Practicle] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Practicle] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Practicle] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Practicle] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Practicle] SET QUERY_STORE = OFF
GO
USE [Practicle]
GO
GRANT VIEW ANY COLUMN ENCRYPTION KEY DEFINITION TO [public] AS [dbo]
GO
GRANT VIEW ANY COLUMN MASTER KEY DEFINITION TO [public] AS [dbo]
GO
/****** Object:  Table [dbo].[Tbl_SortData]    Script Date: 17-03-2024 00:32:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SortData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestSortNumber] [varchar](max) NULL,
	[SortingDirection] [varchar](50) NULL,
	[Timetaken] [varchar](max) NULL,
	[ResponseSortNumber] [varchar](max) NULL,
	[DataAdded] [datetime] NULL,
	[Validation] [varchar](max) NULL,
 CONSTRAINT [PK_Tbl_SortData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Tbl_SortData] ON 
GO
INSERT [dbo].[Tbl_SortData] ([Id], [RequestSortNumber], [SortingDirection], [Timetaken], [ResponseSortNumber], [DataAdded], [Validation]) VALUES (1, N'6,7,3,45,98,2', N'Ascending', 0, N'2,3,6,7,45,98', CAST(N'2024-03-17T00:13:58.540' AS DateTime), NULL)
GO
INSERT [dbo].[Tbl_SortData] ([Id], [RequestSortNumber], [SortingDirection], [Timetaken], [ResponseSortNumber], [DataAdded], [Validation]) VALUES (2, N'6,7,3,45,98,2', N'Desending', 11495, N'98,45,7,6,3,2', CAST(N'2024-03-17T00:14:35.250' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[Tbl_SortData] OFF
GO
/****** Object:  StoredProcedure [dbo].[USP_AddSortData]    Script Date: 17-03-2024 00:32:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddSortData]
@InfoXML xml
AS
BEGIN
	declare @status bit=0,@Message varchar(max)='Unsuccessful';
	begin transaction
	begin try
		
		insert into Tbl_SortData(RequestSortNumber,SortingDirection,Timetaken,ResponseSortNumber,[Validation],DataAdded)
		select 
		RequestSortNumber=x.t.value('RequestSortNumber[1]','varchar(max)')
		,SortingDirection=x.t.value('SortingDirection[1]','varchar(50)')
		,Timetaken=x.t.value('Timetaken[1]','varchar(max)')
		,ResponseSortNumber=x.t.value('ResponseSortNumber[1]','varchar(max)')
		,[Validation]=x.t.value('Validation[1]','varchar(max)')
		,getdate()
		from @InfoXML.nodes('SortData') as X(T);
		
		select @status=1,@Message='Success';

	commit transaction
	end try
	begin catch
		
		rollback transaction;
	end catch

	select [Status]=@status,[Message]=@Message;
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllData]    Script Date: 17-03-2024 00:32:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetAllData] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		select * from Tbl_SortData
  
END
GO
USE [master]
GO
ALTER DATABASE [Practicle] SET  READ_WRITE 
GO
