USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Atendimento_Incluir]    Script Date: 27/11/2016 21:59:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--alter table Atendimento add Valor money

--=========== Incluir de Atendimento
ALTER PROCEDURE [dbo].[Atendimento_Incluir]
	@Codigo_Agenda Int = NULL,
	@Codigo_Funcionario Int = NULL,
	@Descricao VARCHAR(MAX) = NULL,
    @DataHora  Datetime = NULL,
	@Valor Money = NULL
AS
BEGIN

	INSERT INTO Atendimento
	( 
		Codigo_Agenda,
		Codigo_Funcionario,
		Descricao,
		DataHora,
		Valor
	)
	VALUES(
		@Codigo_Agenda,
		@Codigo_Funcionario,
		@Descricao,
		@DataHora,
		@Valor
	)

	SELECT
        Codigo, Codigo_Agenda, Codigo_Funcionario, Codigo_Pedido, Descricao, DataHora, Valor
	FROM Atendimento
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())
END
