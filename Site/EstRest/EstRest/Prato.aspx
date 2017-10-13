<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="Prato.aspx.cs" Inherits="EstRest.Prato" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConsulta" runat="server">
    <div class="form">
        <div class="form-group">
            <label for="txtDescricaoPesquisa">Prato</label>
            <input type="text" runat="server" class="form-control" id="txtDescricaoPesquisa" placeholder="Descrição" />
        </div>
        <div class="form-group">
            <label for="txtDescricaoIngredientePesquisa">Ingrediente</label>
            <input type="text" runat="server" class="form-control" id="txtDescricaoIngredientePesquisa" placeholder="Descrição" />
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-default" runat="server" id="btnConsultar" onserverclick="btnConsultar_ServerClick">Consultar</button>
            <button type="submit" class="btn btn-primary" runat="server" id="btnInserir" onserverclick="btnInserir_ServerClick">Inserir</button>
        </div>
        <asp:GridView runat="server" CssClass="table" AllowPaging="true" AllowSorting="true" ID="gvDados" PageSize="10" OnPageIndexChanging="paginacaoGrid"
            OnSorting="ordenacaoGrid" AutoGenerateColumns="false" OnRowCommand="gvDados_RowCommand" DataKeyNames="cd_prato">
            <Columns>
                <asp:BoundField HeaderText="Nome" SortExpression="ds_prato" DataField="ds_prato" />
                <asp:ButtonField CommandName="EDITAR" ButtonType="Link" Text="Editar" />
                <asp:ButtonField CommandName="EXCLUIR" ButtonType="Link" Text="Excluir" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphEdita" runat="server">
    <div class="form">
        <asp:HiddenField runat="server" ID="hdnCdPrato" />
        <div class="form-group">
            <label for="txtDescricaoInclusao">Descrição</label>
            <input type="text" runat="server" class="form-control" id="txtDescricaoInclusao" placeholder="Descrição" required="required" />
        </div>
        <div class="form-group col-sm-5">
            <div class="form-group">
                <label for="ddlIngredientesDisp">Ingredientes Disponíveis</label>
                <div class="input-group">
                    <asp:ListBox Width="100%" SelectionMode="Multiple" Rows="5" runat="server" ID="ddlIngredientesDisp" DataTextField="ds_ingrediente" DataValueField="cd_ingrediente" CssClass="form-control">
                    </asp:ListBox>
                </div>
            </div>
        </div>
        <div class="form-group col-sm-2">
            <button type="submit" class="btn btn-default" runat="server" id="btnAdicionar" onserverclick="btnAdicionar_ServerClick" name="btnAdicionar">>></button>
            <button type="submit" class="btn btn-default" runat="server" id="btnRemover" onserverclick="btnRemover_ServerClick" name="btnRemover"><<</button>
        </div>
        <div class="form-group col-sm-5">
            <div class="form-group">
                <label for="ddlIngredientesIncl">Data de Validade Final</label>
                <div class="input-group">
                    <asp:ListBox Width="100%" SelectionMode="Multiple" Rows="5" runat="server" ID="ddlIngredientesIncl" DataTextField="ds_ingrediente" DataValueField="cd_ingrediente" CssClass="form-control">
                    </asp:ListBox>
                </div>
            </div>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary" runat="server" id="btnSalvar" onserverclick="btnSalvar_ServerClick">Salvar</button>
            <button type="submit" class="btn btn-default" runat="server" id="btnCancelar" name="btnCancelar">Cancelar</button>
        </div>
    </div>
</asp:Content>
