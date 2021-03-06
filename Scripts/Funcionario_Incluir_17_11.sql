USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Funcionario_Incluir]    Script Date: 18/11/2016 00:07:52 ******/
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
    @Salario MONEY = NULL,
    @DataAdmissao Datetime = NULL,
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
