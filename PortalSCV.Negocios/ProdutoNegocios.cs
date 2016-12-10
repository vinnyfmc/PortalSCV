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

        public string AlterarEstoque(int Codigo_Produto, int Quantidade)
        {
            List<ProdutoModel> oList = new List<ProdutoModel>();
            oList = Listar(new ProdutoModel { Codigo = Codigo_Produto });
            if (oList.Count > 0)
            {
                ProdutoModel Produto = new ProdutoModel();
                Produto = oList[0];
                
                if (Quantidade < 0) //SAIDA DO ESTOQUE
                {
                    if (Produto.QuantidadeEstoque + Quantidade < 0) //Verifica se tem a quantidade em estoque para retirada
                    {
                        return "A quantidade solicitada para este o produto (" + Quantidade.ToString() + "), ultrapassa a quantidade em estoque. (quantidade em estoque: " + Produto.QuantidadeEstoque.ToString() + ".)";
                    }
                }

                //Nova quantidade
                Quantidade = (int)oList[0].QuantidadeEstoque + Quantidade;
                Produto.QuantidadeEstoque = Quantidade;

                ProdutoDAO DAOProduto = new ProdutoDAO();
                DAOProduto.AlterarQuantidadeEstoque(Produto);

                if (oList.Count > 0)
                {
                    //DISPARA EMAIL INFORMANDO A NECESSIDADE DA COMPRA DO MATERIAL
                    if (Quantidade <= Produto.QuantidadeEstoque_Minima)
                    {
                        string CorpoEmail = string.Format("Produto: {0} <BR />Limite minimo em estoque: {1} <BR/>Quantidade em estoque: {2} <BR/>Aviso: Providencie com urgência a compra deste produto para manter o estoque abastecido.", Produto.Descricao, Produto.QuantidadeEstoque_Minima.ToString(), Produto.QuantidadeEstoque);
                        UTIL.UTIL.EnviarEmail("portalscv@gmail.com", "Reposição de produto - Aviso Automático", CorpoEmail);
                    }
                }

            }
            else
            {   
                return "O Produto cód." + Codigo_Produto.ToString() + " não está cadastrado!";
            }
            
            return "OK";
        }

    }
}
