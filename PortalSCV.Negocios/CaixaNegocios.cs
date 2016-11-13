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
    public class CaixaNegocios
    {
        public List<CaixaModel> Listar(CaixaModel oModel)
        {
            CaixaDAO oDAO = new CaixaDAO();
            return oDAO.Listar(oModel);
        }
    }
}
