<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AS_Assignment.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Form</title>
    <script src="https://www.google.com/recaptcha/api.js?render=6LcHmkIaAAAAAMjX9MdC-musLZ2teKRQ_jmXk2yH"></script>
    <style type="text/css">
        .auto-style1 {
            width: 45%;
        }
        .auto-style2 {
            width: 144px;
        }
    </style>
   
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Login</h2>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_email" runat="server" Text="Email" type="email"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_password" runat="server" Text="Password"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_password" runat="server" TextMode="Password"></asp:TextBox>
                        &nbsp;<asp:Label ID="lbl_pwdchecker" runat="server"></asp:Label>
                        <br />
                        Error Message here:
                        <asp:Label ID="lbl_message" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <asp:Label ID="lbl_display" runat="server"></asp:Label>
        <br />
        <br />
        JSON Message:<br />
        <asp:Label ID="lbl_gScore" runat="server"></asp:Label>
        <br />
        <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" /> 
        <br />
        <asp:Button ID="btn_login" runat="server" Text="Login" Width="471px" OnClick="btn_login_Click"  />
    </form>

    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LcHmkIaAAAAAMjX9MdC-musLZ2teKRQ_jmXk2yH', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
