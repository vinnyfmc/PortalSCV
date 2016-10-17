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
    public class PedidoNegocios
    {
        public List<PedidoModel> Listar(PedidoModel oModel)
        {
            PedidoDAO oDAO = new PedidoDAO();
            return oDAO.Listar(oModel);
        }
        
        public PedidoModel Salvar(PedidoModel oModel)
        {
            PedidoDAO oDAO = new PedidoDAO();

            if (oModel.Codigo.HasValue)
            {
                return oDAO.Alterar(oModel);
            }
            else
            {
                return oDAO.Incluir(oModel);
            }
        }

        public PedidoModel AlterarStatus(PedidoModel oModel)
        {
            PedidoDAO oDAO = new PedidoDAO();
            return oDAO.AlterarStatus(oModel);
        }

        public PedidoModel PedidoComplementar(PedidoModel oModel)
        {
            PedidoDAO oDAO = new PedidoDAO();
            return oDAO.AlterarStatus(oModel);
        }

    }
}
