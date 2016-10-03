using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;
using System.Web.Script.Serialization;

namespace PortalSCV.Produto
{
    public partial class Produto_Cad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {

                    //Carrega Fornecedores
                    FornecedorModel oModel = new FornecedorModel();
                    List<FornecedorModel> oList = new List<FornecedorModel>();
                    FornecedorNegocios oNegocios = new FornecedorNegocios();
                    oModel.Ativo = true;
                    oList = oNegocios.Listar(oModel);
                    UTIL.UTIL.PreencheSelect(oList, cmbFornecedor, "RazaoSocial", "Codigo", "Selecione...");
                    
                    if (Request.QueryString["Cod"] != null)
                    {
                        int id;
                        if (int.TryParse(Request.QueryString["Cod"].ToString(), out id))
                        {
                            DetalharObj(id);
                        }
                        else
                        {
                            Response.Redirect("ProdutoCad.aspx");
                        }

                    }
                    else {
                        FuncionarioModel oFuncionario = (FuncionarioModel)Session["objFuncionario"];
                        txCadastradoPor.Text = oFuncionario.Nome;
                        cdFuncionario.Text = oFuncionario.Codigo.ToString();
                        txQuantidade.Text = "0";
                        
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

            ProdutoModel oModel = new ProdutoModel();
            List<ProdutoModel> oListModel = new List<ProdutoModel>();
            ProdutoNegocios oNegocios = new ProdutoNegocios();

            oModel.Codigo = Id;
            oListModel = oNegocios.Listar(oModel);
            if (oListModel.Count > 0)
            {
                oModel = oListModel[0];

                Produto_Id.Value = oModel.Codigo.ToString();
                txDescricao.Text = oModel.Descricao;
                txCadastradoPor.Text = oModel.Nome_Funcionario;
                cdFuncionario.Text = oModel.Codigo_Funcionario.ToString();
                cmbFornecedor.SelectedValue = oModel.Codigo_Fornecedor.ToString();
                if (oModel.DataValidade != null)
                    txDataValidade.Text = ((DateTime)oModel.DataValidade).ToString("dd/MM/yyyy");
                txValorCompra.Text = ((Decimal)oModel.PrecoCompra).ToString("n2");
                txValorVenda.Text = ((Decimal)oModel.PrecoVenda).ToString("n2");
                if (oModel.QuantidadeEstoque_Minima != null)
                    txQuantMinima.Text = oModel.QuantidadeEstoque_Minima.ToString();
                txQuantidade.Text = oModel.QuantidadeEstoque.ToString();
                
            }

        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {

                if (ValidarCampos())
                {
                    ProdutoModel oModel = new ProdutoModel();
                    ProdutoNegocios oNegocios = new ProdutoNegocios();

                    if (!string.IsNullOrEmpty(Produto_Id.Value))
                        oModel.Codigo = UTIL.UTIL.Parse<int>(Produto_Id.Value);
                    
                    oModel.Codigo_Funcionario = UTIL.UTIL.Parse<int>(cdFuncionario.Text);
                    oModel.Codigo_Fornecedor = UTIL.UTIL.Parse<int>(cmbFornecedor.SelectedValue);

                    if (!string.IsNullOrEmpty(txQuantMinima.Text))
                        oModel.QuantidadeEstoque_Minima = UTIL.UTIL.Parse<int>(txQuantMinima.Text);

                    oModel.Descricao = txDescricao.Text;

                    if (!string.IsNullOrEmpty(txDataValidade.Text))
                        oModel.DataValidade = UTIL.UTIL.Parse<DateTime>(txDataValidade.Text);

                    oModel.PrecoCompra = UTIL.UTIL.Parse<Decimal>(txValorCompra.Text);
                    oModel.PrecoVenda = UTIL.UTIL.Parse<Decimal>(txValorVenda.Text);

                    oModel = oNegocios.Salvar(oModel);

                    Produto_Id.Value = oModel.Codigo.ToString();
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
    
            String MSG_ERROR = String.Empty;

            if (string.IsNullOrEmpty(txDescricao.Text.Trim()))
            {
                MSG_ERROR += "- Nome. <br />";
            }

            if (string.IsNullOrEmpty(cmbFornecedor.SelectedValue.Trim()))
            {
                MSG_ERROR += "- Fornecedor. <br />";
            }

            if (string.IsNullOrEmpty(txValorCompra.Text.Trim()))
            {
                MSG_ERROR += "- Preço de Compra. <br />";
            }

            if (string.IsNullOrEmpty(txValorVenda.Text.Trim()))
            {
                MSG_ERROR += "- Preço de Venda. <br />";
            }

            if (MSG_ERROR.Length > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CamposObrigatorios", "$(document).MensagemModal(3,'<strong>Informações obrigatórias:</strong><br/>" + MSG_ERROR + "');", true);
                return false;
            }

            return true;
        }

    }
}