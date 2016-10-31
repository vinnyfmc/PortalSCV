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

                //ValidaPerfilAcessoFuncionario();
            }
        }


        private void ValidaPerfilAcessoFuncionario()
        {
            FuncionarioModel oFuncionario = new FuncionarioModel();
            PerfilAcessoFuncionarioModel oPerfilAcessoFuncionarioModel = new PerfilAcessoFuncionarioModel();
            PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();

            oFuncionario = (FuncionarioModel)Session["objFuncionario"];

            oPerfilAcessoFuncionarioModel = oNegocios.ValidaPerfilAcessoFuncionario(oFuncionario);

            switch (oPerfilAcessoFuncionarioModel.Codigo_PerfilAcesso)
            {
                case 1:
                    ValidaAcesso("Venda");
                    break;
                case 2:
                    ValidaAcesso("Atendimento");
                    break;
                case 3:
                    ValidaAcesso("Administrativo");
                    break;
                default:
                    break;
            }
        }

        private void ValidaAcesso(String oClicado)
        {
            switch (oClicado)
            {
                case "Venda":
                    Atendimento.Disabled = true;
                    Administrativo.Disabled = true;
                    divmensagem.Visible = true;
                    break;
                case "Atendimento":
                    Venda.Disabled = true;
                    Administrativo.Disabled = true;
                    divmensagem.Visible = true;
                    break;
                case "Administrativo":
                    Venda.Disabled = false;
                    Atendimento.Disabled = false;
                    divmensagem.Visible = true;
                    break;
            }
        }
    }
}