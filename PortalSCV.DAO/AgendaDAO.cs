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

        public AgendaModel Incluir(AgendaModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo_Animal", oModel.Codigo_Animal),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@DescricaoServico", oModel.DescricaoServico),
                new SqlParameter("@TipoAtendimento", oModel.TipoAtendimento),
                new SqlParameter("@DataHoraEntrada", oModel.DataHoraEntrada),
                new SqlParameter("@DataHoraSaida", oModel.DataHoraSaida),
                new SqlParameter("@Valor", oModel.Valor)
            };

            return banco.ExecQueryReturnOne<AgendaModel>(P, "Agenda_Incluir");
        }

        public AgendaModel Alterar(AgendaModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_Animal", oModel.Codigo_Animal),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@DescricaoServico", oModel.DescricaoServico),
                new SqlParameter("@TipoAtendimento", oModel.TipoAtendimento),
                new SqlParameter("@DataHoraEntrada", oModel.DataHoraEntrada),
                new SqlParameter("@DataHoraSaida", oModel.DataHoraSaida),
                new SqlParameter("@Valor", oModel.Valor)
            };

            return banco.ExecQueryReturnOne<AgendaModel>(P, "Agenda_Alterar");
        }
    }
}
