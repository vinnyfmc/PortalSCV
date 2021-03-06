USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Alterar]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Funcionario_Alterar]
	@Codigo int = NULL,
    @Nome varchar(255) = NULL,
    @CPF varchar(11) = NULL,
    @Endereco varchar(200) = NULL,
    @Bairro varchar(100) = NULL,
    @Municipio varchar(100) = NULL,
    @UF char(2) = NULL,
    @CEP varchar(9) = NULL,
    @Complemento varchar(100) = NULL,
    @Numero varchar (20) = NULL,
    @Telefone varchar(11) = NULL,
    @Celular varchar(12) = NULL,
    @DataNascimento Date = NULL,
    @Email varchar(100) = NULL,
    @Salario MONEY = NULL,
    @DataAdmissao  Datetime = NULL,
    @Ativo BIT = 1
AS
BEGIN

	UPDATE Funcionario
	SET 
		Nome = @Nome,
		CPF = @CPF,
		Endereco = @Endereco,
		Bairro = @Bairro,
		Municipio = @Municipio,
		UF = @UF,
		CEP = @CEP,
		Complemento = @Complemento,
		Numero = @Numero,
		Telefone = @Telefone,
		Celular = @Celular,
		DataNascimento = @DataNascimento,
		Email = @Email,
		Salario = @Salario,
		DataAdmissao = @DataAdmissao,
		Ativo = @Ativo
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		Senha, Salario, DataAdmissao, DataCadastro, Ativo
	FROM Funcionario
	WHERE Codigo = @Codigo

END


