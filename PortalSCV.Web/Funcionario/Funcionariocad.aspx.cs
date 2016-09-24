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

namespace PortalSCV.Layout.Funcionario
{
    public partial class FuncionarioCad : System.Web.UI.Page
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
                            DetalharObj(id);
                        }
                        else
                        {
                            Response.Redirect("FuncionarioCad.aspx");
                        }

                    }
                    else { }//Novo
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
                }
            }
        }

        private void DetalharObj(int Id)
        {

            FuncionarioModel oModel = new FuncionarioModel();
            List<FuncionarioModel> oListModel = new List<FuncionarioModel>();
            FuncionarioNegocios oNegocios = new FuncionarioNegocios();

            oModel.Codigo = Id;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                oModel = oListModel[0];

                Funcionario_Id.Value = oModel.Codigo.ToString();
                txtNome.Text = oModel.Nome;
                txtCPF.Text = oModel.CPF;

                if (oModel.DataNascimento != null)
                    txtDataNascimento.Text = ((DateTime)oModel.DataNascimento).ToString("dd/MM/yyyy");

                txtCEP.Text = oModel.CEP;
                txtUF.Text = oModel.UF;
                txtCidade.Text = oModel.Municipio;
                txtBairro.Text = oModel.Bairro;
                txtEndereco.Text = oModel.Endereco;
                txtNumEndereco.Text = oModel.Numero;
                txtComplemento.Text = oModel.Complemento;
                txtTelefone.Text = oModel.Telefone;
                txtCelular.Text = oModel.Celular;
                txtEmail.Text = oModel.Email;
                txtEmail_Original.Text = oModel.Email;
                txSalario.Text = oModel.Salario.ToString();
                txDataAdmissao.Text = ((DateTime)oModel.DataAdmissao).ToString("dd/MM/yyyy"); 
                
                cbStatus.SelectedValue = ((bool)oModel.Ativo).ToString();

                FuncionarioModel oFuncionario = (FuncionarioModel)Session["objFuncionario"];
                if(oFuncionario.Codigo == oModel.Codigo)
                {
                    btnAlterarSenhaModal.Visible = true;
                }else
                {
                    btnAlterarSenhaModal.Visible = false;
                }

            }

        }

        protected void btnCEP_Click(object sender, EventArgs e)
        {

            try
            {
                Address Endereco = SearchZip.GetAddress(txtCEP.Text);
                if (Endereco.Zip != null)
                {
                    txtUF.Text = Endereco.State;
                    txtCidade.Text = Endereco.City;
                    txtBairro.Text = Endereco.District;
                    txtEndereco.Text = Endereco.Street;
                }
                else
                {
                    txtUF.Text = string.Empty;
                    txtCidade.Text = string.Empty;
                    txtBairro.Text = string.Empty;
                    txtEndereco.Text = string.Empty;

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "NOCEP", "$(document).MensagemModal(2,'CEP não encontrado!');", true);
                }
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
                    FuncionarioModel oModel = new FuncionarioModel();
                    FuncionarioNegocios oNegocios = new FuncionarioNegocios();

                    if (!string.IsNullOrEmpty(Funcionario_Id.Value))
                        oModel.Codigo = UTIL.UTIL.Parse<int>(Funcionario_Id.Value);
                    else
                        oModel.DataCadastro = DateTime.Now;

                    oModel.Nome = UTIL.UTIL.Parse<string>(txtNome.Text);
                    oModel.CPF = UTIL.UTIL.RetiraFormatacao(txtCPF.Text, new string[] { ".", "-" });
                    oModel.DataNascimento = UTIL.UTIL.Parse<DateTime>(txtDataNascimento.Text);

                    if (!string.IsNullOrEmpty(txtCEP.Text))
                        oModel.CEP = UTIL.UTIL.Parse<string>(txtCEP.Text);

                    if (!string.IsNullOrEmpty(txtUF.Text))
                        oModel.UF = UTIL.UTIL.Parse<string>(txtUF.Text);

                    if (!string.IsNullOrEmpty(txtCidade.Text))
                        oModel.Municipio = UTIL.UTIL.Parse<string>(txtCidade.Text);

                    if (!string.IsNullOrEmpty(txtBairro.Text))
                        oModel.Bairro = UTIL.UTIL.Parse<string>(txtBairro.Text);

                    if (!string.IsNullOrEmpty(txtEndereco.Text))
                        oModel.Endereco = UTIL.UTIL.Parse<string>(txtEndereco.Text);

                    if (!string.IsNullOrEmpty(txtNumEndereco.Text))
                        oModel.Numero = UTIL.UTIL.Parse<string>(txtNumEndereco.Text);

                    if (!string.IsNullOrEmpty(txtComplemento.Text))
                        oModel.Complemento = UTIL.UTIL.Parse<string>(txtComplemento.Text);

                    if (!string.IsNullOrEmpty(txtTelefone.Text))
                        oModel.Telefone = UTIL.UTIL.RetiraFormatacao(UTIL.UTIL.Parse<string>(txtTelefone.Text), new string[] { "(", ")", " ", "-" });

                    if (!string.IsNullOrEmpty(txtCelular.Text))
                        oModel.Celular = UTIL.UTIL.RetiraFormatacao(UTIL.UTIL.Parse<string>(txtCelular.Text), new string[] { "(", ")", " ", "-" });
                    
                    if (!string.IsNullOrEmpty(txtEmail.Text))
                        oModel.Email = UTIL.UTIL.Parse<string>(txtEmail.Text);

                    if (!string.IsNullOrEmpty(txSalario.Text))
                        oModel.Salario = UTIL.UTIL.Parse<Decimal>(txSalario.Text);

                    if (!string.IsNullOrEmpty(txDataAdmissao.Text))
                        oModel.DataAdmissao = UTIL.UTIL.Parse<DateTime>(txDataAdmissao.Text);

                    oModel.Ativo = Boolean.Parse(cbStatus.SelectedValue);

                    oModel = oNegocios.Salvar(oModel);

                    Funcionario_Id.Value = oModel.Codigo.ToString();
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

            FuncionarioModel oModel = new FuncionarioModel();
            List<FuncionarioModel> oListModel = new List<FuncionarioModel>();
            FuncionarioNegocios oNegocios = new FuncionarioNegocios();

            if (string.IsNullOrEmpty(txtNome.Text.Trim()))
            {
                MSG_ERROR += "- Nome. <br />";
            }

            if (string.IsNullOrEmpty(txtDataNascimento.Text.Trim()))
            {
                MSG_ERROR += "- Data de Nascimento. <br />";
            }

            if (string.IsNullOrEmpty(txtCPF.Text.Trim()))
            {
                MSG_ERROR += "- CPF";
            }
            else { 
                if (!UTIL.UTIL.IsCpf(txtCPF.Text.Trim()))
                {
                    MSG_ERROR += "- CPF inválido. <br />";
                }
                else if (string.IsNullOrEmpty(Funcionario_Id.Value))
                {
                    //Valida se CPF já cadastrado
                    oModel = new FuncionarioModel();
                    oListModel = new List<FuncionarioModel>();
                    oNegocios = new FuncionarioNegocios();

                    oModel.CPF = UTIL.UTIL.RetiraFormatacao(txtCPF.Text, new string[] { ".", "-" });
                    oListModel = oNegocios.Listar(oModel);
                    if (oListModel.Count > 0)
                    {
                        MSG_ERROR += "- CPF já cadastrado. <br />";
                    }

                }
            }

            if (string.IsNullOrEmpty(txtEndereco.Text.Trim()))
            {
                MSG_ERROR += "- Endereço. <br />";
            }

            if (!UTIL.UTIL.ValidarEmail(txtEmail.Text.Trim()))
            {
                MSG_ERROR += "- Email não preenchido ou inválido. <br />";
            }
            else if (string.IsNullOrEmpty(Funcionario_Id.Value))
            { 
                //Valida se email já cadastrado
                oModel.Email = txtEmail.Text.Trim();
                oListModel = oNegocios.Listar(oModel);
                if (oListModel.Count > 0)
                {
                    MSG_ERROR += "- Email já cadastrado. <br />";
                }
            }

            if ((string.IsNullOrEmpty(txtTelefone.Text.Trim())) && (string.IsNullOrEmpty(txtCelular.Text.Trim())))
            {
                MSG_ERROR += "- Telefone e/ou Celular. <br />";
            }

            if (MSG_ERROR.Length > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'<strong>Informações obrigatórias:</strong><br/>" + MSG_ERROR + "');", true);
                Valido = false;
            }

            return Valido;
        }

        protected void btnAlterarSenha_Click(object sender, EventArgs e)
        {
            try {

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "FechaModal", "$('#ModalAlterarSenha').modal('hide');", true);

                if (string.IsNullOrEmpty(txPass.Text))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'Digite a senha e a confirmação da senha!');", true);
                    return;
                }
                else if ((string.IsNullOrEmpty(txPass.Text)) != (string.IsNullOrEmpty(txPassConfirm.Text)))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'A senha está diferente da confirmação da senha!');", true);
                    return;
                }
                else {
                    FuncionarioModel oModel = new FuncionarioModel();
                    FuncionarioNegocios oNegocios = new FuncionarioNegocios();

                    oModel.Email = txtEmail_Original.Text;
                    oModel.Senha = txPass.Text;
                    if(oNegocios.AlterarSenha(oModel))
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "SenhaAltrada", "$(document).MensagemModal(1,'Senha alterada com sucesso!');", true);
                    else
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "ErroAlterarSenha", "$(document).MensagemModal(3,'Ocorreu um erro ao alterar sua senha!');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ERROR", "$(document).MensagemModal(3,'Ocorreu um erro inesperado! Mensagem = " + new JavaScriptSerializer().Serialize(ex.Message.ToString()) + "');", true);
            }
        }



    }
}