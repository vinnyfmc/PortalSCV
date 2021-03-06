USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Empresa_Alterar]    Script Date: 17/11/2016 23:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Empresa_Alterar]
	@Codigo int = NULL,
    @NomeFantasia VARCHAR(255) = NULL,
    @Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2),
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20),
	@Telefone VARCHAR(11),
	@Celular VARCHAR(12),
    @Email VARCHAR(100)
AS
BEGIN

	UPDATE Empresa
	SET 
		NomeFantasia = @NomeFantasia,
		Endereco = @Endereco,
		Bairro = @Bairro,
		Municipio = @Municipio,
		UF = @UF,
		Complemento = @Complemento,
		Numero = @Numero,
		Telefone = @Telefone,
		Celular = @Celular,
		Email = @Email
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, RazaoSocial, NomeFantasia, CNPJ, Endereco, Bairro, Municipio, UF,
		Complemento, Numero, Telefone, Celular, Email, DataCadastro, Ativo
	FROM Empresa
	WHERE Codigo = @Codigo

END
