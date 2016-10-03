USE [PortalSCV]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Funcionario_ListarComboFuncionario]
	@Codigo int = NULL,
    @Nome varchar(255) = NULL
AS
BEGIN

	SELECT 
		 Codigo, Nome
	FROM Funcionario	
END