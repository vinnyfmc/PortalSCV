using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class AtendimentoDAO
    {
        public List<AtendimentoModel> Listar(AtendimentoModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_Agenda", oModel.Codigo_Agenda),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Codigo_Pedido", oModel.Codigo_Pedido),
                new SqlParameter("@Descricao", oModel.Descricao),
                new SqlParameter("@DataHora", oModel.DataHora),
                new SqlParameter("@Valor", oModel.Valor)
            };

            return banco.ExecQuery<AtendimentoModel>(P, "Atendimento_Listar");
        }

        public AtendimentoModel Incluir(AtendimentoModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo_Agenda", oModel.Codigo_Agenda),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Codigo_Pedido", oModel.Codigo_Pedido),
                new SqlParameter("@Descricao", oModel.Descricao),
                new SqlParameter("@DataHora", oModel.DataHora),
                new SqlParameter("@Valor", oModel.Valor)
            };

            return banco.ExecQueryReturnOne<AtendimentoModel>(P, "Atendimento_Incluir");
        }

        public AtendimentoModel Alterar(AtendimentoModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_Agenda", oModel.Codigo_Agenda),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Codigo_Pedido", oModel.Codigo_Pedido),
                new SqlParameter("@Descricao", oModel.Descricao),
                new SqlParameter("@DataHora", oModel.DataHora),
                new SqlParameter("@Valor", oModel.Valor)
            };

            return banco.ExecQueryReturnOne<AtendimentoModel>(P, "Atendimento_Alterar");
        }
    }
}