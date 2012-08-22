<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="BestCenterInfo.aspx.cs" Inherits="BaliEnterpriseSystems.BestCenterPageInfo" Title="BEST - Center Information"  EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
    $(document).ready(function(){
        $('#contactPhone').mask('(999) 999-9999');
        $('#bestCenterDiv').css("display", "none");
        BestJSGrid.requiredFields.push({ name: 'CenterId', description: 'Center Id' });
    });
    
    function addNew(){
        BestJSGrid.addNew("bestCenterDiv", 350, 350);
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "bestCenterDiv", 350, 350);
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
    <div id="bestCenterDiv">
        <table>
        <tr>
            <td class="ra">Center Id</td><td><input type="text" id="CenterId" name="CenterId" size="15" maxlength="30" /></td>
        </tr>
        <tr>
            <td class="ra">Address Line 1</td><td><input type="text" id="address1" name="address1" size="30" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Address Line 2</td><td><input type="text" id="address2" name="address2" size="30" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">City</td><td><input type="text" id="city" name="city" size="15" maxlength="30" />
            </td>
        </tr>
        <tr><td class="ra">State</td><td><select id="state" name="state"><asp:Literal ID="ltrState" runat="server"></asp:Literal></select></td></tr>
        <tr><td class="ra">Zip</td><td><input type="text" size="10" id="zip" name="zip" maxlength="10" /></td></tr>
        <tr>
            <td class="ra">Contact Name</td><td><input type="text" id="contactName" name="contactName" size="30" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Phone Number</td><td><input type="text" id="contactPhone" name="contactPhone" size="15" maxlength="15" /></td>
        </tr>
        <tr>
            <td class="ra">E-Mail Address</td><td><input type="text" id="contactEMail" name="contactEMail" size="30" maxlength="80" /></td>
        </tr>
        <tr>
        <td class="ra" colspan="2"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>
        </table>
    </div>

</asp:Content>
