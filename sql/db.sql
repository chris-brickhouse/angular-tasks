/****** Object:  Database [Todo]    Script Date: 12/1/2022 1:11:46 PM ******/
IF NOT EXISTS (SELECT name
FROM sys.databases
WHERE name = N'Todo')
BEGIN
  CREATE DATABASE [Todo]
 CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'Todo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Todo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON
( NAME = N'Todo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Todo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
END
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
  EXEC [Todo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Todo] SET ANSI_NULL_DEFAULT OFF
GO

ALTER DATABASE [Todo] SET ANSI_NULLS OFF
GO

ALTER DATABASE [Todo] SET ANSI_PADDING OFF
GO

ALTER DATABASE [Todo] SET ANSI_WARNINGS OFF
GO

ALTER DATABASE [Todo] SET ARITHABORT OFF
GO

ALTER DATABASE [Todo] SET AUTO_CLOSE OFF
GO

ALTER DATABASE [Todo] SET AUTO_SHRINK OFF
GO

ALTER DATABASE [Todo] SET AUTO_UPDATE_STATISTICS ON
GO

ALTER DATABASE [Todo] SET CURSOR_CLOSE_ON_COMMIT OFF
GO

ALTER DATABASE [Todo] SET CURSOR_DEFAULT  GLOBAL
GO

ALTER DATABASE [Todo] SET CONCAT_NULL_YIELDS_NULL OFF
GO

ALTER DATABASE [Todo] SET NUMERIC_ROUNDABORT OFF
GO

ALTER DATABASE [Todo] SET QUOTED_IDENTIFIER OFF
GO

ALTER DATABASE [Todo] SET RECURSIVE_TRIGGERS OFF
GO

ALTER DATABASE [Todo] SET  DISABLE_BROKER
GO

ALTER DATABASE [Todo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO

ALTER DATABASE [Todo] SET DATE_CORRELATION_OPTIMIZATION OFF
GO

ALTER DATABASE [Todo] SET TRUSTWORTHY OFF
GO

ALTER DATABASE [Todo] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO

ALTER DATABASE [Todo] SET PARAMETERIZATION SIMPLE
GO

ALTER DATABASE [Todo] SET READ_COMMITTED_SNAPSHOT OFF
GO

ALTER DATABASE [Todo] SET HONOR_BROKER_PRIORITY OFF
GO

ALTER DATABASE [Todo] SET RECOVERY FULL
GO

ALTER DATABASE [Todo] SET  MULTI_USER
GO

ALTER DATABASE [Todo] SET PAGE_VERIFY CHECKSUM
GO

ALTER DATABASE [Todo] SET DB_CHAINING OFF
GO

ALTER DATABASE [Todo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
GO

ALTER DATABASE [Todo] SET TARGET_RECOVERY_TIME = 60 SECONDS
GO

ALTER DATABASE [Todo] SET DELAYED_DURABILITY = DISABLED
GO

ALTER DATABASE [Todo] SET ACCELERATED_DATABASE_RECOVERY = OFF
GO

ALTER DATABASE [Todo] SET QUERY_STORE = OFF
GO

ALTER DATABASE [Todo] SET  READ_WRITE
GO

/****** Object:  Table [dbo].[Todo]    Script Date: 12/1/2022 1:12:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[Todo]') AND type in (N'U'))
BEGIN
  CREATE TABLE [dbo].[Todo]
  (
    [TaskID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [varchar](200) NULL,
    [Desc] [varchar](max) NULL,
    [IsComplete] [bit] NULL,
    [TimeStamp] [datetime] NULL,
    [DeleteFlag] [bit] NULL,
    CONSTRAINT [PK_Todo] PRIMARY KEY CLUSTERED
(
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
  ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[DF_Todo_IsComplete]') AND type = 'D')
BEGIN
  ALTER TABLE [dbo].[Todo] ADD  CONSTRAINT [DF_Todo_IsComplete]  DEFAULT ((0)) FOR [IsComplete]
END
GO

IF NOT EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[DF_Todo_TimeStamp]') AND type = 'D')
BEGIN
  ALTER TABLE [dbo].[Todo] ADD  CONSTRAINT [DF_Todo_TimeStamp]  DEFAULT (getdate()) FOR [TimeStamp]
END
GO

IF NOT EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[DF_Todo_DeleteFlag]') AND type = 'D')
BEGIN
  ALTER TABLE [dbo].[Todo] ADD  CONSTRAINT [DF_Todo_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
END
GO
