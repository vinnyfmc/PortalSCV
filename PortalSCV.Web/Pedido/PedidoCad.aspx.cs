using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;
using PortalSCV.UTIL;

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
            }
        }

        protected void btnIncluirItem_Click(object sender, EventArgs e)
        {

        }

        protected void RptItensPedido_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void RptItensPedido_ItemCreated(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void RptItensPedido_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {

        }

        protected void btnExcluir_Click(object sender, EventArgs e)
        {

        }
    }
}