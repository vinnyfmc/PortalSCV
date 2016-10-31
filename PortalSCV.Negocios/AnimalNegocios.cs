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
    public class AnimalNegocios
    {
        public List<AnimalModel> Listar(AnimalModel oModel)
        {
            AnimalDAO oDAO = new AnimalDAO();
            return oDAO.Listar(oModel);
        }


        public AnimalModel Salvar(AnimalModel oModel)
        {
            AnimalDAO oDAO = new AnimalDAO();

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
