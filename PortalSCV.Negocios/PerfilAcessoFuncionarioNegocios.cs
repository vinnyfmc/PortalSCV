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
    public class PerfilAcessoFuncionarioNegocios
    {
        public List<PerfilAcessoFuncionarioModel> Listar(PerfilAcessoFuncionarioModel oModel)
        {
            PerfilAcessoFuncionarioDAO oDAO = new PerfilAcessoFuncionarioDAO();
            return oDAO.Listar(oModel);
        }

        public List<PerfilAcessoModel> ListarComboPerfilAcesso(PerfilAcessoModel oModel)
        {
            PerfilAcessoDAO oDAO = new PerfilAcessoDAO();
            return oDAO.ListarComboPerfilAcesso(oModel);
        }

        public PerfilAcessoFuncionarioModel Salvar(PerfilAcessoFuncionarioModel oModel)
        {
            PerfilAcessoFuncionarioDAO oDAO = new PerfilAcessoFuncionarioDAO();

            if (oModel.Codigo.HasValue)
            {
                return oDAO.Alterar(oModel);
            }
            else
            {
                oModel = oDAO.Incluir(oModel);
                //if (!oModel.Codigo.HasValue)
                return oModel;
                //else
                //    throw new Exception("Não foi possivel incluir o Perfil do funcionário");
            }
        }

        public PerfilAcessoFuncionarioModel ValidaPerfilAcessoFuncionario(FuncionarioModel oModel)
        {
            PerfilAcessoFuncionarioModel oPerfilAcessoFuncionarioModel = new PerfilAcessoFuncionarioModel();
            PerfilAcessoFuncionarioDAO oDAO = new PerfilAcessoFuncionarioDAO();

            oPerfilAcessoFuncionarioModel = oDAO.RetornaPerfilAcessoFuncionario(oModel);

            return oPerfilAcessoFuncionarioModel;
        }
    }
}
