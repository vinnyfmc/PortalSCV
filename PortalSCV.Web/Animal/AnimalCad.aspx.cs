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

namespace PortalSCV.Layout.Animal
{
    public partial class AnimalCad : System.Web.UI.Page
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
                            CarregaComboClientes();
                            DetalharObj(id);
                        }
                        else
                        {
                            Response.Redirect("AnimalCad.aspx");
                        }

                    }
                    else {
                        CarregaComboClientes();

                        FuncionarioModel oFuncionario = (FuncionarioModel)Session["objFuncionario"];
                        CodigoFunc.Value = oFuncionario.Codigo.ToString();
                    }//Novo
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
                }
            }
        }

        private void DetalharObj(int Id)
        {

            AnimalModel oModel = new AnimalModel();
            List<AnimalModel> oListModel = new List<AnimalModel>();
            AnimalNegocios oNegocios = new AnimalNegocios();

            oModel.Codigo = Id;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                oModel = oListModel[0];

                Animal_Id.Value = oModel.Codigo.ToString();

                ddlCliente.SelectedValue = oModel.Codigo_Cliente.ToString();
            
                txtNome.Text = oModel.Nome;
                txtRaca.Text = oModel.Raca;
                txtCor.Text = oModel.Cor;
                txtIdade.Text = oModel.Idade.ToString();
                txtPeso.Text = oModel.Peso.ToString();
                ddlSexo.SelectedValue = oModel.Sexo.ToString();
                txtObs.Text = oModel.DescricaoDoencas;

                CodigoFunc.Value = oModel.Codigo_Funcionario.Value.ToString();
                
                if (oModel.DataNascimento != null)
                    txtDataNascimento.Text = ((DateTime)oModel.DataNascimento).ToString("dd/MM/yyyy");
                
                cbStatus.SelectedValue = ((bool)oModel.Ativo).ToString();
            }

        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {

                if (ValidarCampos())
                {
                    AnimalModel oModel = new AnimalModel();
                    AnimalNegocios oNegocios = new AnimalNegocios();

                    if (!string.IsNullOrEmpty(Animal_Id.Value))
                        oModel.Codigo = UTIL.UTIL.Parse<int>(Animal_Id.Value);
                    else
                        oModel.DataCadastro = DateTime.Now;

                    if (!string.IsNullOrEmpty(ddlCliente.SelectedValue))
                        oModel.Codigo_Cliente = Convert.ToInt32(ddlCliente.SelectedValue);
                    
                    oModel.Codigo_Funcionario = Convert.ToInt32(CodigoFunc.Value);

                    oModel.Nome = UTIL.UTIL.Parse<string>(txtNome.Text);
                    oModel.Raca = UTIL.UTIL.Parse<string>(txtRaca.Text);
                    oModel.Cor = UTIL.UTIL.Parse<string>(txtCor.Text);
                   
                    if(!string.IsNullOrEmpty(txtPeso.Text))
                        oModel.Peso = UTIL.UTIL.Parse<decimal>(txtPeso.Text);

                    oModel.Sexo = UTIL.UTIL.Parse<string>(ddlSexo.SelectedValue);
                    oModel.DescricaoDoencas = UTIL.UTIL.Parse<string>(txtObs.Text);
                    oModel.DataNascimento = UTIL.UTIL.Parse<DateTime>(txtDataNascimento.Text);
                    oModel.Ativo = Boolean.Parse(cbStatus.SelectedValue);

                    oModel = oNegocios.Salvar(oModel);

                    Animal_Id.Value = oModel.Codigo.ToString();
                    txtIdade.Text = oModel.Idade.ToString();
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

            AnimalModel oModel = new AnimalModel();
            List<AnimalModel> oListModel = new List<AnimalModel>();
            AnimalNegocios oNegocios = new AnimalNegocios();

            if (ddlCliente.SelectedValue == "Selecione")
            {
                MSG_ERROR += "- Perfil de Acesso. <br />";
            }

            if (string.IsNullOrEmpty(txtNome.Text.Trim()))
            {
                MSG_ERROR += "- Nome. <br />";
            }

            if (string.IsNullOrEmpty(txtRaca.Text.Trim()))
            {
                MSG_ERROR += "- Raça. <br />";
            }

            if (string.IsNullOrEmpty(txtCor.Text.Trim()))
            {
                MSG_ERROR += "- Cor. <br />";
            }

            //if (string.IsNullOrEmpty(txtObs.Text.Trim()))
            //{
            //    MSG_ERROR += "- Descrição de Doenças/Observações. <br />";
            //}

            if (!string.IsNullOrEmpty(txtPeso.Text))
            {
                decimal peso;
                if (!decimal.TryParse(txtPeso.Text, out peso))
                {
                    MSG_ERROR += "- Peso inválido, digite ex: 7,2 (7 Kilo e 200 Gramas). <br />";
                }

            }

            if (string.IsNullOrEmpty(txtDataNascimento.Text.Trim()))
            {
                MSG_ERROR += "- Data de Nascimento. <br />";
            }


            if (MSG_ERROR.Length > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'<strong>Informações obrigatórias:</strong><br/>" + MSG_ERROR + "');", true);
                Valido = false;
            }

            return Valido;
        }
        
        private void CarregaComboClientes()
        {
            try
            {
                ClienteNegocios oNegocios = new ClienteNegocios();
                List<ClienteModel> oListModel = new List<ClienteModel>();

                oListModel = oNegocios.ListarComboCliente(new ClienteModel());
                oListModel.Insert(0, new ClienteModel() { Codigo = 0, Nome = "Selecione" });
                ddlCliente.DataSource = oListModel;
                ddlCliente.DataBind();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }
    }
}