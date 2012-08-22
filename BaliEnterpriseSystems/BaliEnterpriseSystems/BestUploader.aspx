<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BestUploader.aspx.cs" Inherits="BaliEnterpriseSystems.BestUploader" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>BEST - Picture Uploader</title>
    <script type="text/javascript">
        function checkFile() {
            var path = document.forms[0].imgfile.value;
            var ext = path.substring(path.length - 4, path.length).toLowerCase();
            if (ext != ".jpg" && ext != ".gif") {
                alert("You must choose an image file!");
                document.forms[0].reset();
            }
        }
        
        function submitImage() {
            var path = document.forms[0].imgfile.value;
            if (path.length == 0) {
                alert('Picture Image Selection is required');
                return;
            }
            $('#form:first').submit();
        }
        
   </script>
    <style type="text/css">
        #btnSubmit
        {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <div>
        <table><tr><td>Choose Student Picture File</td></tr>
        <tr><td><input type="file" id="imgfile" name="imgfile" runat="server" onchange="checkFile();" /></td></tr>
        <tr><td><input type="button" id="btnSubmit" name="btnSubmit" value="Submit" onclick="submitImage();" /></td></tr>
        </table>
    </div>
    </form>
</body>
</html>
