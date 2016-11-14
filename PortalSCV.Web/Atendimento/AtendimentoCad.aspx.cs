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
                CarregaComboFuncionarios();
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

                    oModel.Codigo_Agenda = UTIL.UTIL.Parse<int>(ddlAgenda.SelectedValue);
                    oModel.Codigo_Funcionario = UTIL.UTIL.Parse<int>(ddlFuncionario.SelectedValue);
                    oModel.Codigo_Pedido = UTIL.UTIL.Parse<int>(ddlPedido.SelectedValue);
                    oModel.Descricao = UTIL.UTIL.Parse<String>(txtDescricao.Text);
                    oModel.DataHora = UTIL.UTIL.Parse<DateTime>(txDataHora.Text);
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


            if (!DateTime.TryParse(txDataHora.Text, out dt))
            {
                MSG_ERROR += "- Data Inválida<br />";
                DataValida = false;
            }


            if (string.IsNullOrEmpty(ddlAgenda.SelectedValue))
            {
                MSG_ERROR += "- Selecione uma Agenda<br />";
            }

            if (string.IsNullOrEmpty(ddlFuncionario.SelectedValue))
            {
                MSG_ERROR += "- Selecione um Funcionario<br />";
            }

            if (string.IsNullOrEmpty(ddlPedido.SelectedValue))
            {
                MSG_ERROR += "- Selecione um Pedido<br />";
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

    }
}