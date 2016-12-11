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

namespace PortalSCV.Atendimento
{
    public partial class AtendimentoCad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                

                if (Request.QueryString["Cod"] != null)
                {
                    int id;
                    if (int.TryParse(Request.QueryString["Cod"].ToString(), out id))
                    {
                        DetalharObj(id);
                    }
                    else
                    {
                        Response.Redirect("AtendimentoCad.aspx");
                    }

                }
                else
                { //NOVO

                    CarregaAgendamentos();

                    btnCalcelar.Visible = false;

                    FuncionarioModel oFuncionario = (FuncionarioModel)Session["objFuncionario"];
                    CodigoFunc.Value = oFuncionario.Codigo.ToString();

                    txData.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txHora.Text = DateTime.Now.ToString("HH:mm");
                }

            }
        }

        private void DetalharObj(int Id)
        {

            AtendimentoModel oModel = new AtendimentoModel();
            List<AtendimentoModel> oListModel = new List<AtendimentoModel>();
            AtendimentoNegocios oNegocios = new AtendimentoNegocios();

            oModel.Codigo = Id;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                oModel = oListModel[0];

                Atendimento_Id.Value = oModel.Codigo.ToString();

                ddlAgenda.SelectedValue = oModel.Codigo_Agenda.Value.ToString();
                CodigoFunc.Value = oModel.Codigo_Funcionario.ToString();
                
                txData.Text = ((DateTime)oModel.DataHora).ToString("yyyy-MM-dd");
                txHora.Text = ((DateTime)oModel.DataHora).ToString("HH:mm");
                txValor.Text = ((Decimal)oModel.Valor).ToString("c2");
                txValor.Focus();
                txtDescricao.Text = oModel.Descricao;


                AgendaModel oParam = new AgendaModel();
                AgendaNegocios oNegocios_Agenda = new AgendaNegocios();
                List<AgendaModel> oListModel_Agenda = new List<AgendaModel>();
                oParam.Codigo = oModel.Codigo_Agenda;
                oListModel_Agenda = oNegocios_Agenda.Listar(oParam);
                ddlAgenda = UTIL.UTIL.PreencheSelect(oListModel_Agenda, ddlAgenda, "Nome_Agendamento", "Codigo", "Selecione");
                ddlAgenda.Enabled = false;


            }

        }

        private void CarregaAgendamentos()
        {
            try
            {
                AgendaModel oParam = new AgendaModel();
                AgendaNegocios oNegocios = new AgendaNegocios();
                List<AgendaModel> oListModel = new List<AgendaModel>();
                
                oListModel = oNegocios.ListarParaCombo(oParam);
                ddlAgenda = UTIL.UTIL.PreencheSelect(oListModel, ddlAgenda, "Nome_Agendamento", "Codigo", "Selecione");
               

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidarCampos())
                {
                    AtendimentoModel oModel = new AtendimentoModel();
                    AtendimentoNegocios oNegocios = new AtendimentoNegocios();

                    if (!string.IsNullOrEmpty(Atendimento_Id.Value))
                        oModel.Codigo = UTIL.UTIL.Parse<int>(Atendimento_Id.Value);

                    int? codAgenda = UTIL.UTIL.Parse<int?>(ddlAgenda.SelectedValue);
                    if ((codAgenda != null) && (codAgenda > 0))
                        oModel.Codigo_Agenda = UTIL.UTIL.Parse<int>(ddlAgenda.SelectedValue);

                    oModel.Codigo_Funcionario = UTIL.UTIL.Parse<int>(CodigoFunc.Value);
                    oModel.Descricao = UTIL.UTIL.Parse<String>(txtDescricao.Text);
                    oModel.DataHora = UTIL.UTIL.Parse<DateTime>(txData.Text + " " + txHora.Text);
                    oModel.Valor = UTIL.UTIL.Parse<Decimal>(txValor.Text);

                    oModel = oNegocios.Salvar(oModel);

                    Atendimento_Id.Value = oModel.Codigo.ToString();
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
            Boolean DataValida = true;
            String MSG_ERROR = String.Empty;

            DateTime dt;

            int? codAgenda = UTIL.UTIL.Parse<int?>(ddlAgenda.SelectedValue);
            if ((codAgenda == null) || (codAgenda <= 0))
            {
                MSG_ERROR += "- Selecione um agendamento, caso não exista, crie um agendamento primeiro!<br />";
                DataValida = false;
            }

            if (!DateTime.TryParse(txData.Text, out dt))
            {
                MSG_ERROR += "- Data Inválida<br />";
                DataValida = false;
            }
            
            if (string.IsNullOrEmpty(txtDescricao.Text))
            {
                MSG_ERROR += "- Descreva o serviço<br />";
            }

            if (string.IsNullOrEmpty(txValor.Text))
            {
                MSG_ERROR += "- Digite o valor<br />";
            }
            else
            {
                Decimal D;
                if (Decimal.TryParse(txValor.Text, out D))
                {
                    if (D <= 0)
                    {
                        MSG_ERROR += "- Valor não pode ser zero ou negativo<br />";
                    }
                }
            }

            if (MSG_ERROR.Length > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'<strong>Informações obrigatórias:</strong><br/>" + MSG_ERROR + "');", true);
                Valido = false;
            }

            return Valido;
        }

        protected void ddlAgenda_SelectedIndexChanged(object sender, EventArgs e)
        {
            int? codAgenda = UTIL.UTIL.Parse<int?>(ddlAgenda.SelectedValue);

            if ((codAgenda != null) && (codAgenda > 0))
            {
                Codigo_Agenda.Value = codAgenda.ToString();

                String[] info = ddlAgenda.SelectedItem.Text.Split('|');
                txData.Text = UTIL.UTIL.Parse<DateTime>(info[0].Trim()).ToString("yyyy-MM-dd");
                txHora.Text = UTIL.UTIL.Parse<DateTime>(info[0].Trim()).ToString("HH:mm");
                txValor.Text = info[2].Trim();
                txValor.Focus();
            }
            else {
                Codigo_Agenda.Value = "";
                txData.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txHora.Text = DateTime.Now.ToString("HH:mm");
                txValor.Text = "";
            }

        }

        protected void btnCalcelar_Click(object sender, EventArgs e)
        {
            try
            {

                AtendimentoModel oModel = new AtendimentoModel();
                AtendimentoNegocios oNegocios = new AtendimentoNegocios();

                if (!string.IsNullOrEmpty(Atendimento_Id.Value))
                {
                    oModel.Codigo = UTIL.UTIL.Parse<int>(Atendimento_Id.Value);

                    oModel = oNegocios.Excluir(oModel);
                    Response.Redirect("AtendimentoList.aspx");
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }
    }
}