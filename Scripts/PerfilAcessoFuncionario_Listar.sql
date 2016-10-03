USE [PortalSCV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PerfilAcessoFuncionario_Listar]
	@Codigo int = NULL,
    @Codigo_PerfilAcesso int = NULL,
    @Codigo_Funcionario int = NULL
AS
BEGIN

	SELECT 
		Codigo, Codigo_PerfilAcesso, Codigo_Funcionario
	FROM PerfilAcessoFuncionario
	WHERE Codigo = ISNULL(@Codigo, Codigo)
	AND Codigo_PerfilAcesso = ISNULL(@Codigo_PerfilAcesso, Codigo_PerfilAcesso)
	AND Codigo_Funcionario = ISNULL(@Codigo_Funcionario, Codigo_Funcionario)
END