GO
/****** Object:  StoredProcedure [dbo].[Funcionario_AlterarSenha]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Funcionario_AlterarSenha]
	@Email varchar(100),
    @Senha VARCHAR(255) = NULL
AS
BEGIN
	IF(@Senha IS NULL)
	BEGIN
		SET @Senha = LEFT(newid(),8)
	END
	
	UPDATE Funcionario
	SET 
		Senha = CONVERT(VARCHAR(32), HashBytes('MD5', @Senha), 2)
	WHERE Email = @Email
	
	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		@Senha as Senha, Salario, DataAdmissao, DataCadastro, Ativo
	FROM Funcionario
	WHERE Email = @Email
	 
END

GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Incluir]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Funcionario_Incluir]
    @Nome varchar(255),
    @CPF varchar(11),
    @Endereco varchar(200) = NULL,
    @Bairro varchar(100) = NULL,
    @Municipio varchar(100) = NULL,
    @UF char(2) = NULL,
    @CEP varchar(9) = NULL,
    @Complemento varchar(100) = NULL,
    @Numero varchar (20) = NULL,
    @Telefone varchar(11) = NULL,
    @Celular varchar(12) = NULL,
    @DataNascimento Date,
    @Email varchar(100),
    @Salario MONEY,
    @DataAdmissao Datetime
AS
BEGIN

	DECLARE @Senha VARCHAR(255)
	DECLARE @SenhaMD5 VARCHAR(255)
	SET @Senha = LEFT(newid(),8)
	SET @SenhaMD5 = CONVERT(VARCHAR(32), HashBytes('MD5', @Senha), 2)

	INSERT INTO Funcionario
	( 
		Nome,
		CPF,
		Endereco,
		Bairro,
		Municipio,
		UF ,
		CEP,
		Complemento,
		Numero,
		Telefone,
		Celular,
		DataNascimento,
		Email,
		Senha,
		Salario,
		DataAdmissao,
		DataCadastro,
		Ativo
		)
	VALUES(
		@Nome,
		@CPF,
		@Endereco,
		@Bairro,
		@Municipio,
		@UF,
		@CEP,
		@Complemento,
		@Numero,
		@Telefone,
		@Celular,
		@DataNascimento,
		@Email,
		@SenhaMD5,
		@Salario,
		@DataAdmissao,
		GETDATE(),
		1
	)

	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		@Senha as Senha, Salario, DataAdmissao, DataCadastro, Ativo
	FROM Funcionario
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END


GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Listar]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Funcionario_Listar]
	@Codigo int = NULL,
    @Nome varchar(255) = NULL,
    @CPF varchar(11) = NULL,
    --@Endereco varchar(200) = NULL,
    --@Bairro varchar(100) = NULL,
    --@Municipio varchar(100) = NULL,
    --@UF char(2) = NULL,
    --@CEP varchar(9) = NULL,
    --@Complemento varchar(100) = NULL,
    --@Numero varchar (20) = NULL,
    --@Telefone varchar(11) = NULL,
    --@Celular varchar(12) = NULL,
    --@DataNascimento Date = NULL,
    @Email varchar(100) = NULL,
    --@Salario MONEY = NULL,
    @DataAdmissao  Datetime = NULL,
    @DataCadastro  Datetime = NULL,
    @Ativo BIT = NULL
AS
BEGIN

	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		Senha, Salario, DataAdmissao, DataCadastro, Ativo
	FROM Funcionario
	WHERE Codigo = ISNULL(@Codigo, Codigo)
	AND Nome = ISNULL(@Nome, Nome)
	AND (CPF = ISNULL(@CPF, CPF) OR (CPF IS NULL))
	--AND (Endereco = ISNULL(@Endereco, Endereco) OR (Endereco IS NULL))
	--AND (Bairro = ISNULL(@Bairro, Bairro) OR (Bairro IS NULL))
	--AND (Municipio = ISNULL(@Municipio, Municipio) OR (Municipio IS NULL))
	--AND (UF = ISNULL(@UF, UF) OR (UF IS NULL))
	--AND (CEP = ISNULL(@CEP, CEP) OR (CEP IS NULL))
	--AND (Complemento = ISNULL(@Complemento, Complemento) OR (Complemento IS NULL))
	--AND (Numero = ISNULL(@Numero, Numero) OR (Numero IS NULL))
	--AND (Telefone = ISNULL(@Telefone, Telefone) OR (Telefone IS NULL))
	--AND (Celular = ISNULL(@Celular, Celular) OR (Celular IS NULL))
	--AND (DataNascimento = ISNULL(@DataNascimento, DataNascimento) OR (DataNascimento IS NULL))
	AND (Email = ISNULL(@Email, Email) OR (Email IS NULL))
	--AND (Salario = ISNULL(@Salario, Salario) OR (Salario IS NULL))
	AND (DataAdmissao = ISNULL(@DataAdmissao, DataAdmissao) OR (DataAdmissao IS NULL))
	AND (DataCadastro = ISNULL(@DataCadastro, DataCadastro) OR (DataCadastro IS NULL))
	AND Ativo = ISNULL(@Ativo, Ativo)
	
END



GO
/****** Object:  Table [dbo].[Agenda]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Agenda](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Animal] [int] NOT NULL,
	[Codigo_Funcionario] [int] NOT NULL,
	[DescricaoServico] [varchar](max) NULL,
	[TipoAtendimento] [varchar](100) NULL,
	[DataHoraEntrada] [datetime] NULL,
	[DataHoraSaida] [datetime] NULL,
	[Valor] [money] NULL,
 CONSTRAINT [PK_Agenda] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Animal]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Animal](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Cliente] [int] NOT NULL,
	[Codigo_Funcionario] [int] NOT NULL,
	[Nome] [varchar](100) NULL,
	[Raca] [varchar](100) NULL,
	[Cor] [varchar](50) NULL,
	[Idade] [int] NULL,
	[Peso] [float] NULL,
	[Sexo] [varchar](50) NULL,
	[DescricaoDoencas] [varchar](max) NULL,
	[DataNascimento] [date] NULL,
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_Animal] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Atendimento]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Atendimento](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Agenda] [int] NOT NULL,
	[Codigo_Funcionario] [int] NOT NULL,
	[Codigo_Pedido] [int] NULL,
	[Descricao] [varchar](max) NULL,
	[DataHora] [datetime] NULL,
 CONSTRAINT [PK_Atendimento] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Caixa]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Caixa](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Valor] [money] NULL,
	[Quantidade] [int] NULL,
	[Total] [money] NULL,
	[DataHoraMovimentacao] [datetime] NULL,
	[Observacao] [varchar](500) NULL,
 CONSTRAINT [PK_Caixa] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Cliente](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](255) NULL,
	[CPF] [varchar](11) NULL,
	[Endereco] [varchar](200) NULL,
	[Bairro] [varchar](100) NULL,
	[Municipio] [varchar](100) NULL,
	[UF] [char](2) NULL,
	[CEP] [varchar](9) NULL,
	[Complemento] [varchar](100) NULL,
	[Numero] [varchar](20) NULL,
	[Telefone] [varchar](11) NULL,
	[Celular] [varchar](12) NULL,
	[DataNascimento] [date] NULL,
	[DataCadastro] [datetime] NOT NULL,
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Empresa](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[RazaoSocial] [varchar](255) NULL,
	[NomeFantasia] [varchar](255) NULL,
	[CNPJ] [varchar](14) NULL,
	[Endereco] [varchar](200) NULL,
	[Bairro] [varchar](100) NULL,
	[Municipio] [varchar](100) NULL,
	[UF] [char](2) NULL,
	[Complemento] [varchar](100) NULL,
	[Numero] [varchar](20) NULL,
	[Telefone] [varchar](11) NULL,
	[Celular] [varchar](12) NULL,
	[Email] [varchar](100) NOT NULL,
	[DataCadastro] [datetime] NOT NULL,
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_Empresa] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Fornecedor]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Fornecedor](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[RazaoSocial] [varchar](200) NULL,
	[NomeFantasia] [varchar](200) NULL,
	[CNPJ] [varchar](14) NULL,
	[Contato] [varchar](12) NULL,
	[Email] [varchar](100) NOT NULL,
	[DataCadastro] [datetime] NOT NULL,
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_Fornecedor] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Funcionario]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Funcionario](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](255) NULL,
	[CPF] [varchar](11) NULL,
	[Endereco] [varchar](200) NULL,
	[Bairro] [varchar](100) NULL,
	[Municipio] [varchar](100) NULL,
	[UF] [char](2) NULL,
	[CEP] [varchar](9) NULL,
	[Complemento] [varchar](100) NULL,
	[Numero] [varchar](20) NULL,
	[Telefone] [varchar](11) NULL,
	[Celular] [varchar](12) NULL,
	[DataNascimento] [date] NULL,
	[Email] [varchar](100) NOT NULL,
	[Senha] [varchar](255) NULL,
	[Salario] [money] NULL,
	[DataAdmissao] [datetime] NULL,
	[DataCadastro] [datetime] NOT NULL,
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_Funcionario] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pedido]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedido](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Funcionario] [int] NOT NULL,
	[Tipo] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Observacao] [nvarchar](max) NULL,
	[DataCriacao] [datetime] NOT NULL,
	[PedidoComplementar] [int] NULL,
 CONSTRAINT [PK_Pedido] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pedido_Produtos]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedido_Produtos](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Produto] [int] NOT NULL,
	[Codigo_Pedido] [int] NOT NULL,
	[Quantidade] [int] NOT NULL,
	[ValorUnitario] [money] NOT NULL,
 CONSTRAINT [PK_Pedido_Produtos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PerfilAcesso]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PerfilAcesso](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
 CONSTRAINT [PK_PerfilAcesso] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PerfilAcessoFuncionario]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerfilAcessoFuncionario](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_PerfilAcesso] [int] NOT NULL,
	[Codigo_Funcionario] [int] NOT NULL,
 CONSTRAINT [PK_PerfilAcessoFuncionario] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Produto]    Script Date: 26/09/2016 20:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Produto](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Fornecedor] [int] NOT NULL,
	[Codigo_Funcionario] [int] NOT NULL,
	[QuantidadeEstoque] [int] NOT NULL,
	[QuantidadeEstoque_Minima] [int] NULL,
	[Descricao] [varchar](max) NULL,
	[DataValidade] [datetime] NULL,
	[PrecoCompra] [money] NULL,
	[PrecoVenda] [money] NULL,
	[Foto] [varchar](max) NULL,
 CONSTRAINT [PK_Produto] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_Animal] FOREIGN KEY([Codigo_Animal])
REFERENCES [dbo].[Animal] ([Codigo])
GO
ALTER TABLE [dbo].[Agenda] CHECK CONSTRAINT [FK_Agenda_Animal]
GO
ALTER TABLE [dbo].[Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Funcionario] ([Codigo])
GO
ALTER TABLE [dbo].[Agenda] CHECK CONSTRAINT [FK_Agenda_Funcionario]
GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_Cliente] FOREIGN KEY([Codigo_Cliente])
REFERENCES [dbo].[Cliente] ([Codigo])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_Cliente]
GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Funcionario] ([Codigo])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_Funcionario]
GO
ALTER TABLE [dbo].[Atendimento]  WITH CHECK ADD  CONSTRAINT [FK_Atendimento_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Agenda] ([Codigo])
GO
ALTER TABLE [dbo].[Atendimento] CHECK CONSTRAINT [FK_Atendimento_Funcionario]
GO
ALTER TABLE [dbo].[Atendimento]  WITH CHECK ADD  CONSTRAINT [FK_Atendimento_Pedido] FOREIGN KEY([Codigo_Pedido])
REFERENCES [dbo].[Pedido] ([Codigo])
GO
ALTER TABLE [dbo].[Atendimento] CHECK CONSTRAINT [FK_Atendimento_Pedido]
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Funcionario] ([Codigo])
GO
ALTER TABLE [dbo].[Pedido] CHECK CONSTRAINT [FK_Pedido_Funcionario]
GO
ALTER TABLE [dbo].[Pedido_Produtos]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_Produtos_Pedido] FOREIGN KEY([Codigo_Pedido])
REFERENCES [dbo].[Pedido] ([Codigo])
GO
ALTER TABLE [dbo].[Pedido_Produtos] CHECK CONSTRAINT [FK_Pedido_Produtos_Pedido]
GO
ALTER TABLE [dbo].[Pedido_Produtos]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_Produtos_Produto] FOREIGN KEY([Codigo_Produto])
REFERENCES [dbo].[Produto] ([Codigo])
GO
ALTER TABLE [dbo].[Pedido_Produtos] CHECK CONSTRAINT [FK_Pedido_Produtos_Produto]
GO
ALTER TABLE [dbo].[PerfilAcessoFuncionario]  WITH CHECK ADD  CONSTRAINT [FK_PerfilAcessoFuncionario_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Funcionario] ([Codigo])
GO
ALTER TABLE [dbo].[PerfilAcessoFuncionario] CHECK CONSTRAINT [FK_PerfilAcessoFuncionario_Funcionario]
GO
ALTER TABLE [dbo].[PerfilAcessoFuncionario]  WITH CHECK ADD  CONSTRAINT [FK_PerfilAcessoFuncionario_PerfilAcesso] FOREIGN KEY([Codigo_PerfilAcesso])
REFERENCES [dbo].[PerfilAcesso] ([Codigo])
GO
ALTER TABLE [dbo].[PerfilAcessoFuncionario] CHECK CONSTRAINT [FK_PerfilAcessoFuncionario_PerfilAcesso]
GO
ALTER TABLE [dbo].[Produto]  WITH CHECK ADD  CONSTRAINT [FK_Produto_Fornecedor] FOREIGN KEY([Codigo_Fornecedor])
REFERENCES [dbo].[Fornecedor] ([Codigo])
GO
ALTER TABLE [dbo].[Produto] CHECK CONSTRAINT [FK_Produto_Fornecedor]
GO
ALTER TABLE [dbo].[Produto]  WITH CHECK ADD  CONSTRAINT [FK_Produto_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Funcionario] ([Codigo])
GO
ALTER TABLE [dbo].[Produto] CHECK CONSTRAINT [FK_Produto_Funcionario]
GO
