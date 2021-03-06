﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PortalSCV.Dominio
{
    [Serializable]
    public class EmpresaModel
    {
        public int? Codigo { get; set; }
        public String RazaoSocial { get; set; }
        public String NomeFantasia { get; set; }
        public String CNPJ { get; set; }
        public String Endereco { get; set; }
        public String Bairro { get; set; }
        public String Municipio { get; set; }
        public String UF { get; set; }
        public String Complemento { get; set; }
        public String Numero { get; set; }
        public String Telefone { get; set; }
        public String Celular { get; set; }
        public String Email { get; set; }
        public DateTime? DataCadastro { get; set; }
        public Boolean? Ativo { get; set; }
    }
}
