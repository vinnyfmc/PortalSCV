USE [PortalSCV]
GO
/****** Object:  StoredProcedure [dbo].[Agenda_Listar]    Script Date: 11/12/2016 04:18:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Agenda_ListarParaCombo]
	
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
	LEFT JOIN Atendimento AT ON AT.Codigo_Agenda = AG.Codigo
	WHERE AT.Codigo IS NULL

END
