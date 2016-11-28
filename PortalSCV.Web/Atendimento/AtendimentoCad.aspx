<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="AtendimentoCad.aspx.cs" Inherits="PortalSCV.Atendimento.AtendimentoCad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../Layout/js/plugins/mask/jquery.maskMoney.js"></script>
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

        <asp:HiddenField runat="server" ID="CodigoFunc" />

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
                    <asp:DropDownList runat="server" ID="ddlAgenda" CssClass="form-control" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="ddlAgenda_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
            <%--<asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>--%>
                    <asp:HiddenField runat="server" ID="Codigo_Agenda" />
                    <div class="col-lg-2"> 
                        <div class="form-group">
                            <label>Data</label>
                            <asp:TextBox runat="server" ID="txData" CssClass="form-control" Width="100%" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-lg-1"> 
                        <div class="form-group">
                            <label>Hr Início</label>
                            <asp:TextBox runat="server" ID="txHora" CssClass="form-control hora" Width="100%"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-lg-2"> 
                        <div class="form-group">
                            <label>Valor</label>
                            <asp:TextBox runat="server" ID="txValor" CssClass="form-control money" Width="100%"></asp:TextBox>
                        </div>
                    </div>
                <%--</ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlAgenda" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>--%>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="form-group">
                    <label>Descrição</label>
                    <asp:TextBox runat="server" ID="txtDescricao" CssClass="form-control" TextMode="MultiLine" Columns="45" Rows="3" Style="resize: none;"></asp:TextBox>
                </div>
            </div>
        </div>

        <div style="float: right;">
            <asp:Button runat="server" ID="btnCalcelar" CssClass="btn btn-danger" Text="Cancelar"></asp:Button>
            <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
        </div>
    </div>
</asp:Content>
