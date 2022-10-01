<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Categoria.aspx.cs" Inherits="FoodFy.Admin.Categoria" %>
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
                    $('#<%=imgCategoria.ClientID%>').prop('src', e.target.result)
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
                                            <h4 class="sub-title">Categoria</h4>
                                            <div>
                                                <div class="form-group">
                                                    <label>Nome Categoria</label>
                                                    <div>
                                                        <asp:TextBox ID="txtNome" runat="server" CssClass="form-control"
                                                            placeholder="Digite Nome da Categoria" required></asp:TextBox>
                                                        <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Imagem da Categoria</label>
                                                    <div>
                                                        <asp:FileUpload ID="fuCategoriaImage" runat="server" CssClass="form-control"
                                                            onchange="ImagePreview(this);" />

                                                    </div>
                                                </div>
                                                <div class="form-check pl-4">
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; IsActive"
                                                        CssClass="form-check-input" />
                                                </div>
                                                <div class="pb-5">
                                                    <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary" 
                                                        OnClick="btnAddOrUpdate_Click"/>
                                                    &nbsp;
                                                    <asp:Button ID="btnClear" runat="server" Text="Limpar" CssClass="btn btn-primary" 
                                                        CausesValidation="false" OnClick="btnClear_Click" />
                                                </div>
                                            </div>
                                            <asp:Image ID="imgCategoria" runat="server" CssClass="img-thumbnail" />
                                        </div>

                                        <div class="col-sm6 col-md-8 col-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Lista de Categorias</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                      <asp:Repeater ID="rCategoria" runat="server" OnItemCommand="rCategoria_ItemCommand" 
                                          OnItemDataBound="rCategoria_ItemDataBound"> 

                               
                                                        <HeaderTemplate>
                                                                <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                <tr>
                                                                 <th class="table-plus">Nome</th>
                                                                 <th>Imagem</th>
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
                                                                <td> 
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                                                </td>
                                                                <td> <%# Eval("DataCriada") %></td>
                                                                <td> 
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("CategoriaId") %>' CommandName="edit">
                                                                        <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("CategoriaId") %>'
                                                                        OnclientClick="return confirm('Deseja deletar essa categoria?');">
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
