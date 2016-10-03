using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Negocios;
using PortalSCV.Dominio;

namespace PortalSCV.Layout.PerfilAcesso
{
    public partial class PerfilAcessoFuncionarioList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();

                    List<PerfilAcessoFuncionarioModel> oList = new List<PerfilAcessoFuncionarioModel>();
                    oList = oNegocios.Listar(new PerfilAcessoFuncionarioModel());
                    if (oList.Count > 0)
                    {
                        Rpt.DataSource = oList;
                        Rpt.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EROOR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
                }

            }
        }
    }
}