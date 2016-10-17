using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class PedidoModel
    { 
        public int? Codigo { get; set; }
        public int? Codigo_Funcionario { get; set; }
        public int? Tipo { get; set; }
        public int? Status { get; set; }
        public String Observacao { get; set; }
        public DateTime? DataCriacao { get; set; }
        public int? PedidoComplementar { get; set; }

        public DateTime? DataCriacaoFim { get; set; }
    }
}
