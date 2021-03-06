USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[PerfilAcessoFuncionario_Listar]    Script Date: 03/10/2016 11:09:08 ******/
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
		PAF.Codigo, PAF.Codigo_PerfilAcesso, PAF.Codigo_Funcionario,
		F.Nome as Funcionario_Nome, PA.Nome as PerfilAcesso_Nome
	FROM PerfilAcessoFuncionario PAF
	INNER JOIN PerfilAcesso PA ON PA.Codigo = PAF.Codigo_PerfilAcesso
	INNER JOIN Funcionario F ON F.Codigo = PAF.Codigo_Funcionario
	WHERE (PAF.Codigo = ISNULL(@Codigo, PAF.Codigo) OR @Codigo IS NULL)
	AND (PAF.Codigo_PerfilAcesso = ISNULL(@Codigo_PerfilAcesso, PAF.Codigo_PerfilAcesso) OR @Codigo_PerfilAcesso IS NULL)
	AND (PAF.Codigo_Funcionario = ISNULL(@Codigo_Funcionario, PAF.Codigo_Funcionario) OR @Codigo_Funcionario IS NULL)
END
