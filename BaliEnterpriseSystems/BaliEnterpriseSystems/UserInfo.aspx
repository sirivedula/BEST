<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="BaliEnterpriseSystems.UserInfo" Title="BEST - User Information"  EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function() {
            $('#cellPhone,#homePhone,#workPhone').mask('(999) 999-9999');
            $('#bestUserDiv').css("display", "none");
            BestJSGrid.requiredFields.push({ name: 'firstName', description: 'First Name' },
            { name: 'lastName', description: 'Last Name' },
            { name: 'userName', description: 'User Name' },
            { name: 'cellPhone', description: 'Cell Phone' },
            { name: 'emailId', description: 'E-Mail Address' },
            { name: 'Centers', description: 'Available To Centers' });
        });
    function addNew(){
        BestJSGrid.addNew("bestUserDiv", 550, 400);
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "bestUserDiv", 550, 400);
    }
    
    function resetPassword(){        
        $('form:first').submit();
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
    <div id="bestUserDiv">
        <table>
        <tr>
            <td class="ra">User Name *</td><td><input type="text" id="userName" name="userName" size="30" maxlength="80" /></td>
        </tr>
        <tr>
            <td class="ra">First Name *</td><td><input type="text" id="firstName" name="firstName" size="30" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Last Name *</td><td><input type="text" id="lastName" name="lastName" size="30" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Middle Name</td><td><input type="text" id="middleName" name="middleName" size="30" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Gender</td><td><select id="gender" name="gender"><option value=""></option><option value="Male">Male</option><option value="Female">Female</option></select></td>
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
            <td class="ra">Cell Phone *</td><td><input type="text" id="cellPhone" name="cellPhone" size="15" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Work Phone</td><td><input type="text" id="workPhone" name="workPhone" size="15" maxlength="15" /></td>
        </tr>
        <tr>
            <td class="ra">Home Phone</td><td><input type="text" id="homePhone" name="homePhone" size="15" maxlength="15" /></td>
        </tr>
        <tr>
            <td class="ra">E-Mail Address *</td><td><input type="text" id="emailId" name="emailId" size="30" maxlength="80" /></td>
        </tr>
        <tr>
            <td class="ra">Available To Centers</td><td><input type="text" id="Centers" name="Centers" size="30" maxlength="1000" /></td>
        </tr>
        <tr>
            <td class="ra">User Type</td><td><select id="userType" name="userType">
            <option value="Admin">Admin</option>
            <option value="Manager">Manager</option>
            <option value="CenterHead">Center Head</option>
            <option value="Clerk">Clerk</option>
            </select></td>
        </tr>
        <tr>
        <td class="ra" colspan="2"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" />
        </td>
        </tr>
        </table>
    </div>
</asp:Content>
