USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Fornecedor_Alterar]    Script Date: 02/10/2016 21:21:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Fornecedor_Alterar]
	@Codigo int = NULL,
    @RazaoSocial VARCHAR(200),
    @NomeFantasia VARCHAR(200) = NULL,
    @CNPJ VARCHAR(14),
	@Contato VARCHAR(12) = NULL,
    @Email VARCHAR(100),
    @Ativo BIT = 1
AS
BEGIN

	UPDATE Fornecedor
	SET 
		RazaoSocial = @RazaoSocial,
		NomeFantasia = @NomeFantasia,
		CNPJ = @CNPJ,
		Contato = @Contato,
		Email = @Email,
		Ativo = @Ativo
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, RazaoSocial, NomeFantasia, CNPJ
		Contato, Email, DataCadastro, Ativo
	FROM Fornecedor
	WHERE Codigo = @Codigo

END


GO
/****** Object:  StoredProcedure [dbo].[Fornecedor_Incluir]    Script Date: 02/10/2016 21:21:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Fornecedor_Incluir]
    @RazaoSocial VARCHAR(200),
    @NomeFantasia VARCHAR(200) = NULL,
    @CNPJ VARCHAR(14),
	@Contato VARCHAR(12) = NULL,
    @Email VARCHAR(100),
    /*@DataCadastro DateTime = NULL,*/
    @Ativo BIT = NULL
AS
BEGIN

	INSERT INTO Fornecedor
	( 
		RazaoSocial,
		NomeFantasia,
		CNPJ,
		Contato,
		Email,
		DataCadastro,
		Ativo
		)
	VALUES(
		@RazaoSocial,
		@NomeFantasia,
		@CNPJ,
		@Contato,
		@Email,
    	GETDATE(),
		@Ativo
	)

	SELECT 
		Codigo, RazaoSocial, NomeFantasia, CNPJ
		Contato, Email, DataCadastro, Ativo
	FROM Fornecedor
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END


