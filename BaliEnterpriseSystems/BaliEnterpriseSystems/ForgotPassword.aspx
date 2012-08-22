<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="BaliEnterpriseSystems.ForgotPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Bali Enterprise System - Forgot Password</title>
    <link  href="js/MasterStyles.css?20110611" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .ui-widget { font-size:small; }
        .ra { text-align:right; }
        .MidCenDiv table {text-align:center;}
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
        <div id="TopWraper">
	        <div class="TopCenDiv">
    	        <div class="Logo"></div>
            </div>
        </div>

        <div class="MidCenDiv">
                <div style="text-align:center;background-color:#f9f9f9;text-align:center;padding-top:100px;font-family:Tahoma;font-size:large;">
                <asp:Literal ID="ltrMsg" runat="server"></asp:Literal>
                
                    <div>EMail Address: <input type="text" id="emailid" name="emailid" size="30" runat="server" /></div>
                    <div><input type="submit" id="btnsubmit" value="Submit" /></div>
                </div>        </div>
        <div id="FooterDiv">
            <div class="FootNoteL">&copy; 2011 - Bali Enterprise System - Terms &amp; Conditions</div>
            <div class="FootNoteR">Bali Learning Center, 2808 Park Ave. Suite C Merced CA 95348</div>
        </div>
    </form>
</body>
</html>
