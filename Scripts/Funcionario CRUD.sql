USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Alterar]    Script Date: 21/09/2016 03:08:18 ******/
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
/****** Object:  StoredProcedure [dbo].[Funcionario_AlterarSenha]    Script Date: 21/09/2016 03:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Funcionario_AlterarSenha]
	@Codigo INT,
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
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		Senha, Salario, DataAdmissao, DataCadastro, Ativo
	FROM Funcionario
	WHERE Codigo = @Codigo
	 
END

GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Incluir]    Script Date: 21/09/2016 03:08:18 ******/
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
		@Salario,
		@DataAdmissao,
		GETDATE(),
		1
	)

	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		Senha, Salario, DataAdmissao, DataCadastro, Ativo
	FROM Funcionario
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END


GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Listar]    Script Date: 21/09/2016 03:08:18 ******/
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
    @Ativo BIT = 1
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

--update Funcionario set Senha = '7488E331B8B64E5794DA3FA4EB10AD5D' where Codigo = 1
