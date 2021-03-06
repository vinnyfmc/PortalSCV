--alter table Atendimento add Valor money

--=========== Incluir de Atendimento
CREATE PROCEDURE [dbo].[Atendimento_Incluir]
	@Codigo_Agenda Int = NULL,
	@Codigo_Funcionario Int = NULL,
	@Codigo_Pedido Int = NULL,
	@Descricao VARCHAR(MAX) = NULL,
    @DataHora  Datetime = NULL,
	@Valor Money = NULL
AS
BEGIN

	INSERT INTO Atendimento
	( 
		Codigo_Agenda,
		Codigo_Funcionario,
		Codigo_Pedido,
		Descricao,
		DataHora,
		Valor
	)
	VALUES(
		@Codigo_Agenda,
		@Codigo_Funcionario,
		@Codigo_Pedido,
		@Descricao,
		@DataHora,
		@Valor
	)

	SELECT
        Codigo, Codigo_Agenda, Codigo_Funcionario, Codigo_Pedido, Descricao, DataHora, Valor
	FROM Atendimento
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())
END
GO


--=========== Alterar de Atendimento
CREATE PROCEDURE [dbo].[Atendimento_Alterar]
	@Codigo int = NULL,
	@Codigo_Agenda Int = NULL,
	@Codigo_Funcionario Int = NULL,
	@Codigo_Pedido Int = NULL,
	@Descricao VARCHAR(MAX) = NULL,
    @DataHora  Datetime = NULL,
	@Valor Money = NULL
AS
BEGIN

	UPDATE Atendimento
			SET 
				Codigo_Agenda = @Codigo_Agenda,
				Codigo_Funcionario = @Codigo_Funcionario,
				Codigo_Pedido = @Codigo_Pedido,
				Descricao = @Descricao,
				DataHora = @DataHora,
			    Valor = @Valor
	WHERE Codigo = @Codigo
	
	SELECT 
        Codigo, Codigo_Agenda, Codigo_Funcionario, Codigo_Pedido, Descricao, DataHora, Valor
	FROM Atendimento
	WHERE Codigo = @Codigo
END
GO


--=========== Lista de Atendimento
CREATE PROCEDURE [dbo].[Atendimento_Listar]
	@Codigo int = NULL,
	@Codigo_Agenda Int = NULL,
	@Codigo_Funcionario Int = NULL,
	@Codigo_Pedido Int = NULL,
	@Descricao VARCHAR(MAX) = NULL,
    @DataHora  Datetime = NULL
AS
BEGIN
	SELECT 
        A.Codigo, A.Codigo_Agenda, A.Codigo_Funcionario, A.Codigo_Pedido, A.Descricao, 
		A.DataHora, F.Nome as Nome_Funcionario, P.Codigo as Numero_Pedido
	FROM Atendimento A
	INNER JOIN Funcionario F ON A.Codigo_Funcionario = F.Codigo
	INNER JOIN Pedido P ON A.Codigo_Pedido = P.Codigo
	WHERE A.Codigo = ISNULL(@Codigo, A.Codigo)
	AND A.Codigo_Funcionario = ISNULL(@Codigo_Funcionario, A.Codigo_Funcionario)
	AND A.Codigo_Pedido = ISNULL(@Codigo_Pedido, A.Codigo_Pedido)
	AND (A.DataHora = ISNULL(@DataHora, A.DataHora) OR (A.DataHora IS NULL))
END
GO