using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using PortalSCV.Negocios;
using PortalSCV.Dominio;
using System.Web.Script.Serialization;

namespace PortalSCV.Atendimento
{
    public partial class AtendimentoList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    AtendimentoNegocios oNegocios = new AtendimentoNegocios();

                    List<AtendimentoModel> oList = new List<AtendimentoModel>();
                    oList = oNegocios.Listar(new AtendimentoModel());
                    if (oList.Count > 0)
                    {
                        btnNovo.Visible = false;
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