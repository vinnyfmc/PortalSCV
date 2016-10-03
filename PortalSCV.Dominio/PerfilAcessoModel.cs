using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class PerfilAcessoModel
    {
        public int? Codigo { get; set; }
        public String Nome { get; set; }
    }
}
