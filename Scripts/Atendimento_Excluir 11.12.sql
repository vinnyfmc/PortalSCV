
CREATE PROCEDURE [dbo].[Atendimento_Excluir]
	@Codigo int
AS
BEGIN
	
	
		DELETE FROM Atendimento
		WHERE Codigo = @Codigo
	

END