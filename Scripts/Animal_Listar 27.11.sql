USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Animal_Listar]    Script Date: 27/11/2016 12:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Animal_Listar]
	@Codigo int = NULL,
	@Codigo_Cliente Int = NULL,
	@Codigo_Funcionario Int = NULL,
	@Nome VARCHAR(100) = NULL,
	@Raca VARCHAR(100) = NULL,
	@Cor VARCHAR(50) = NULL,
	@Idade Int = NULL,
	@Peso Decimal = NULL,
	@Sexo VARCHAR(50) = NULL,
	@DescricaoDoencas VARCHAR(MAX) = NULL,
	@DataNascimento Date  = NULL,
    @DataCadastro  Datetime = NULL,
    @Ativo BIT = NULL
AS
BEGIN

	SELECT 
        A.Codigo, A.Codigo_Cliente, A.Codigo_Funcionario, A.Nome, A.Raca, A.Cor, 
		CASE 
			WHEN ((DATEDIFF(day, A.DataNascimento, getdate()) % 365) > 0) THEN
				(DATEDIFF(day, A.DataNascimento, getdate()) / 365) + 1
			ELSE
				DATEDIFF(day, A.DataNascimento, getdate()) / 365
		END as Idade,
		A.Peso, A.Sexo, A.DescricaoDoencas, A.DataNascimento, A.DataCadastro, A.Ativo,
		C.Nome as Nome_Cliente, F.Nome as Nome_Funcionario
	FROM Animal A
	INNER JOIN Cliente C ON A.Codigo_Cliente = C.Codigo
	INNER JOIN Funcionario F ON A.Codigo_Funcionario = F.Codigo
	WHERE A.Codigo = ISNULL(@Codigo, A.Codigo)
	AND A.Codigo_Cliente = ISNULL(@Codigo_Cliente, A.Codigo_Cliente)
	AND A.Codigo_Funcionario = ISNULL(@Codigo_Funcionario, A.Codigo_Funcionario)
	AND A.Nome = ISNULL(@Nome, A.Nome)
	AND (A.Raca = ISNULL(@Raca, A.Raca) OR (A.Raca IS NULL))
	AND (A.Cor = ISNULL(@Cor, A.Cor) OR (A.Cor IS NULL))
	AND (A.Idade = ISNULL(@Idade, A.Idade) OR (A.Idade IS NULL))
	--AND (A.Peso = ISNULL(@Peso, A.Peso) OR (A.Peso IS NULL))
	--AND (A.Sexo = ISNULL(@Sexo, A.Sexo) OR (A.Sexo IS NULL))
	--AND (A.DescricaoDoencas = ISNULL(@DescricaoDoencas, A.DescricaoDoencas) OR (A.DescricaoDoencas IS NULL))
	--AND (A.DataNascimento = ISNULL(@DataNascimento, A.DataNascimento) OR (A.DataNascimento IS NULL))
	AND (A.DataCadastro = ISNULL(@DataCadastro, A.DataCadastro) OR (A.DataCadastro IS NULL))
	--AND A.Ativo = ISNULL(@Ativo, A.Ativo)
END
