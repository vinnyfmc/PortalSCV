using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class FornecedorDAO
    {
        public List<FornecedorModel> Listar(FornecedorModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@RazaoSocial", oModel.RazaoSocial),
                new SqlParameter("@NomeFantasia", oModel.NomeFantasia),
                new SqlParameter("@CNPJ", oModel.CNPJ),
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@DataCadastro", oModel.DataCadastro),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQuery<FornecedorModel>(P, "Fornecedor_Listar");
        }

        public FornecedorModel Incluir(FornecedorModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@RazaoSocial", oModel.RazaoSocial),
                new SqlParameter("@NomeFantasia", oModel.NomeFantasia),
                new SqlParameter("@CNPJ", oModel.CNPJ),
                new SqlParameter("@Contato", oModel.Contato),
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQueryReturnOne<FornecedorModel>(P, "Fornecedor_Incluir");
        }

        public FornecedorModel Alterar(FornecedorModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@RazaoSocial", oModel.RazaoSocial),
                new SqlParameter("@NomeFantasia", oModel.NomeFantasia),
                new SqlParameter("@CNPJ", oModel.CNPJ),
                new SqlParameter("@Contato", oModel.Contato),
                new SqlParameter("@Email", oModel.Email),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQueryReturnOne<FornecedorModel>(P, "Fornecedor_Alterar");
        }
    }
}
