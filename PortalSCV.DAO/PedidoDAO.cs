using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class PedidoDAO
    {
        public List<PedidoModel> Listar(PedidoModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Tipo", oModel.Tipo),
                new SqlParameter("@Status", oModel.Status),
                new SqlParameter("@DataCriacao", oModel.DataCriacao),
                new SqlParameter("@DataCriacaoFim", oModel.DataCriacaoFim),
                new SqlParameter("@PedidoComplementar", oModel.PedidoComplementar)
            };

            return banco.ExecQuery<PedidoModel>(P, "Pedido_Listar");
        }

        public PedidoModel Incluir(PedidoModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Tipo", oModel.Tipo),
                new SqlParameter("@Observacao", oModel.Observacao),
                new SqlParameter("@PedidoComplementar", oModel.PedidoComplementar)
            };

            return banco.ExecQueryReturnOne<PedidoModel>(P, "Pedido_Incluir");
        }

        public PedidoModel Alterar(PedidoModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Observacao", oModel.Observacao)
            };

            return banco.ExecQueryReturnOne<PedidoModel>(P, "Pedido_Alterar");
        }

        public PedidoModel AlterarStatus(PedidoModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Status", oModel.Status)
            };

            return banco.ExecQueryReturnOne<PedidoModel>(P, "Pedido_AlterarStatus");
        }

        public PedidoModel PedidoComplementar(PedidoModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@PedidoComplementar", oModel.PedidoComplementar)
            };

            return banco.ExecQueryReturnOne<PedidoModel>(P, "Pedido_Complementar");
        }

        public List<Pedido_ProdutosModel> Pedido_Produtos_Listar(Pedido_ProdutosModel oModel)
        {

            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo), 
                new SqlParameter("@Codigo_Produto", oModel.Codigo_Produto),
                new SqlParameter("@Codigo_Pedido", oModel.Codigo_Pedido),
                new SqlParameter("@Status_Pedido", oModel.StatusPedido)
            };

            return banco.ExecQuery<Pedido_ProdutosModel>(P, "Pedido_Produtos_Listar");
        }

        public Pedido_ProdutosModel Pedido_Produtos_Incluir(Pedido_ProdutosModel oModel)
        {

            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo_Produto", oModel.Codigo_Produto),
                new SqlParameter("@Codigo_Pedido", oModel.Codigo_Pedido),
                new SqlParameter("@Quantidade", oModel.Quantidade),
                new SqlParameter("@ValorUnitario", oModel.ValorUnitario)
            };

            return banco.ExecQueryReturnOne<Pedido_ProdutosModel>(P, "Pedido_Produtos_Incluir");
        }

    }
}
