ALTER TABLE AGENDA ADD Ativo BIT NOT NULL

USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Agenda_Listar]    Script Date: 02/11/2016 21:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Agenda_Listar]
	@Codigo INT = NULL,
    @CodigoAnimal INT = NULL,
    @CodigoFuncionario INT = NULL,
	@CodigoCliente INT = NULL,
    @DataInicio DateTime = NULL,
    @DataFim DateTime = NULL,
	@Ativo bit = NULL
AS
BEGIN

	SELECT 
		AG.Codigo, AG.Codigo_Animal, AG.Codigo_Funcionario, AG.DescricaoServico, AG.TipoAtendimento, 
		AG.DataHoraEntrada, AG.DataHoraSaida, AG.Valor, AG.Ativo,
		
		AN.Codigo_Cliente, AN.Nome as Nome_Animal, AN.Raca, AN.Cor, AN.Idade, AN.Peso, AN.Sexo, AN.DescricaoDoencas,
		AN.DataNascimento, AN.Ativo as Ativo_Animal, 
		
		CL.Nome as Nome_CLiente, CL.CPF as CPF_Cliente, CL.Endereco as Endereco_Cliente, CL.Bairro as Bairro_Cliente, 
		CL.Municipio as Municipio_Cliente, CL.UF as UF_Cliente, CL.CEP as CEP_Cliente, CL.Complemento as Complemento_Cliente,
		CL.Numero as Numero_Cliente, CL.Telefone as Telefone_Cliente, CL.Celular as Celular_Cliente, 
		CL.DataNascimento as DataNascimento_Cliente, CL.DataCadastro as DataCadastro_Cliente, CL.Ativo as Ativo_Cliente,
		
		FU.Nome as Nome_Funcionario, FU.CPF as CPF_Funcionario, FU.Telefone as Telefone_Funcionario, 
		FU.Celular as Celular_Funcionario, FU.Email as Email_Funcionario, FU.Ativo as Ativo_Funcionario

	FROM Agenda AG
	INNER JOIN Animal AN ON AG.Codigo_Animal = AN.Codigo
	INNER JOIN Cliente CL ON AN.Codigo_Cliente = CL.Codigo
	INNER JOIN Funcionario FU ON AG.Codigo_Funcionario = FU.Codigo
	WHERE AG.Codigo = ISNULL(@Codigo, AG.Codigo)
	AND AG.Codigo_Animal = ISNULL(@CodigoAnimal, AG.Codigo_Animal)
	AND AG.Codigo_Funcionario = ISNULL(@CodigoFuncionario, AG.Codigo_Funcionario)
	AND AN.Codigo_Cliente = ISNULL(@CodigoCliente, AN.Codigo_Cliente)
	AND AG.DataHoraEntrada >= ISNULL(@DataInicio, AG.DataHoraEntrada)
	AND AG.DataHoraSaida <= ISNULL(@DataFim, AG.DataHoraSaida)
	AND AG.Ativo = ISNULL(@Ativo, AG.Ativo)

END


USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Agenda_Incluir]    Script Date: 02/11/2016 21:07:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[Agenda_Incluir]
	@Codigo_Animal Int,
	@Codigo_Funcionario Int,
	@DescricaoServico VARCHAR(MAX) = NULL,
	@TipoAtendimento VARCHAR(100) = NULL,
	@DataHoraEntrada DATETIME,
	@DataHoraSaida DATETIME,
	@Valor Money,
	@Ativo bit
AS
BEGIN
	INSERT INTO Agenda
	( 
		Codigo_Animal,
		Codigo_Funcionario,
		DescricaoServico,
		TipoAtendimento,
		DataHoraEntrada,
		DataHoraSaida,
		Valor,
		Ativo
	)
	VALUES(
		@Codigo_Animal,
		@Codigo_Funcionario,
		@DescricaoServico,
		@TipoAtendimento,
		@DataHoraEntrada,
		@DataHoraSaida,
		@Valor,
		@Ativo
	)

	SELECT
		Codigo,
        Codigo_Animal,
		Codigo_Funcionario,
		DescricaoServico,
		TipoAtendimento,
		DataHoraEntrada,
		DataHoraSaida,
		Valor,
		Ativo
	FROM Agenda
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END


USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Agenda_Alterar]    Script Date: 02/11/2016 21:09:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[Agenda_Alterar]
	@Codigo Int,
	@Codigo_Animal Int,
	@Codigo_Funcionario Int,
	@DescricaoServico VARCHAR(MAX) = NULL,
	@TipoAtendimento VARCHAR(100) = NULL,
	@DataHoraEntrada DATETIME,
	@DataHoraSaida DATETIME,
	@Valor Money,
	@Ativo bit
AS
BEGIN
	UPDATE Agenda
	set
		Codigo_Animal = @Codigo_Animal,
		Codigo_Funcionario = @Codigo_Funcionario,
		DescricaoServico = @DescricaoServico,
		TipoAtendimento = @TipoAtendimento,
		DataHoraEntrada = @DataHoraEntrada,
		DataHoraSaida = @DataHoraSaida,
		Valor = @Valor,
		Ativo = @Ativo
		WHERE Codigo = @Codigo
	

	SELECT
	Codigo,
        Codigo_Animal,
		Codigo_Funcionario,
		DescricaoServico,
		TipoAtendimento,
		DataHoraEntrada,
		DataHoraSaida,
		Valor,
		Ativo
	FROM Agenda
	WHERE Codigo = @Codigo

END


