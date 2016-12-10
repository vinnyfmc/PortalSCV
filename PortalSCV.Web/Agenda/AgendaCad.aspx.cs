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

                if (Request.QueryString["Cod"] != null)
                {
                    int id;
                    if (int.TryParse(Request.QueryString["Cod"].ToString(), out id))
                    {
                        DetalharObj(id);
                    }
                    else
                    {
                        Response.Redirect("AgendaCad.aspx");
                    }

                }else { //NOVO

                    txData.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }
            }
        }

        private void DetalharObj(int Id)
        {

            AgendaModel oModel = new AgendaModel();
            List<AgendaModel> oListModel = new List<AgendaModel>();
            AgendaNegocios oNegocios = new AgendaNegocios();

            oModel.Codigo = Id;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                oModel = oListModel[0];

                Agenda_Id.Value = oModel.Codigo.ToString();

                cmbAnimal.SelectedValue = oModel.Codigo_Animal.Value.ToString();
                cmbFuncionario.SelectedValue = oModel.Codigo_Funcionario.ToString();
                txData.Text = ((DateTime)oModel.DataHoraEntrada).ToString("yyyy-MM-dd");
                txHoraIni.Text = ((DateTime)oModel.DataHoraEntrada).ToString("HH:mm");
                txHoraFim.Text = ((DateTime)oModel.DataHoraSaida).ToString("HH:mm");
                txValor.Text = ((Decimal)oModel.Valor).ToString("n2");
                cbStatus.SelectedValue = ((bool)oModel.Ativo).ToString();
                txAtendimento.Text = oModel.TipoAtendimento;
                txDescricao.Text = oModel.DescricaoServico;
                
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

        private void CarregaComboAnimal()
        {
            try
            {
                AnimalNegocios oNegocios = new AnimalNegocios();
                List<AnimalModel> oListModel = new List<AnimalModel>();
                List<AnimalModel> oListModel_AUX = new List<AnimalModel>();
                
                oListModel = oNegocios.Listar(new AnimalModel() { Ativo = true });

                foreach (AnimalModel model in oListModel)
                {
                    model.Nome = model.Nome_Cliente + " - " + model.Nome;

                    oListModel_AUX.Add(model);
                }

                oListModel_AUX.Insert(0, new AnimalModel() { Codigo = null, Nome = "Selecione" });
                cmbAnimal.DataSource = oListModel_AUX;
                cmbAnimal.DataTextField = "Nome";
                cmbAnimal.DataValueField = "Codigo";
                cmbAnimal.DataBind();

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
                    AgendaModel oModel = new AgendaModel();
                    AgendaNegocios oNegocios = new AgendaNegocios();

                    if (!string.IsNullOrEmpty(Agenda_Id.Value))
                        oModel.Codigo = UTIL.UTIL.Parse<int>(Agenda_Id.Value);
                    
                    oModel.Codigo_Animal = UTIL.UTIL.Parse<int>(cmbAnimal.SelectedValue);
                    oModel.Codigo_Funcionario = UTIL.UTIL.Parse<int>(cmbFuncionario.SelectedValue);
                    oModel.DataHoraEntrada = UTIL.UTIL.Parse<DateTime>(txData.Text + " " + txHoraIni.Text);
                    oModel.DataHoraSaida = UTIL.UTIL.Parse<DateTime>(txData.Text + " " + txHoraFim.Text);
                    oModel.Valor = UTIL.UTIL.Parse<Decimal>(txValor.Text);
                    oModel.Ativo = Boolean.Parse(cbStatus.SelectedValue);
                    oModel.TipoAtendimento = UTIL.UTIL.Parse<String>(txAtendimento.Text);
                    oModel.DescricaoServico = UTIL.UTIL.Parse<String>(txDescricao.Text);
                    
                    oModel = oNegocios.Salvar(oModel);

                    Agenda_Id.Value = oModel.Codigo.ToString();
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
            if(!DateTime.TryParse(txData.Text, out dt))
            {
                MSG_ERROR += "- Data Inválida<br />";
                DataValida = false;
            }

            if (!DateTime.TryParse(txData.Text + " " + txHoraIni.Text, out dt))
            {
                MSG_ERROR += "- Hora de início Inválida<br />";
                DataValida = false;
            }

            if (!DateTime.TryParse(txData.Text + " " + txHoraFim.Text, out dt))
            {
                MSG_ERROR += "- Hora fim Inválida<br />";
                DataValida = false;
            }

            if (DataValida)
            {
                DateTime ini = DateTime.Parse(txData.Text + " " + txHoraIni.Text);
                DateTime fim = DateTime.Parse(txData.Text + " " + txHoraFim.Text);
                TimeSpan ts = fim - ini;
                if (ts.TotalMinutes <= 0)
                {
                    MSG_ERROR += "- Hora de início não pode ser maior que a hora final<br />";
                }
            }

            if(string.IsNullOrEmpty( cmbAnimal.SelectedValue))
            {
                MSG_ERROR += "- Selecione o Animal<br />";
            }

            if (string.IsNullOrEmpty(cmbFuncionario.SelectedValue))
            {
                MSG_ERROR += "- Selecione o Funcionario<br />";
            }

            if (string.IsNullOrEmpty(txValor.Text))
            {
                MSG_ERROR += "- Digite o valor<br />";
            }else
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

            if (string.IsNullOrEmpty(txAtendimento.Text))
            {
                MSG_ERROR += "- Informe o atendimento<br />";
            }

            if (string.IsNullOrEmpty(txDescricao.Text))
            {
                MSG_ERROR += "- Descreva o serviço<br />";
            }

            if (DataValida)
            {
                List<AgendaModel> oListModel = new List<AgendaModel>();
                AgendaNegocios oNegocios = new AgendaNegocios();

                oListModel = oNegocios.Listar(new AgendaModel() { DataHoraEntrada = DateTime.Parse(txData.Text + " " + txHoraIni.Text), Codigo_Funcionario = UTIL.UTIL.Parse<int>(cmbFuncionario.SelectedValue) });
                if (oListModel.Count > 0)
                {
                    MSG_ERROR += "- Este horário já está ocupado para o Funcionário selecionado.<br />";
                }
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