<%@ Page Title="" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="StudentDocuments.aspx.cs" Inherits="BaliEnterpriseSystems.StudentDocuments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    .ra { text-align:right;}
</style>
    <script type="text/javascript">
        var autoStudents = [];
        $(document).ready(function() {
        $('#documentDate,#documentExpiry').mask('99/99/9999');
        $('#documentDate,#documentExpiry').datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });
        $('#documentDiv').css("display", "none");
        BestJSGrid.requiredFields.push({ name: 'studentGuid', description: 'Student' });
    });
    
    function addNew(){
        BestJSGrid.addNew("documentDiv", 250, 350);
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "documentDiv", 250, 350);
    }

    function afterGridSetValue() {
        $("#g_showToStudent").val($("#showToStudent").attr("checked"));
    }

    function gridfillDefaults(rownum) {
        if (rownum >= 0) {
            var currow = gridJS.Rows[rownum];
            if (currow["showToStudent"] == "True") {
                $("#showToStudent").attr('checked', 'checked');
            } else {
                $("#showToStudent").removeAttr('checked');
            }
            $("#studentGuid").val(currow["studentGuid"]);
            for (var x in autoStudents) {
                if (autoStudents[x].value == currow["studentGuid"]) {
                    $("#studentTag1").val(autoStudents[x].label);
                    break;
                }
            }
        }
    }

    function showUploadDocument(cid, sid, guid, rownum) {
        var currow = gridJS.Rows[rownum];
        $('#docUploadDiv').dialog({title:'Upload Document - ' + currow["documentTitle"] , height:250, width:450});
        $('#docUploadDiv').html('<iframe border="0" style="height:200px;width:350px;" id="docFrame" src="UploadDocument.aspx?guid=' + encodeURIComponent(guid) + '&cid=' + encodeURIComponent(cid) + '&sid=' + encodeURIComponent(sid) + '" />');
    }

    function closeUploadDoc() {
        alert('Document Uploaded Successfully.');
        $('#docUploadDiv').dialog("close");
        location = location;
    }

    function DownloadDocument(guid, cid, sid) {
        var inputs = '<input type="hidden" name="guid" value="' + guid + '">';
        inputs += '<input type="hidden" name="cid" value="' + cid + '">';
        inputs += '<input type="hidden" name="sid" value="' + sid + '">';
        jQuery('<form action="DownloadDocument.aspx" method="post">' + inputs + '</form>')
		.appendTo('body').submit().remove();
    }
    </script>

    <asp:Literal ID="ltrMScript" runat="server"></asp:Literal>
    <asp:Literal ID="ltrScript" runat="server"></asp:Literal>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="MidCenDiv">
	    <div class="ContentCenDiv">
    	    <div class="ContentbrdrDiv">
			    <div class="LeftNav">
				    <ul>
                        <asp:Literal ID="ltrSubMenu" runat="server"></asp:Literal>
				    </ul>
			    </div>
                    <div><asp:Literal ID="ltrValidateMsg" runat="server"></asp:Literal></div>
			        <div class="CAreaDiv">
                    <asp:Literal ID="ltrGrid" runat="server"></asp:Literal>
			        </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div id="documentDiv">
        <table>
        <tr>
            <td class="ra">Student Name</td>
		    <td><input id="studentTag1" /><input type="hidden" id="studentGuid" name="studentGuid" /></td>
        </tr>
        <tr>
            <td class="ra">Document Title</td><td><input type="text" id="documentTitle" name="documentTitle" size="30" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Document Date</td><td><input type="text" id="documentDate" name="documentDate" size="10" maxlength="10" /></td>
        </tr>
        <tr>
            <td class="ra">Document Expiry Date</td><td><input type="text" id="documentExpiry" name="documentExpiry" size="10" maxlength="10" /></td>
        </tr>
        <tr>
        <td class="ra">Show To Student</td><td><input type="checkbox" id="showToStudent" name="showToStudent" /></td>
        </tr>
        <tr>
            <td class="ra" colspan="2"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>
        </table>
    </div>
    <div id="docUploadDiv">
        
    </div>
</asp:Content>
