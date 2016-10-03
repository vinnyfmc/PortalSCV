<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="FornecedorList.aspx.cs" Inherits="PortalSCV.Fornecedor.FornecedorList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../Layout/js/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/ColReorder/js/dataTables.colReorder.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/Scroller/js/dataTables.scroller.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <link href="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" rel="stylesheet" />
    
    <script type="text/javascript">
        $(document).ready(function () {
            $(".Telefone").mask("(99) 9999-99999");

            var table = $('#tblList');

            var colID = 0;
            var colNome = 1;
            var colTel = 2;
            var colEmail = 3;
            
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
                <h1 class="page-header">
                    Lista de Fornecedores
                    <asp:LinkButton runat="server" ID="btnNovo" CssClass="btn btn-primary pull-right" Text="Cadastrar Fornecedor" PostBackUrl="~/Fornecedor/FornecedorCad.aspx" ></asp:LinkButton>
                </h1>
                    
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped" id="tblList">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nome</th>
                                <th>Telefone</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="Rpt" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center"><a href="FornecedorCad.aspx?Cod=<%#DataBinder.Eval(Container.DataItem, "Codigo") %>"><%#DataBinder.Eval(Container.DataItem, "Codigo") %></a></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "RazaoSocial") %></td>
                                        <td><span class="Telefone"><%#DataBinder.Eval(Container.DataItem, "Contato") %></span></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "Email") %></td>
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
