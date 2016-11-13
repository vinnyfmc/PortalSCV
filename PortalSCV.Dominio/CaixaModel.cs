using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class CaixaModel
    {
        public int? Codigo { get; set; }
        public DateTime? Data { get; set; }
        public DateTime? DataFim { get; set; }
        public Decimal? Valor { get; set; }
        public String Descricao { get; set; }
        public int? Origem { get; set; }
    }
}
