<%@ Page Title=".:: SCV - Sistema de Controle Veterinário ::." Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="Acesso.aspx.cs" Inherits="PortalSCV.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <body background="../Layout/images/bgTela.jpg" style="margin-top: 0px; background-repeat: repeat-x;" />

    <script type="text/javascript">
        $(document).ready(function () {

            $("#_btEsqueceuSenha").on('click', function () {

                if ($("#txUser").val().trim().length == 0) {
                    $(document).MensagemModal(3, 'Digite seu <strong>e-mail</strong>.');
                } else {
                    $("#MsgChangePass").html('Será enviado uma nova senha para o e-mail <strong>' + $("#txUser").val().trim() + '</strong> em instantes. <br \>Clique em Confirmar para prosseguir.');
                    $("#ModalReenviarSenha").modal('toggle');
                }

                return false;
            });

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row" style="margin-top:13%">
        <div class="col-lg-4 col-lg-offset-3">
            <div class="panel panel-default">

                <div class="panel-heading">Login</div>
                
                <div class="panel-body">
                    <asp:UpdatePanel runat="server" ID="PanelAviso">
                        <ContentTemplate>
                            <div class="" runat="server" id="txAviso" visible="false">
                                
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btLogar" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btEsqueceuSenha" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    
                    <div class="form-group">
                        <label>E-mail</label>
                        <asp:TextBox runat="server" ID="txUser" CssClass="form-control" ClientIDMode="Static" placeholder="Digite seu e-mail." TextMode="Email"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Senha</label>
                        <asp:TextBox runat="server" ID="txPass" CssClass="form-control" placeholder="Digite sua senha." TextMode="Password"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <a href="#" id="_btEsqueceuSenha">Esqueceu sua senha?</a>
                    </div>

                </div>

                <div class="panel-footer">
                    <div class="row">
                        <div class="col-lg-4 col-lg-offset-8">
                            <asp:Button runat="server" ID="btLogar" CssClass="btn btn-primary" Text="Acessar" OnClick="btLogar_Click"></asp:Button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    
     <div class="modal fade" id="ModalReenviarSenha" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Esqueceu sua senha?</h4>
                </div>
                <div class="modal-body" >
                    <div id="MsgChangePass" class="alert alert-warning">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <asp:Button runat="server" ID="btEsqueceuSenha" CssClass="btn btn-primary" Text="Confirmar" OnClick="btEsqueceuSenha_Click"></asp:Button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

</asp:Content>
