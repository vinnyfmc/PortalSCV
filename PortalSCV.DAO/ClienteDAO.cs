using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class ClienteDAO
    {
        public List<ClienteModel> Listar(ClienteModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@CPF", oModel.CPF),
                new SqlParameter("@Endereco", oModel.Endereco),
                new SqlParameter("@Bairro", oModel.Bairro),
                new SqlParameter("@Municipio", oModel.Municipio),
                new SqlParameter("@UF", oModel.UF),
                new SqlParameter("@CEP", oModel.CEP),
                new SqlParameter("@Complemento", oModel.Complemento),
                new SqlParameter("@Numero", oModel.Numero),
                new SqlParameter("@Telefone", oModel.Telefone),
                new SqlParameter("@Celular", oModel.Telefone),
                new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@DataCadastro", oModel.DataCadastro),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQuery<ClienteModel>(P, "Cliente_Listar");
        }

        public List<ClienteModel> ListarComboCliente(ClienteModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Nome", oModel.Nome)
            };

            return banco.ExecQuery<ClienteModel>(P, "Cliente_ListarComboCliente");
        }

        public ClienteModel Incluir(ClienteModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@CPF", oModel.CPF),
                new SqlParameter("@Endereco", oModel.Endereco),
                new SqlParameter("@Bairro", oModel.Bairro),
                new SqlParameter("@Municipio", oModel.Municipio),
                new SqlParameter("@UF", oModel.UF),
                new SqlParameter("@CEP", oModel.CEP),
                new SqlParameter("@Complemento", oModel.Complemento),
                new SqlParameter("@Numero", oModel.Numero),
                new SqlParameter("@Telefone", oModel.Telefone),
                new SqlParameter("@Celular", oModel.Telefone),
                new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@Ativo", oModel.Ativo)
    };

            return banco.ExecQueryReturnOne<ClienteModel>(P, "Cliente_Incluir");
        }

        public ClienteModel Alterar(ClienteModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@CPF", oModel.CPF),
                new SqlParameter("@Endereco", oModel.Endereco),
                new SqlParameter("@Bairro", oModel.Bairro),
                new SqlParameter("@Municipio", oModel.Municipio),
                new SqlParameter("@UF", oModel.UF),
                new SqlParameter("@CEP", oModel.CEP),
                new SqlParameter("@Complemento", oModel.Complemento),
                new SqlParameter("@Numero", oModel.Numero),
                new SqlParameter("@Telefone", oModel.Telefone),
                new SqlParameter("@Celular", oModel.Telefone),
                new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQueryReturnOne<ClienteModel>(P, "Cliente_Alterar");
        }
    }
}