GO
/****** Object:  StoredProcedure [dbo].[Fornecedor_Listar]    Script Date: 02/10/2016 21:21:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Fornecedor_Listar]
	@Codigo INT = NULL,
    @RazaoSocial VARCHAR(200) = NULL,
    @NomeFantasia VARCHAR(200) = NULL,
    @CNPJ VARCHAR(14) = NULL,
    @Email VARCHAR(100) = NULL,
    @DataCadastro DateTime = NULL,
    @Ativo BIT = NULL
AS
BEGIN

	SELECT 
		Codigo, RazaoSocial, NomeFantasia, CNPJ,
		Contato, Email, DataCadastro, Ativo
	FROM Fornecedor
	WHERE Codigo = ISNULL(@Codigo, Codigo)
	AND RazaoSocial = ISNULL(@RazaoSocial, RazaoSocial)
	AND (NomeFantasia = ISNULL(@NomeFantasia, NomeFantasia) OR (NomeFantasia IS NULL))
	AND CNPJ = ISNULL(@CNPJ, CNPJ)
	AND (Email = ISNULL(@Email, Email) OR (Email IS NULL))
	AND (DataCadastro = ISNULL(@DataCadastro, DataCadastro) OR (DataCadastro IS NULL))
	AND Ativo = ISNULL(@Ativo, Ativo)
	
END



GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Alterar]    Script Date: 02/10/2016 21:21:30 ******/
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
/****** Object:  StoredProcedure [dbo].[Funcionario_AlterarSenha]    Script Date: 02/10/2016 21:21:30 ******/
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
/****** Object:  StoredProcedure [dbo].[Funcionario_Incluir]    Script Date: 02/10/2016 21:21:30 ******/
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
/****** Object:  StoredProcedure [dbo].[Funcionario_Listar]    Script Date: 02/10/2016 21:21:30 ******/
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
/****** Object:  StoredProcedure [dbo].[Produto_Alterar]    Script Date: 02/10/2016 21:21:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Produto_Alterar]
	@Codigo int,
    @Codigo_Fornecedor INT,
    @QuantidadeEstoque_Minima INT = NULL,
    @Descricao VARCHAR(MAX),
    @DataValidade DATETIME = NULL,
    @PrecoCompra MONEY,
    @PrecoVenda MONEY,
    @Foto VARCHAR(MAX) = NULL
AS
BEGIN

	UPDATE Produto
	SET 
		Codigo_Fornecedor = @Codigo_Fornecedor,
		QuantidadeEstoque_Minima = @QuantidadeEstoque_Minima,
		Descricao = @Descricao,
		DataValidade = @DataValidade,
		PrecoCompra = @PrecoCompra,
		PrecoVenda = @PrecoVenda,
		Foto = @Foto
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, Codigo_Fornecedor, Codigo_Funcionario,
		QuantidadeEstoque, QuantidadeEstoque_Minima, Descricao,
		DataValidade, PrecoCompra, PrecoVenda, Foto
	FROM Produto
	WHERE Codigo = @Codigo

END


GO
/****** Object:  StoredProcedure [dbo].[Produto_AlterarQuantidadeEstoque]    Script Date: 02/10/2016 21:21:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Produto_AlterarQuantidadeEstoque]
	@Codigo INT,
    @QuantidadeEstoque INT
AS
BEGIN
	
	
	UPDATE Produto
	SET 
		QuantidadeEstoque = @QuantidadeEstoque
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, Codigo_Fornecedor, Codigo_Funcionario,
		QuantidadeEstoque, QuantidadeEstoque_Minima, Descricao,
		DataValidade, PrecoCompra, PrecoVenda, Foto
	FROM Produto
	WHERE Codigo = @Codigo

END

GO
/****** Object:  StoredProcedure [dbo].[Produto_Incluir]    Script Date: 02/10/2016 21:21:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Produto_Incluir]
    @Codigo_Fornecedor INT,
    @Codigo_Funcionario INT,
    @QuantidadeEstoque_Minima INT = NULL,
    @Descricao VARCHAR(MAX),
    @DataValidade DATETIME = NULL,
    @PrecoCompra MONEY,
    @PrecoVenda MONEY,
    @Foto VARCHAR(MAX) = NULL
AS
BEGIN

	INSERT INTO Produto
	( 
		Codigo_Fornecedor,
		Codigo_Funcionario,
		QuantidadeEstoque_Minima,
		QuantidadeEstoque,
		Descricao,
		DataValidade,
		PrecoCompra,
		PrecoVenda,
		Foto
		)
	VALUES(
		@Codigo_Fornecedor,
		@Codigo_Funcionario,
		@QuantidadeEstoque_Minima,
		0,
		@Descricao,
		@DataValidade,
		@PrecoCompra,
		@PrecoVenda,
		@Foto
	)

	SELECT 
		Codigo, Codigo_Fornecedor, Codigo_Funcionario,
		QuantidadeEstoque, QuantidadeEstoque_Minima, Descricao,
		DataValidade, PrecoCompra, PrecoVenda, Foto
	FROM Produto
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END


GO
/****** Object:  StoredProcedure [dbo].[Produto_Listar]    Script Date: 02/10/2016 21:21:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Produto_Listar]
	@Codigo int = NULL,
    @Codigo_Fornecedor INT = NULL,
    @Codigo_Funcionario INT = NULL,
    @Descricao varchar(MAX) = NULL
AS
BEGIN

	SELECT 
		P.Codigo, P.Codigo_Fornecedor, P.Codigo_Funcionario,
		P.QuantidadeEstoque, P.QuantidadeEstoque_Minima, P.Descricao,
		P.DataValidade, P.PrecoCompra, PrecoVenda, P.Foto,
		F.Nome as Nome_Funcionario
	FROM Produto P
	INNER JOIN Funcionario F ON P.Codigo_Funcionario = F.Codigo
	WHERE P.Codigo = ISNULL(@Codigo, P.Codigo)
	AND P.Codigo_Fornecedor = ISNULL(@Codigo_Fornecedor, P.Codigo_Fornecedor)
	AND P.Codigo_Funcionario = ISNULL(@Codigo_Funcionario, P.Codigo_Funcionario)
	AND P.Descricao = ISNULL(@Descricao, P.Descricao)
	
END



GO
