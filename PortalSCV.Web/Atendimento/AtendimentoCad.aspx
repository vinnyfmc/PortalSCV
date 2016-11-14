<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="AtendimentoCad.aspx.cs" Inherits="PortalSCV.Atendimento.AtendimentoCad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Layout/js/plugins/mask/jquery.maskMoney.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $(".money").maskMoney({ prefix: 'R$ ', allowNegative: false, thousands: '', decimal: ',', affixesStay: false });
            $('.hora').mask('00:00');
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Heading -->
    <div class="container-fluid">

        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Cadastro de Atendimento</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <asp:UpdatePanel runat="server" ID="PanelAvisos">
                    <ContentTemplate>
                        <div runat="server" id="AvisoPage" visible="false" class="">
                        </div>
                        <asp:HiddenField runat="server" ID="Atendimento_Id" />
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
                    <label>Agenda</label>
                    <asp:DropDownList runat="server" ID="ddlAgenda" CssClass="form-control" Width="100%"></asp:DropDownList>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Funcionario</label>
                    <asp:DropDownList runat="server" ID="ddlFuncionario" CssClass="form-control" Width="100%"></asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Pedido</label>
                    <asp:DropDownList runat="server" ID="ddlPedido" CssClass="form-control" Width="100%"></asp:DropDownList>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="form-group">
                    <label>Data/Hora</label>
                    <asp:TextBox runat="server" ID="txDataHora" CssClass="form-control hora" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Valor</label>
                    <asp:TextBox runat="server" ID="txValor" CssClass="form-control money" Width="100%"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Descrição</label>
                    <asp:TextBox runat="server" ID="txtDescricao" CssClass="form-control" TextMode="MultiLine" Columns="45" Rows="5" Style="resize: none;"></asp:TextBox>
                </div>
            </div>
        </div>

        <div style="float: right;">
            <asp:Button runat="server" ID="btnCalcelar" CssClass="btn btn-danger" Text="Cancelar"></asp:Button>
            <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
        </div>
    </div>
</asp:Content>
