<%@ Page Title="BEST - User Preferences" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="BaliEnterpriseSystems.ChangePassword" ValidateRequest="false" EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<script type="text/javascript">
    function checkPasswords() {

        if ($('#newpassword').val() != $('#newpasswordconfirm').val()) {
            alert("The new password and the confirmation do not match.\nPlease enter the same password in the New Password and the Confirm New Password boxes");
            return false;
        }
        if ($.trim($('#newpassword').val()) == '') {
            alert("The new password cannot be blank.");
            return false;
        }
        if ($('#newpassword').val().length < 6) {
            alert("The new password must be at least 6 characters long.");
            return false;
        }
        var np = $('#newpassword').val();
        if (!/.*[0123456789!@#$%^&*()-=_+`~[\]{};:'",.\/<>?\\].*/i.test(np)) {
            alert("The new password must contain at least 1 number or punctuation mark.");
            return false;
        }


        return true;
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<br />
<h2>Change Password</h2>
Change your password now. <br /><br />
Your new password must be at least 6 characters long and contain at least one number or punctuation mark.<br /><br />
<form method="post" action="ChangePassword.aspx" onsubmit="return checkPasswords()">
    <asp:Literal ID="ChangePasswordMessage" runat="server"></asp:Literal>
    <table>
    <tr><td>New Password</td><td><input type="password" id="newpassword" name="newpassword" autocomplete="off" size="15" maxlength="128" /></td></tr>
    <tr><td>Confirm New Password</td><td><input type="password" id="newpasswordconfirm" autocomplete="off" size="15" maxlength="128" /></td></tr>
    <tr><td><input type="submit" value="Submit" /></td></tr>
    </table>
</form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
