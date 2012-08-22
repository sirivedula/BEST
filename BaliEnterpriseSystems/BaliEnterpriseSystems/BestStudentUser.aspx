<%@ Page Title="BEST - Student Users" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="BestStudentUser.aspx.cs" Inherits="BaliEnterpriseSystems.BestStudentUser"  EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    var autoStudents = [];
    $(document).ready(function(){
		    $('#studentTag1').autocomplete( { source:autoStudents, delay: 0, select : function( event, ui){ 
			$('#'+this.id+'0').val( ui.item.value );
			$( this ).val( ui.item.label ); 
			return false; 
		} } );
});
    
    function addNew() {
        BestJSGrid.addNew("divStudentUser", 100, 250);
    }

    function editForm(rownum) {
        BestJSGrid.fillUIForm(rownum, "divStudentUser", 100, 250);
    }

    function Submit() {        
        $("form:first").submit();
    }
 </script>
<asp:Literal ID="ltrScript" runat="server">
</asp:Literal>    
<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>
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
<input type="hidden" id="studentTag10" name="studentTag10" />
    <div id="divStudentUser" style="display:none;">
        <table>
            <tr><td>Student</td><td><input id="studentTag1" /></td></tr>
            <tr><td></td><td><input type="button" value="Save" onclick="Submit();" /></td></tr>
        </table>
    </div>
</asp:Content>
