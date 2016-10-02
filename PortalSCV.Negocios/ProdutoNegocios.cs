using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.DAO;
using PortalSCV.Dominio;
using PortalSCV.UTIL;

namespace PortalSCV.Negocios
{
    public class ProdutoNegocios
    {
        public List<ProdutoModel> Listar(ProdutoModel oModel)
        {
            ProdutoDAO oDAO = new ProdutoDAO();
            return oDAO.Listar(oModel);
        }

        public ProdutoModel Salvar(ProdutoModel oModel)
        {
            ProdutoDAO oDAO = new ProdutoDAO();

            if (oModel.Codigo.HasValue)
            {
                return oDAO.Alterar(oModel);
            }
            else
            {
                return oModel = oDAO.Incluir(oModel);
            }
        }

        public ProdutoModel AlterarEstoque(ProdutoModel oModel)
        {
            List<ProdutoModel> oList = new List<ProdutoModel>();
            oList = Listar(oModel);
            if (oList.Count > 0)
            {

                if (oModel.QuantidadeEstoque < 0) //SAIDA DO ESTOQUE
                {
                    if (oList[0].QuantidadeEstoque + oModel.QuantidadeEstoque < 0) //Verifica se tem a quantidade em estoque para retirada
                    {
                        oModel.AvisoEstoque = "A quantidade solicitada para este o produto '" + oList[0].QuantidadeEstoque + oModel.QuantidadeEstoque + "', ultrapassa a quantidade em estoque. (quantidade em estoque: " + oList[0].QuantidadeEstoque.ToString() + ".)";
                        return oModel;
                    }
                }

                //Nova quantidade
                oModel.QuantidadeEstoque = oList[0].QuantidadeEstoque + oModel.QuantidadeEstoque;
            }
            else
            {
                if (oModel.QuantidadeEstoque < 0) //SAIDA DO ESOTOQUE
                {
                    oModel.AvisoEstoque = "O Produto não existe no estoque!";
                    return oModel;
                }
            }

            //ALTERA O ESTOQUE
            ProdutoDAO oDAO = new ProdutoDAO();
            if (oModel.Codigo.HasValue)
            {
                oDAO.AlterarQuantidadeEstoque(oModel);
            }
            else
            {
                oDAO.Incluir(oModel);
            }

            if (oList.Count > 0)
            {
                //DISPARA EMAIL INFORMANDO A NECESSIDADE DA COMPRA DO MATERIAL
                if (oModel.QuantidadeEstoque <= oList[0].QuantidadeEstoque_Minima)
                {
                    string CorpoEmail = string.Format("Produto: {0} <BR />Limite minimo em estoque: {1} <BR/>Quantidade em estoque: {2} <BR/>Aviso: Providencie com urgência a compra deste produto para manter o estoque abastecido.", oList[0].Descricao, oList[0].QuantidadeEstoque_Minima.ToString(), oModel.QuantidadeEstoque.ToString());
                    UTIL.UTIL.EnviarEmail("vinnyfmc@gmail.com", "Reposição de produto - Aviso Automático", CorpoEmail);
                }
            }

            return oModel;
        }

    }
}
