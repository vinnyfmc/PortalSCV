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
                    
                    CarregaComboPerfilAcesso();
                    CarregaComboFuncionarios();
           
                }
                catch (Exception ex)
                {
                    string msg = "Ocorreu um erro na inicialização da página!";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'" + msg + "');", true);
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
                string msg = "Ocorreu um erro preencher os perfis de acesso!";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'" + msg + "');", true);
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
                string msg = "Ocorreu um erro preencher os funcionários!";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'" + msg + "');", true);
            }
        }

        private void ListaPerfilAcesso(int IdFunc)
        {

            PerfilAcessoFuncionarioModel oModel = new PerfilAcessoFuncionarioModel();
            List<PerfilAcessoFuncionarioModel> oListModel = new List<PerfilAcessoFuncionarioModel>();
            PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();

            oModel.Codigo_Funcionario = IdFunc;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                Rpt.DataSource = oListModel;
                Rpt.DataBind();
            }else
            {
                Rpt.DataSource = new List<PerfilAcessoFuncionarioModel>();
                Rpt.DataBind();
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

                    
                    if (!string.IsNullOrEmpty(ddlPerfilAcesso.SelectedValue))
                        oModel.Codigo_PerfilAcesso = Convert.ToInt32(ddlPerfilAcesso.SelectedValue);

                    if (!string.IsNullOrEmpty(ddlFuncionario.SelectedValue))
                        oModel.Codigo_Funcionario = Convert.ToInt32(ddlFuncionario.SelectedValue);

                    oModel = oNegocios.Salvar(oModel);

                    ListaPerfilAcesso((int)oModel.Codigo_Funcionario);

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "SUCESSbtnSalvar_Click", "$(document).MensagemModal(1,'Registro salvo com <strong>sucesso</strong>!');", true);
                }
            }
            catch (Exception ex)
            {
                string msg = "Ocorreu um erro ao salvar o perfil do funcionário!";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'" + msg + "');", true);
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

            if ((ddlPerfilAcesso.SelectedValue != "0") && (ddlFuncionario.SelectedValue != "0"))
            {
                oModel.Codigo_Funcionario = UTIL.UTIL.Parse<int>(ddlFuncionario.SelectedValue);
                oModel.Codigo_PerfilAcesso = UTIL.UTIL.Parse<int>(ddlPerfilAcesso.SelectedValue);
                oListModel = oNegocios.Listar(oModel);
                if(oListModel.Count > 0 )
                {
                    MSG_ERROR += "- O Funcionário já possui este acesso! <br />";
                }
            }

            if (MSG_ERROR.Length > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'<strong>Informações obrigatórias:</strong><br/>" + MSG_ERROR + "');", true);
                Valido = false;
            }

            return Valido;
        }

        protected void Rpt_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                
                if (e.CommandName == "Remover")
                {
                    int? Codigo_PerfilAcessoFuncionario = UTIL.UTIL.Parse<int?>(((HiddenField)e.Item.FindControl("PerfilAcessoFuncionario_Id")).Value);
                    if(Codigo_PerfilAcessoFuncionario != null)
                    {
                        new PerfilAcessoFuncionarioNegocios().Excluir(new PerfilAcessoFuncionarioModel { Codigo = Codigo_PerfilAcessoFuncionario });
                        ListaPerfilAcesso(UTIL.UTIL.Parse<int>(ddlFuncionario.SelectedValue));
                    }
                }

            }
            catch (Exception ex)
            {
                string msg = "Ocorreu um erro ao remover o perfil do funcionário!";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'" + msg + "');", true);
            }
        }

        protected void ddlFuncionario_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Rpt.DataSource = null;
                int cdFunc = 0;
                if (int.TryParse(ddlFuncionario.SelectedValue, out cdFunc))
                {
                    if(cdFunc != 0)
                    {
                        ListaPerfilAcesso(cdFunc);
                    }

                }

                Rpt.DataBind();
            }
            catch (Exception ex)
            {
                string msg = "Ocorreu um erro ao Listar os perfis do funcionário!";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'" + msg + "');", true);
            }
        }
    }
}