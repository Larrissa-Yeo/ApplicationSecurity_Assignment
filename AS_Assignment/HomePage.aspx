<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="AS_Assignment.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <fieldset>
                <legend>HomePage</legend>
                User Profile<br />
                <br />
                Email:
                <asp:Label ID="lbl_userID" runat="server"></asp:Label>
                <br />
                <br />
                Name:
                <asp:Label ID="lbl_email" runat="server"></asp:Label>
                <br />
                <br />
                Message: <asp:Label ID="lbl_message" runat="server" EnableViewState="false" />
                <br />
                <br />
                Welcome you&#39;ve made it! ^^<br />
                <br />

                <asp:Button ID="btn_logout" runat="server" Text="Logout" OnClick="LogoutMe" Visible="false" />
            </fieldset>
        </div>
    </form>
</body>
</html>
