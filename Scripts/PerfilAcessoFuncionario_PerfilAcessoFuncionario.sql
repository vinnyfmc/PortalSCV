USE [PortalSCV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PerfilAcessoFuncionario_PerfilAcessoFuncionario]
	@Codigo int = NULL,
    @Codigo_PerfilAcesso int = NULL,
    @Codigo_Funcionario int = NULL
AS
BEGIN
	SELECT 
		Codigo_PerfilAcesso
	FROM PerfilAcessoFuncionario
	WHERE 
	 (Codigo_Funcionario = ISNULL(@Codigo_Funcionario, Codigo_Funcionario) OR @Codigo_Funcionario IS NULL)
END
