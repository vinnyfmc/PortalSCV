USE [PortalSCV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Empresa_Incluir]
    @RazaoSocial VARCHAR(200),
    @NomeFantasia VARCHAR(200) = NULL,
    @CNPJ VARCHAR(14),
	@Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2) = NULL,
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20) = NULL,
	@Telefone VARCHAR(11) = NULL,
	@Celular VARCHAR(12) = NULL,
    @Email VARCHAR(100),
    /*@DataCadastro DateTime = NULL,*/
    @Ativo BIT = NULL
AS
BEGIN

	INSERT INTO Empresa
	( 
		RazaoSocial,
		NomeFantasia,
		CNPJ,
        Endereco,
		Bairro,
		Municipio,
		UF,
		Complemento,
		Numero,
		Telefone,
		Celular,
		Email,
		DataCadastro,
		Ativo
		)
	VALUES(
		@RazaoSocial,
		@NomeFantasia,
		@CNPJ,
        @Endereco,
		@Bairro,
		@Municipio,
		@UF,
		@Complemento,
		@Numero,
		@Telefone,
		@Celular,
		@Email,
    	GETDATE(),
		@Ativo
	)

	SELECT 
		Codigo, RazaoSocial, NomeFantasia, CNPJ, Endereco, Bairro, Municipio, UF,
		Complemento, Numero, Telefone, Celular, Email, DataCadastro, Ativo
	FROM Empresa
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END