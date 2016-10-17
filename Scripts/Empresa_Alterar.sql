USE [PortalSCV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Empresa_Alterar]
	@Codigo int = NULL,
    @RazaoSocial VARCHAR(255),
    @NomeFantasia VARCHAR(255) = NULL,
    @CNPJ VARCHAR(14),
	@Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2),
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20),
	@Telefone VARCHAR(11),
	@Celular VARCHAR(12),
    @Email VARCHAR(100),
    @Ativo BIT = 1
AS
BEGIN

	UPDATE Empresa
	SET 
		RazaoSocial = @RazaoSocial,
		NomeFantasia = @NomeFantasia,
		CNPJ = @CNPJ,
		Endereco = @Endereco,
		Bairro = @Bairro,
		Municipio = @Municipio,
		UF = @UF,
		Complemento = @Complemento,
		Numero = @Numero,
		Telefone = @Telefone,
		Celular = @Celular,
		Email = @Email,
		Ativo = @Ativo
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, RazaoSocial, NomeFantasia, CNPJ, Endereco, Bairro, Municipio, UF,
		Complemento, Numero, Telefone, Celular, Email, DataCadastro, Ativo
	FROM Empresa
	WHERE Codigo = @Codigo

END