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
    public class ClienteNegocios
    {
        public List<ClienteModel> Listar(ClienteModel oModel)
        {
            ClienteDAO oDAO = new ClienteDAO();
            return oDAO.Listar(oModel);
        }

        public List<ClienteModel> ListarComboCliente(ClienteModel oModel)
        {
            ClienteDAO oDAO = new ClienteDAO();
            return oDAO.ListarComboCliente(oModel);
        }

        public ClienteModel Salvar(ClienteModel oModel)
        {
            ClienteDAO oDAO = new ClienteDAO();

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
