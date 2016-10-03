USE [PortalSCV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PerfilAcessoFuncionario_Incluir]
	@Codigo_PerfilAcesso int,
	@Codigo_Funcionario int
AS
BEGIN

	INSERT INTO PerfilAcessoFuncionario
	( 
		Codigo_PerfilAcesso,
		Codigo_Funcionario
		)
	VALUES(
		@Codigo_PerfilAcesso,
		@Codigo_Funcionario
	)

	SELECT 
		Codigo_PerfilAcesso, Codigo_Funcionario
	FROM PerfilAcessoFuncionario
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END