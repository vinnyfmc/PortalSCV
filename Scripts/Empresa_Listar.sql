USE [PortalSCV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Empresa_Listar]
	@Codigo INT = NULL,
    @RazaoSocial VARCHAR(255) = NULL,
    @NomeFantasia VARCHAR(255) = NULL,
    @CNPJ VARCHAR(14) = NULL,
	@Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2) = NULL,
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20) = NULL,
	@Telefone VARCHAR(11) = NULL,
	@Celular VARCHAR(12) = NULL,
    @Email VARCHAR(100) = NULL,
    @DataCadastro DateTime = NULL,
    @Ativo BIT = NULL
AS
BEGIN

	SELECT 
		Codigo, RazaoSocial, NomeFantasia, CNPJ, Endereco, Bairro, Municipio, 
		UF, Complemento, Numero, Celular, Email, DataCadastro, Ativo
	FROM Empresa
	WHERE Codigo = ISNULL(@Codigo, Codigo)
	AND RazaoSocial = ISNULL(@RazaoSocial, RazaoSocial)
	AND (NomeFantasia = ISNULL(@NomeFantasia, NomeFantasia) OR (NomeFantasia IS NULL))
	AND CNPJ = ISNULL(@CNPJ, CNPJ)
	AND (Endereco = ISNULL(@Endereco, Endereco) OR (Endereco IS NULL)) 
	AND (Bairro = ISNULL(@Bairro, Bairro) OR (Bairro IS NULL)) 
	AND (Municipio = ISNULL(@Municipio, Municipio) OR (Municipio IS NULL))
	AND (UF = ISNULL(@UF, UF) OR (UF IS NULL))
	AND (Complemento = ISNULL(@Complemento, Complemento) OR (Complemento IS NULL))
	AND (Numero = ISNULL(@Numero, Numero) OR (Numero IS NULL))
	AND (Telefone = ISNULL(@Telefone, Telefone) OR (Telefone IS NULL))
	AND (Celular = ISNULL(@Celular, Celular) OR (Celular IS NULL))
	AND (DataCadastro = ISNULL(@DataCadastro, DataCadastro) OR (DataCadastro IS NULL))
	AND Ativo = ISNULL(@Ativo, Ativo)
END