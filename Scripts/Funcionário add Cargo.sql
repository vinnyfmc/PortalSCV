
ALTER TABLE Funcionario ADD Cargo INT NULL

USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Listar]    Script Date: 02/11/2016 21:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

[Funcionario_Listar] NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL

ALTER PROCEDURE [dbo].[Funcionario_Listar]
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
    @Cargo INT = NULL,
    @DataAdmissao  Datetime = NULL,
    @DataCadastro  Datetime = NULL,
    @Ativo BIT = NULL
AS
BEGIN

	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		Senha, Salario, DataAdmissao, DataCadastro, Ativo, Cargo
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
	AND (Cargo = ISNULL(@Cargo, Cargo) OR (Cargo IS NULL)) 
	
END

USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Incluir]    Script Date: 02/11/2016 21:13:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Funcionario_Incluir]
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
    @DataAdmissao Datetime,
	@Cargo int = NULL
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
		Ativo,
		Cargo
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
		1,
		@Cargo
	)

	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		@Senha as Senha, Salario, DataAdmissao, DataCadastro, Ativo, Cargo
	FROM Funcionario
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END


USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Alterar]    Script Date: 02/11/2016 21:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Funcionario_Alterar]
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
    @Ativo BIT = 1,
	@Cargo INT = NULL
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
		Ativo = @Ativo,
		Cargo = @Cargo
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio,
		UF, CEP, Complemento, Numero, Telefone, Celular, DataNascimento, Email,
		Senha, Salario, DataAdmissao, DataCadastro, Ativo, Cargo
	FROM Funcionario
	WHERE Codigo = @Codigo

END






