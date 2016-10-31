--*******************************  Adicionar coluna DataCadastro na tabela Animal ********************************

--EXEC sp_rename 'Ativo', 'DataCadastro';
--Alter table Animal alter column DataCadastro datetime not null
--Alter table Animal add Ativo bit null

--alter table animal alter column Peso decimal

--*********************************  Procedures de Cadastro de Clientes e Animais *********************************

--*****************************************
--*************** INCLUIR *****************
--*****************************************

CREATE PROCEDURE [dbo].[Cliente_Incluir]
    @Nome VARCHAR(255) = NULL,
    @CPF VARCHAR(11) = NULL,
	@Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2) = NULL,
	@CEP CHAR(9) = NULL,
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20) = NULL,
	@Telefone VARCHAR(11) = NULL,
	@Celular VARCHAR(12) = NULL,
    @DataNascimento Date,
    /*@DataCadastro DateTime = NULL,*/
    @Ativo BIT = NULL
AS
BEGIN

	INSERT INTO Cliente
	( 
		Nome,
		CPF,
		Endereco,
        Bairro,
		Municipio,
		UF,
		CEP,
		Complemento,
		Numero,
		Telefone,
		Celular,
		DataNascimento,
		DataCadastro,
		Ativo
		)
	VALUES(
		@Nome,
		@CPF,
		@Endereco,
        @Bairro,
		@Municipio,
		@UF,
		@CEP,
		@Complemento,
		@Numero,
		@Telefone,
		@Celular,
		@DataNascimento,
    	GETDATE(),
		@Ativo
	)

	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio, UF, CEP, Complemento, 
		Numero, Telefone, Celular, DataNascimento, DataCadastro, Ativo
	FROM Cliente
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END
GO



CREATE PROCEDURE [dbo].[Animal_Incluir]
	@Codigo_Cliente Int,
	@Codigo_Funcionario Int,
	@Nome VARCHAR(100) = NULL,
	@Raca VARCHAR(100) = NULL,
	@Cor VARCHAR(50) = NULL,
	@Idade Int,
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
		Idade,
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
		@Idade,
		@Peso,
		@Sexo,
		@DescricaoDoencas,
		@DataNascimento,
    	GETDATE(),
		@Ativo
	)

	SELECT
        Codigo, Codigo_Cliente, Codigo_Funcionario, Nome, Raca, Cor, Idade, Peso, 
		Sexo, DescricaoDoencas, DataNascimento, DataCadastro, Ativo
	FROM Animal
	WHERE Codigo = CONVERT(INT,SCOPE_IDENTITY())

END
GO

--*****************************************
--*************** ALTERAR *****************
--*****************************************

CREATE PROCEDURE [dbo].[Cliente_Alterar]
	@Codigo int = NULL,
    @Nome VARCHAR(255) = NULL,
    @CPF VARCHAR(11) = NULL,
	@Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2) = NULL,
	@CEP CHAR(9) = NULL,
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20) = NULL,
	@Telefone VARCHAR(11) = NULL,
	@Celular VARCHAR(12) = NULL,
    @DataNascimento Date,
    @Ativo BIT = 1
AS
BEGIN

	UPDATE Cliente
			SET 
				Endereco = @Endereco,
				Bairro = @Bairro,
				Municipio = @Municipio,
				UF = @UF,
				CEP	= @CEP,
				Complemento	= @Complemento,
				Numero = @Numero,
				Telefone = @Telefone,
				Celular = @Celular,
				Ativo = @Ativo
	WHERE Codigo = @Codigo
	
	SELECT 
		Codigo, Endereco, Bairro, Municipio, UF, CEP, Complemento, 
		Numero, Telefone, Celular, Ativo
	FROM Cliente
	WHERE Codigo = @Codigo

END
GO




CREATE PROCEDURE [dbo].[Animal_Alterar]
	@Codigo int = NULL,
	@Codigo_Cliente Int,
	@Codigo_Funcionario Int,
	@Nome VARCHAR(100) = NULL,
	@Raca VARCHAR(100) = NULL,
	@Cor VARCHAR(50) = NULL,
	@Idade Int,
	@Peso Decimal,
	@Sexo VARCHAR(50) = NULL,
	@DescricaoDoencas VARCHAR(MAX) = NULL,
	@DataNascimento Date,
    @Ativo BIT = 1
AS
BEGIN

	UPDATE Animal
			SET 
				Nome = @Nome,
				Idade = @Idade,
				Peso = @Peso,
				DescricaoDoencas = @DescricaoDoencas,
				Ativo = @Ativo
	WHERE Codigo = @Codigo
	
	SELECT 
        Codigo, Nome, Idade, Peso, DescricaoDoencas, Ativo
	FROM Animal
	WHERE Codigo = @Codigo

END
GO



--*****************************************
--*************** LISTAR *****************
--*****************************************

