using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Negocios;
using PortalSCV.Dominio;
using System.Web.Script.Serialization;

namespace PortalSCV.Fornecedor
{
    public partial class FornecedorList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    FornecedorNegocios oNegocios = new FornecedorNegocios();

                    List<FornecedorModel> oList = new List<FornecedorModel>();
                    oList = oNegocios.Listar(new FornecedorModel());
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