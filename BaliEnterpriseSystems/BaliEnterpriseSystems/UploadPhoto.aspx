<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadPhoto.aspx.cs" Inherits="BaliEnterpriseSystems.UploadPhoto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Best - Upload Photo</title>
    <link  href="js/MasterStyles.css?20110611" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.5.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui-1.8.9.custom.min.js" type="text/javascript"></script>
    <link rel="Stylesheet" href="js/jquery-ui-1.8.10.custom.css" />
    <style type="text/css">
        .ui-widget { font-size:small; }
        .ra { text-align:right; }
        h2 { font-size:16px; vertical-align:middle; font-weight:bold;}
    </style>
    
    <script type="text/javascript">
    $().ready(function() {
        $('#empPhoto').load(function() {
            parentwindow().resizeIframe('theframe');
        })
        if (defaultSize != '') {
            $('#resizePhoto').val(defaultSize);
        }
    });

</script>
<asp:Literal runat="server" ID="defaultResizeOptionScript"></asp:Literal>
</head>
<body>
    <div id="TopWraper">
	    <div class="TopCenDiv">
    	    <div class="Logo"></div>
        </div>
    </div>

<div class="MidCenDiv">
        <form id="form1" runat="server" enctype="multipart/form-data">
        <div>
            <table><tr><td>
                <asp:Literal runat="server" ID="errorDisplay"></asp:Literal>
            </td></tr></table>
            <table><tr><td>
                <asp:Literal runat="server" ID="photoDisplay"></asp:Literal><br />
            </td><td style="vertical-align:middle;"><h2><asp:Literal ID="ltrStdName" runat="server"></asp:Literal></h2>
            </table>
            
            <hr />
            <table>
            <tr><th><h3>Upload New Photo </h3></th></tr>
            <tr><td><input type="file" name="photoFile" accept="image/*" /></td></tr>
            <tr><td><label style="font-size:80%">Reduce Longest Side To</label><select id="resizePhoto" name="resizePhoto">
            <option value="120">120 pixels</option>
            <option value="100">100 pixels</option>
            <option value="90"  selected="selected">90 pixels</option>
            <option value="80">80 pixels</option>
            <option value="60">60 pixels</option>
            <option value="50">50 pixels</option>

            </select></td></tr>

            <tr><td><input type="submit" name="uploadPhoto" value="Upload Photo" /><br /></td></tr>


            </table>
        </div>
        </form>
</div>

<div id="FooterDiv">
    <div class="FootNoteL">&copy; 2011 - Bali Enterprise System - Terms &amp; Conditions</div>
    <div class="FootNoteR">Bali Learning Center, 2808 Park Ave. Suite C Merced CA 95348</div>
</div>
       
</body>
</html>
