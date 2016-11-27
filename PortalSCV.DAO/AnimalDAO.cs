using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using System.Data.SqlClient;

namespace PortalSCV.DAO
{
    public class AnimalDAO
    {
        public List<AnimalModel> Listar(AnimalModel oModel)
        {
            DB banco = new DB();

            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_Cliente", oModel.Codigo_Cliente),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@Raca", oModel.Raca),
                new SqlParameter("@Cor", oModel.Cor),
                new SqlParameter("@Peso", oModel.Peso),
                new SqlParameter("@Sexo", oModel.Sexo),
                new SqlParameter("@DescricaoDoencas", oModel.DescricaoDoencas),
                new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@DataCadastro", oModel.DataCadastro),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQuery<AnimalModel>(P, "Animal_Listar");
        }

        public AnimalModel Incluir(AnimalModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo_Cliente", oModel.Codigo_Cliente),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@Raca", oModel.Raca),
                new SqlParameter("@Cor", oModel.Cor),
                new SqlParameter("@Peso", oModel.Peso),
                new SqlParameter("@Sexo", oModel.Sexo),
                new SqlParameter("@DescricaoDoencas", oModel.DescricaoDoencas),
                new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQueryReturnOne<AnimalModel>(P, "Animal_Incluir");
        }

        public AnimalModel Alterar(AnimalModel oModel)
        {
            DB banco = new DB();
            SqlParameter[] P = {
                new SqlParameter("@Codigo", oModel.Codigo),
                new SqlParameter("@Codigo_Cliente", oModel.Codigo_Cliente),
                new SqlParameter("@Codigo_Funcionario", oModel.Codigo_Funcionario),
                new SqlParameter("@Nome", oModel.Nome),
                new SqlParameter("@Raca", oModel.Raca),
                new SqlParameter("@Cor", oModel.Cor),
                new SqlParameter("@Peso", oModel.Peso),
                new SqlParameter("@Sexo", oModel.Sexo),
                new SqlParameter("@DescricaoDoencas", oModel.DescricaoDoencas),
                new SqlParameter("@DataNascimento", oModel.DataNascimento),
                new SqlParameter("@Ativo", oModel.Ativo)
            };

            return banco.ExecQueryReturnOne<AnimalModel>(P, "Animal_Alterar");
        }
    }
}
