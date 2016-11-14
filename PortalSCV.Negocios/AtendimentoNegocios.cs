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
    public class AtendimentoNegocios
    {
        public List<AtendimentoModel> Listar(AtendimentoModel oModel)
        {
            AtendimentoDAO oDAO = new AtendimentoDAO();
            return oDAO.Listar(oModel);
        }

        public AtendimentoModel Salvar(AtendimentoModel oModel)
        {
            AtendimentoDAO oDAO = new AtendimentoDAO();

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