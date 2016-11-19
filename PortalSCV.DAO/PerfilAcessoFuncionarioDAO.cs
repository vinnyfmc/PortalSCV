using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class PerfilAcessoFuncionarioDAO
    {
        public List<PerfilAcessoFuncionarioModel> Listar(PerfilAcessoFuncionarioModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_PerfilAcesso", oModel.Codigo_PerfilAcesso),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario)
            };
    
            return banco.ExecQuery<PerfilAcessoFuncionarioModel>(P, "PerfilAcessoFuncionario_Listar");
        }
        
        public PerfilAcessoFuncionarioModel Incluir(PerfilAcessoFuncionarioModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo_PerfilAcesso", oModel.Codigo_PerfilAcesso),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario)
            };
            
            return banco.ExecQueryReturnOne<PerfilAcessoFuncionarioModel>(P, "PerfilAcessoFuncionario_Incluir");
        }

        public PerfilAcessoFuncionarioModel Alterar(PerfilAcessoFuncionarioModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_PerfilAcesso", oModel.Codigo_PerfilAcesso),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario)
            };

            return banco.ExecQueryReturnOne<PerfilAcessoFuncionarioModel>(P, "PerfilAcessoFuncionario_Alterar");
        }

        public PerfilAcessoFuncionarioModel RetornaPerfilAcessoFuncionario(FuncionarioModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo)
            };

            return banco.ExecQueryReturnOne<PerfilAcessoFuncionarioModel>(P, "PerfilAcessoFuncionario_PerfilAcessoFuncionario");
        }

        public void Excluir(PerfilAcessoFuncionarioModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo)
            };

            banco.ExecQueryReturnOne<PerfilAcessoFuncionarioModel>(P, "PerfilAcessoFuncionario_Excluir");
        }

    }
}
