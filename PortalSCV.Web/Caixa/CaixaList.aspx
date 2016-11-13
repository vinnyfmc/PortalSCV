<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="CaixaList.aspx.cs" Inherits="PortalSCV.Caixa.CaixaList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript" src="../Layout/js/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/ColReorder/js/dataTables.colReorder.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/Scroller/js/dataTables.scroller.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <link href="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" rel="stylesheet" />
    <script type="text/javascript" src="../Layout/js/plugins/mask/jquery.maskMoney.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".money").maskMoney({ prefix: 'R$ ', allowNegative: false, thousands: '', decimal: ',', affixesStay: false });

            var table = $('#tblList');

            var colID = 0;
            var colData = 1;
            var colValor = 2;
            var colDescricao = 3;
           
            var oTable = table.dataTable({
                "language": {
                    "aria": {
                        "sortAscending": ": activate to sort column ascending",
                        "sortDescending": ": activate to sort column descending"
                    },
                    "emptyTable": "Nenhum registro foi encontrado",
                    "info": "Mostrando _START_ até _END_ de _TOTAL_ registro(s)",
                    "infoEmpty": "Nenhum entrada foi encontrada",
                    "infoFiltered": "(Filtrado de _MAX_ registros)",
                    "lengthMenu": "Exibir Registros _MENU_ ",
                    "search": "Procurar:",
                    "zeroRecords": "Nenhum registro foi encontrado"
                },
                "order": [
                    [colID, 'dsc']
                ],
                "lengthMenu": [
                    [5, 10, 15, 20, -1],
                    [5, 10, 15, 20, "Todos"] // change per page values here
                ],
                "pageLength": 20 // set the initial value,
                
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">

            <div class="col-lg-12">
                <h3 class="page-header">
                    Mês
                    <asp:DropDownList runat="server" ID="cmbMes" Width="300px"></asp:DropDownList>

                    <asp:LinkButton runat="server" ID="btnFiltrar" CssClass="btn btn-sm btn-primary" OnClick="btnFiltrar_Click">
                        <i class="fa fa-search" aria-hidden="true"></i>
                    </asp:LinkButton>

                </h3>
            </div>
        </div>
        <!-- /.row -->
        
        <div class="row">
            <div class="col-lg-12">
                <h4>Resumido</h4>
                <hr />
            </div>
        </div>

        <div class="row">
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Vendas</label>
                    <asp:TextBox runat="server" ID="ReceitaVendas" CssClass="form-control money" Enabled="false"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Atendimentos</label>
                    <asp:TextBox runat="server" ID="ReceitaAtendimentos" CssClass="form-control money" Enabled="false"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Compras</label>
                    <asp:TextBox runat="server" ID="DespesaCompras" CssClass="form-control money" Enabled="false"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Desp. Atendimentos</label>
                    <asp:TextBox runat="server" ID="DespesaAtendimentos" CssClass="form-control money" Enabled="false"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Salários</label>
                    <asp:TextBox runat="server" ID="DespesaSalarios" CssClass="form-control money" Enabled="false"></asp:TextBox>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-12">
                <h4>Detalhado</h4>
                <hr />
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped" id="tblList">
                        <thead>
                            <tr>
                                <th>Data</th>
                                <th>Valor</th>
                                <th>Descrição</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="Rpt" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%#DataBinder.Eval(Container.DataItem, "Data", "{0:dd/MM/yyyy hh:mm:ss tt}") %></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "Valor", "{0:c}") %></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "Descricao") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    
    
    </div>
</asp:Content>
