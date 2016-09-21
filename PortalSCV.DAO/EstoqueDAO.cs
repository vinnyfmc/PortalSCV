using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;

namespace PortalSCV.DAO
{
    public class EstoqueDAO
    {
        public List<EstoqueModel> Listar(EstoqueModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Id", oModel.Id),
                new SqlParameter("@IdProduto", oModel.IdProduto),
                new SqlParameter("@Quantidade", oModel.Quantidade)
            };

            return banco.ExecQuery<EstoqueModel>(P, "Estoque_Listar");
        }
        
        public EstoqueModel Incluir(EstoqueModel oModel)
        {

            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@IdProduto", oModel.IdProduto),
                new SqlParameter("@Quantidade", oModel.Quantidade)
            };

            return banco.ExecQueryReturnOne<EstoqueModel>(P, "Estoque_Incluir");

        }

        public EstoqueModel AlterarQuantidade(EstoqueModel oModel)
        {

            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Id", oModel.Id),
                new SqlParameter("@Quantidade", oModel.Quantidade)
            };

            return banco.ExecQueryReturnOne<EstoqueModel>(P, "Estoque_AlterarQuantidade");

        }
    }

}
