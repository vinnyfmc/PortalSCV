using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;
using System.Web.Script.Serialization;

namespace PortalSCV.Agenda
{
    public partial class AgendaCad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                CarregaComboAnimal();

                CarregaComboFuncionarios();

            }
        }

        private void CarregaComboFuncionarios()
        {
            try
            {
                PerfilAcessoFuncionarioNegocios oNegocios = new PerfilAcessoFuncionarioNegocios();
                List<PerfilAcessoFuncionarioModel> oListModel = new List<PerfilAcessoFuncionarioModel>();

                oListModel = oNegocios.Listar(new PerfilAcessoFuncionarioModel() { Codigo_PerfilAcesso = 3 });
                oListModel.Insert(0, new PerfilAcessoFuncionarioModel() { Codigo_Funcionario = 0, Funcionario_Nome = "Selecione" });
                cmbFuncionario.DataSource = oListModel;
                cmbFuncionario.DataTextField = "Funcionario_Nome";
                cmbFuncionario.DataValueField = "Codigo_Funcionario";
                cmbFuncionario.DataBind();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }

        private void CarregaComboAnimal()
        {
            try
            {
                AnimalNegocios oNegocios = new AnimalNegocios();
                List<AnimalModel> oListModel = new List<AnimalModel>();

                oListModel = oNegocios.Listar(new AnimalModel());
                oListModel.Insert(0, new AnimalModel() { Codigo = 0, Nome = "Selecione" });
                cmbFuncionario.DataSource = oListModel;
                cmbFuncionario.DataTextField = "Nome";
                cmbFuncionario.DataValueField = "Codigo";
                cmbFuncionario.DataBind();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {

        }
    }
}