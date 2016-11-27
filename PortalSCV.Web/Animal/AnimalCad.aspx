<%@ Page Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="AnimalCad.aspx.cs" Inherits="PortalSCV.Layout.Animal.AnimalCad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Layout/js/plugins/mask/jquery.maskMoney.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $('.date').mask('00/00/0000', { placeholder: "__/__/__" });
            $('.cep').mask('00000-000', { reverse: true, placeholder: "_____-___" });
            $('.phone_with_ddd').mask('(00) 0000-00009', { placeholder: "(__)____-____" });
            $('.cpf').mask('000.000.000-00', { reverse: true, placeholder: "___.___.___-__" });
            $('.cnpj').mask('00.000.000/0000-00', { reverse: true, placeholder: "__.___.___/____-__" });
            $(".money").maskMoney({ prefix: 'R$ ', allowNegative: false, thousands: '', decimal: ',', affixesStay: false });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Heading -->
    <div class="container-fluid">

        <div class="row">
            <asp:HiddenField runat="server" ID="CodigoFunc" />
            <div class="col-lg-12">
                <h1 class="page-header">Cadastro de Animal
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
                        <asp:HiddenField runat="server" ID="Animal_Id" />
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
                    <label>Cliente</label>
                    <asp:DropDownList ID="ddlCliente" runat="server" DataTextField="Nome" DataValueField="Codigo" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Nome</label>
                    <asp:TextBox runat="server" ID="txtNome" CssClass="form-control" placeholder="Digite o nome do animal"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="row">
            

            <div class="col-lg-3">
                <div class="form-group">
                    <label>Raça</label>
                    <asp:TextBox runat="server" ID="txtRaca" CssClass="form-control" placeholder="Digite a raça do animal"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-3">
                <div class="form-group">
                    <label>Cor</label>
                    <asp:TextBox runat="server" ID="txtCor" CssClass="form-control" placeholder="Digite a cor do animal"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-2">
                <div class="form-group">
                    <label>Sexo</label>
                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlSexo">
                        <asp:ListItem Value="Selecione" Text="Selecione"></asp:ListItem>
                        <asp:ListItem Value="Masculino" Text="Masculino"></asp:ListItem>
                        <asp:ListItem Value="Feminino" Text="Feminino"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="col-lg-2">
                <div class="form-group">
                    <label>Peso</label>
                    <asp:TextBox runat="server" ID="txtPeso" CssClass="form-control" placeholder="Peso do animal"></asp:TextBox>
                </div>
            </div>

        </div>

        <div class="row">
            
            <div class="col-lg-2">
                <div runat="server" id="Div_DataNascimento" class="form-group">
                    <label>Data de Nascimento</label>
                    <asp:TextBox runat="server" ID="txtDataNascimento" CssClass="form-control date" placeholder="Ex 99/99/9999" TextMode="DateTime"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-2">
                <div class="form-group">
                    <label>Idade</label>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                        <ContentTemplate>
                            <asp:TextBox runat="server" ID="txtIdade" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
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

            <div class="col-lg-6">
                <div class="form-group">
                    <label>Descrição de Doenças/Observações</label>
                    <asp:TextBox runat="server" ID="txtObs" CssClass="form-control" TextMode="MultiLine" Columns="45" Rows="5" Style="resize: none;"></asp:TextBox>
                </div>
            </div>
        </div>

      
        <div style="float: right;">
            <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
        </div>

    </div>

</asp:Content>
