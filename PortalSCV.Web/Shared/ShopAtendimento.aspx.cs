using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PortalSCV.Shared
{
    public partial class ShopAtendimento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HtmlGenericControl Master_Body = (HtmlGenericControl)Master.FindControl("Master_Body");
                Master_Body.Style.Add("Display", "none");
            }
        }
    }
}