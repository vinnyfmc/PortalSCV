<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="ProdutoList.aspx.cs" Inherits="PortalSCV.Produto.Produto_List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript" src="../Layout/js/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    
    <script type="text/javascript" src="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <link href="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {

            var table = $('#tblProdutos');

            var colID = 0;
            var colNome = 1;
            var colVlSugerido = 2;
            var colStatus = 3;
            var colCategoria = 4;
            var colMarca = 5;


            var oTable = table.dataTable({
                "language": {
                    "aria": {
                        "sortAscending": ": activate to sort column ascending",
                        "sortDescending": ": activate to sort column descending"
                    },
                    "emptyTable": "Nenhum registro foi encontrado",
                    "info": "Mostrando _START_ até _END_ de _TOTAL_ registros",
                    "infoEmpty": "Nenhum entrada foi encontrada",
                    "infoFiltered": "(Filtrado de _MAX_ registros)",
                    "lengthMenu": "Mostrando _MENU_ registros",
                    "search": "Procurar:",
                    "zeroRecords": "Nenhum registro foi encontrado"
                },
                "order": [
                    [colNome, 'asc']
                ],
                "lengthMenu": [
                    [5, 10, 15, 20, -1],
                    [5, 10, 15, 20, "Todos"] // change per page values here
                ],
                "pageLength": 10 // set the initial value,
                //"columnDefs": [{  // set default column settings
                //    'orderable': false,
                //    'targets': [colDtModif, colDel, colEdit]
                //}]
            });


        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">

            <div class="col-lg-12">
                <h1 class="page-header">
                    Lista de Produtos
                    <asp:LinkButton runat="server" ID="btnNovo" CssClass="btn btn-primary pull-right" Text="Cadastrar Produto" PostBackUrl="~/Produto/ProdutoCad.aspx" ></asp:LinkButton>
                </h1>
                    
            </div>
        </div>
        <!-- /.row -->

        <!-- /.row -->
       <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover" id="tblProdutos">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nome</th>
                                <th>Quant. Estoque</th>
                                <th>Preço Compra</th>
                                <th>Preço Venda</th>
                            </tr>
                        </thead>
                        <tbody>

                            <asp:Repeater ID="RptProdutos" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center"><a href="ProdutoCad.aspx?Cod=<%#DataBinder.Eval(Container.DataItem, "Codigo") %>"><%#DataBinder.Eval(Container.DataItem, "Codigo") %></a></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "Descricao") %></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "QuantidadeEstoque") %></td>
                                        <td class="right"><%# DataBinder.Eval(Container.DataItem, "PrecoCompra", "{0:C}") %></td>
                                        <td class="right"><%# DataBinder.Eval(Container.DataItem, "PrecoVenda", "{0:C}") %></td>
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
