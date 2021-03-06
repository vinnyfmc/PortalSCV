USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Atendimento_Listar]    Script Date: 27/11/2016 21:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--=========== Lista de Atendimento
ALTER PROCEDURE [dbo].[Atendimento_Listar]
	@Codigo int = NULL,
	@Codigo_Agenda Int = NULL,
	@Codigo_Funcionario Int = NULL,
	@Descricao VARCHAR(MAX) = NULL,
    @DataHora  Datetime = NULL
AS
BEGIN
	SELECT 
        A.Codigo, A.Codigo_Agenda, A.Codigo_Funcionario, A.Codigo_Pedido, A.Descricao, 
		A.DataHora, F.Nome as Nome_Funcionario, P.Codigo as Numero_Pedido, A.Valor
	FROM Atendimento A
	INNER JOIN Funcionario F ON A.Codigo_Funcionario = F.Codigo
	LEFT JOIN Pedido P ON A.Codigo_Pedido = P.Codigo
	WHERE A.Codigo = ISNULL(@Codigo, A.Codigo)
	AND A.Codigo_Funcionario = ISNULL(@Codigo_Funcionario, A.Codigo_Funcionario)
	AND (A.DataHora = ISNULL(@DataHora, A.DataHora) OR (A.DataHora IS NULL))
END
