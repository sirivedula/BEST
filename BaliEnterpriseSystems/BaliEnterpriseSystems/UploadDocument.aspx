<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadDocument.aspx.cs" Inherits="BaliEnterpriseSystems.UploadDocument" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="font-family:Tahoma;">
            <table><tr><td>
                <asp:Literal runat="server" ID="errorDisplay"></asp:Literal>
            </td></tr></table>

        <table><tr><td>Document File</td><td><input type="file" id="docFile" name="docFile" size="20" runat="server" /></td></tr>
            <tr><td></td><td><input type="submit" id="btnSubmit" name="btnSubmit" /></td></tr>
        </table>
        
    </div>
    </form>
</body>
</html>
