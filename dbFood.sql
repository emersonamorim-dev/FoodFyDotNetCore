USE [master]
GO
/****** Object:  Database [FoodFy]    Script Date: 01/10/2022 10:23:11 ******/
CREATE DATABASE [FoodFy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FoodFy', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FoodFy.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FoodFy_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FoodFy_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FoodFy] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FoodFy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FoodFy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FoodFy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FoodFy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FoodFy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FoodFy] SET ARITHABORT OFF 
GO
ALTER DATABASE [FoodFy] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [FoodFy] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FoodFy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FoodFy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FoodFy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FoodFy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FoodFy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FoodFy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FoodFy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FoodFy] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FoodFy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FoodFy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FoodFy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FoodFy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FoodFy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FoodFy] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FoodFy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FoodFy] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FoodFy] SET  MULTI_USER 
GO
ALTER DATABASE [FoodFy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FoodFy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FoodFy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FoodFy] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FoodFy] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FoodFy] SET QUERY_STORE = OFF
GO
USE [FoodFy]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[ProdutoId] [int] NULL,
	[Quantidade] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[CategoriaId] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NULL,
	[ImageUrl] [varchar](max) NULL,
	[IsActive] [bit] NULL,
	[DataCriada] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contato]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contato](
	[ContatoId] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Assunto] [varchar](200) NULL,
	[Mensagem] [varchar](max) NULL,
	[DataCriada] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ContatoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagamentos]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagamentos](
	[PagamentoId] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NULL,
	[CardNr] [varchar](50) NULL,
	[DataExpiracao] [varchar](50) NULL,
	[CvvNr] [int] NULL,
	[Endereco] [varchar](max) NULL,
	[ModoPagamento] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PagamentoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[PedidoDetalhesId] [int] IDENTITY(1,1) NOT NULL,
	[PedidoNr] [varchar](max) NULL,
	[ProdutoId] [int] NULL,
	[Quantidade] [int] NULL,
	[UserId] [int] NULL,
	[Status] [varchar](50) NULL,
	[PagamentoId] [int] NULL,
	[DataPedido] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PedidoDetalhesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produtos]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produtos](
	[ProdutoId] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NULL,
	[Descricao] [varchar](max) NULL,
	[Preco] [decimal](18, 2) NULL,
	[Quantidade] [int] NULL,
	[ImageUrl] [varchar](max) NULL,
	[CategoriaId] [int] NULL,
	[IsActive] [bit] NULL,
	[DataCriada] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProdutoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NULL,
	[Username] [varchar](50) NULL,
	[Celular] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Endereco] [varchar](max) NULL,
	[CEP] [varchar](50) NULL,
	[Senha] [varchar](50) NULL,
	[ImageUrl] [varchar](max) NULL,
	[DataCriada] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Produtos] FOREIGN KEY([ProdutoId])
