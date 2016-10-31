using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;
using System.Web.Script.Serialization;

namespace PortalSCV.Empresa
{
    public partial class EmpresaCad : System.Web.UI.Page
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
                            btnSalvar.Visible = false;
                        }
                        else
                        {
                            Response.Redirect("EmpresaCad.aspx");
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

            EmpresaModel oModel = new EmpresaModel();
            List<EmpresaModel> oListModel = new List<EmpresaModel>();
            EmpresaNegocios oNegocios = new EmpresaNegocios();

            oModel.Codigo = Id;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                oModel = oListModel[0];

                Empresa_Id.Value = oModel.Codigo.ToString();
                txtRazaoSocial.Text = oModel.RazaoSocial;

                if (oModel.NomeFantasia != null)
                    txtNomeFantasia.Text = oModel.NomeFantasia;

                txtCNPJ.Text = oModel.CNPJ;
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
                cbStatus.SelectedValue = ((bool)oModel.Ativo).ToString();
                
            }

        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {

                if (ValidarCampos())
                {
                    EmpresaModel oModel = new EmpresaModel();
                    EmpresaNegocios oNegocios = new EmpresaNegocios();

                    if (!string.IsNullOrEmpty(Empresa_Id.Value))
                        oModel.Codigo = UTIL.UTIL.Parse<int>(Empresa_Id.Value);
                    
                    oModel.RazaoSocial = UTIL.UTIL.Parse<string>(txtRazaoSocial.Text);
                    oModel.NomeFantasia = UTIL.UTIL.Parse<string>(txtNomeFantasia.Text);
                    oModel.CNPJ = UTIL.UTIL.RetiraFormatacao(txtCNPJ.Text, new string[] { ".", "-", "/" });

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

                    oModel.Ativo = Boolean.Parse(cbStatus.SelectedValue);

                    oModel = oNegocios.Salvar(oModel);

                    Empresa_Id.Value = oModel.Codigo.ToString();
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

            EmpresaModel oModel = new EmpresaModel();
            List<EmpresaModel> oListModel = new List<EmpresaModel>();
            EmpresaNegocios oNegocios = new EmpresaNegocios();

            if (string.IsNullOrEmpty(txtRazaoSocial.Text.Trim()))
            {
                MSG_ERROR += "- Razão Social. <br />";
            }
            
            if (string.IsNullOrEmpty(txtCNPJ.Text.Trim()))
            {
                MSG_ERROR += "- CNPJ <br />";
            }
            else
            {
                if (!UTIL.UTIL.IsCnpj(txtCNPJ.Text.Trim()))
                {
                    MSG_ERROR += "- CNPJ inválido. <br />";
                }
                else if (string.IsNullOrEmpty(Empresa_Id.Value))
                {
                    //Valida se CNPJ já cadastrado
                    oModel.CNPJ = UTIL.UTIL.RetiraFormatacao(txtCNPJ.Text, new string[] { ".", "-", "/" });
                    oListModel = oNegocios.Listar(oModel);
                    if (oListModel.Count > 0)
                    {
                        MSG_ERROR += "- CNPJ já cadastrado. <br />";
                    }

                }
            }
            
            if (!UTIL.UTIL.ValidarEmail(txtEmail.Text.Trim()))
            {
                MSG_ERROR += "- Email não preenchido ou inválido. <br />";
            }
            else if (string.IsNullOrEmpty(Empresa_Id.Value))
            {
                //Valida se email já cadastrado
                oModel.CNPJ = null;
                oModel.Email = txtEmail.Text.Trim();
                oListModel = oNegocios.Listar(oModel);
                if (oListModel.Count > 0)
                {
                    MSG_ERROR += "- Email já cadastrado. <br />";
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