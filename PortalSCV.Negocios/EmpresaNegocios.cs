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
    public class EmpresaNegocios
    {

        public List<EmpresaModel> Listar(EmpresaModel oModel)
        {
            EmpresaDAO oDAO = new EmpresaDAO();
            return oDAO.Listar(oModel);
        }

        public EmpresaModel Salvar(EmpresaModel oModel)
        {
            EmpresaDAO oDAO = new EmpresaDAO();

            if (oModel.Codigo.HasValue)
            {
                return oDAO.Alterar(oModel);
            }
            else
            {
                //return oModel = oDAO.Incluir(oModel);
                return null;
            }

        }

    }
}
