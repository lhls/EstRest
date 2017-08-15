<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EstRest.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login EstRest</title>
    <script src="js/jquery-1.12.4.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".container").css("margin-top", (($(document).height() - $(".container").height()) / 2).toString() + "px");

            $(document).resize(function () {
                $(".container").css("margin-top", (($(document).height() - $(".container").height()) / 2).toString() + "px");
            });
        });
    </script>
</head>
<body>
    <form id="form1" class="form-signin" runat="server">
        <div class="container">
            <label for="inputEmail" class="sr-only">Login</label>
            <input type="text" runat="server" id="txtLogin" class="form-control" placeholder="Login" required autofocus />
            <label for="inputPassword" class="sr-only">Senha</label>
            <input type="password" runat="server" id="txtSenha" class="form-control" placeholder="Senha" required />
            <div class="form-group">
                <label id="lblErro" runat="server" class="alert-danger" visible="false"></label>
            </div>
            <asp:Button CssClass="btn btn-lg btn-primary btn-block" runat="server" ID="btnAcessar" Text="Login" OnClick="btnAcessar_Click" />
        </div>
    </form>
</body>
</html>
