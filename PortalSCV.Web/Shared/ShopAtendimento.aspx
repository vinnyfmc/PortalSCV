<%@ Page Title=".:: SCV - Sistema de Controle Veterinário ::." Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="ShopAtendimento.aspx.cs" Inherits="PortalSCV.Shared.ShopAtendimento" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <body background="../Layout/images/bgTela.jpg" style="margin-top: 0px; background-repeat: repeat-x;" />
    <link rel="icon" href="../Layout/images/Sirea-Animal-Tracks-Dog.ico" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row" style="margin-top:50px">
        <div class="col-lg-7">
            <a href="#" >
                <img src="../Layout/images/slide-cachorro.png" width="300" height="174" alt="Shop" />
            </a>
            <h1 style="margin-left:100px">VENDAS</h1>
        </div>
        <div class="col-lg-5">
            <a href="#" >
                <img src="../Layout/images/dog-doctor.png" width="174" height="174"  alt="Atendimento" />
            </a>
            <h1>ATENDIMENTOS</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-4 col-lg-offset-3">
            <a href="../Funcionario/FuncionarioList.aspx" >
                <img src="../Layout/images/dogwork.png" width="302" height="174"  alt="Administrativo" />
            </a>
            <h1>ADMINISTRATIVO</h1>
        </div>
    </div>
</asp:Content>
