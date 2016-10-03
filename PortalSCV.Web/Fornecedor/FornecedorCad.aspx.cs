using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;
using System.Web.Script.Serialization;

namespace PortalSCV.Fornecedor
{
    public partial class FornecedorCad : System.Web.UI.Page
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
                            Response.Redirect("FornecedorCad.aspx");
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

            FornecedorModel oModel = new FornecedorModel();
            List<FornecedorModel> oListModel = new List<FornecedorModel>();
            FornecedorNegocios oNegocios = new FornecedorNegocios();

            oModel.Codigo = Id;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                oModel = oListModel[0];

                Fornecedor_Id.Value = oModel.Codigo.ToString();
                txtRazaoSocial.Text = oModel.RazaoSocial;

                if (oModel.NomeFantasia != null)
                    txtNomeFantasia.Text = oModel.NomeFantasia;

                txtCNPJ.Text = oModel.CNPJ;

                if (oModel.Contato != null)
                    txtTelefone.Text = oModel.Contato;

                txtEmail.Text = oModel.Email;
                cbStatus.SelectedValue = ((bool)oModel.Ativo).ToString();
                
            }

        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {

                if (ValidarCampos())
                {
                    FornecedorModel oModel = new FornecedorModel();
                    FornecedorNegocios oNegocios = new FornecedorNegocios();

                    if (!string.IsNullOrEmpty(Fornecedor_Id.Value))
                        oModel.Codigo = UTIL.UTIL.Parse<int>(Fornecedor_Id.Value);
                    
                    oModel.RazaoSocial = UTIL.UTIL.Parse<string>(txtRazaoSocial.Text);
                    oModel.NomeFantasia = UTIL.UTIL.Parse<string>(txtNomeFantasia.Text);
                    oModel.CNPJ = UTIL.UTIL.RetiraFormatacao(txtCNPJ.Text, new string[] { ".", "-", "/" });

                    if (!string.IsNullOrEmpty(txtTelefone.Text))
                        oModel.Contato = UTIL.UTIL.RetiraFormatacao(UTIL.UTIL.Parse<string>(txtTelefone.Text), new string[] { "(", ")", " ", "-" });

                    if (!string.IsNullOrEmpty(txtEmail.Text))
                        oModel.Email = UTIL.UTIL.Parse<string>(txtEmail.Text);
                    
                    oModel.Ativo = Boolean.Parse(cbStatus.SelectedValue);

                    oModel = oNegocios.Salvar(oModel);

                    Fornecedor_Id.Value = oModel.Codigo.ToString();
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

            FornecedorModel oModel = new FornecedorModel();
            List<FornecedorModel> oListModel = new List<FornecedorModel>();
            FornecedorNegocios oNegocios = new FornecedorNegocios();

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
                else if (string.IsNullOrEmpty(Fornecedor_Id.Value))
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
            else if (string.IsNullOrEmpty(Fornecedor_Id.Value))
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