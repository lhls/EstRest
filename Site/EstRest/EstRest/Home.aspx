<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="EstRest.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .divColuna{
            width:1px;
            height:300px;
            background-color:black; 
            float:left;
            margin-right:5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHome" runat="server">
    <div class="form">
        <div class="form-group" style="width:49%; float:left;">
            <div class="form-group">
                <label>Ingredientes Próximos ao Vencimento</label><br />
                <asp:Literal runat="server" ID="litIngredientesValidade"></asp:Literal>
            </div>
        </div>
        <div class="divColuna"></div>
        <div class="form-group" style="width:49%; float:left;">
            <div class="form-group">
                <label>Pratos Sugeridos</label><br />
                <asp:Literal runat="server" ID="litPratosSugeridos"></asp:Literal>
            </div>
        </div>
    </div>
</asp:Content>
