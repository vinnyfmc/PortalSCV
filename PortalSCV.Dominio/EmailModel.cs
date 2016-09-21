using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class EmailModel
    {
        public string EmailPara { get; set; }
        public string Assunto { get; set; }
        public string CorpoEmail { get; set; }
    }
}
