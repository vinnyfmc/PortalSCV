USE [PortalSCV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PerfilAcessoFuncionario_Alterar]
	@Codigo int = NULL,
    @Codigo_PerfilAcesso int = NULL,
    @Codigo_Funcionario int = NULL
AS
BEGIN

	UPDATE PerfilAcessoFuncionario
	SET 
		Codigo_PerfilAcesso = @Codigo_PerfilAcesso,
		Codigo_Funcionario = @Codigo_Funcionario
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, Codigo_PerfilAcesso, Codigo_Funcionario
	FROM PerfilAcessoFuncionario
	WHERE Codigo = @Codigo

END