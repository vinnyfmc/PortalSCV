
CREATE PROCEDURE [dbo].[Pedido_Produtos_Incluir]
	@Codigo_Produto Int,
	@Codigo_Pedido Int,
	@Quantidade int,
	@ValorUnitario Money
AS
BEGIN
	INSERT INTO Pedido_Produtos
	( 
		Codigo_Produto,
		Codigo_Pedido,
		Quantidade,
		ValorUnitario
	)
	VALUES(
		@Codigo_Produto,
		@Codigo_Pedido,
		@Quantidade,
		@ValorUnitario
	)

	SELECT
        Codigo, Codigo_Produto, Codigo_Pedido,
		Quantidade,	ValorUnitario
	FROM Pedido_Produtos
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END

CREATE PROCEDURE [dbo].[Pedido_Incluir]
	@Codigo_Funcionario Int,
	@Tipo Int,
	@Observacao varchar(max) = null,
	@PedidoComplementar int = null
AS
BEGIN
	INSERT INTO Pedido
	( 
		Codigo_Funcionario,
		Tipo,
		[Status],
		Observacao,
		DataCriacao,
		PedidoComplementar
	)
	VALUES(
		@Codigo_Funcionario,
		@Tipo,
		1,
		@Observacao,
		GETDATE(),
		@PedidoComplementar
	)

	SELECT
        Codigo, Codigo_Funcionario, Tipo, [Status],
		Observacao,	DataCriacao, PedidoComplementar
	FROM Pedido
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END


CREATE PROCEDURE [dbo].[Pedido_AlterarStatus]
	@Codigo Int,
	@Status Int
AS
BEGIN
	UPDATE Pedido
	SET [Status] = @Status,
	Observacao = (CASE WHEN Observacao IS NULL THEN 'Pedido Cancelado em ' + convert(varchar, GETDATE(), 120)
						ELSE Observacao + ' - ' + 'Pedido Cancelado em ' + convert(varchar, GETDATE(), 120) END)
	WHERE Codigo = @Codigo

	SELECT
        Codigo, Codigo_Funcionario, Tipo, [Status],
		Observacao,	DataCriacao, PedidoComplementar
	FROM Pedido
	WHERE Codigo = @Codigo

END



CREATE PROCEDURE [dbo].[Pedido_Produtos_Listar]
	@Codigo INT = NULL,
    @Codigo_Pedido INT = NULL,
    @Codigo_Produto INT = NULL,
    @Status_Pedido INT = NULL
AS
BEGIN

	SELECT 
		PP.Codigo,
        PP.Codigo_Produto,
        PP.Codigo_Pedido,
        PP.Quantidade,
        PP.ValorUnitario,

        PR.QuantidadeEstoque,
        PR.QuantidadeEstoque_Minima,
        PR.Descricao as DescricaoProduto,
        PR.DataValidade,
        PR.PrecoCompra,
        PR.PrecoVenda,

        F.Nome as Nome_Funcionario,

		PE.Tipo as TipoPedido,
        PE.[Status] as StatusPedido,
        PE.Observacao as ObservacaoPedido,
        PE.DataCriacao as DataCriacaoPedido,
        PE.PedidoComplementar

	FROM Pedido_Produtos PP
	INNER JOIN Pedido PE ON PP.Codigo_Pedido = PE.Codigo
	INNER JOIN Funcionario F ON PE.Codigo_Funcionario = F.Codigo
	INNER JOIN Produto PR ON PP.Codigo_Produto = PR.Codigo
	
	WHERE PP.Codigo = ISNULL(@Codigo, PP.Codigo)
	AND PP.Codigo_Pedido = ISNULL(@Codigo_Pedido, PP.Codigo_Pedido)
	AND PP.Codigo_Produto = ISNULL(@Codigo_Produto, PP.Codigo_Produto)
	AND PE.[Status] = ISNULL(@Status_Pedido, PE.[Status])
	
END
