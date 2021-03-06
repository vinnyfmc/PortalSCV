USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Animal_Incluir]    Script Date: 27/11/2016 12:25:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Animal_Incluir]
	@Codigo_Cliente Int,
	@Codigo_Funcionario Int,
	@Nome VARCHAR(100) = NULL,
	@Raca VARCHAR(100) = NULL,
	@Cor VARCHAR(50) = NULL,
	@Peso Decimal,
	@Sexo VARCHAR(50) = NULL,
	@DescricaoDoencas VARCHAR(MAX) = NULL,
	@DataNascimento Date,
    /*@DataCadastro DateTime = NULL,*/
    @Ativo BIT = NULL
AS
BEGIN

	INSERT INTO Animal
	( 
		Codigo_Cliente,
		Codigo_Funcionario,
		Nome,
		Raca,
		Cor,
		Peso,
		Sexo,
		DescricaoDoencas,
		DataNascimento,
		DataCadastro,
		Ativo
	)
	VALUES(
		@Codigo_Cliente,
		@Codigo_Funcionario,
		@Nome,
		@Raca,
		@Cor,
		@Peso,
		@Sexo,
		@DescricaoDoencas,
		@DataNascimento,
    	GETDATE(),
		@Ativo
	)

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
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END
