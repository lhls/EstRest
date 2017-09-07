<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="Ingrediente.aspx.cs" Inherits="EstRest.Ingrediente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConsulta" runat="server">
    <div class="form">
        <div class="form-group">
            <label for="txtDescricaoPesquisa">Ingrediente</label>
            <input type="text" runat="server" class="form-control" id="txtDescricaoPesquisa" placeholder="Descrição" />
        </div>
        <!-- TODO: Inserir Pesquisa por Prato -->
        <div class="form-group">
            <button type="submit" class="btn btn-default" runat="server" id="btnConsultar" onserverclick="btnConsultar_ServerClick">Consultar</button>
            <button type="submit" class="btn btn-primary" runat="server" id="btnInserir" onserverclick="btnInserir_ServerClick">Inserir</button>
        </div>
        <asp:GridView runat="server" CssClass="table" AllowPaging="true" AllowSorting="true" ID="gvDados" PageSize="10" OnPageIndexChanging="paginacaoGrid"
            OnSorting="ordenacaoGrid" AutoGenerateColumns="false" OnRowCommand="gvDados_RowCommand" DataKeyNames="cd_ingrediente">
            <Columns>
                <asp:BoundField HeaderText="Nome" SortExpression="ds_ingrediente" DataField="ds_ingrediente" />
                <asp:ButtonField CommandName="EDITAR" ButtonType="Link" Text="Editar" />
                <asp:ButtonField CommandName="EXCLUIR" ButtonType="Link" Text="Excluir" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphEdita" runat="server">
    <div class="form">
        <asp:HiddenField runat="server" ID="hdnCdIngrediente" />
        <div class="form-group">
            <label for="txtDescricaoInclusao">Descrição</label>
            <input type="text" runat="server" class="form-control" id="txtDescricaoInclusao" placeholder="Descrição" />
        </div>
        <div class="form-group">
            <label for="ddlUnidadeMedidaInclusao">Unidade de Medida</label>
            <asp:DropDownList runat="server" ID="ddlUnidadeMedidaInclusao" DataTextField="ds_unidade_medida" DataValueField="cd_unidade_medida" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="form-group" id="divValidadeInicial" runat="server">
            <label for="txtDtValidade">Data de Validade Inicial</label>
            <div class="input-group date">
                <input type="text" runat="server" id="txtDtValidade" class="form-control" readonly="true" />
                <div class="input-group-addon">
                    <span class="glyphicon glyphicon-th"></span>
                </div>
            </div>
        </div>
        <div class="form-group" id="divQuantidadeInicial" runat="server">
            <label for="txtQtdInicial">Quantidade Inicial em Estoque</label>
            <input type="text" runat="server" class="form-control" id="txtQtdInicial" />
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary" runat="server" id="btnSalvar" onserverclick="btnSalvar_ServerClick">Salvar</button>
            <button type="submit" class="btn btn-default" runat="server" id="btnCancelar" name="btnCancelar">Cancelar</button>
        </div>
    </div>
</asp:Content>
