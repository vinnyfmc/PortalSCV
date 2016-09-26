
--Drop table PortalSCV
--Create table PortalSCV

--drop table agenda
--drop table animal
--drop table caixa
--drop table cliente
--drop table Empresa
--drop table Fornecedor
--drop table Funcionario
--drop table Grupo
--drop table GrupoFuncionario
 
-- Tabela de Empresa
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
    [DataCadastro] [Datetime] NOT NULL,
    [Ativo] [bit] NULL,
 CONSTRAINT [PK_Empresa] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO
 
 
-- Tabela de Caixa
CREATE TABLE [dbo].[Caixa](
    [Codigo] [int] IDENTITY(1,1) NOT NULL,
    [Valor] [money] NULL,
    [Quantidade] [int] NULL,
    [DataHoraMovimentacao] datetime NULL,
    [Observacao] [varchar](500) NULL,
 CONSTRAINT [PK_Caixa] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO
 
 
-- Tabela de Grupo
CREATE TABLE [dbo].[Grupo](
    [Codigo] [int] IDENTITY(1,1) NOT NULL,
    [Nome] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO
 
 
-- Tabela de Funcionario
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
    [DataNascimento] [Date] NULL,
    [Email] [varchar](100) NOT NULL,
    [Senha] [varchar](255) NULL,
    [Salario] [money] NULL,
    [DataAdmissao] [Datetime] NULL,
    [DataCadastro] [Datetime] NOT NULL,
    [Ativo] [Bit] NULL,
 CONSTRAINT [PK_Funcionario] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO
 
 
-- Tabela de GrupoFuncionario
CREATE TABLE [dbo].[GrupoFuncionario](
    [Codigo] [int] IDENTITY(1,1) NOT NULL,
    [Codigo_Grupo] [int] NOT NULL,
    [Codigo_Funcionario] [int] NOT NULL,
 CONSTRAINT [PK_GrupoFuncionario] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO
 
ALTER TABLE [dbo].[GrupoFuncionario]  WITH CHECK ADD  CONSTRAINT [FK_GrupoFuncionario_Grupo] FOREIGN KEY([Codigo_Grupo])
REFERENCES [dbo].[Grupo] ([Codigo])
GO
 
ALTER TABLE [dbo].[GrupoFuncionario] CHECK CONSTRAINT [FK_GrupoFuncionario_Grupo]
GO
 
ALTER TABLE [dbo].[GrupoFuncionario]  WITH CHECK ADD  CONSTRAINT [FK_GrupoFuncionario_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Funcionario] ([Codigo])
GO
 
ALTER TABLE [dbo].[GrupoFuncionario] CHECK CONSTRAINT [FK_GrupoFuncionario_Funcionario]
GO
 
 
-- Tabela de Cliente
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
    [DataNascimento] [Date] NULL,
    [DataCadastro] [Datetime] NOT NULL,
    [Ativo] [Bit] NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO


-- Tabela de Fornecedor
CREATE TABLE [dbo].[Fornecedor](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[RazaoSocial] [varchar](200) NULL,
	[NomeFantasia] [varchar](200) NULL,
	[CNPJ] [varchar](14) NULL,
	[Contato] [varchar](12) NULL,
	[Email] [varchar](100) NOT NULL,
	[DataCadastro] [datetime] NOT NULL,
	[Ativo] [Bit] NULL,
 CONSTRAINT [PK_Fornecedor] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO
 
 
-- Tabela de Animal
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
 CONSTRAINT [PK_Animal] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
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
 
 
 
-- Tabela de Agenda
CREATE TABLE [dbo].[Agenda](
    [Codigo] [int] IDENTITY(1,1) NOT NULL,
    [Codigo_Animal] [int] NOT NULL,
    [Codigo_Funcinonario] [int] NOT NULL,
    [Codigo_TipoAtendimento] INT NOT NULL, -- CRIAR TABELA DE TIPOATENDIMENTO
    [DataHoraEntrada] [datetime] NULL,
    [DataHoraSaida] [datetime] NULL,
    [Valor] [money] NULL,
 CONSTRAINT [PK_Agenda] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
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


--Tabela de Produto
CREATE TABLE [dbo].[Produto](
    [Codigo] [int] IDENTITY(1,1) NOT NULL,
    [Codigo_Fornecedor] [int] NOT NULL,
    [Codigo_Funcionario] [int] NOT NULL,
    [CodigoIdentificador] [int] NOT NULL,
	[QuantidadeEstoque] [int] NOT NULL,
	[QuantidadeEstoque_Minimo] [int] NULL,
    [Descricao] [varchar](MAX) NULL,
    [DataValidade] [datetime] NULL,
    --[PrecoUnitario] [money] NULL,
    [PrecoCompra] [money] NULL,
    [PrecoVenda] [money] NULL,
	[Foto] [varchar](255) NULL,
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_Produto] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
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

-- tabela de Pedido
CREATE TABLE [dbo].[Pedido](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Funcionario] [int] NOT NULL,
	[Tipo] [int] NOT NULL, -- 1 - Entrada, 2 - Saida, 3 - Devolução, 4 - Perda e Ganho
	[Observacao] [nvarchar](max) NULL,
	[DataCriacao] [datetime] NOT NULL,
	[PedidoComplementar] [int] NULL, -- Devolução amarrada a uma saída.
	[Ativo] [bit] NULL,
 CONSTRAINT [PK_Pedido] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Funcionario] ([Codigo])
GO
 
ALTER TABLE [dbo].[Pedido] CHECK CONSTRAINT [FK_Pedido_Funcionario]
GO

-- Tabela Pedido com produtos
CREATE TABLE [dbo].[Pedido_Produtos](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Codigo_Produto] [int] NOT NULL,
	[Codigo_Pedido] [int] NOT NULL,
	[Quantidade] [int] NOT NULL,
	[ValorUnitario] [money] NOT NULL
 CONSTRAINT [PK_Pedido_Produtos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

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

--Tabela de Atendimento
CREATE TABLE [dbo].[Atendimento](
    [Codigo] [int] IDENTITY(1,1) NOT NULL,
    [Codigo_Agenda] [int] NOT NULL,
	[Codigo_Funcionario] [int] NOT NULL,
	[Descricao] [varchar](max) NULL,
    [DataHora] [datetime] NULL,
 CONSTRAINT [PK_Atendimento] PRIMARY KEY CLUSTERED 
(
    [Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Atendimento]  WITH CHECK ADD  CONSTRAINT [FK_Atendimento_Funcionario] FOREIGN KEY([Codigo_Funcionario])
REFERENCES [dbo].[Agenda] ([Codigo])
GO
 
ALTER TABLE [dbo].[Atendimento] CHECK CONSTRAINT [FK_Atendimento_Funcionario]
GO