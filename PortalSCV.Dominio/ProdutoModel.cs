using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class ProdutoModel
    {

        public int? Codigo { get; set; }
        public int? Codigo_Fornecedor { get; set; }
        public int? Codigo_Funcionario { get; set; }
        public int? QuantidadeEstoque { get; set; }
        public int? QuantidadeEstoque_Minima { get; set; }
        public String Descricao { get; set; }
        public DateTime? DataValidade { get; set; }
        public Decimal? PrecoCompra { get; set; }
        public Decimal? PrecoVenda { get; set; }
        public String Foto { get; set; }

        public String AvisoEstoque { get; set; }
        public String Nome_Funcionario { get; set; }
        public String Nome_Fornecedor { get; set; }
    }
}
