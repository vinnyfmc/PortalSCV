<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="PedidoCad.aspx.cs" Inherits="PortalSCV.Pedido.PedidoCad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript" src="../Layout/js/plugins/mask/jquery.maskMoney.js"></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Heading -->
    <div class="container-fluid">
    
        <div class="row">
            <div class="col-lg-4" style="padding:30px">
                <div id="InfoPedido">
                    <strong>Data do Pedido:</strong><asp:Label runat="server" ID="txDataPedido" Text=""></asp:Label>
                    <br />
                    <strong>Status do Pedido:</strong><asp:Label runat="server" ForeColor="Red" ID="txStatusPedido" Text=""></asp:Label>
                    <br />
                    <strong>Cadastrado Por:</strong><asp:Label runat="server" ID="txCadastradoPor" Text="" ></asp:Label>
                    <asp:HiddenField runat="server" ID="CodigoFunc" />
                </div>
            </div>
            <div class="col-lg-4">
                <asp:UpdatePanel runat="server" ID="PanelAviso">
                    <ContentTemplate>
                        <h1 style="padding:30px"><strong>
                            Pedido Nr.<asp:Label runat="server" ForeColor="Blue" ID="CodigoPedido" Text="0"></asp:Label>
                        </strong></h1>
                    </ContentTemplate>
                    <Triggers>
                        <%--<asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-6">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label>Tipo do Pedido</label>
                            <asp:DropDownList runat="server" ID="cmbTipoPedido" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <%--<div class="row" style="">
                    <div class="col-lg-12">
                        <label>Pedido Devolução</label>
                        <div class="form-inline">
                            <asp:TextBox runat="server" ID="txtPedidoComplementar" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <button id="btnDevolucao" class="btn btn-primary" title="Ver Pedido de Devolução.">
                                <i class="fa fa-arrow-circle-right" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>--%>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Observação</label>
                    <asp:TextBox runat="server" ID="txtObs" CssClass="form-control" TextMode="MultiLine" Columns="45" Rows="2" style="resize:none;"></asp:TextBox>
                </div>
            </div>
        </div>

        <div id="tblItensCabecalho" runat="server" class="row">
            <div class="col-lg-12">
                <h3 class="page-header" runat="server" id="H3">
                    Itens do Pedido
                    <i style="float:right; font-size:small; margin-right:40px; margin-top:15px;">
                    </i>
                </h3>
            </div>
        </div>

        <div id="tblItens" runat="server" class="row col-lg-12"><!--Tabela Itens-->
                            
            <div class="panel panel-default">
                        
                <div class="panel-body">
            
                    <div runat="server" id="div_add_item" style="margin-bottom:30px;">

                        <div class="row">
                            <div class="col-lg-5">
                                <div class="form-group" >
                                    <label>Produto</label>
                                    <asp:DropDownList runat="server" CssClass="form-control chosen-select" ID="ddlProduto" Width="90%" AutoPostBack="true" OnSelectedIndexChanged="ddlProduto_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="form-group" >
                                    <label>Quant.</label>
                                    <asp:TextBox runat="server" ID="txQuantidade" CssClass="form-control" TextMode="Number" Width="100px"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="form-group" >
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" ClientIDMode="Static" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                        <ContentTemplate>
                                            <label>Valor</label>
                                            <asp:TextBox runat="server" ID="vlProduto" CssClass="form-control" Width="100px"></asp:TextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlProduto" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group" >
                                    <asp:Button runat="server" ID="btnIncluirItem" CssClass="btn btn-primary pull-left" style="margin-top:25px" Text="Incluir" OnClick="btnIncluirItem_Click" />
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="dataTable_wrapper row col-lg-12"">

                        <asp:UpdatePanel ID="UpdPanelTableItens" runat="server" ClientIDMode="Static" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <ContentTemplate>
                           
                            <div class="alert alert-danger alert-dismissable" style="width:500px; padding:4px;" runat="server" id="DivAvisoItensPedido" visible="false">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <asp:Label runat="server" ID="AvisoItensPedido"></asp:Label>
                            </div>

                            <table class="table table-striped table-bordered table-hover" id="tblItensPedido">
                                <thead>
                                    <tr>
                                        <th style="display:none;">#</th>
                                        <th>Produto</th>
                                        <th>Quantidade</th>
                                        <th>Valor</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <asp:Repeater ID="RptItensPedido" runat="server" OnItemCommand="RptItensPedido_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td style="display:none;">
                                                    <asp:HiddenField runat="server" ID="idPedido_item" Value='<%#DataBinder.Eval(Container.DataItem, "Codigo_Pedido") %>' />
                                                    <asp:HiddenField runat="server" ID="Codigo" Value='<%#DataBinder.Eval(Container.DataItem, "Codigo") %>' />
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="DescricaoProduto" Text='<%#DataBinder.Eval(Container.DataItem, "DescricaoProduto") %>'></asp:Label>
                                                    <asp:HiddenField runat="server" ID="Codigo_Produto" Value='<%#DataBinder.Eval(Container.DataItem, "Codigo_Produto") %>' />
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="txQuantidade" Text='<%#DataBinder.Eval(Container.DataItem, "Quantidade") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="txValorUnitario" Text='<%# String.Format("{0:f2}",DataBinder.Eval(Container.DataItem, "ValorUnitario"))%>'></asp:Label>
                                                </td>
                                                <td>
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
                            <asp:AsyncPostBackTrigger ControlID="btnIncluirItem" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnExcluir" EventName="Click" />
                        </Triggers>
                        </asp:UpdatePanel>

                    </div>

                </div>

            </div>

        </div>

        <div id="DivBotoes" style="margin:5px" runat="server">
            <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Salvar" OnClick="btnSalvar_Click" />
            <asp:Button runat="server" ID="btnExcluir" CssClass="btn btn-danger" Text="Excluir" OnClick="btnExcluir_Click" 
                    OnClientClick="return confirm('Tem certeza que deseja excluir este registro?');"/>
        </div>

    </div>
</asp:Content>
