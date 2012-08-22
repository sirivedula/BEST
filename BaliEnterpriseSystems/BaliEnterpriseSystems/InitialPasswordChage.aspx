<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InitialPasswordChage.aspx.cs" Inherits="BaliEnterpriseSystems.InitialPasswordChage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Best - Initial Password Change</title>
    <link  href="js/MasterStyles.css?20110611" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.5.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui-1.8.9.custom.min.js" type="text/javascript"></script>
    <link rel="Stylesheet" href="js/jquery-ui-1.8.10.custom.css" />
    
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

    <style type="text/css">
        .ui-widget { font-size:small; }
        .ra { text-align:right; }
    </style>
    
</head>
<body>
    <div id="TopWraper">
	    <div class="TopCenDiv">
    	    <div class="Logo"></div>
        </div>
    </div>

        <div style="background-color:#f9f9f9;border:1px solid #ABCABC;height:300px;width:100%;padding-top:10px;font-family:Tahoma;font-size:large;">
        <h2>Change Password</h2>
        Since you logged in with your temporary password you need to change your password now. <br /><br />
        Your new password must be at least 6 characters long and contain at least one number or punctuation mark.<br /><br />
        <form method="post" action="InitialPasswordChage.aspx" onsubmit="return checkPasswords()">
            <asp:Literal ID="ChangePasswordMessage" runat="server"></asp:Literal>
            <table>
            <tr><td>New Password</td><td><input type="password" id="newpassword" name="newpassword" autocomplete="off" size="15" maxlength="128" /></td></tr>
            <tr><td>Confirm New Password</td><td><input type="password" id="newpasswordconfirm" autocomplete="off" size="15" maxlength="128" /></td></tr>
            <tr><td><input type="submit" value="Submit" /></td></tr>
            </table>
        </form>
        </div>
    <div id="FooterDiv">
        <div class="FootNoteL">&copy; 2011 - Bali Enterprise System - Terms &amp; Conditions</div>
        <div class="FootNoteR">Bali Learning Center, 2808 Park Ave. Suite C Merced CA 95348</div>
    </div>
 </body>
</html>
