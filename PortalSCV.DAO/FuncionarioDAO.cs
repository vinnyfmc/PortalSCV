using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class FuncionarioDAO
    {
        public List<FuncionarioModel> Listar(FuncionarioModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@CPF", oModel.CPF),
                //new SqlParameter("@Endereco", oModel.Endereco),
                //new SqlParameter("@Bairro", oModel.Bairro),
                //new SqlParameter("@Municipio", oModel.Municipio),
                //new SqlParameter("@UF", oModel.UF),
                //new SqlParameter("@CEP", oModel.CEP),
                //new SqlParameter("@Complemento", oModel.Complemento),
                //new SqlParameter("@Numero", oModel.Numero),
                //new SqlParameter("@Telefone", oModel.Telefone),
                //new SqlParameter("@Celular", oModel.Celular),
                //new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@Email", oModel.Email),
                //new SqlParameter("@Salario", oModel.Salario),
                new SqlParameter("@DataAdmissao", oModel.DataAdmissao),
                new SqlParameter("@DataCadastro", oModel.DataCadastro),
                new SqlParameter("@Ativo", oModel.Ativo)
            };
    
            return banco.ExecQuery<FuncionarioModel>(P,"Funcionario_Listar");
        }

        public List<FuncionarioModel> ListarComboFuncionario(FuncionarioModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Nome", oModel.Nome)
            };

            return banco.ExecQuery<FuncionarioModel>(P, "Funcionario_ListarComboFuncionario");
        }

        public FuncionarioModel Incluir(FuncionarioModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@CPF", oModel.CPF),
                new SqlParameter("@Endereco", oModel.Endereco),
                new SqlParameter("@Bairro", oModel.Bairro),
                new SqlParameter("@Municipio", oModel.Municipio),
                new SqlParameter("@UF", oModel.UF),
                new SqlParameter("@CEP", oModel.CEP),
                new SqlParameter("@Complemento", oModel.Complemento),
                new SqlParameter("@Numero", oModel.Numero),
                new SqlParameter("@Telefone", oModel.Telefone),
                new SqlParameter("@Celular", oModel.Celular),
                new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@Salario", oModel.Salario),
                new SqlParameter("@DataAdmissao", oModel.DataAdmissao)
            };
            
            return banco.ExecQueryReturnOne<FuncionarioModel>(P, "Funcionario_Incluir");
        }

        public FuncionarioModel Alterar(FuncionarioModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@CPF", oModel.CPF),
                new SqlParameter("@Endereco", oModel.Endereco),
                new SqlParameter("@Bairro", oModel.Bairro),
                new SqlParameter("@Municipio", oModel.Municipio),
                new SqlParameter("@UF", oModel.UF),
                new SqlParameter("@CEP", oModel.CEP),
                new SqlParameter("@Complemento", oModel.Complemento),
                new SqlParameter("@Numero", oModel.Numero),
                new SqlParameter("@Telefone", oModel.Telefone),
                new SqlParameter("@Celular", oModel.Celular),
                new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@Salario", oModel.Salario),
                new SqlParameter("@DataAdmissao", oModel.DataAdmissao),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQueryReturnOne<FuncionarioModel>(P, "Funcionario_Alterar");
        }
        
        public FuncionarioModel AlterarSenha(FuncionarioModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = { 
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@Senha", oModel.Senha)
            };
            return banco.ExecQueryReturnOne<FuncionarioModel>(P, "Funcionario_AlterarSenha");
        }
    }
}
