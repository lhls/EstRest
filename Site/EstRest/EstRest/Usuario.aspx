<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="Usuario.aspx.cs" Inherits="EstRest.Usuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConsulta" runat="server">
    <div class="form">
        <div class="form-group">
            <label for="txtNomePesquisa">Nome</label>
            <input type="text" runat="server" class="form-control" id="txtNomePesquisa" placeholder="Nome" />
        </div>
        <div class="form-group">
            <label for="txtLoginPesquisa">Login</label>
            <input type="text" runat="server" class="form-control" id="txtLoginPesquisa" placeholder="Nome" />
        </div>
        <div class="form-group">
            <label for="ddlPerfilPesquisa">Perfil</label>
            <asp:DropDownList runat="server" ID="ddlPerfilPesquisa" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-default" runat="server" id="btnConsultar" onserverclick="btnConsultar_ServerClick">Consultar</button>
            <button type="submit" class="btn btn-primary" runat="server" id="btnInserir" onserverclick="btnInserir_ServerClick">Inserir</button>
        </div>
    </div>
    <asp:GridView runat="server" CssClass="table" AllowPaging="true" AllowSorting="true" ID="gvDados" PageSize="10" OnPageIndexChanging="paginacaoGrid"
        OnSorting="ordenacaoGrid" AutoGenerateColumns="false" OnRowCommand="gvDados_RowCommand" DataKeyNames="cd_usuario">
        <Columns>
            <asp:BoundField HeaderText="Usuario" SortExpression="ds_usuario" DataField="ds_usuario" />
            <asp:BoundField HeaderText="Nome" SortExpression="ds_nome" DataField="ds_nome" />
            <asp:ButtonField CommandName="EDITAR" ButtonType="Link" Text="Editar" />
            <asp:ButtonField CommandName="EXCLUIR" ButtonType="Link" Text="Excluir" />
        </Columns>
    </asp:GridView>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphEdita" runat="server">
    <div class="form">
        <asp:HiddenField runat="server" ID="hdnCdUsuario" />
        <div class="form-group">
            <label for="txtNomeInclusao">Nome</label>
            <input type="text" runat="server" class="form-control" id="txtNomeInclusao" placeholder="Nome" />
        </div>
        <div class="form-group">
            <label for="txtLoginInclusao">Login</label>
            <input type="text" runat="server" class="form-control" id="txtLoginInclusao" placeholder="Nome" />
        </div>
        <div class="form-group">
            <label for="txtSenhaInclusao">Senha</label>
            <input type="password" runat="server" class="form-control" id="txtSenhaInclusao" placeholder="Nome" />
        </div>
        <div class="form-group">
            <label for="ddlPerfilInclusao">Perfil</label>
            <asp:DropDownList runat="server" ID="ddlPerfilInclusao" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary" runat="server" id="btnSalvar" onserverclick="btnSalvar_ServerClick">Salvar</button>
            <button type="submit" class="btn btn-default" runat="server" id="btnCancelar" onserverclick="btnCancelar_ServerClick">Cancelar</button>
        </div>
    </div>
</asp:Content>
