<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="AS_Assignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Registration</title>
    <style>
        /* The message box is shown when the user clicks on the password field */
        #message {
          display:none;
          background: #f1f1f1;
          color: #000;
          position: relative;
          margin-top: 10px;
        }

        #message p {
          font-size: 18px;
        }

        /* Add a green text color and a checkmark when the requirements are right */
        .valid {
          color: green;
        }

        .valid:before {
          position: relative;
          left: -35px;
          content: "✔";
        }

        /* Add a red text color and an "x" when the requirements are wrong */
        .invalid {
          color: red;
        }

        .invalid:before {
          position: relative;
          left: -35px;
          content: "✖";
        }
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 226px;
        }
        .auto-style3 {
            width: 226px;
            height: 29px;
        }
        .auto-style4 {
            height: 29px;
        }
    </style>
    <script type="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tb_password.ClientID %>').value;
            
            if (str.length < 8) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password Length must be at least 8 characters";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("too_short");
            }    

            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML == "Password requires at least 1 number";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_number");
            }

            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password requires at least 1 lower case";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_lowercase");
            }

            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password requires at least 1 upper case";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_uppercase");
            }

            else if (str.search(/[^A-Za-z0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password requires at least 1 special character";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_special");
            }
        
            document.getElementById("lbl_pwdchecker").innerHTML = "Exellent!";
            document.getElementById("lbl_pwdchecker").style.color = "Blue";
        }

        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2><asp:Label ID="lbReg" runat="server" Text="Registration"></asp:Label></h2>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style3">
                        <asp:Label ID="lbl_fName" runat="server" Text="First Name"></asp:Label>
                    </td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_fName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_lName" runat="server" Text="Last Name"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_lName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_credit" runat="server" Text="Credit Card Info"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_credit" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_email" runat="server" Text="Email Address" type="email"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
            <asp:Label ID="lbPwrd" runat="server" Text="Password" ></asp:Label>
                    </td>
                    <td>
            <asp:TextBox ID="tb_password" runat="server" Width ="158px"  TextMode="Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"></asp:TextBox>
                    &nbsp;<asp:Label ID="lbl_pwdchecker" runat="server"></asp:Label>
                        <div id="message">
                          <h3>Password must contain the following:</h3>
                          <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
                          <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
                          <p id="number" class="invalid">A <b>number</b></p>
                          <p id="length" class="invalid">Minimum <b>8 characters</b></p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">
                        <asp:Label ID="lbl_birthdate" runat="server" Text="Date of Birth"></asp:Label>
                    </td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_dob" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">
                        Verification Code</td>
                    <td class="auto-style4">
                        <asp:Image ID="Image2" runat="server" Height="55px" ImageUrl="~/Captcha.aspx" Width="186px" />
                        <br />
                        <asp:Label ID="lbl_captchaMessage" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">
                        Enter Verification Code</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_verification" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:Label ID="lbl_comments" runat="server"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btn_checkPassword" runat="server" OnClick="btn_checkPassword_Click" Text="Sign Up" Width="471px" />
        </div>
        
    </form>
    <script>
        var myInput = document.getElementById("tb_password");
        var letter = document.getElementById("letter");
        var capital = document.getElementById("capital");
        var number = document.getElementById("number");
        var length = document.getElementById("length");

        // When the user clicks on the password field, show the message box
        myInput.onfocus = function () {
            document.getElementById("message").style.display = "block";
        }

        // When the user clicks outside of the password field, hide the message box
        myInput.onblur = function () {
            document.getElementById("message").style.display = "none";
        }

        // When the user starts to type something inside the password field
        myInput.onkeyup = function () {
            // Validate lowercase letters
            var lowerCaseLetters = /[a-z]/g;
            if (myInput.value.match(lowerCaseLetters)) {
                letter.classList.remove("invalid");
                letter.classList.add("valid");
            } else {
                letter.classList.remove("valid");
                letter.classList.add("invalid");
            }

            // Validate capital letters
            var upperCaseLetters = /[A-Z]/g;
            if (myInput.value.match(upperCaseLetters)) {
                capital.classList.remove("invalid");
                capital.classList.add("valid");
            } else {
                capital.classList.remove("valid");
                capital.classList.add("invalid");
            }

            // Validate numbers
            var numbers = /[0-9]/g;
            if (myInput.value.match(numbers)) {
                number.classList.remove("invalid");
                number.classList.add("valid");
            } else {
                number.classList.remove("valid");
                number.classList.add("invalid");
            }

            // Validate length
            if (myInput.value.length >= 8) {
                length.classList.remove("invalid");
                length.classList.add("valid");
            } else {
                length.classList.remove("valid");
                length.classList.add("invalid");
            }
        }
    </script>
</body>
</html>
