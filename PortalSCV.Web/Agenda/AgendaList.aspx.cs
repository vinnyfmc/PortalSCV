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
                FuncionarioNegocios oNegocios = new FuncionarioNegocios();
                List<FuncionarioModel> oListModel = new List<FuncionarioModel>();

                oListModel = oNegocios.Listar(new FuncionarioModel() { Cargo = 3 });
                oListModel.Insert(0, new FuncionarioModel() { Codigo = null, Nome = "Selecione", Cargo = 3 });

                var obj = oListModel.Where(p => p.Cargo == 3);

                cmbFuncionario.DataSource = obj;
                cmbFuncionario.DataTextField = "Nome";
                cmbFuncionario.DataValueField = "Codigo";
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
                    oModel.DataHoraSaida = ((DateTime)oModel.DataHoraEntrada).AddDays(1);
                    oModel.Codigo_Funcionario = UTIL.UTIL.Parse<int?>(cmbFuncionario.SelectedValue);
                    oModel.Ativo = true;

                    oListModel = oNegocios.Listar(oModel);
                    if(oListModel.Count > 0)
                    {
                        Rpt.DataSource = oListModel;
                        Rpt.DataBind();
                    }else
                    {
                        Rpt.DataSource = new List<AgendaModel>();
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