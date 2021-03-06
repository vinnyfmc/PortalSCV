USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Animal_Alterar]    Script Date: 27/11/2016 12:27:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Animal_Alterar]
	@Codigo int = NULL,
	@Codigo_Cliente Int,
	@Codigo_Funcionario Int,
	@Nome VARCHAR(100) = NULL,
	@Raca VARCHAR(100) = NULL,
	@Cor VARCHAR(50) = NULL,
	@Peso Decimal = NULL,
	@Sexo VARCHAR(50) = NULL,
	@DescricaoDoencas VARCHAR(MAX) = NULL,
	@DataNascimento Date,
    @Ativo BIT = 1
AS
BEGIN

	UPDATE Animal
			SET 
				Codigo_Cliente = @Codigo_Cliente,
				Nome = @Nome,
				Raca = @Raca,
				Cor = @Cor,
				Sexo = @Sexo,
				Peso = @Peso,
				DataNascimento = @DataNascimento,
				DescricaoDoencas = @DescricaoDoencas,
				Ativo = @Ativo
	WHERE Codigo = @Codigo
	
	SELECT
        Codigo, Codigo_Cliente, Codigo_Funcionario, Nome, Raca, Cor, Peso, 
		CASE 
			WHEN ((DATEDIFF(day, DataNascimento, getdate()) % 365) > 0) THEN
				(DATEDIFF(day, DataNascimento, getdate()) / 365) + 1
			ELSE
				DATEDIFF(day, DataNascimento, getdate()) / 365
		END as Idade,
		Sexo, DescricaoDoencas, DataNascimento, DataCadastro, Ativo
	FROM Animal
	WHERE Codigo = @Codigo

END
