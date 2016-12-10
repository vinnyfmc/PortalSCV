USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Funcionario_ListarComboFuncionario]    Script Date: 10/12/2016 18:50:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Funcionario_ListarComboFuncionario]
	@Codigo int = NULL,
    @Nome varchar(255) = NULL
AS
BEGIN

	SELECT 
		 Codigo, Nome
	FROM Funcionario	
	WHERE Ativo = 1
	ORDER BY Nome
END