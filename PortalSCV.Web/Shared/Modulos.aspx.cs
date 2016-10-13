using PortalSCV.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PortalSCV.Shared
{
    public partial class Modulos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FuncionarioModel oFuncionario = new FuncionarioModel();

            if (!IsPostBack)
            {
                HtmlGenericControl Master_Body = (HtmlGenericControl)Master.FindControl("Master_Body");
                Master_Body.Style.Add("Display", "none");

                oFuncionario = (FuncionarioModel)Session["objFuncionario"];


            }
        }
    }
}