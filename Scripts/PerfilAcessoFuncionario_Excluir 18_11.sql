USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[PerfilAcessoFuncionario_Alterar]    Script Date: 18/11/2016 04:11:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PerfilAcessoFuncionario_Excluir]
	@Codigo int
AS
BEGIN

	DELETE FROM PerfilAcessoFuncionario
	WHERE Codigo = @Codigo
	

END
