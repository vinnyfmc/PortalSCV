USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Cliente_Alterar]    Script Date: 10/12/2016 19:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--*****************************************
--*************** ALTERAR *****************
--*****************************************

ALTER PROCEDURE [dbo].[Cliente_Alterar]
	@Codigo int = NULL,
    @Nome VARCHAR(255) = NULL,
    @CPF VARCHAR(11) = NULL,
	@Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2) = NULL,
	@CEP CHAR(9) = NULL,
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20) = NULL,
	@Telefone VARCHAR(11) = NULL,
	@Celular VARCHAR(12) = NULL,
    @DataNascimento Date,
    @Ativo BIT = 1
AS
BEGIN

	UPDATE Cliente
			SET Nome = @Nome,
				Endereco = @Endereco,
				Bairro = @Bairro,
				Municipio = @Municipio,
				UF = @UF,
				CEP	= @CEP,
				Complemento	= @Complemento,
				Numero = @Numero,
				Telefone = @Telefone,
				Celular = @Celular,
				Ativo = @Ativo
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, Endereco, Bairro, Municipio, UF, CEP, Complemento, 
		Numero, Telefone, Celular, Ativo
	FROM Cliente
	WHERE Codigo = @Codigo

END
