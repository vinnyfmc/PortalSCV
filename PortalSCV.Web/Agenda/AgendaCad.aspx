<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="AgendaCad.aspx.cs" Inherits="PortalSCV.Agenda.AgendaCad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Layout/js/plugins/mask/jquery.maskMoney.js"></script>
    <script type="text/javascript">

        $(document).ready(function(){
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
                <h1 class="page-header">
                    Cadastro de Atendimento
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
                        <asp:HiddenField runat="server" ID="Agenda_Id" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <div class="row">
            <%--<div class="col-lg-4">
                <div class="form-group">
                    <label>Cliente</label>
                    <asp:DropDownList runat="server" ID="cmbCliente" CssClass="form-control" Width="100%"></asp:DropDownList>
                </div>
            </div>--%>
             <div class="col-lg-6">
                <div class="form-group">
                    <label>Animal</label>
                    <asp:DropDownList runat="server" ID="cmbAnimal" CssClass="form-control" Width="100%"></asp:DropDownList>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Funcionario</label>
                    <asp:DropDownList runat="server" ID="cmbFuncionario" CssClass="form-control" Width="100%"></asp:DropDownList>
                </div>
            </div>
        </div>
       
        <div class="row">
            <div class="col-lg-4"> 
                <div class="form-group">
                    <label>Data</label>
                    <asp:TextBox runat="server" ID="txData" CssClass="form-control" Width="100%" TextMode="DateTime"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2"> 
                <div class="form-group">
                    <label>Hora Início</label>
                    <asp:TextBox runat="server" ID="txHoraIni" CssClass="form-control hora" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-2"> 
                <div class="form-group">
                    <label>Hora Fim</label>
                    <asp:TextBox runat="server" ID="txHoraFim" CssClass="form-control hora" Width="100%"></asp:TextBox>
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
                    <label>Tipo de Atendimento</label>
                    <asp:TextBox runat="server" ID="txAtendimento" CssClass="form-control" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-6"> 
                <div class="form-group">
                    <label>Descrição do Serviço</label>
                    <asp:TextBox runat="server" ID="txDescrição" CssClass="form-control" Width="100%"></asp:TextBox>
                </div>
            </div>
        </div>

        <div style="float:right;">
            <asp:Button runat="server" ID="btnCalcelar" CssClass="btn btn-danger" Text="Cancelar"></asp:Button>
            <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
        </div>

</asp:Content>
