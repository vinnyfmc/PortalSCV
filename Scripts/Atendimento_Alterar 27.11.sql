USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Atendimento_Alterar]    Script Date: 27/11/2016 22:10:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--=========== Alterar de Atendimento
ALTER PROCEDURE [dbo].[Atendimento_Alterar]
	@Codigo int = NULL,
	@Codigo_Agenda Int = NULL,
	@Codigo_Funcionario Int = NULL,
	@Descricao VARCHAR(MAX) = NULL,
    @DataHora  Datetime = NULL,
	@Valor Money = NULL
AS
BEGIN

	UPDATE Atendimento
			SET 
				Codigo_Agenda = @Codigo_Agenda,
				Codigo_Funcionario = @Codigo_Funcionario,
				Descricao = @Descricao,
				DataHora = @DataHora,
			    Valor = @Valor
	WHERE Codigo = @Codigo
	
	SELECT 
        Codigo, Codigo_Agenda, Codigo_Funcionario, Codigo_Pedido, Descricao, DataHora, Valor
	FROM Atendimento
	WHERE Codigo = @Codigo
END
