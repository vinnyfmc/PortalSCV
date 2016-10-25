using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class AnimalModel
    {
        public int? Codigo { get; set; }
        public int? Codigo_Cliente { get; set; }
        public int? Codigo_Funcionario { get; set; }
        public String Nome { get; set; }
        public String Raca { get; set; }
        public String Cor { get; set; }
        public int? Idade { get; set; }
        public String Peso { get; set; }
        public String Sexo { get; set; }
        public String DescricaoDoencas { get; set; }
        public DateTime? DataNascimento { get; set; }
        public DateTime? DataCadastro { get; set; }
        public Boolean? Ativo { get; set; }
        public String Nome_Cliente { get; set; }
        public String Nome_Funcionario { get; set; }
    }
}
