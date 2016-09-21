using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class FuncionarioModel
    {
        public int? Codigo { get; set; }
        public String Nome { get; set; }
        public String CPF { get; set; }
        public String Endereco { get; set; }
        public String Bairro { get; set; }
        public String Municipio { get; set; }
        public String UF { get; set; }
        public String CEP { get; set; }
        public String Complemento { get; set; }
        public String Numero { get; set; }
        public String Telefone { get; set; }
        public String Celular { get; set; }
        public DateTime? DataNascimento { get; set; }
        public DateTime? DataAdmissao { get; set; }
        public DateTime? DataCadastro { get; set; }
        public Decimal? Salario { get; set; }
        public String Email { get; set; }
        public String Senha { get; set; }
        public Boolean? Ativo { get; set; }
        
    }
}
