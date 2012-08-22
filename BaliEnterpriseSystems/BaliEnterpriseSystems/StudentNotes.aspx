<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="StudentNotes.aspx.cs" Inherits="BaliEnterpriseSystems.StudentNotes" Title="BEST - Student Notes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
    $(document).ready(function(){
        $('#noteDate').mask('99/99/9999');
        $('#noteDate').datepicker({showOn:'button', buttonImage:'images/date.png', buttonImageOnly:true, changeYear:true, changeMonth:true });
        $('#divStudentInfo').css("display", "none");
        BestJSGrid.requiredFields.push({ name: 'studentGuid', description: 'Student' });        
    });
    
    function addNew(){
        BestJSGrid.addNew("divStudentInfo", 250, 450);
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "divStudentInfo", 250, 450);
    }

    function gridfillDefaults(rownum) {
        if (rownum >= 0) {
            var currow = gridJS.Rows[rownum];
            $("#studentGuid").val(currow["studentGuid"]);
            for (var x in autoStudents) {
                if (autoStudents[x].value == currow["studentGuid"]) {
                    $("#studentTag1").val(autoStudents[x].label);
                    break;
                }
            }
        }
    }
</script>
<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>
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
<div id="divStudentInfo">
    <table>
        <tr>
            <td class="ra">Student Name</td>
		    <td><input id="studentTag1" /><input type="hidden" id="studentGuid" name="studentGuid" /></td>
        </tr>
        <tr><td class="ra">Note Date</td><td><input type="text" size="10" maxlength="10" id="noteDate" name="noteDate" /></td></tr>
        <tr><td class="ra">Note</td><td><textarea id="notes" name="notes" cols="40" rows="5"></textarea></td></tr>
        <tr>
            <td class="ra" colspan="2"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>
    </table>
</div>
</asp:Content>
