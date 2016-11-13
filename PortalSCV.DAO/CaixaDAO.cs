using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class CaixaDAO
    {
        public List<CaixaModel> Listar(CaixaModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@DATA_INICIO", oModel.Data),
                new SqlParameter("@DATA_FIM", oModel.DataFim)
            };

            return banco.ExecQuery<CaixaModel>(P, "Caixa_Listar");
        }
    }
}
