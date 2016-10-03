using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class PerfilAcessoDAO
    {
        public List<PerfilAcessoModel> ListarComboPerfilAcesso(PerfilAcessoModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Nome", oModel.Nome)
            };

            return banco.ExecQuery<PerfilAcessoModel>(P, "PerfilAcesso_ListarCombo");
        }
    }
}
