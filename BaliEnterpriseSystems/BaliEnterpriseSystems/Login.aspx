<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BaliEnterpriseSystems.Login" EnableViewState="false" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Bali Enterprise System - Login</title>
    <link  href="js/MasterStyles.css?20110611" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.5.min.js?20110611" type="text/javascript"></script>
    <script src="js/jquery-ui-1.8.9.custom.min.js?20110611" type="text/javascript"></script>
    <link rel="Stylesheet" href="js/jquery-ui-1.8.10.custom.css?20110611" type="text/css" />
    
    <style type="text/css">
        .ui-widget { font-size:small; }
        .ra { text-align:right; }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $('input[type=text]:first').focus();
        });
        function ssubmit() {
            $("form:first").submit();
        }
        function keydown(e) {
            var key = e.keyCode ? e.keyCode : e.which;
            if (key == 13) {
                ssubmit();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="TopWraper">
	    <div class="TopCenDiv">
    	    <div class="Logo"></div>
        </div>
    </div>
    <asp:Literal ID="ltrValidateMsg" runat="server"></asp:Literal>
    <div onkeydown="return keydown(event);" class="MidCenDiv">
        <div class="LoginBoxDiv LeftGap15 TopGap15">
    	    <div class="LoginDiv">
        	    <div class="H"></div>
                <div class="Row">
                    <div class="FieldName">Username :</div>                    
                    <div class="FieldValue"><asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox></div>
                </div>
                <div class="Row">
                    <div class="FieldName">Password :</div>
                    <div class="FieldValue">
                        <asp:TextBox TextMode="Password" ID="txtPassword" runat="server" CssClass="TextBox"></asp:TextBox>
                    </div>
                </div>
                <div class="Row">
            	    <div class="ButtonsDiv">
                        <a href="javascript:voud(0);" onclick="ssubmit();" class="Button">Sign in</a>
                    </div>
                </div>
                <div class="ForGotDiv">
            	    <a href="ForgotPassword.aspx">Forgot password?</a> | <a href="#">Help </a>
                </div>
            </div>
        </div>
    </div>
    <div id="FooterDiv">
        <div class="FootNoteL">&copy; 2011 - Bali Enterprise System - Terms &amp; Conditions</div>
        <div class="FootNoteR">Bali Learning Center, 2808 Park Ave. Suite C Merced CA 95348</div>
    </div>
    </form>
</body>
</html>
