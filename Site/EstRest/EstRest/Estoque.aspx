<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="Estoque.aspx.cs" Inherits="EstRest.Estoque" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConsulta" runat="server">
    <div class="form">
        <div class="form-group">
            <label for="txtDescricaoPesquisa">Ingrediente</label>
            <input type="text" runat="server" class="form-control" id="txtDescricaoPesquisa" placeholder="Descrição" />
        </div>
        <div class="form-group col-sm-6">
            <div class="form-group">
                <label for="txtDtValidadeInicio">Data de Validade Inicial</label>
                <div class="input-group date">
                    <input type="text" runat="server" id="txtDtValidadeInicio" class="form-control" readonly="true" />
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-th"></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group col-sm-6">
            <div class="form-group">
                <label for="txtDtValidadeFim">Data de Validade Final</label>
                <div class="input-group date">
                    <input type="text" runat="server" id="txtDtValidadeFim" class="form-control" readonly="true" />
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-th"></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-default" runat="server" id="btnConsultar" onserverclick="btnConsultar_ServerClick">Consultar</button>
            <button type="submit" class="btn btn-primary" runat="server" id="btnInserir" onserverclick="btnInserir_ServerClick">Inserir</button>
        </div>
        <asp:GridView runat="server" CssClass="table" AllowPaging="true" AllowSorting="true" ID="gvDados" PageSize="10" OnPageIndexChanging="paginacaoGrid"
            OnSorting="ordenacaoGrid" AutoGenerateColumns="false" OnRowCommand="gvDados_RowCommand" DataKeyNames="cd_estoque,dt_validade">
            <Columns>
                <asp:BoundField HeaderText="Nome" SortExpression="ds_ingrediente" DataField="ds_ingrediente" />
                <asp:BoundField HeaderText="Quantidade Atual" SortExpression="nr_quantidade_atual" DataField="nr_quantidade_atual" />
                <asp:BoundField HeaderText="Validade" SortExpression="dt_validade" DataField="dt_validade" />
                <asp:TemplateField HeaderText="Quantidade para alterar" >
                    <ItemTemplate>
                        <asp:TextBox type="number" step=".01" runat="server" class="form-control" id="txtQtdAlterar" placeholder="0" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ButtonField CommandName="ADICIONAR" ButtonType="Link" Text="Adicionar" />
                <asp:ButtonField CommandName="REMOVER" ButtonType="Link" Text="Remover" />
                <asp:ButtonField CommandName="EDITAR" ButtonType="Link" Text="Ver Detalhes" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphEdita" runat="server">
    <div class="jumbotron">
        <h2 runat="server" id="hNomeIngredienteValidade"></h2>
    </div>
    <div class="form">
        <asp:GridView runat="server" CssClass="table" AllowPaging="true" AllowSorting="true" ID="gvHistorico" PageSize="10" OnPageIndexChanging="paginacaoGrid"
            OnSorting="ordenacaoGrid" AutoGenerateColumns="false" >
            <Columns>
                <asp:BoundField HeaderText="Nome" SortExpression="ds_ingrediente" DataField="ds_ingrediente" />
                <asp:BoundField HeaderText="Quantidade" SortExpression="nr_quantidade" DataField="nr_quantidade" />
                <asp:BoundField HeaderText="Tipo Alteração" SortExpression="ds_tipo_alteracao" DataField="ds_tipo_alteracao" />
                <asp:BoundField HeaderText="Usuário Alteração" SortExpression="ds_usuario_alteracao" DataField="ds_usuario_alteracao" />
                <asp:BoundField HeaderText="Data Alteração" SortExpression="dt_alteracao" DataField="dt_alteracao" />
            </Columns>
        </asp:GridView>
        <div class="form-group">
            <button type="submit" class="btn btn-default" id="btnVoltar" runat="server" name="btnVoltar">Voltar</button>
        </div>
    </div>
    <div runat="server" id="divInclusao" class="form">
        <div class="form-group">
            <label for="txtDescricaoInclusao">Ingrediente</label>
            <asp:DropDownList runat="server" CssClass="form-control" ID="ddlIngredienteInclusao" DataTextField="ds_ingrediente" DataValueField="cd_ingrediente" />
        </div>
        <div class="form-group" id="divValidade" runat="server">
            <label for="txtDtValidadeInclusao">Data de Validade</label>
            <div class="input-group date inclusao">
                <input type="text" runat="server" id="txtDtValidadeInclusao" class="form-control" readonly="true" />
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
            <button type="submit" class="btn btn-primary" runat="server" id="btnSalvar" name="btnSalvar" onserverclick="btnSalvar_ServerClick">Salvar</button>
            <button type="submit" class="btn btn-default" runat="server" id="btnCancelar" name="btnCancelar">Cancelar</button>
        </div>
    </div>
</asp:Content>
