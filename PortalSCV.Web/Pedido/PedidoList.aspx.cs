using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Negocios;
using PortalSCV.Dominio;
using System.Web.Script.Serialization;

namespace PortalSCV.Pedido
{
    public partial class PedidoList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    PedidoNegocios oNegocios = new PedidoNegocios();

                    List<PedidoModel> oList = new List<PedidoModel>();
                    oList = oNegocios.Listar(new PedidoModel());
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