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
    public class FuncionarioNegocios
    {
        public List<FuncionarioModel> Listar(FuncionarioModel oModel)
        {
            FuncionarioDAO oDAO = new FuncionarioDAO();
            return oDAO.Listar(oModel);
        }

        public List<FuncionarioModel> ListarComboFuncionario(FuncionarioModel oModel)
        {
            FuncionarioDAO oDAO = new FuncionarioDAO();
            return oDAO.ListarComboFuncionario(oModel);
        }

        public FuncionarioModel Salvar(FuncionarioModel oModel)
        {
            FuncionarioDAO oDAO = new FuncionarioDAO();

            if (oModel.Codigo.HasValue)
            {
                return oDAO.Alterar(oModel);
            }
            else
            {
                oModel = oDAO.Incluir(oModel);
                if (EnviarEmailNovaSenha(oModel))
                    return oModel;
                else
                    throw new Exception("Não foi possivel incluir o funcionário");
            }
        }

        public Boolean EnviarEmailNovaSenha(FuncionarioModel oModel)
        {
            if ((!string.IsNullOrEmpty(oModel.Email)) && (!string.IsNullOrEmpty(oModel.Senha)))
            {
                EmailModel oEmail = new EmailModel();

                String CorpoEmail = @"<html>
                                        <head>
                                            <title></title> 
                                        </head> 
                                        <body style='font-size:14px;'>
                                            <h1>Portal SCV</h1>
                                            <p>Prezado(a) Usuário(a),</p>
                                            <p>Suas novas credenciais para acessar o sistema da Portal SCV são:</p>
                                            E-mail: <strong>" + oModel.Email + @"</strong> <br /> 
                                            Senha: <strong>" + oModel.Senha + @"</strong>
                                            <br />
                                            <p>Att,</p>
                                            <p>Equipe Portal SCV.</p>
                                        </body>
                                    </html>";

                oEmail.EmailPara = oModel.Email;
                oEmail.Assunto = "Portal SCV - Nova Senha";
                oEmail.CorpoEmail = CorpoEmail;

                UTIL.UTIL.EnviarEmail(oEmail.EmailPara, oEmail.Assunto, oEmail.CorpoEmail);
                return true;
            }
            return false;
        }

        public Boolean AlterarSenha(FuncionarioModel oModel)
        {
            
            List<FuncionarioModel> oList = new List<FuncionarioModel>();
            FuncionarioDAO oDAO = new FuncionarioDAO();

            oModel = oDAO.AlterarSenha(oModel);
            
            if (oModel.Codigo.HasValue)
            {
               if(EnviarEmailNovaSenha(oModel))
                    return true;
                else
                    throw new Exception("Não foi alterar a senha do funcionário");
            }

            return false; 
        }

        public FuncionarioModel Validar(FuncionarioModel oModel)
        {
            List<FuncionarioModel> oList = new List<FuncionarioModel>();
            FuncionarioDAO oDAO = new FuncionarioDAO();
            oList = oDAO.Listar(oModel);
            
            if(oList.Count > 0)
            {
                if (oList[0].Senha == UTIL.UTIL.GerarHashMd5(oModel.Senha).ToUpper()) {
                    return oList[0];
                }
            }
            return new FuncionarioModel();
        }
    }
}
