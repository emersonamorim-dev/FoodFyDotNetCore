<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="FoodFy.User.Registration" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

          <script>
                /*For disappearing alert message*/
                window.onload = function () {
                    var seconds = 5;
                    setTimeout(function () {
                        document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
                }, seconds * 1000);
                };
            </script>
    <script>

        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=ImgUser.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align_self_end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <asp:Label ID="lblHeaderMsg" runat="server" Text="<h2>Registrar Usuário</h2>"></asp:Label>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                       <div>
                        <asp:RequiredFieldValidator ID="rfvNome" runat="server" ErrorMessage="Nome é requerido" ControlToValidate="txtNome"
                            ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtNome" runat="server" CssClass="form-control" placeholder="Digite Nome Completo"
                         ToolTip="Nome Completo"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revNome" runat="server" ErrorMessage="Nome apenas caracteres"
                           ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$" 
                            ControlToValidate="txtNome" >

                        </asp:RegularExpressionValidator>
                       </div>

                       <div>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Usuário é requerido" 
                            ControlToValidate="txtUsername" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                        </asp:RequiredFieldValidator>
                       <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Digite Usuário"
                         ToolTip="Username"></asp:TextBox>

                       </div>

                       <div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="E-mail é requerido" 
                            ControlToValidate="txtEmail" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                        </asp:RequiredFieldValidator>
                       <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Digite E-mail"
                         ToolTip="Digite E-mail" TextMode="Email"></asp:TextBox>

                       </div>

                       <div>

                        <asp:RequiredFieldValidator ID="rfvCelular" runat="server" ErrorMessage="Digite Celular" ControlToValidate="txtCelular"
                            ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                       <asp:TextBox ID="txtCelular" runat="server" CssClass="form-control" placeholder="Digite Número Celular"
                         ToolTip="Digite Celular" TextMode="Number"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revCelular" runat="server" ErrorMessage="Número de Celular 11 digitos"
                           ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{11}$" 
                            ControlToValidate="txtCelular" >

                        </asp:RegularExpressionValidator>
                       </div>
                    </div>
                    
                </div>
                <div class="col-md-6">
                    <div class="form_container">

                         <div>
                        <asp:RequiredFieldValidator ID="rfvEndereco" runat="server" ErrorMessage="Endereço é requerido" ControlToValidate="txtEndereco"
                            ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                       <asp:TextBox ID="txtEndereco" runat="server" CssClass="form-control" placeholder="Digite Endereço"
                         ToolTip="Endereco" TextMode="MultiLine"></asp:TextBox>
                       </div>

                       <div>
                        <asp:RequiredFieldValidator ID="rfvCEP" runat="server" ErrorMessage="CEP é requerido" 
                            ControlToValidate="txtCEP" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                        </asp:RequiredFieldValidator>
                       <asp:TextBox ID="txtCEP" runat="server" CssClass="form-control" placeholder="Digite CEP"
                         ToolTip="Digite CEP" TextMode="Number"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revCEP" runat="server" ErrorMessage="Número do seu CEP"
                           ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{8}$" 
                            ControlToValidate="txtCEP" >

                        </asp:RegularExpressionValidator>

                       </div>

                       <div>
                           <asp:FileUpload ID="fuUserImage" runat="server" CssClass="form-control" ToolTip="Imagem Usuário" onchange="ImagePreview(this);" />
                       </div>

                       <div>
                        <asp:RequiredFieldValidator ID="rfvSenha" runat="server" ErrorMessage="Digite Senha" ControlToValidate="txtSenha"
                            ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtSenha" runat="server" CssClass="form-control" placeholder="Digite Senha"
                         ToolTip="Senha" TextMode="Password"></asp:TextBox>

                       </div>

                    </div>
                </div>
                <div class="row pl-4">
                    <div cll="btn_box">
                        <asp:Button ID="btnRegister" runat="server" Text="Cadastre-se" 
                            CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white" OnClick="btnRegister_Click" />

                        <asp:Label ID="lblAlreadyUser" runat="server" CssClass="pl-3 text-black-100"
                            Text="Já registrado? <a href='Login.aspx' class='badge badge-info'>Entrar</a>">
                            </asp:Label>
                    </div>
                </div>
                <div class="row p-5">
                    <div style="align-items:center">
                        <asp:Image ID="ImgUser" runat="server" CssClass="img-thumbnail" />
                    </div>
                </div>
            </div>
        </div>
    </section>


</asp:Content>
