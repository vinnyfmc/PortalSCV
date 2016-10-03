using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class PerfilAcessoFuncionarioModel
    {
        public int? Codigo { get; set; }
        public int? Codigo_PerfilAcesso { get; set; }
        public int? Codigo_Funcionario { get; set; }
        public String Funcionario_Nome { get; set; }
        public String PerfilAcesso_Nome { get; set; }

    }
}
