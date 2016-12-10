using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;
using System.Web.Script.Serialization;

namespace PortalSCV
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HtmlGenericControl Master_Body = (HtmlGenericControl)Master.FindControl("Master_Body");
                Master_Body.Style.Add("Display", "none");

                Session.Abandon();
            }
        }

        protected void btLogar_Click(object sender, EventArgs e)
        {
            try
            {
                txAviso.Visible = false;
                txAviso.InnerHtml = "";

                if ((string.IsNullOrEmpty(txUser.Text.Trim())) || (string.IsNullOrEmpty(txPass.Text.Trim())))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'<strong> Informações obrigatórias:</strong><br/> -E-mail <br/> -Senha');", true);
                }
                else
                {
                    FuncionarioNegocios oNegocios = new FuncionarioNegocios();
                    FuncionarioModel oModel = new FuncionarioModel();
                    oModel.Email = txUser.Text.Trim();
                    oModel.Senha = txPass.Text.Trim();

                    oModel = oNegocios.Validar(oModel);

                    if (oModel.Codigo.HasValue)
                    {
                        if (oModel.Ativo == true)
                        {

                            Session.Add("objFuncionario", oModel);
                            Response.Redirect("~/Shared/Modulos.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                            //Response.Redirect("~/Shared/ShopAtendimento.aspx");
                        }
                        else
                        {
                            txAviso.Visible = true;
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Inativo", "$(document).MensagemModal(3,'<strong>Funcionário inativo no sistema.</ strong >');", true);
                        }
                    }
                    else
                    {
                        txAviso.Visible = true;
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "UserInvalid", "$(document).MensagemModal(3,'<strong>E-mail e/ou Senha Inválido(s).</ strong >');", true);
                    }

                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EROOR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }

        protected void btEsqueceuSenha_Click(object sender, EventArgs e)
        {
            try
            {

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "FechaModal", "$('#ModalReenviarSenha').modal('hide');", true);

                FuncionarioNegocios oNegocios = new FuncionarioNegocios();
                List<FuncionarioModel> oList = new List<FuncionarioModel>();
                FuncionarioModel oModel = new FuncionarioModel();
                oModel.Email = txUser.Text.Trim();

                if (oNegocios.AlterarSenha(oModel))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "SenhaAlterada", "$(document).MensagemModal(1,'Uma nova senha foi enviada para seu e-mail.');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "EmailNaoExiste", "$(document).MensagemModal(3,'E-mail não cadastrado!');", true);
                }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EROOR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " +  new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }

    }
}