using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using PortalSCV.Negocios;
using PortalSCV.Dominio;
using System.Web.Script.Serialization;

namespace PortalSCV.Agenda
{
    public partial class AgendaList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txData.Text = DateTime.Now.ToString("yyyy-MM-dd");
                
                //Carrega Funcionarios
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

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txData.Text))
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(2,'Selecione a data!');", true);
                }
                else {
                    AgendaNegocios oNegocios = new AgendaNegocios();
                    List<AgendaModel> oListModel = new List<AgendaModel>();
                    AgendaModel oModel = new AgendaModel();

                    oModel.DataHoraEntrada = UTIL.UTIL.Parse<DateTime>(txData.Text);
                    oModel.DataHoraSaida = UTIL.UTIL.Parse<DateTime>(txData.Text).AddDays(1);
                    oModel.Codigo_Funcionario = UTIL.UTIL.Parse<int?>(cmbFuncionario.SelectedValue);

                    oListModel = oNegocios.Listar(new AgendaModel() {  });
                    if(oListModel.Count > 0)
                    {
                        Rpt.DataSource = oListModel;
                        Rpt.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }
    }
}