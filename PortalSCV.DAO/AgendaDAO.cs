using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class AgendaDAO
    {
        public List<AgendaModel> Listar(AgendaModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@CodigoAnimal", oModel.Codigo_Animal),
                new SqlParameter("@CodigoFuncionario", oModel.Codigo_Funcionario),
                new SqlParameter("@CodigoCliente", oModel.Codigo_Cliente),
                new SqlParameter("@DataInicio", oModel.DataHoraEntrada),
                new SqlParameter("@DataFim", oModel.DataHoraSaida)
            };

            return banco.ExecQuery<AgendaModel>(P, "Agenda_Listar");
        }
    }
}
