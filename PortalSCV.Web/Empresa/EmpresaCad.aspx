<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="EmpresaCad.aspx.cs" Inherits="PortalSCV.Empresa.EmpresaCad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {
            $('.date').mask('00/00/0000', { placeholder: "__/__/__" });
            $('.cep').mask('00000-000', { reverse: true, placeholder: "_____-___" });
            $('.phone_with_ddd').mask('(00) 0000-00009', { placeholder: "(__)____-____" });
            $('.cpf').mask('000.000.000-00', { reverse: true, placeholder: "___.___.___-__" });
            $('.cnpj').mask('00.000.000/0000-00', { reverse: true, placeholder: "__.___.___/____-__" });
            $(".money").maskMoney({ prefix: 'R$ ', allowNegative: false, thousands: '', decimal: ',', affixesStay: false });

            $("#btnAlterarSenhaModal").on('click', function () {

                $("#ModalAlterarSenha").modal('toggle');

                return false;
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Heading -->
    <div class="container-fluid">

        <div class="row">

            <div class="col-lg-12">
                <h1 class="page-header">Cadastro da Empresa
                </h1>

            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <asp:UpdatePanel runat="server" ID="PanelAviso">
                    <ContentTemplate>
                        <asp:HiddenField runat="server" ID="Empresa_Id" />
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
                    <asp:TextBox runat="server" ID="txtRazaoSocial" CssClass="form-control" Enabled="false" placeholder="Digite a razão social do Empresa"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>CNPJ</label>
                    <asp:TextBox runat="server" ID="txtCNPJ" Enabled="false" CssClass="form-control cnpj"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Nome Fantasia</label>
                    <asp:TextBox runat="server" ID="txtNomeFantasia" CssClass="form-control" placeholder="Digite o nome fantasia do Empresa" ></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="row">

            <div class="col-lg-2">
                <div class="form-group">
                    <label>UF</label>
                    <asp:TextBox runat="server" ID="txtUF" CssClass="form-control" placeholder="Digite a UF" MaxLength="2" ></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="form-group">
                    <label>Cidade</label>
                    <asp:TextBox runat="server" ID="txtCidade" CssClass="form-control" placeholder="Digite a cidade da empresa" ></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="form-group">
                    <label>Bairro</label>
                    <asp:TextBox runat="server" ID="txtBairro" CssClass="form-control" placeholder="Digite o bairro da empresa" ></asp:TextBox>
                </div>
            </div>

        </div>

        <div class="row">

            <div class="col-lg-4">
                <div class="form-group">
                    <label>Endereço</label>
                    <asp:TextBox runat="server" ID="txtEndereco" CssClass="form-control" placeholder="Digite o endereço da empresa" ></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-2">
                <div class="form-group">
                    <label>Número</label>
                    <asp:TextBox runat="server" ID="txtNumEndereco" CssClass="form-control" placeholder="Digite o número" ></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="form-group">
                    <label>Complemento</label>
                    <asp:TextBox runat="server" ID="txtComplemento" CssClass="form-control" placeholder="Digite o complemento do endereço" ></asp:TextBox>
                </div>
            </div>

        </div>


        <div class="row">

            <div class="col-lg-2">
                <div class="form-group">
                    <label>Telefone</label>
                    <asp:TextBox runat="server" ID="txtTelefone" CssClass="form-control phone_with_ddd" placeholder="Ex: (99) 99999-9999"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-2">
                <div class="form-group">
                    <label>Celular</label>
                    <asp:TextBox runat="server" ID="txtCelular" CssClass="form-control phone_with_ddd" placeholder="Ex: (99) 99999-9999" ></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="Digite o email da empresa" TextMode="Email"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtEmail_Original" CssClass="form-control" Visible="false"></asp:TextBox>
                </div>
            </div>

        </div>

        <div class="row">
            

            <%--<div class="col-lg-2">
                <div class="form-group">
                    <label>Status</label>
                    <asp:DropDownList runat="server" CssClass="form-control" ID="cbStatus">
                        <asp:ListItem Text="Ativo" Value="True" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Inativo" Value="False"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>--%>
        </div>

        <div style="float: right;">
            <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
        </div>

    </div>

</asp:Content>
