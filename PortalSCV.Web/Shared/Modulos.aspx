<%@ Page Title=".:: SCV - Sistema de Controle Veterinário ::." Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="Modulos.aspx.cs" Inherits="PortalSCV.Shared.Modulos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <body background="../Layout/images/bgTela.jpg" style="margin-top: 0px; background-repeat: repeat-x;" />
    <link rel="icon" href="../Layout/images/Sirea-Animal-Tracks-Dog.ico" />

    <script src="../Layout/js/jquery-2.2.4.min.js" type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="../Layout/css/Site.css" />
    <link rel="stylesheet" type="text/css" href="../Layout/css/style2.css" />
    <link href='http://fonts.googleapis.com/css?family=Terminal+Dosis' rel='stylesheet' type='text/css' />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row" style="padding: 10px">
        <div class="col-lg-4 col-lg-offset-3">
            <div class="im-centered">
                <div id="divModuloNew">
                    <div class="moduleHeader">
                        <asp:ImageButton ID="imgBtnSair" runat="server" ImageUrl="~/images/logout-icon.png" PostBackUrl="../Login/Acesso.aspx" Style="padding-right: 3px; position: relative; left: 70px; top: -60px; display: none;" ToolTip="Sair" CausesValidation="false" Height="16" Width="16" />
                    </div>
                    <div class="moduleContent">
                        <ul class="ca-menu">
                            <li>
                                <a href="#">
                                    <span class="ca-icon">
                                        <img style="padding-top: 10px; width: 100px; height: 80px;" src="../Layout/images/slide-cachorro.png" />
                                    </span>
                                    <div class="ca-content">
                                        <h2 class="ca-main">&nbsp;&nbsp;PET SHOP</h2>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span class="ca-icon">
                                        <img style="padding-top: 10px; width: 90px; height: 90px;" src="../Layout/images/dog-doctor.png" />
                                    </span>
                                    <div class="ca-content">
                                        <h3 class="ca-main">&nbsp;&nbsp;ATENDIMENTO</h3>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="../Funcionario/FuncionarioList.aspx">
                                    <span class="ca-icon">
                                        <img style="padding-top: 10px; width: 100px; height: 80px;" src="../Layout/images/dogwork.png" />
                                    </span>
                                    <div class="ca-content">
                                        <h3 class="ca-main">&nbsp;&nbsp;ADMINISTRATIVO</h3>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="../Login/Acesso.aspx">
                                    <span class="ca-icon">
                                        <img style="padding-top: 10px; width: 70px; height: 70px;" src="../Layout/images/Button-Turn-On-icon.png" /></span>
                                    <div class="ca-content">
                                        <h3 class="ca-main">Sair</h3>
                                    </div>
                                </a>
                            </li>
                        </ul>
                        <div id="divmensagem" runat="server" class="alert alert-info" style="margin: 0 !important;" visible="false">
                            <asp:Label ID="lblmensagem" runat="server" Text="Usuário não possui permissão para este módulo" Font-Bold="True" Font-Size="9pt"></asp:Label>
                        </div>
                    </div>
                    <div class="moduleFooter">
                        <br />
                        <h3>Selecione o Módulo</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
