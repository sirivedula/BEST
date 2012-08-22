<%@ Page Title="BEST - Tutor Users" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="TutorUsers.aspx.cs" Inherits="BaliEnterpriseSystems.TutorUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    var autoTutors = [];
    $(document).ready(function(){
        $('#tutorTag').autocomplete({ source: autoTutors, delay: 0, select: function(event, ui) { 
			$('#'+this.id+'0').val( ui.item.value );
			$( this ).val( ui.item.label ); 
			return false; 
		} } );
});
    
    function addNew() {
        BestJSGrid.addNew("divTutorUser", 100, 250);
    }

    function editForm(rownum) {
        BestJSGrid.fillUIForm(rownum, "divTutorUser", 100, 250);
    }

    function Submit() {        
        $("form:first").submit();
    }
 </script>
<asp:Literal ID="ltrScript" runat="server">
</asp:Literal>    
<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal></asp:Content>
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
<input type="hidden" id="tutorTag0" name="tutorTag0" />
    <div id="divTutorUser" style="display:none;">
        <table>
            <tr><td>Tutor</td><td><input id="tutorTag" /></td></tr>
            <tr><td></td><td><input type="button" value="Save" onclick="Submit();" /></td></tr>
        </table>
    </div>
</asp:Content>
