USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[PerfilAcessoFuncionario_Excluir]    Script Date: 11/12/2016 02:52:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[Agenda_Excluir]
	@Codigo int
AS
BEGIN
	
	IF(NOT EXISTS(SELECT 1 FROM Atendimento WHERE Codigo_Agenda = @Codigo))
	BEGIN 
		DELETE FROM Agenda
		WHERE Codigo = @Codigo
	END
	ELSE
	BEGIN
		SELECT @Codigo AS Codigo
	END

END
