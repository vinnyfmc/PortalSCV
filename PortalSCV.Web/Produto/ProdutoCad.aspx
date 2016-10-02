<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="ProdutoCad.aspx.cs" Inherits="PortalSCV.Produto.Produto_Cad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript" src="../Layout/js/plugins/maskmoney/jquery.maskMoney.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('.money').maskMoney({ thousands: '', decimal: ',' });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Heading -->
    <div class="container-fluid">
    
        <div class="row">

            <div class="col-lg-12">
                <h1 class="page-header">
                    Cadastro de Produto
                </h1>
                        
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <asp:UpdatePanel runat="server" ID="PanelAviso">
                    <ContentTemplate>
                        <asp:HiddenField runat="server" ID="Produto_Id" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
        
         <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Nome</label>
                    <asp:TextBox runat="server" ID="txDescricao" CssClass="form-control" placeholder="Digite o nome do produto."></asp:TextBox>
                </div>
            </div>
             <div class="col-lg-2">
                <div class="form-group">
                    <label>Cadastrado Por</label>
                    <asp:TextBox runat="server" ID="txCadastradoPor" CssClass="form-control" Enabled="false"></asp:TextBox>
                    <asp:TextBox runat="server" ID="cdFuncionario" CssClass="form-control" Visible="false"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Fornecedor</label>
                    <asp:DropDownList runat="server" CssClass="form-control" ID="cmbFornecedor">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Data de validade</label>
                    <asp:TextBox runat="server" ID="txDataValidade" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Valor de compra</label>
                    <asp:TextBox runat="server" ID="txValorCompra" CssClass="form-control money"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Valor de venda</label>
                    <asp:TextBox runat="server" ID="txValorVenda" CssClass="form-control money"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Qtd. Mínima</label>
                    <asp:TextBox runat="server" ID="txQuantMinima" CssClass="form-control" TextMode="Number"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Qtd. Estoque</label>
                    <asp:TextBox runat="server" ID="txQuantidade" CssClass="form-control" Enabled="false"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-8">
                <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary pull-right" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
            </div>
        </div>

    </div>


</asp:Content>
