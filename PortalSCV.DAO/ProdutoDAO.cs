using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class ProdutoDAO
    {
        public List<ProdutoModel> Listar(ProdutoModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_Fornecedor", oModel.Codigo_Fornecedor),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Descricao", oModel.Descricao)
            };

            return banco.ExecQuery<ProdutoModel>(P, "Produto_Listar");
        }

        public ProdutoModel Incluir(ProdutoModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo_Fornecedor", oModel.Codigo_Fornecedor),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@QuantidadeEstoque_Minima", oModel.QuantidadeEstoque_Minima),
                new SqlParameter("@Descricao", oModel.Descricao),
                new SqlParameter("@DataValidade", oModel.DataValidade),
                new SqlParameter("@PrecoCompra", oModel.PrecoCompra),
                new SqlParameter("@PrecoVenda", oModel.PrecoVenda),
                new SqlParameter("@Foto", oModel.Foto)
            };

            return banco.ExecQueryReturnOne<ProdutoModel>(P, "Produto_Incluir");
        }

        public ProdutoModel Alterar(ProdutoModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_Fornecedor", oModel.Codigo_Fornecedor),
                new SqlParameter("@QuantidadeEstoque_Minima", oModel.QuantidadeEstoque_Minima),
                new SqlParameter("@Descricao", oModel.Descricao),
                new SqlParameter("@DataValidade", oModel.DataValidade),
                new SqlParameter("@PrecoCompra", oModel.PrecoCompra),
                new SqlParameter("@PrecoVenda", oModel.PrecoVenda),
                new SqlParameter("@Foto", oModel.Foto)
            };

            return banco.ExecQueryReturnOne<ProdutoModel>(P, "Produto_Alterar");
        }

        public ProdutoModel AlterarQuantidadeEstoque(ProdutoModel oModel)
        {

            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@QuantidadeEstoque", oModel.QuantidadeEstoque)
            };

            return banco.ExecQueryReturnOne<ProdutoModel>(P, "Produto_AlterarQuantidadeEstoque");

        }

    }
}
