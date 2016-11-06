using PortalSCV.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using PortalSCV.Negocios;

namespace PortalSCV.Shared
{
    public partial class Modulos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HtmlGenericControl Master_Body = (HtmlGenericControl)Master.FindControl("Master_Body");
                Master_Body.Style.Add("Display", "none");

                ValidaPerfilAcessoFuncionario();
            }
        }


        private void ValidaPerfilAcessoFuncionario()
        {
            DisableLinkButton(Venda);
            DisableLinkButton(Atendimento);
            DisableLinkButton(Administrativo);
            
            FuncionarioModel oFuncionario = new FuncionarioModel();
            List<PerfilAcessoFuncionarioModel> oPerfilAcessoFuncionarioList = new List<PerfilAcessoFuncionarioModel>();
            PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();

            oFuncionario = (FuncionarioModel)Session["objFuncionario"];

            oPerfilAcessoFuncionarioList = oNegocios.Listar(new PerfilAcessoFuncionarioModel { Codigo_Funcionario = oFuncionario.Codigo });

            if(oPerfilAcessoFuncionarioList.Count > 0)
            { 
                foreach (PerfilAcessoFuncionarioModel Perfil in oPerfilAcessoFuncionarioList)
                {
                    ValidaAcesso((int)Perfil.Codigo_PerfilAcesso);
                }
            }else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "NoAccess", "$(document).MensagemModal(3,'Nenhum perfil de acesso foi encontrado, entre em contato com o Gerente ou o Administrador do sistema.');", true);
            }
        }

        private void ValidaAcesso(int Perfil)
        {
            switch (Perfil)
            {
                case 1: //VENDA
                    EnableLinkButton(Venda);
                    break;
                case 2: //ATENDIMENTO
                    EnableLinkButton(Atendimento);
                    break;
                case 3://ADMINISTRATIVO
                    EnableLinkButton(Administrativo);
                    break;
                case 4://MASTER
                    EnableLinkButton(Venda);
                    EnableLinkButton(Atendimento);
                    EnableLinkButton(Administrativo);
                    break;
            }
        }

        protected void Venda_Click(object sender, EventArgs e)
        {
            FuncionarioModel oFuncionario = (FuncionarioModel)Session["objFuncionario"];
            oFuncionario.ModuloSelected = 1;
            Session["objFuncionario"] = oFuncionario;
            Response.Redirect("~/Pedido/PedidoCad.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void Atendimento_Click(object sender, EventArgs e)
        {
            FuncionarioModel oFuncionario = (FuncionarioModel)Session["objFuncionario"];
            oFuncionario.ModuloSelected = 2;
            Session["objFuncionario"] = oFuncionario;
            Response.Redirect("~/Agenda/AgendaList.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void Administrativo_Click(object sender, EventArgs e)
        {
            FuncionarioModel oFuncionario = (FuncionarioModel)Session["objFuncionario"];
            oFuncionario.ModuloSelected = 3;
            Session["objFuncionario"] = oFuncionario;
            Response.Redirect("~/Funcionario/FuncionarioList.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        public static void DisableLinkButton(LinkButton linkButton)
        {
            linkButton.Attributes.CssStyle[HtmlTextWriterStyle.Cursor] = "not-allowed";
            if (linkButton.Enabled != false)
            {
                linkButton.Enabled = false;
            }

            if (linkButton.OnClientClick != null)
            {
                linkButton.OnClientClick = null;
            }
        }

        public static void EnableLinkButton(LinkButton linkButton)
        {
            linkButton.Attributes.CssStyle[HtmlTextWriterStyle.Cursor] = "pointer";
            if (linkButton.Enabled != true)
            {
                linkButton.Enabled = true;
            }

            if (linkButton.OnClientClick == null)
            {
                switch (linkButton.ID)
                {
                    case "Venda":
                        linkButton.OnClientClick = "Venda_Click";
                        break;
                    case "Atendimento":
                        linkButton.OnClientClick = "Atendimento_Click";
                        break;
                    case "Administrativo":
                        linkButton.OnClientClick = "Administrativo_Click";
                        break;
                }
                
            }
        }

    }
}