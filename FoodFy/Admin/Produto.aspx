<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Produto.aspx.cs" Inherits="FoodFy.Admin.Produto" %>
<%@ Import Namespace="FoodFy" %>

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
                    $('#<%=imgProduto.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

       <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>

        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <!-- Statestics Start -->
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">

                                        <div class="col-sm6 col-md-4 col-lg-4">
                                            <h4 class="sub-title">Produto</h4>
                                            
                                            <div>
                                                <div class="form-group">
                                                    <label>Nome do Produto</label>
                                                    <div>
                                                        <asp:TextBox ID="txtNome" runat="server" CssClass="form-control"
                                                            placeholder="Digite Nome do Produto"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                            ErrorMessage="Nome é requerido" ForeColor="Red" Display="Dynamic" 
                                                            SetFocusOnError="true" ControlToValidate="txtNome">
                                                        </asp:RequiredFieldValidator>

                                                        <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                    </div>
                                                </div>

                                             <div class="form-group">
                                                    <label>Descrição do Produto</label>
                                                    <div>
                                                        <asp:TextBox ID="txtDescricao" runat="server" CssClass="form-control"
                                                            placeholder="Digite Descrição do Produto" TextMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                            ErrorMessage="Descrição é requerido" ForeColor="Red" Display="Dynamic" 
                                                            SetFocusOnError="true" ControlToValidate="txtDescricao">
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                    <div class="form-group">
                                                    <label>Preço do Produto(R$)</label>
                                                    <div>
                                                        <asp:TextBox ID="txtPreco" runat="server" CssClass="form-control"
                                                            placeholder="Digite Preço do Produto"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                            ErrorMessage="Preço é requerido" ForeColor="Red" Display="Dynamic" 
                                                            SetFocusOnError="true" ControlToValidate="txtPreco">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                            ErrorMessage="Preço valor decimal" ForeColor="Red" Display="Dynamic" 
                                                            SetFocusOnError="true" ControlToValidate="txtPreco" 
                                                            ValidationExpression="^\d{0,8}(\.\d{1,4})?$">
                                                        </asp:RegularExpressionValidator>
                                                    </div>
                                                </div>

                                                    <div class="form-group">
                                                    <label>Quantidade do Produto</label>
                                                    <div>
                                                        <asp:TextBox ID="txtQuantidade" runat="server" CssClass="form-control"
                                                            placeholder="Digite Quantidade do Produto"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                            ErrorMessage="Quantidade é requerido" ForeColor="Red" Display="Dynamic" 
                                                            SetFocusOnError="true" ControlToValidate="txtQuantidade">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                                            ErrorMessage="Quantidade não pode ser negativo" ForeColor="Red" Display="Dynamic" 
                                                            SetFocusOnError="true" ControlToValidate="txtQuantidade" 
                                                            ValidationExpression="^([1-9]\d*|0)$">
                                                        </asp:RegularExpressionValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Imagem do Produto</label>
                                                    <div>
                                                        <asp:FileUpload ID="fuProdutoImage" runat="server" CssClass="form-control"
                                                            onchange="ImagePreview(this);" />

                                                    </div>
                                                </div>

                                             <div class="form-group">
                                                    <label>Categoria do Produto</label>
                                                    <div>
                                                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control"
                                                            DataSourceID="SqlDataSource1" DataTextField="Nome" DataValueField="CategoriaId"
                                                            AppendDataBoundItems="true">

                                                            <asp:ListItem Value="0">Selecione Categoria</asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                            ErrorMessage="Categoria é requrido" ForeColor="Red" Display="Dynamic" 
                                                            SetFocusOnError="true" ControlToValidate="ddlCategoria" InitialValue="0">
                                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                                                ConnectionString="<%$ ConnectionStrings:cs %>"
                                                                SelectCommand="SELECT [CategoriaId], [Nome] FROM [Categorias]"></asp:SqlDataSource>
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-check pl-4">
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; IsActive"
                                                        CssClass="form-check-input" />
                                                </div>
                                                <div class="pb-5">
                                                    <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary" 
                                                       onClick="btnAddOrUpdate_Click"/>
                                                    &nbsp;
                                                    <asp:Button ID="btnClear" runat="server" Text="Limpar" CssClass="btn btn-primary" 
                                                        CausesValidation="false" OnClick="btnClear_Click" />
                                                </div>
                                            </div>
                                            <asp:Image ID="imgProduto" runat="server" CssClass="img-thumbnail" />
                                        </div>

                                        <div class="col-sm6 col-md-8 col-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Lista de Produtos</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                      <asp:Repeater ID="rProduto" runat="server" OnItemCommand="rProduto_ItemCommand" 
                                          OnItemDataBound="rProduto_ItemDataBound"> 

                               
                                                        <HeaderTemplate>
                                                                <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                <tr>
                                                                 <th class="table-plus">Nome</th>
                                                                 <th>Imagem</th>
                                                                 <th>Preço(R$)</th>
                                                                 <th>Qtd</th>
                                                                 <th>Categoria</th>
                                                                 <th>Descrição</th>
                                                                 <th>Ativo</th>
                                                                 <th>Data Criada</th>
                                                                 <th class="datatable-nosort">Ação</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                              
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"> <%# Eval("Nome") %></td>
                                                                <td> 
                                                                    <img alt="" width="40" height="40" src="<%# Utils.GetImageUrl( Eval("ImageUrl")) %>" />
                                                                </td>
                                                                <td> <%# Eval("Preco") %></td>
                                                                <td> 
                                                                    <asp:Label ID="lblQuantidade" runat="server" Text='<%# Eval("Quantidade") %>'></asp:Label>
                                                                </td>
                                                                <td> <%# Eval("CategoriaNome") %></td>
                                                                <td> 
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                                                </td>
                                                                <td> <%# Eval("Descricao") %></td>
                                                                <td> <%# Eval("DataCriada") %></td>
                                                                <td> 
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CausesValidation="false" 
                                                                        CssClass="badge badge-primary" CommandArgument='<%# Eval("ProdutoId") %>' CommandName="edit">
                                                                        <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("ProdutoId") %>'
                                                                        OnclientClick="return confirm('Deseja deletar esse Produto?');" CausesValidation="false">
                                                                        <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
 
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                        </asp:Repeater>
                                                

                                                </div>
                                            </div>
                                          </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>