REFERENCES [dbo].[Produtos] ([ProdutoId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Produtos]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Users]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Pagamentos] FOREIGN KEY([PagamentoId])
REFERENCES [dbo].[Pagamentos] ([PagamentoId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Pagamentos]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Produtos] FOREIGN KEY([ProdutoId])
REFERENCES [dbo].[Produtos] ([ProdutoId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Produtos]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Users]
GO
ALTER TABLE [dbo].[Produtos]  WITH CHECK ADD  CONSTRAINT [FK_Produtos_Categorias] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[Categorias] ([CategoriaId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Produtos] CHECK CONSTRAINT [FK_Produtos_Categorias]
GO
/****** Object:  StoredProcedure [dbo].[Categoria_Crud]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Categoria_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@CategoriaId INT = NULL,
	@Nome VARCHAR(100) = NULL,
	@IsActive BIT = false,
	@ImageUrl VARCHAR(MAX) = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT
	IF @Action = 'SELECT'
	  BEGIN
	        SELECT * FROM dbo.Categorias ORDER BY DataCriada DESC

	  END

	--INSERT
	IF @Action = 'INSERT'
	  BEGIN
	        INSERT INTO dbo.Categorias(Nome, ImageUrl, IsActive, DataCriada)
		    VALUES (@Nome, @ImageUrl, @IsActive, GETDATE())
      END

	  --UPDATE
	  IF @Action = 'UPDATE'
	    BEGIN
		  DECLARE @UPDATE_IMAGE VARCHAR(20)
		  SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		  IF @UPDATE_IMAGE = 'NO'
		     BEGIN
			    UPDATE dbo.Categorias
				SET Nome = @Nome, IsActive = @IsActive
				WHERE CategoriaId = @CategoriaId
		     END
		ELSE
		    BEGIN
			    UPDATE dbo.Categorias
				SET Nome = @Nome, ImageUrl = @ImageUrl, IsActive = @IsActive
				WHERE CategoriaId = @CategoriaId

			END
		END

		--DELETE
		IF @Action = 'DELETE'
		BEGIN
		      DELETE FROM dbo.Categorias WHERE CategoriaId = @CategoriaId
	    END

		--GETBYID
		IF @Action = 'GETBYID'
		BEGIN
		      SELECT * FROM dbo.Categorias WHERE CategoriaId = @CategoriaId
	    END


END
GO
/****** Object:  StoredProcedure [dbo].[Produto_Crud]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Produto_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@ProdutoId INT = NULL,
	@Nome VARCHAR(100) = NULL,
	@Descricao VARCHAR(MAX) = NULL,
	@Preco Decimal(18,2) = 0,
	@Quantidade INT = NULL,
	@ImageUrl VARCHAR(MAX) = NULL,
	@CategoriaId INT = NULL,
	@IsActive BIT = false

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT
	IF @Action = 'SELECT'
	  BEGIN

			SELECT p.*,c.Nome AS CategoriaNome FROM dbo.Produtos p 
			INNER JOIN dbo.Categorias c ON c.CategoriaId = p.CategoriaId ORDER BY p.DataCriada DESC


	  END

	--INSERT
	IF @Action = 'INSERT'
	  BEGIN
	        INSERT INTO dbo.Produtos(Nome, Descricao, Preco, Quantidade, CategoriaId, ImageUrl, IsActive, DataCriada)
		    VALUES (@Nome, @Descricao, @Preco, @Quantidade, @CategoriaId, @ImageUrl, @IsActive, GETDATE())
      END

	  --UPDATE
	  IF @Action = 'UPDATE'
	    BEGIN
		  DECLARE @UPDATE_IMAGE VARCHAR(20)
		  SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		  IF @UPDATE_IMAGE = 'NO'
		     BEGIN
			    UPDATE dbo.Produtos
				SET Nome = @Nome, Descricao = @Descricao, Preco = @Preco, Quantidade = @Quantidade, 
				CategoriaId = @CategoriaId, IsActive =@IsActive
				WHERE ProdutoId = @ProdutoId
		     END
		ELSE
		    BEGIN
			    UPDATE dbo.Produtos
				SET Nome = @Nome, Descricao = @Descricao, Preco = @Preco, Quantidade = @Quantidade, 
				CategoriaId = @CategoriaId, IsActive =@IsActive
				WHERE ProdutoId = @ProdutoId

			END
		END

		--Update Quantidade
		IF @Action = 'QDTUPDATE'
		BEGIN
		      UPDATE dbo.Produtos SET Quantidade = @Quantidade
			  WHERE ProdutoId = @ProdutoId
	    END

		--DELETE
		IF @Action = 'DELETE'
		BEGIN
		      DELETE FROM dbo.Produtos WHERE ProdutoId = @ProdutoId
	    END

		--GETBYID
		IF @Action = 'GETBYID'
		BEGIN
		      SELECT * FROM dbo.Produtos WHERE ProdutoId = @ProdutoId
	    END


END
GO
/****** Object:  StoredProcedure [dbo].[User_Crud]    Script Date: 01/10/2022 10:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[User_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@UserId INT = NULL,
	@Nome VARCHAR(100) = NULL,
	@Username VARCHAR(50) = NULL,
	@Celular VARCHAR(50) = NULL,
	@Email VARCHAR(50) = NULL,
	@Endereco VARCHAR(MAX) = NULL,
	@CEP VARCHAR(50) = NULL,
	@Senha VARCHAR(50) = NULL,
	@ImageUrl VARCHAR(MAX) = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT
	IF @Action = 'SELECT4LOGIN'
	  BEGIN
	        SELECT * FROM dbo.Users WHERE Username = @Username and Senha = @Senha

	  END

	--SELECT USER
	IF @Action = 'SELECT4PERFIL'
	  BEGIN
	       
		   SELECT * FROM dbo.Users WHERE UserId = @UserId
      END

	  	--Insert Registro
	IF @Action = 'INSERT'
	  BEGIN
	       Insert into dbo.Users(UserId,Nome,Username,Celular,Email,Endereco,CEP,Senha,ImageUrl,DataCriada)
		   values (@UserId, @Nome,@Username,@Celular,@Email,@Endereco,@CEP,@Senha,@ImageUrl,GETDATE())
      END

	  --UPDATE PERFIL
	  IF @Action = 'UPDATE'
	    BEGIN
		  DECLARE @UPDATE_IMAGE VARCHAR(20)
		  SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		  IF @UPDATE_IMAGE = 'NO'
		     BEGIN
			    UPDATE dbo.Users
				SET Nome = @Nome, Username = @Username, Celular = @Celular, Email = @Email, Endereco = @Endereco,
				CEP = @CEP
				WHERE UserId = @UserId
		     END
		ELSE
		    BEGIN
			    UPDATE dbo.Users
				SET Nome = @Nome, Username = @Username, Celular = @Celular, Email = @Email, Endereco = @Endereco,
				CEP = @CEP, ImageUrl = @ImageUrl
				WHERE UserId = @UserId

			END
		END

		--SELECT FOR ADMIN
		IF @Action = 'SELECT4ADMIN'
		   BEGIN
		       SELECT  ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],UserId, Nome,
			   Username, Email, DataCriada
			   FROM Users
           END

		--DELETE
		IF @Action = 'DELETE'
		BEGIN
		      DELETE FROM dbo.Users WHERE UserId = @UserId
	    END


END
GO
USE [master]
GO
ALTER DATABASE [FoodFy] SET  READ_WRITE 
GO
