<%@ Page Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="PerfilAcessoFuncionarioList.aspx.cs" Inherits="PortalSCV.Layout.PerfilAcesso.PerfilAcessoFuncionarioList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../Layout/js/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/ColReorder/js/dataTables.colReorder.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/Scroller/js/dataTables.scroller.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <link href="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" rel="stylesheet" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">

            <div class="col-lg-12">
                <h1 class="page-header">
                    Lista de Perfis de Acesso
                    <asp:LinkButton runat="server" ID="btnNovo" CssClass="btn btn-primary pull-right" Text="Cadastrar Perfil de Acesso" PostBackUrl="~/PerfilAcesso/PerfilAcessoFuncionarioCad.aspx" ></asp:LinkButton>
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
                                <th>Perfil Acesso</th>
                                <th>Funcionário</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="Rpt" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center"><a href="PerfilAcessoFuncionarioCad.aspx?Cod=<%#DataBinder.Eval(Container.DataItem, "Codigo") %>"><%#DataBinder.Eval(Container.DataItem, "Codigo") %></a></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "PerfilAcesso_Nome") %></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "Funcionario_Nome") %></td>
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
