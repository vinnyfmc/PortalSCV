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
                AlterarSenha(oModel);
                return oModel;
            }
        }
        
        public Boolean AlterarSenha(FuncionarioModel oModel)
        {
            
            List<FuncionarioModel> oList = new List<FuncionarioModel>();
            FuncionarioDAO oDAO = new FuncionarioDAO();

            oModel.Ativo = true;
            oList = oDAO.Listar(oModel);
            if (oList.Count > 0)
            {
                oModel = oList[0];
                if (!string.IsNullOrEmpty(oModel.Email)) 
                {

                    oModel = oDAO.AlterarSenha(oModel);

                    if (!string.IsNullOrEmpty(oModel.Senha))
                    {
                        EmailModel oEmail = new EmailModel();

                        String CorpoEmail = @"<html>
                                                <head>
                                                    <title></title> 
                                                </head> 
                                                <body style='font-size:14px;'>
                                                    <h1>PortalSCV</h1>
                                                    <p>Prezado(a),</p>
                                                    <p>Informamos que suas novas credenciais para acessar o site da PortalSCV são:</p>
                                                    <strong>E-mail: " + oModel.Email + @"</strong>
                                                    <strong>Senha: " + oModel.Senha + @"</strong>
                                                    <br />
                                                    <p>Att,</p>
                                                    <p>Equipe Desenvolvedora.</p>
                                                </body>
                                            </html>";

                        oEmail.EmailPara = oModel.Email;
                        oEmail.Assunto = "PortalSCV - Alteração de Senha";
                        oEmail.CorpoEmail = CorpoEmail;

                        UTIL.UTIL.EnviarEmail(oEmail.EmailPara, oEmail.Assunto, oEmail.CorpoEmail);
                        return true;
                    }
                }
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
