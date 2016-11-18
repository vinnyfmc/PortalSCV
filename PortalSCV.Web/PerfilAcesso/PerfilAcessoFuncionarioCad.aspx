<%@ Page Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="PerfilAcessoFuncionarioCad.aspx.cs" Inherits="PortalSCV.Layout.PerfilAcesso.PerfilAcessoFuncionarioCad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
                        <asp:HiddenField runat="server" ID="PerfilAcessoFuncionario_Id" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnExcluir" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-3">
                <div class="form-group">
                    <label>Funcionário</label>
                    <asp:DropDownList ID="ddlFuncionario" runat="server" DataTextField="Nome" DataValueField="Codigo" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlFuncionario_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-3">
                <div class="form-group">
                    <label>Perfil de Acesso</label>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlPerfilAcesso" runat="server" DataTextField="Nome" DataValueField="Codigo" CssClass="form-control"></asp:DropDownList>
                    </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlFuncionario" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="btnExcluir" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>


        <div style="float: left;">
            <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
        </div>
    </div>
</asp:Content>
