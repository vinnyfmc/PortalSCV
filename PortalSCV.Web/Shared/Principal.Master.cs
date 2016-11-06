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
            if (info.Name != "Acesso.aspx")
            {
                if (Session["objFuncionario"] == null)
                    Response.Redirect("~/Login/Acesso.aspx");
            }

            if (!IsPostBack)
            {
                if ((info.Name != "Acesso.aspx") && (info.Name != "Modulos.aspx"))
                {
                    oFuncionario = (FuncionarioModel)Session["objFuncionario"];
                    txtEmailUsuario.Text = oFuncionario.Nome;

                    lnkMeuCadastro.NavigateUrl = "~/Funcionario/FuncionarioCad.aspx?Cod=" + oFuncionario.Codigo;

                    switch (oFuncionario.ModuloSelected)
                    {
                        case 1:
                            MenuVenda.Visible = true;
                            break;
                        case 2:
                            MenuAtendimento.Visible = true;
                            break;
                        case 3:
                            MenuAdm.Visible = true;
                            break;
                        default:
                            Response.Redirect("~/Shared/Modulos.aspx");
                            break;
                    }

                    
                }
            }
        }
    }
}