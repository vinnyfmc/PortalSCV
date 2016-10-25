using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Negocios;
using PortalSCV.Dominio;

namespace PortalSCV.Layout.Animal
{
    public partial class AnimalList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    AnimalNegocios oNegocios = new AnimalNegocios();

                    List<AnimalModel> oList = new List<AnimalModel>();
                    oList = oNegocios.Listar(new AnimalModel());
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