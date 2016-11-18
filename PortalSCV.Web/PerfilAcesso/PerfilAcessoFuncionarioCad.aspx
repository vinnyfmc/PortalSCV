<%@ Page Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="PerfilAcessoFuncionarioCad.aspx.cs" Inherits="PortalSCV.Layout.PerfilAcesso.PerfilAcessoFuncionarioCad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript" src="../Layout/js/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/ColReorder/js/dataTables.colReorder.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/extensions/Scroller/js/dataTables.scroller.min.js"></script>
    <script type="text/javascript" src="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <link href="../Layout/js/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" rel="stylesheet" />
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Heading -->
    <div class="container-fluid">

        <div class="row">

            <div class="col-lg-12">
                <h1 class="page-header">Cadastro de Perfil de Acesso
                </h1>

            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <asp:UpdatePanel runat="server" ID="PanelAviso">
                    <ContentTemplate>
                        <div runat="server" id="AvisoPage" visible="false" class="">
                        </div>
                        
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-3">
                <div class="form-group">
                    <label>Funcionário</label>
                    <asp:DropDownList ID="ddlFuncionario" runat="server" DataTextField="Nome" DataValueField="Codigo" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlFuncionario_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="form-group">
                    <label>Perfil de Acesso</label>
                    <asp:DropDownList ID="ddlPerfilAcesso" runat="server" DataTextField="Nome" DataValueField="Codigo" CssClass="form-control"></asp:DropDownList>                 
                </div>
            </div>
            <div class="col-lg-3">
                <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Incluir" OnClick="btnSalvar_Click" style="margin-top:26px"></asp:Button>
            </div>
        </div>

        <h4>Perfis de Acesso do Funcionário:</h4>
        <hr />

        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                    <ContentTemplate>
                        <table class="table table-bordered table-hover table-striped" id="tblList">
                            <thead>
                                <tr>
                                    <th>Perfil Acesso</th>
                                    <th>#</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="Rpt" runat="server" OnItemCommand="Rpt_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#DataBinder.Eval(Container.DataItem, "PerfilAcesso_Nome") %></td>
                                            <td>
                                                <asp:HiddenField runat="server" ID="PerfilAcessoFuncionario_Id" Value='<%#DataBinder.Eval(Container.DataItem, "Codigo") %>' />
                                                <asp:LinkButton runat="server" ID="btnRemover_item" Text="<i class='fa fa-trash-o fa-2x'></i>" ToolTip="Remover Item" CommandName="Remover"
                                                    OnClientClick="return confirm('Tem certeza que deseja Remover este item?');" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlFuncionario" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                </div>
            </div>


        
    </div>
</asp:Content>
