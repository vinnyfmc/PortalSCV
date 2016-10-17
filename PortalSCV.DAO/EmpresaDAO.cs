using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class EmpresaDAO
    {
        public List<EmpresaModel> Listar(EmpresaModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@RazaoSocial", oModel.RazaoSocial),
                new SqlParameter("@NomeFantasia", oModel.NomeFantasia),
                new SqlParameter("@CNPJ", oModel.CNPJ),
                new SqlParameter("@Endereco", oModel.Endereco),
                new SqlParameter("@Bairro", oModel.Bairro),
                new SqlParameter("@Municipio", oModel.Municipio),
                new SqlParameter("@UF", oModel.UF),
                new SqlParameter("@Complemento", oModel.Complemento),
                new SqlParameter("@Numero", oModel.Numero),
                new SqlParameter("@Telefone", oModel.Telefone),
                new SqlParameter("@Celular", oModel.Celular),
                new SqlParameter("@Contato", oModel.Contato),
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@DataCadastro", oModel.DataCadastro),
                new SqlParameter("@Ativo", oModel.Ativo)
    };

            return banco.ExecQuery<EmpresaModel>(P, "Empresa_Listar");
        }

        public EmpresaModel Incluir(EmpresaModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@RazaoSocial", oModel.RazaoSocial),
                new SqlParameter("@NomeFantasia", oModel.NomeFantasia),
                new SqlParameter("@CNPJ", oModel.CNPJ),
                new SqlParameter("@Endereco", oModel.Endereco),
                new SqlParameter("@Bairro", oModel.Bairro),
                new SqlParameter("@Municipio", oModel.Municipio),
                new SqlParameter("@UF", oModel.UF),
                new SqlParameter("@Complemento", oModel.Complemento),
                new SqlParameter("@Numero", oModel.Numero),
                new SqlParameter("@Telefone", oModel.Telefone),
                new SqlParameter("@Celular", oModel.Celular),
                new SqlParameter("@Contato", oModel.Contato),
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@DataCadastro", oModel.DataCadastro),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQueryReturnOne<EmpresaModel>(P, "Empresa_Incluir");
        }

        public EmpresaModel Alterar(EmpresaModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@RazaoSocial", oModel.RazaoSocial),
                new SqlParameter("@NomeFantasia", oModel.NomeFantasia),
                new SqlParameter("@CNPJ", oModel.CNPJ),
                new SqlParameter("@Endereco", oModel.Endereco),
                new SqlParameter("@Bairro", oModel.Bairro),
                new SqlParameter("@Municipio", oModel.Municipio),
                new SqlParameter("@UF", oModel.UF),
                new SqlParameter("@Complemento", oModel.Complemento),
                new SqlParameter("@Numero", oModel.Numero),
                new SqlParameter("@Telefone", oModel.Telefone),
                new SqlParameter("@Celular", oModel.Celular),
                new SqlParameter("@Contato", oModel.Contato),
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@DataCadastro", oModel.DataCadastro),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQueryReturnOne<EmpresaModel>(P, "Empresa_Alterar");
        }
    }
}