CREATE PROCEDURE [dbo].[Cliente_Listar]
	@Codigo int = NULL,
    @Nome VARCHAR(255) = NULL,
    @CPF VARCHAR(11) = NULL,
	@Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2) = NULL,
	@CEP CHAR(9) = NULL,
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20) = NULL,
	@Telefone VARCHAR(11) = NULL,
	@Celular VARCHAR(12) = NULL,
    @DataNascimento Date = NULL,
    @DataCadastro  Datetime = NULL,
    @Ativo BIT = NULL
AS
BEGIN

	SELECT 
		Codigo, Nome, CPF, Endereco, Bairro, Municipio, UF, CEP, Complemento, 
		Numero, Telefone, Celular, DataNascimento, DataCadastro, Ativo
	FROM Cliente
	WHERE Codigo = ISNULL(@Codigo, Codigo)
	AND Nome = ISNULL(@Nome, Nome)
	AND (CPF = ISNULL(@CPF, CPF) OR (CPF IS NULL))
	AND (Endereco = ISNULL(@Endereco, Endereco) OR (Endereco IS NULL))
	AND (Bairro = ISNULL(@Bairro, Bairro) OR (Bairro IS NULL))
	AND (Municipio = ISNULL(@Municipio, Municipio) OR (Municipio IS NULL))
	AND (UF = ISNULL(@UF, UF) OR (UF IS NULL))
	AND (CEP = ISNULL(@CEP, CEP) OR (CEP IS NULL))
	AND (Complemento = ISNULL(@Complemento, Complemento) OR (Complemento IS NULL))
	AND (Numero = ISNULL(@Numero, Numero) OR (Numero IS NULL))
	AND (Telefone = ISNULL(@Telefone, Telefone) OR (Telefone IS NULL))
	AND (Celular = ISNULL(@Celular, Celular) OR (Celular IS NULL))
	AND (DataNascimento = ISNULL(@DataNascimento, DataNascimento) OR (DataNascimento IS NULL))
	AND (DataCadastro = ISNULL(@DataCadastro, DataCadastro) OR (DataCadastro IS NULL))
	AND Ativo = ISNULL(@Ativo, Ativo)
END
GO



CREATE PROCEDURE [dbo].[Animal_Listar]
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
        A.Codigo, A.Codigo_Cliente, A.Codigo_Funcionario, A.Nome, A.Raca, A.Cor, A.Idade, A.Peso, 
		A.Sexo, A.DescricaoDoencas, A.DataNascimento, A.DataCadastro, A.Ativo,
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
GO


--*******************************************************
--*************** LISTAR COMBO CLIENTES *****************
--*******************************************************
CREATE PROCEDURE [dbo].[Cliente_ListarComboCliente]
	@Codigo int = NULL,
    @Nome varchar(255) = NULL
AS
BEGIN

	SELECT 
		 Codigo, Nome
	FROM Cliente	
END
GO




--Correção
ALTER PROCEDURE [dbo].[Empresa_Listar]
	@Codigo INT = NULL,
    @RazaoSocial VARCHAR(255) = NULL,
    @NomeFantasia VARCHAR(255) = NULL,
    @CNPJ VARCHAR(14) = NULL,
	@Endereco VARCHAR(200) = NULL,
	@Bairro VARCHAR(100) = NULL,
	@Municipio VARCHAR(100) = NULL,
	@UF CHAR(2) = NULL,
	@Complemento VARCHAR(100) = NULL,
	@Numero VARCHAR(20) = NULL,
	@Telefone VARCHAR(11) = NULL,
	@Celular VARCHAR(12) = NULL,
    @Email VARCHAR(100) = NULL,
    @DataCadastro DateTime = NULL,
    @Ativo BIT = NULL
AS
BEGIN

	SELECT 
		Codigo, RazaoSocial, NomeFantasia, CNPJ, Endereco, Bairro, Municipio, 
		UF, Complemento, Numero, Telefone, Celular, Email, DataCadastro, Ativo
	FROM Empresa
	WHERE Codigo = ISNULL(@Codigo, Codigo)
	AND RazaoSocial = ISNULL(@RazaoSocial, RazaoSocial)
	AND (NomeFantasia = ISNULL(@NomeFantasia, NomeFantasia) OR (NomeFantasia IS NULL))
	AND CNPJ = ISNULL(@CNPJ, CNPJ)
	AND (Endereco = ISNULL(@Endereco, Endereco) OR (Endereco IS NULL)) 
	AND (Bairro = ISNULL(@Bairro, Bairro) OR (Bairro IS NULL)) 
	AND (Municipio = ISNULL(@Municipio, Municipio) OR (Municipio IS NULL))
	AND (UF = ISNULL(@UF, UF) OR (UF IS NULL))
	AND (Complemento = ISNULL(@Complemento, Complemento) OR (Complemento IS NULL))
	AND (Numero = ISNULL(@Numero, Numero) OR (Numero IS NULL))
	AND (Telefone = ISNULL(@Telefone, Telefone) OR (Telefone IS NULL))
	AND (Celular = ISNULL(@Celular, Celular) OR (Celular IS NULL))
	AND (DataCadastro = ISNULL(@DataCadastro, DataCadastro) OR (DataCadastro IS NULL))
	AND Ativo = ISNULL(@Ativo, Ativo)
END
GO