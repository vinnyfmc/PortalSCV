using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortalSCV.Dominio;
using PortalSCV.Negocios;

namespace PortalSCV.Caixa
{
    public partial class CaixaList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                for(int i=1;i<= 12; i++)
                {
                    switch(i)
                    {
                        case 1:
                            cmbMes.Items.Add(new ListItem { Text = "Janeiro", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 2:
                            cmbMes.Items.Add(new ListItem { Text = "Fevereiro", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 3:
                            cmbMes.Items.Add(new ListItem { Text = "Março", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 4:
                            cmbMes.Items.Add(new ListItem { Text = "Abril", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 5:
                            cmbMes.Items.Add(new ListItem { Text = "Maio", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 6:
                            cmbMes.Items.Add(new ListItem { Text = "Junho", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 7:
                            cmbMes.Items.Add(new ListItem { Text = "Julho", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 8:
                            cmbMes.Items.Add(new ListItem { Text = "Agosto", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 9:
                            cmbMes.Items.Add(new ListItem { Text = "Setembro", Value = DateTime.Now.Year.ToString() + "-0" + i.ToString() + "-01" });
                            break;
                        case 10:
                            cmbMes.Items.Add(new ListItem { Text = "Outubro", Value = DateTime.Now.Year.ToString() + "-" + i.ToString() + "-01" });
                            break;
                        case 11:
                            cmbMes.Items.Add(new ListItem { Text = "Novembro", Value = DateTime.Now.Year.ToString() + "-" + i.ToString() + "-01" });
                            break;
                        case 12:
                            cmbMes.Items.Add(new ListItem { Text = "Dezembro", Value = DateTime.Now.Year.ToString() + "-" + i.ToString() + "-01" });
                            break;
                    }
                    
                }

                String ano = DateTime.Now.Year.ToString();
                String mes = DateTime.Now.Month.ToString();
                if (mes.Length == 1)
                    mes = "0" + mes;

                String DataHoje = ano + "-" + mes + "-01";
                cmbMes.SelectedValue = DataHoje;
                
                
                btnFiltrar_Click(null, null);

            }
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            CaixaModel oCaixa = new CaixaModel();
            oCaixa.Data = DateTime.Parse(cmbMes.SelectedValue);
            oCaixa.DataFim = DateTime.Parse(cmbMes.SelectedValue).AddMonths(1);

            List<CaixaModel> oList = new List<CaixaModel>();
            oList = new CaixaNegocios().Listar(oCaixa);

            decimal R_Venda = 0;
            decimal R_Atendimento = 0;
            decimal D_Compra = 0;
            decimal D_Atendimento = 0;
            decimal D_Funcionario = 0;

            foreach (CaixaModel c in oList)
            {
                switch(c.Origem)
                {
                    case 1:
                        R_Venda += (decimal)c.Valor;
                        break;
                    case 2:
                        R_Atendimento += (decimal)c.Valor;
                        break;
                    case 3:
                        D_Compra += (decimal)c.Valor;
                        break;
                    case 4:
                        D_Atendimento += (decimal)c.Valor;
                        break;
                    case 5:
                        D_Funcionario += (decimal)c.Valor;
                        break;
                }
            }

            ReceitaVendas.Text = R_Venda.ToString("0.00");
            ReceitaAtendimentos.Text = R_Atendimento.ToString("0.00");
            DespesaCompras.Text = D_Compra.ToString("0.00");
            DespesaAtendimentos.Text = D_Atendimento.ToString("0.00");
            DespesaSalarios.Text = D_Funcionario.ToString("0.00");
            
            if (oList.Count > 0)
            {
                Rpt.DataSource = oList;
                Rpt.DataBind();
            }
        }

        
    }
}