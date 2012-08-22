<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="EMailTemplates.aspx.cs" Inherits="BaliEnterpriseSystems.EMailTemplates" Title="BEST - EMail Templates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    $(document).ready(function(){
        $('#bestEMailDiv').css("display", "none");
    });
    
    function addNew(){
        BestJSGrid.addNew("bestEMailDiv", 400, 600);
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "bestEMailDiv", 400, 600);
    }
</script>
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
    <div id="bestEMailDiv">
        <table>
        <tr>
            <td class="ra">EMail Template Name</td><td><input type="text" id="emialTemplateName" name="emialTemplateName" size="25" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Template Description</td><td><textarea id="templateDescription" name="templateDescription" cols="60" rows="20"></textarea></td>
        </tr>
        <tr>
        <td class="ra" colspan="2"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>        
    </table>
</div>
</asp:Content>
