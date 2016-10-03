using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class FornecedorModel
    {
        public int? Codigo { get; set; }
        public String RazaoSocial { get; set; }
        public String NomeFantasia { get; set; }
        public String CNPJ { get; set; }
        public String Contato { get; set; }
        public String Email { get; set; }
        public DateTime? DataCadastro { get; set; }
        public Boolean? Ativo { get; set; }
        
    }
}
