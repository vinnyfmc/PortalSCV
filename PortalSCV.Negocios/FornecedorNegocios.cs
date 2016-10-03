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
    public class FornecedorNegocios
    {

        public List<FornecedorModel> Listar(FornecedorModel oModel)
        {
            FornecedorDAO oDAO = new FornecedorDAO();
            return oDAO.Listar(oModel);
        }

        public FornecedorModel Salvar(FornecedorModel oModel)
        {
            FornecedorDAO oDAO = new FornecedorDAO();

            if (oModel.Codigo.HasValue)
            {
                return oDAO.Alterar(oModel);
            }
            else
            {
                return oModel = oDAO.Incluir(oModel);
            }
        }

    }
}
