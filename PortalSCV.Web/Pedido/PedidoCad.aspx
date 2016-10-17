<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="PedidoCad.aspx.cs" Inherits="PortalSCV.Pedido.PedidoCad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Heading -->
    <div class="container-fluid">
    
        <div class="row">
            <div class="col-lg-4" style="padding:30px">
                <strong>Data do Pedido:</strong><asp:Label runat="server" ID="DataPedido" Text="29/07/1900 99:99"></asp:Label>
                <br />
                <strong>Status do Pedido:</strong><asp:Label runat="server" ForeColor="Red" ID="StatusPedido" Text="Cancelado"></asp:Label>
                <br />
                <strong>Cadastrado Por:</strong><asp:Label runat="server" ID="Label2" Text="Marcus Vinicius Amaral do Nascimento"></asp:Label>
            </div>
            <div class="col-lg-4">
                <asp:UpdatePanel runat="server" ID="PanelAviso">
                    <ContentTemplate>
                        <h1 style="padding:30px"><strong>
                            Pedido Nr.<asp:Label runat="server" ForeColor="Blue" ID="Label1" Text="0"></asp:Label>
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
                <div class="row" style="">
                    <div class="col-lg-12">
                        <label>Pedido Devolução</label>
                        <div class="form-inline">
                            <asp:TextBox runat="server" ID="txtPedidoComplementar" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <button id="btnDevolucao" class="btn btn-primary" title="Ver Pedido de Devolução.">
                                <i class="fa fa-arrow-circle-right" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Observação</label>
                    <asp:TextBox runat="server" ID="txtObs" CssClass="form-control" TextMode="MultiLine" Columns="45" Rows="5" style="resize:none;"></asp:TextBox>
                </div>
            </div>
        </div>

</asp:Content>
