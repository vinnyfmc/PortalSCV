using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;

namespace PortalSCV.Shared
{
    public partial class Principal : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FuncionarioModel oFuncionario = new FuncionarioModel();

            string path = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
            System.IO.FileInfo info = new System.IO.FileInfo(path);
            if (info.Name != "Index.aspx")
            {
                if (Session["objFuncionario"] == null)
                    Response.Redirect("~/Login/Index.aspx");
            }

            if (!IsPostBack)
            {
                if (info.Name != "Index.aspx")
                {
                    oFuncionario = (FuncionarioModel)Session["objFuncionario"];
                    txtEmailUsuario.Text = oFuncionario.Nome;

                    lnkMeuCadastro.NavigateUrl = "~/Funcionario/FuncionarioCad.aspx?Cod=" + oFuncionario.Codigo;
                }
            }
        }
    }
}