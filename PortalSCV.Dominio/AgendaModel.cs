using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class AgendaModel
    {
        public int? Codigo { get; set; }
        public int? Codigo_Animal { get; set; }
        public int? Codigo_Funcionario { get; set; }
        public String DescricaoServico { get; set; }
        public String TipoAtendimento { get; set; }
        public DateTime? DataHoraEntrada { get; set; }
        public DateTime? DataHoraSaida { get; set; }
        public Decimal? Valor { get; set; }
        public Boolean? Ativo { get; set; }

        public int? Codigo_Cliente { get; set; }
        public String Nome_Animal { get; set; }
        public String Raca { get; set; }
        public String Cor { get; set; }
        public int? Idade { get; set; }
        public Decimal? Peso { get; set; }
        public String Sexo { get; set; }
        public String DescricaoDoencas { get; set; }
        public DateTime? DataNascimento { get; set; }
        public Boolean? Ativo_Animal { get; set; }

        public String Nome_CLiente { get; set; }
        public String Telefone_Cliente { get; set; }
        public String Celular_Cliente { get; set; }
        public Boolean? Ativo_Cliente { get; set; }

        public String Nome_Funcionario { get; set; }
        public String Telefone_Funcionario { get; set; }
        public String Celular_Funcionario { get; set; }
        public String Email_Funcionario { get; set; }
        public Boolean? Ativo_Funcionario { get; set; }

        public String Nome_Agendamento
        {
            get { return ((DateTime)DataHoraEntrada).ToString("dd/MM/yyyy HH:mm") + " | " + Nome_Animal + " | " + ((Decimal)Valor).ToString("C"); }
        }
        

    }
}
