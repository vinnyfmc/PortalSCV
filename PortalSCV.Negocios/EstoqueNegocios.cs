using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PortalSCV.Dominio;
using PortalSCV.DAO;
using PortalSCV.UTIL;

namespace PortalSCV.Negocios
{
    public class EstoqueNegocios
    {
        public List<EstoqueModel> Listar(EstoqueModel oModel)
        {
            EstoqueDAO oDAO = new EstoqueDAO();
            return oDAO.Listar(oModel);
        }

        public EstoqueModel AlterarEstoque(EstoqueModel oModel)
        {
            List<EstoqueModel> oList = new List<EstoqueModel>();
            oList = Listar(oModel);
            if (oList.Count > 0)
            {
                
                if (oModel.Quantidade < 0) //SAIDA DO ESTOQUE
                {
                    if (oList[0].Quantidade + oModel.Quantidade < 0) //Verifica se tem a quantidade em estoque para retirada
                    {
                        oModel.AvisoEstoque = "A quantidade solicitada para este o produto '" + oList[0].Quantidade + oModel.Quantidade + "', ultrapassa a quantidade em estoque. (quantidade em estoque: " + oList[0].Quantidade.ToString() + ".)";
                        return oModel;
                    }
                }

                //Nova quantidade
                oModel.Quantidade = oList[0].Quantidade + oModel.Quantidade;
            }
            else
            {
                if (oModel.Quantidade < 0) //SAIDA DO ESOTOQUE
                {
                    oModel.AvisoEstoque = "O Produto não existe no estoque!";
                    return oModel;
                }
            }

            //ALTERA O ESTOQUE
            EstoqueDAO oDAO = new EstoqueDAO();
            if(oModel.Id.HasValue)
            {
                oDAO.AlterarQuantidade(oModel);
            }else
            {
                oDAO.Incluir(oModel);
            }
            
            if (oList.Count > 0)
            {
                //DISPARA EMAIL INFORMANDO A NECESSIDADE DA COMPRA DO MATERIAL
                if (oModel.Quantidade <= oList[0].QuantidadeMinima)
                {
                    string CorpoEmail = string.Format("Produto: {0} <BR />Limite minimo em estoque: {1} <BR/>Quantidade em estoque: {2} <BR/>Aviso: Providencie com urgência a compra deste produto para manter o estoque abastecido.", oList[0].NomeProduto, oList[0].QuantidadeMinima.ToString(), oModel.Quantidade.ToString());
                    UTIL.UTIL.EnviarEmail("vinnyfmc@gmail.com", "Reposição de material - Aviso Automático", CorpoEmail);
                }
            }

            return oModel;
        }

    }
}
