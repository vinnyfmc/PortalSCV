using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.DAO;
using PortalSCV.Dominio;
using PortalSCV.UTIL;

namespace PortalSCV.Negocios
{
    public class AgendaNegocios
    {
        public List<AgendaModel> Listar(AgendaModel oModel)
        {
            AgendaDAO oDAO = new AgendaDAO();
            return oDAO.Listar(oModel);
        }

        public List<AgendaModel> ListarParaCombo(AgendaModel oModel)
        {
            AgendaDAO oDAO = new AgendaDAO();
            return oDAO.ListarParaCombo(oModel);
        }

        public List<AgendaModel> VerificarAgendamento(AgendaModel oModel)
        {
            AgendaDAO oDAO = new AgendaDAO();
            return oDAO.VerificarAgendamento(oModel);
        }

        public AgendaModel Excluir(AgendaModel oModel)
        {
            AgendaDAO oDAO = new AgendaDAO();
            return oDAO.Excluir(oModel);
        }

        public AgendaModel Salvar(AgendaModel oModel)
        {
            AgendaDAO oDAO = new AgendaDAO();

            if (oModel.Codigo.HasValue)
            {
                return oDAO.Alterar(oModel);
            }
            else
            {
                return oDAO.Incluir(oModel);
            }
        }

    }
}
