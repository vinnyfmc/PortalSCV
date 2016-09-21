using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class EstoqueModel
    {
        //Campos Tabela Estoque
        public int? Id { get; set; }
        public int? IdProduto { get; set; }
        public int? Quantidade { get; set; }

        //Preenchido pela tabela de PRODUTO
        public String NomeProduto { get; set; }
        public int QuantidadeMinima { get; set; }

        //Aviso Estoque
        public String AvisoEstoque { get; set; }
    }
}
