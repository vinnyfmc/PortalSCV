<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="FornecedorCad.aspx.cs" Inherits="PortalSCV.Fornecedor.FornecedorCad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        $(document).ready(function(){
            $('.date').mask('00/00/0000', {placeholder: "__/__/__"});
            $('.cep').mask('00000-000', { reverse: true, placeholder: "_____-___" });
            $('.phone_with_ddd').mask('(00) 0000-00009', {placeholder: "(__)____-____"});
            $('.cpf').mask('000.000.000-00', {reverse: true, placeholder: "___.___.___-__"});
            $('.cnpj').mask('00.000.000/0000-00', { reverse: true, placeholder: "__.___.___/____-__" });
            $(".money").maskMoney({ prefix: 'R$ ', allowNegative: false, thousands: '', decimal: ',', affixesStay: false });


        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <!-- Page Heading -->
    <div class="container-fluid">
    
        <div class="row">

            <div class="col-lg-12">
                <h1 class="page-header">
                    Cadastro de Fornecedor
                </h1>
                        
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <asp:UpdatePanel runat="server" ID="PanelAviso">
                    <ContentTemplate>
                        <asp:HiddenField runat="server" ID="Fornecedor_Id" />
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
                    <label>Razão Social</label>
                    <asp:TextBox runat="server" ID="txtRazaoSocial" CssClass="form-control" placeholder="Digite a razão social do Fornecedor"></asp:TextBox>
                </div>
            </div>
        </div>
       
        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Nome Fantasia</label>
                    <asp:TextBox runat="server" ID="txtNomeFantasia" CssClass="form-control" placeholder="Digite o nome fantasia do Fornecedor"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="form-group"> 
                    <label>Email</label>
                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" placeholder="Digite o E-Mail do Fornecedor"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-2">
                <div class="form-group"> 
                    <label>CNPJ</label>
                    <asp:TextBox runat="server" ID="txtCNPJ" CssClass="form-control cnpj"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group"> 
                    <label>Telefone</label>
                    <asp:TextBox runat="server" ID="txtTelefone" CssClass="form-control phone_with_ddd"></asp:TextBox>
                </div>
            </div>
            
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Status</label>
                    <asp:DropDownList runat="server" CssClass="form-control" ID="cbStatus">
                        <asp:ListItem Text="Ativo" Value="True" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Inativo" Value="False"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary pull-right" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
            </div>
        </div>
    
    </div>

</asp:Content>
