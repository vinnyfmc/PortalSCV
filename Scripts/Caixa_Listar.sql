

CREATE PROCEDURE [dbo].[Caixa_Listar]
	@DATA_INICIO DATE,
    @DATA_FIM DATE
AS
BEGIN

	DECLARE @NUMBER_MONTHS INT

	
	SET @NUMBER_MONTHS = DATEDIFF(MONTH, @DATA_INICIO, @DATA_FIM) 

	--RECEITAS DE VENDA DE PRODUTOS
	SELECT PP.Codigo_Pedido as Codigo, PED.DataCriacao as Data, SUM(PP.Quantidade * PP.ValorUnitario) as Valor, 'VENDA' as Descricao, 1 as Origem  
	FROM Pedido_Produtos PP 
	INNER JOIN Pedido PED ON PED.Codigo = PP.Codigo_Pedido
	INNER JOIN Produto PRD ON PRD.Codigo = pp.Codigo_Produto
	WHERE PED.Tipo = 2 --SAIDA
	AND PED.[Status] = 1 -- ATIVO
	AND PED.DataCriacao >= @DATA_INICIO
	AND PED.DataCriacao < @DATA_FIM
	GROUP BY PP.Codigo_Pedido, PED.DataCriacao, Descricao

	UNION ALL

	--RECEITAS DE ATENDIMENTO
	SELECT A.Codigo, A.DataHora as Data, NULL as Valor, 'ATENDIMENTO' as Descricao, 2 as Origem  
	FROM Atendimento A
	WHERE A.DataHora >= @DATA_INICIO
	AND A.DataHora < @DATA_FIM

	UNION ALL

	--DESPESAS DE PEDIDO DE ENTRADA E ATENDIMENTO
	SELECT PP.Codigo_Pedido as CPdogp, PED.DataCriacao as Data, ((-1) * SUM(PP.Quantidade * PP.ValorUnitario)) as Valor, 
	(CASE PED.Tipo WHEN 1 THEN 'COMPRA DE PRODUTOS' WHEN 3 THEN 'DESPESAS DE ATENDIMENTO' END) as Descricao, (CASE PED.Tipo WHEN 1 THEN 3 WHEN 3 THEN 4 END) as Origem     
	FROM Pedido_Produtos PP 
	INNER JOIN Pedido PED ON PED.Codigo = PP.Codigo_Pedido
	INNER JOIN Produto PRD ON PRD.Codigo = pp.Codigo_Produto
	WHERE PED.Tipo in (1,3) --ENTRADA E ATENDIMENTO
	AND PED.[Status] = 1 -- ATIVO
	AND PED.DataCriacao >= @DATA_INICIO
	AND PED.DataCriacao < @DATA_FIM
	GROUP BY PP.Codigo_Pedido, PED.DataCriacao, PED.Tipo, Descricao

	UNION ALL

	-- DESPESAS FUNCIONARIOS
	SELECT Codigo, @DATA_INICIO, (-1 * (@NUMBER_MONTHS * Salario)) as Valor, 'DESPESAS DE SALÁRIOS' as Descricao, 5 as Origem  
	FROM Funcionario
	WHERE Ativo = 1

END
