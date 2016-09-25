<%@ Page Title=".:: SCV - Sistema de Controle Veterinário ::." Language="C#" MasterPageFile="~/Shared/Principal.Master" AutoEventWireup="true" CodeBehind="FuncionarioCad.aspx.cs" Inherits="PortalSCV.Layout.Funcionario.FuncionarioCad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Layout/js/plugins/mask/jquery.maskMoney.js"></script>
    <script type="text/javascript">

        $(document).ready(function(){
            $('.date').mask('00/00/0000', {placeholder: "__/__/__"});
            $('.cep').mask('00000-000', { reverse: true, placeholder: "_____-___" });
            $('.phone_with_ddd').mask('(00) 0000-00009', {placeholder: "(__)____-____"});
            $('.cpf').mask('000.000.000-00', {reverse: true, placeholder: "___.___.___-__"});
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
                <h1 class="page-header">
                    Cadastro de Funcionário
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
                        <asp:HiddenField runat="server" ID="Funcionario_Id" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAlterarSenha" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnSalvar" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Nome</label>
                    <asp:TextBox runat="server" ID="txtNome" CssClass="form-control" placeholder="Digite o nome completo do funcionário"></asp:TextBox>
                </div>
            </div>
             <div class="col-lg-2">
                <div class="form-group">
                    <label>CPF</label>
                    <asp:TextBox runat="server" ID="txtCPF" CssClass="form-control cpf"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-2">
                <div runat="server" id="Div_DataNascimento" class="form-group">
                    <label>Data de Nascimento</label>
                    <asp:TextBox runat="server" ID="txtDataNascimento" CssClass="form-control date" placeholder="Ex 99/99/9999" TextMode="DateTime"></asp:TextBox>
                </div>
            </div>
        </div>
       
        <div class="row">
            <div class="col-lg-2"> 
                <div class="form-group input-group">
                    <label>CEP</label>
                    <asp:TextBox runat="server" ID="txtCEP" CssClass="form-control cep" placeholder="Ex: 99999-999"></asp:TextBox>
                    <span class="input-group-btn" style="vertical-align: bottom;"><asp:LinkButton runat="server" ID="btnCEP" CssClass="btn btn-primary" Text="<i class='fa fa-search'></i>" OnClick="btnCEP_Click" /></span>
                </div>
            </div>
        </div>

        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <div class="row">

                    <div class="col-lg-2"> 
                        <div class="form-group">
                            <label>UF</label>
                            <asp:TextBox runat="server" ID="txtUF" CssClass="form-control" placeholder="Digite a UF"></asp:TextBox>
                        </div>
                    </div>
        
                    <div class="col-lg-4"> 
                        <div class="form-group">
                            <label>Cidade</label>
                            <asp:TextBox runat="server" ID="txtCidade" CssClass="form-control" placeholder="Digite a cidade do funcionário"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-4"> 
                        <div class="form-group">
                            <label>Bairro</label>
                            <asp:TextBox runat="server" ID="txtBairro" CssClass="form-control" placeholder="Digite o bairro do funcionário"></asp:TextBox>
                        </div>
                    </div>

                </div>

                <div class="row">
                            
            <div class="col-lg-4">
                <div class="form-group">
                    <label>Endereço</label>
                    <asp:TextBox runat="server" ID="txtEndereco" CssClass="form-control" placeholder="Digite o endereço do funcionário"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-2">
                <div class="form-group">
                    <label>Número</label>
                    <asp:TextBox runat="server" ID="txtNumEndereco" CssClass="form-control" placeholder="Digite o número"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="form-group">
                    <label>Complemento</label>
                    <asp:TextBox runat="server" ID="txtComplemento" CssClass="form-control" placeholder="Digite o complemento do endereço"></asp:TextBox>
                </div>
            </div>

        </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnCEP" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>

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
                    <asp:TextBox runat="server" ID="txtCelular" CssClass="form-control phone_with_ddd" placeholder="Ex: (99) 99999-9999"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="Digite o email do funcionário" TextMode="Email"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtEmail_Original" CssClass="form-control" Visible="false"></asp:TextBox>
                </div>
            </div>

        </div>
        
        <div class="row">       
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Salário</label>
                    <asp:TextBox runat="server" ID="txSalario" CssClass="form-control money" placeholder="Salário do Funcionário"></asp:TextBox>
                </div>
            </div>
        
            <div class="col-lg-2">
                <div class="form-group">
                    <label>Data de Admissão</label>
                    <asp:TextBox runat="server" ID="txDataAdmissao" CssClass="form-control date" placeholder="Ex 99/99/9999" TextMode="DateTime"></asp:TextBox>
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

        <div style="float:right;">
            <asp:Button runat="server" ID="btnAlterarSenhaModal" ClientIDMode="Static" CssClass="btn btn-primary" Text="Alterar Senha" Visible="false"></asp:Button>
            <asp:Button runat="server" ID="btnSalvar" CssClass="btn btn-primary" Text="Salvar" OnClick="btnSalvar_Click"></asp:Button>
        </div>

    </div>


    <div class="modal fade" id="ModalAlterarSenha" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Alterar Senha</h4>
                </div>
                <div class="modal-body" >
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Senha</label>
                                <asp:TextBox runat="server" ID="txPass" CssClass="form-control" placeholder="Digite sua senha." TextMode="Password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Confirma Senha</label>
                                <asp:TextBox runat="server" ID="txPassConfirm" CssClass="form-control" placeholder="Digite sua senha." TextMode="Password"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <asp:Button runat="server" ID="btnAlterarSenha" CssClass="btn btn-primary" Text="Confirmar" OnClick="btnAlterarSenha_Click"></asp:Button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

</asp:Content>
