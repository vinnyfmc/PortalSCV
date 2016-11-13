using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class Pedido_ProdutosModel
    {
        public int? Codigo { get; set; }
        public int? Codigo_Produto { get; set; }
        public int? Codigo_Pedido { get; set; }
        public int? Quantidade { get; set; }
        public decimal? ValorUnitario { get; set; }

        public int? QuantidadeEstoque { get; set; }
        public int? QuantidadeEstoque_Minima { get; set; }
        public String DescricaoProduto { get; set; }
        public DateTime? DataValidade { get; set; }
        public Decimal? PrecoCompra { get; set; }
        public Decimal? PrecoVenda { get; set; }

        public String AvisoEstoque { get; set; }
        public String Nome_Funcionario { get; set; }

        public int? TipoPedido { get; set; }
        public int? StatusPedido { get; set; }
        public String ObservacaoPedido { get; set; }
        public DateTime? DataCriacaoPedido { get; set; }
        public int? PedidoComplementar { get; set; }
    }
}
