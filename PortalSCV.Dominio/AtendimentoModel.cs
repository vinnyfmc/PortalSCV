using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class AtendimentoModel
    {
        public int? Codigo { get; set; }
        public int? Codigo_Agenda { get; set; }
        public int? Codigo_Funcionario { get; set; }
        public int? Codigo_Pedido { get; set; }
        public String Descricao { get; set; }
        public DateTime? DataHora { get; set; }
        public Decimal? Valor { get; set; }
    }
}
