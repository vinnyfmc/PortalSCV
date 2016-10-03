USE [PortalSCV]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PerfilAcesso_ListarCombo]
	@Codigo int = NULL,
    @Nome varchar(255) = NULL
AS
BEGIN

	SELECT 
		 Codigo, Nome
	FROM PerfilAcesso	
END