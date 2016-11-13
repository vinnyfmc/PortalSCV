using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;
using PortalSCV.UTIL;
using System.Transactions;

namespace PortalSCV.Pedido
{
    public partial class PedidoCad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(! IsPostBack)
            {
                //Carrega Combo Tipo Pedido
                Array aTipoPedido = Enum.GetValues(typeof(PedidoModel.TipoPedido));

                cmbTipoPedido.Items.Add(new ListItem("Selecione", "0"));
                foreach (PedidoModel.TipoPedido TipoPedido in aTipoPedido)
                {
                    cmbTipoPedido.Items.Add(new ListItem(TipoPedido.ToString(), ((int)TipoPedido).ToString()));
                }


                //Carrega Combo Produtos
                ProdutoNegocios oProduto = new ProdutoNegocios();
                List<ProdutoModel> oProdutoList = new List<ProdutoModel>();
                oProdutoList = oProduto.Listar(new ProdutoModel { });
                oProdutoList.Insert(0, new ProdutoModel { Descricao = "Selecione", Codigo = 0 });
                UTIL.UTIL.PreencheSelect(oProdutoList, ddlProduto, "Descricao", "Codigo");

                if (Request.QueryString["Pedido"] != null)
                {
                    int nuPedido = 0;
                    if (int.TryParse(Request.QueryString["Pedido"].ToString(), out nuPedido))
                    {
                        DetalhaPedido(nuPedido);
                    }
                    else
                    {
                        //AVISO
                        //PARAMETRO NUMERO DO PEDIDO INVÁLIDO
                    }
                }
                else //NOVO PEDIDO
                {
                    btnExcluir.Visible = false;

                    //CRIA VIEWSTATE DOS ITENS DO PEDIDO
                    ViewState.Add("oItensProduto", new List<Pedido_ProdutosModel>());

                    txDataPedido.Text = DateTime.Now.ToString("dd/MM/yyyy");

                    txStatusPedido.Text = "Novo Pedido";

                    FuncionarioModel oFuncionario = (FuncionarioModel)Session["objFuncionario"];
                    txCadastradoPor.Text = oFuncionario.Nome;
                    CodigoFunc.Value = oFuncionario.Codigo.ToString();

                }

            }
        }

        private void DetalhaPedido(int nuPedido)
        {
            
            List<Pedido_ProdutosModel> oPedido = new List<Pedido_ProdutosModel>();
            oPedido = new PedidoNegocios().ListarProdutoPedido(new Pedido_ProdutosModel { Codigo_Pedido = nuPedido });
            if (oPedido.Count > 0)
            {

                CodigoPedido.Text = oPedido[0].Codigo_Pedido.ToString();

                txDataPedido.Text = oPedido[0].DataCriacaoPedido.ToString();
                cmbTipoPedido.SelectedValue = oPedido[0].TipoPedido.ToString();
                cmbTipoPedido.Enabled = false;

                if (oPedido[0].StatusPedido == 1)
                    txStatusPedido.Text = "Realizado";
                else { 
                    txStatusPedido.Text = "Cancelado";
                    btnExcluir.Visible = false;
                }
                btnSalvar.Visible = false;
                div_add_item.Visible = false;

                txtObs.Text = oPedido[0].ObservacaoPedido;
                txtObs.Enabled = false;
                
                txCadastradoPor.Text = oPedido[0].Nome_Funcionario;
                
                ViewState.Add("oItensProduto", oPedido);

                RptItensPedido.DataSource = oPedido;
                RptItensPedido.DataBind();
                
            }
        }

        protected void btnIncluirItem_Click(object sender, EventArgs e)
        {
            try
            {
               
                List<Pedido_ProdutosModel> ListProdutos = (List<Pedido_ProdutosModel>)ViewState["oItensProduto"];
                if (ValidaItens())
                {
                    Pedido_ProdutosModel oPedidoProduto = new Pedido_ProdutosModel();
                    oPedidoProduto.DescricaoProduto = ddlProduto.Items.FindByValue(ddlProduto.SelectedValue).Text;
                    oPedidoProduto.Codigo_Produto = UTIL.UTIL.Parse<int>(ddlProduto.SelectedValue);
                    oPedidoProduto.Quantidade = UTIL.UTIL.Parse<int>(txQuantidade.Text);
                    oPedidoProduto.ValorUnitario = UTIL.UTIL.Parse<decimal>(vlProduto.Text);
                   
                    ListProdutos.Add(oPedidoProduto);

                    RptItensPedido.DataSource = ListProdutos;
                    RptItensPedido.DataBind();

                    ViewState["oItensProduto"] = ListProdutos;

                }

            }
            catch (Exception ex)
            {
              
            }
        }

        protected Boolean ValidaItens()
        {
            String msgError = "Não foi possível incluir o Produto! <br />";

            bool err = false;

            if (ddlProduto.SelectedValue == "0")
            {
                msgError += " - Selecione o Produto! <br />";
                err = true;
            }

            if (string.IsNullOrEmpty(txQuantidade.Text))
            {
                msgError += " - Informe a Quantidade! <br />";
                err = true;
            }
            else
            {
                int qtd = 0;
                if (!int.TryParse(txQuantidade.Text, out qtd))
                {
                    msgError += " - Quantidade está no formato inválido! <br />";
                    err = true;
                }
                else
                {
                    if (qtd <= 0)
                    {
                        msgError += " - Quantidade não pode ser zero ou menor! <br />";
                        err = true;
                    }
                    
                }

            }

            decimal valor = 0;
            if (string.IsNullOrEmpty(vlProduto.Text))
            {
                msgError += " - Informe o Valor! <br />";
                err = true;
            }
            else if (!decimal.TryParse(vlProduto.Text, out valor))
            {
                msgError += " - Valor no Formato incorreto! <br />";
                err = true;
            }

            List<Pedido_ProdutosModel> ListProdutos = (List<Pedido_ProdutosModel>)ViewState["oItensProduto"];
            if (ListProdutos.Count > 0)
            {
                foreach (Pedido_ProdutosModel p in ListProdutos)
                {
                    if (p.Codigo_Produto.ToString() == ddlProduto.SelectedValue)
                    {
                        msgError += " - Este Produto já foi inserido! <br />";
                        err = true;
                    }
                }
            }

            if (err == true)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "NOCEP", "$(document).MensagemModal(3,'" + msgError + "');", true);
                return false;
            }
            else
            {
                return true;
            }
           
        }
        
        protected void RptItensPedido_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                
                if (e.CommandName == "Remover")
                {
                    
                    ProdutoModel oProduto = new ProdutoModel();

                    int? Codigo = UTIL.UTIL.Parse<int?>(((HiddenField)e.Item.FindControl("Codigo")).Value);

                    oProduto.Descricao = ((Label)e.Item.FindControl("DescricaoProduto")).Text;
                    oProduto.Codigo = UTIL.UTIL.Parse<int>(((HiddenField)e.Item.FindControl("Codigo_Produto")).Value);
                    oProduto.QuantidadeEstoque = UTIL.UTIL.Parse<int>(((Label)e.Item.FindControl("txQuantidade")).Text);
                    oProduto.PrecoVenda = UTIL.UTIL.Parse<decimal>(((Label)e.Item.FindControl("txValorUnitario")).Text);

                    List<Pedido_ProdutosModel> ListProdutos = (List<Pedido_ProdutosModel>)ViewState["oItensProduto"];
                   
                    if (Codigo != null) //ALTERA ESTOQUE
                    {
                        DivAvisoItensPedido.Visible = true;
                        AvisoItensPedido.Text = "Não é possível realizar alterações no pedido pois o mesmo já está concluído!";
                        return;
                    }

                    if (ListProdutos.Count > 0)
                    {
                        foreach (Pedido_ProdutosModel p in ListProdutos)
                        {
                            if ((p.Codigo_Produto == oProduto.Codigo) && (p.Quantidade == oProduto.QuantidadeEstoque) && (p.ValorUnitario == oProduto.PrecoVenda))
                            {
                                ListProdutos.Remove(p);
                                break;
                            }
                        }
                    }

                    RptItensPedido.DataSource = ListProdutos;
                    RptItensPedido.DataBind();

                    ViewState["oItensProduto"] = ListProdutos;
                    UpdPanelTableItens.Update();

                }

            }
            catch (Exception ex)
            {
                DivAvisoItensPedido.Visible = true;
                AvisoItensPedido.Text = "Ocorreu um erro ao deletar o produto do pedido.";
            }
        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidaCampos())
                {

                    using (TransactionScope tran = new TransactionScope())
                    {
                        PedidoModel model = new PedidoModel();

                        if ((!string.IsNullOrEmpty(CodigoPedido.Text)) && (CodigoPedido.Text != "0"))
                        {
                            model.Codigo = UTIL.UTIL.Parse<int>(CodigoPedido.Text);
                        }
                       
                        model.Tipo = UTIL.UTIL.Parse<int>(cmbTipoPedido.SelectedValue);
                   
                        if (!string.IsNullOrEmpty(txtObs.Text))
                            model.Observacao = txtObs.Text;

                        model.Codigo_Funcionario = UTIL.UTIL.Parse<int>(CodigoFunc.Value);
                        model.DataCriacao = DateTime.Now;

                        PedidoNegocios Pedidos_N = new PedidoNegocios();
                        model = Pedidos_N.Salvar(model);
                        
                        //ITENS PEDIDO
                        List<Pedido_ProdutosModel> ListProdutos = (List<Pedido_ProdutosModel>)ViewState["oItensProduto"];
                        if (ListProdutos.Count > 0)
                        {
                            foreach (Pedido_ProdutosModel P in ListProdutos)
                            {
                                if (P.Codigo == null)
                                {
                                    if ((model.Tipo == (int)PedidoModel.TipoPedido.Venda) || (model.Tipo == (int)PedidoModel.TipoPedido.Atendimento))
                                        P.Quantidade = -1 * P.Quantidade;

                                    //ALTERA ESTOQUE
                                    string msgErro = new ProdutoNegocios().AlterarEstoque((int)P.Codigo_Produto, (int)P.Quantidade);
                                    if (msgErro != "OK")
                                    {
                                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Erro_Salvar", "$(document).MensagemModal(3,'" + msgErro + "');", true);
                                        UpdPanelTableItens.Update();
                                        tran.Dispose();
                                        return;
                                    }
                                    else
                                    {
                                        Pedido_ProdutosModel oPedido_Produtos = new Pedido_ProdutosModel();
                                        oPedido_Produtos.Codigo_Pedido = model.Codigo;
                                        oPedido_Produtos.Codigo_Produto = P.Codigo_Produto;
                                        oPedido_Produtos.Quantidade = P.Quantidade;
                                        oPedido_Produtos.ValorUnitario = P.ValorUnitario;

                                        new PedidoNegocios().IncluirProdutoPedido(oPedido_Produtos);
                                        
                                    }

                                }
                            }
                        }

                        tran.Complete();
                        Response.Redirect("PedidoCad.aspx?Pedido=" + model.Codigo.ToString(), false);
                    }

                }
            }
            catch (Exception ex)
            {
                
            }
        }

        protected Boolean ValidaCampos()
        {
            bool err = false;
            String msgError = "Não foi possível salvar o Pedido! <br />";

            if((string.IsNullOrEmpty(cmbTipoPedido.SelectedValue)) ||(cmbTipoPedido.SelectedValue == "0"))
            {
                msgError += " - Selecione o tipo do pedido. <br />";
                err = true;
            }

            List<Pedido_ProdutosModel> ListProdutos = (List<Pedido_ProdutosModel>)ViewState["oItensProduto"];
            if (ListProdutos.Count == 0)
            {
                msgError += " - Inclua ao menos um Produto ao pedido. <br />";
                err = true;
            }

            if (err == true)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "NOCEP", "$(document).MensagemModal(3,'" + msgError + "');", true);
                return false;
            }
            else
            {
                return true;
            }
        }

        protected void btnExcluir_Click(object sender, EventArgs e)
        {
            try
            {
                
                using (TransactionScope tran = new TransactionScope())
                {
                    int CodPedido = (int.Parse(CodigoPedido.Text));

                    new PedidoNegocios().AlterarStatus(new PedidoModel { Codigo = CodPedido, Status = 0 });
                    
                    List<Pedido_ProdutosModel> oList_Produtos = new List<Pedido_ProdutosModel>();
                    oList_Produtos = new PedidoNegocios().ListarProdutoPedido(new Pedido_ProdutosModel { Codigo_Pedido = CodPedido });
                    foreach (Pedido_ProdutosModel P in oList_Produtos)
                    {

                        if ((P.TipoPedido == (int)PedidoModel.TipoPedido.Compra))
                            P.Quantidade = -1 * P.Quantidade;

                        //ALTERA ESTOQUE
                        string msgErro = new ProdutoNegocios().AlterarEstoque((int)P.Codigo_Produto, (int)P.Quantidade);
                        if (msgErro != "OK")
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Erro_Excluir", "$(document).MensagemModal(3,'" + msgErro + "');", true);
                            UpdPanelTableItens.Update();
                            tran.Dispose();
                            return;
                        }

                    }
                    tran.Complete();
                }

                Response.Redirect("PedidoCad.aspx?Pedido=" + CodigoPedido.Text, false);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Erro_Excluir", "$(document).MensagemModal(3,'Ocorreu um erro ao excluir o pedido.');", true);
            }
        }

        protected void ddlProduto_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string idProd = ddlProduto.SelectedValue;
                if ((string.IsNullOrEmpty(idProd)) || idProd == "0")
                {
                    vlProduto.Text = "";
                }
                else
                {
                    //GET VALOR PRODUTO
                    ProdutoNegocios ProdutosN = new ProdutoNegocios();
                    List<ProdutoModel> oProduto = new List<ProdutoModel>();
                    oProduto = ProdutosN.Listar(new ProdutoModel { Codigo = int.Parse(idProd) });

                    if(cmbTipoPedido.SelectedValue == ((int)PedidoModel.TipoPedido.Compra).ToString())
                        vlProduto.Text = oProduto[0].PrecoCompra.Value.ToString("0.00");
                    else
                        vlProduto.Text = oProduto[0].PrecoVenda.Value.ToString("0.00");
                }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "NOCEP", "$(document).MensagemModal(3,'Ocorreu um erro ao buscar o valor do produto selecionado.');", true);
            }
        }

    }
}