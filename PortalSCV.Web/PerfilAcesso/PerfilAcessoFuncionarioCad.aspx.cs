using Correios.Net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;

namespace PortalSCV.Layout.PerfilAcesso
{
    public partial class PerfilAcessoFuncionarioCad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Request.QueryString["Cod"] != null)
                    {
                        int id;
                        if (int.TryParse(Request.QueryString["Cod"].ToString(), out id))
                        {
                            CarregaComboPerfilAcesso();
                            CarregaComboFuncionarios();
                            DetalharObj(id);
                        }
                        else
                        {
                            Response.Redirect("PerfilAcessoCad.aspx");
                        }
                    }
                    else {
                        CarregaComboPerfilAcesso();
                        CarregaComboFuncionarios();
                    }//Novo
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
                }
            }
        }


        private void CarregaComboPerfilAcesso()
        {
            try
            {
                PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();
                List<PerfilAcessoModel> oListModel = new List<PerfilAcessoModel>();

                oListModel = oNegocios.ListarComboPerfilAcesso(new PerfilAcessoModel());
                oListModel.Insert(0, new PerfilAcessoModel() { Codigo = 0, Nome = "Selecione" });
                ddlPerfilAcesso.DataSource = oListModel;
                ddlPerfilAcesso.DataBind();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }


        private void CarregaComboFuncionarios()
        {
          try
            {
                FuncionarioNegocios oNegocios = new FuncionarioNegocios();
                List<FuncionarioModel> oListModel = new List<FuncionarioModel>();

                oListModel = oNegocios.ListarComboFuncionario(new FuncionarioModel());
                oListModel.Insert(0, new FuncionarioModel() { Codigo = 0, Nome = "Selecione" });
                ddlFuncionario.DataSource = oListModel;
                ddlFuncionario.DataBind();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }

        private void DetalharObj(int Id)
        {

            PerfilAcessoFuncionarioModel oModel = new PerfilAcessoFuncionarioModel();
            List<PerfilAcessoFuncionarioModel> oListModel = new List<PerfilAcessoFuncionarioModel>();
            PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();

            oModel.Codigo = Id;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                oModel = oListModel[0];

                PerfilAcesso_Id.Value = oModel.Codigo.ToString();

                ddlPerfilAcesso.SelectedValue = oModel.Codigo_PerfilAcesso.ToString();
                ddlFuncionario.SelectedValue = oModel.Codigo_Funcionario.ToString();
             }
        }


        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {

                if (ValidarCampos())
                {
                    PerfilAcessoFuncionarioModel oModel = new PerfilAcessoFuncionarioModel();
                    PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();

                    if (!string.IsNullOrEmpty(PerfilAcesso_Id.Value))
                        oModel.Codigo = UTIL.UTIL.Parse<int>(PerfilAcesso_Id.Value);
                    
                    if (!string.IsNullOrEmpty(ddlPerfilAcesso.SelectedValue))
                        oModel.Codigo_PerfilAcesso = Convert.ToInt32(ddlPerfilAcesso.SelectedValue);

                    if (!string.IsNullOrEmpty(ddlFuncionario.SelectedValue))
                        oModel.Codigo_Funcionario = Convert.ToInt32(ddlFuncionario.SelectedValue);

                    oModel = oNegocios.Salvar(oModel);

                    PerfilAcesso_Id.Value = oModel.Codigo.ToString();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "SUCESSbtnSalvar_Click", "$(document).MensagemModal(1,'Registro salvo com <strong>sucesso</strong>!');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }

        private bool ValidarCampos()
        {
            Boolean Valido = true;
            String MSG_ERROR = String.Empty;

            PerfilAcessoFuncionarioModel oModel = new PerfilAcessoFuncionarioModel();
            List<PerfilAcessoFuncionarioModel> oListModel = new List<PerfilAcessoFuncionarioModel>();
            PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();

            if (ddlPerfilAcesso.SelectedValue == "0")
            {
                MSG_ERROR += "- Perfil de Acesso. <br />";
            }

            if (ddlFuncionario.SelectedValue == "0")
            {
                MSG_ERROR += "- Funcionário. <br />";
            }

            if (MSG_ERROR.Length > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'<strong>Informações obrigatórias:</strong><br/>" + MSG_ERROR + "');", true);
                Valido = false;
            }

            return Valido;
        }
    }
}