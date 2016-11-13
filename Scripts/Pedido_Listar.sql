USE [PortalSCV]
GO

/****** Object:  StoredProcedure [dbo].[Pedido_Produtos_Listar]    Script Date: 13/11/2016 18:41:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Pedido_Listar]
	@Status INT = NULL
AS
BEGIN

	SELECT PE.Codigo,
		PE.Codigo_Funcionario,
		PE.Tipo,
		PE.[Status],
		PE.Observacao,
		PE.DataCriacao,
		PE.PedidoComplementar,
		F.Nome as Nome_Funcionario,
		SUM(PP.ValorUnitario * PP.Quantidade) as ValorTotal
	FROM Pedido PE 
	INNER JOIN Funcionario F ON PE.Codigo_Funcionario = F.Codigo
	INNER JOIN Pedido_Produtos PP ON PP.Codigo_Pedido = PE.Codigo
	WHERE PE.[Status] = ISNULL(@Status, PE.[Status])
	GROUP BY PE.Codigo,
		PE.Codigo_Funcionario,
		PE.Tipo,
		PE.[Status],
		PE.Observacao,
		PE.DataCriacao,
		PE.PedidoComplementar,
		F.Nome
END

GO


