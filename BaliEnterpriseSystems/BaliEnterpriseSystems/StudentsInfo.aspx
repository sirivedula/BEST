<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="StudentsInfo.aspx.cs" Inherits="BaliEnterpriseSystems.StudentsPageInfo" Title="BEST - Students Information"  EnableViewState="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
    var jsProg = [];

    $(document).ready(function() {
        $('#cellPhone,#homePhone,#workPhone').mask('(999) 999-9999');
        $('#joinDate,#birthDate').mask('99/99/9999');
        $('#joinDate,#birthDate').datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });
        $('#divStudentInfo').css("display", "none");
        BestJSGrid.requiredFields.push({ name: 'firstName', description: 'First Name' },
        { name: 'lastName', description: 'Last Name' },
        { name: 'StudentId', description: 'Student Id' },
        { name: 'CenterId', description: 'Center Id' });
    });
    
    function addNew(){
        // BestJSGrid.addNew("divStudentInfo", 400, 750);
        location = "StudentForm.aspx?ms=3&submitMode=add";
    }

    function editForm(rownum) {
		var currow = gridJS.Rows[rownum];
		if (typeof currow != 'undefined') {
		    var guid = currow["guidfield"];
		    location = "StudentForm.aspx?ms=3&submitMode=edit&studentguid=" + encodeURIComponent(guid);
		} else {
		    alert("Student Record Not Found.");
		}
    }
    
    function updateAmtType(proguid){
        for(var x in jsProg){
            if(jsProg[x].guid == proguid){
                $('#amountType').val(jsProg[x].amountType);
                $('#Amount').val(jsProg[x].amount);
            }
        }
    }
</script>
<asp:Literal ID="ltrProgScript" runat="server">
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
<div id="divStudentInfo">
    <table>
        <tr><td class="ra">Student Id *</td><td><input type="text" size="9" maxlength="10" id="StudentId" name="StudentId" /></td>
            <td class="ra">Center Id *</td><td><select id="CenterId" name="CenterId"><asp:Literal id="ltrCenters" runat="server"></asp:Literal></select></td></tr>
        <tr><td class="ra">First Name *</td><td><input type="text" id="firstName" name="firstName" maxlength="50" /></td>
            <td class="ra">Last Name *</td><td><input type="text" id="lastName" name="lastName" maxlength="50" /></td></tr>
        <tr><td class="ra">Middle Name</td><td><input type="text" id="middleName" name="middleName" maxlength ="50" /></td>
            <td class="ra">Parent Name</td><td><input type="text" name="parentName" id="parentName" maxlength="80" /></td></tr>
        <tr><td class="ra">Joining Date</td><td><input type="text" size="10" maxlength="10" id="joinDate" name="joinDate" /></td>
            <td class="ra">Birth Date</td><td><input type="text" size="10" maxlength="10" id="birthDate" name="birthDate" /></td></tr>
        <tr><td class="ra">Address 1</td><td><input type="text" id="address1" name="address2" maxlength="50" /></td>
            <td  class="ra">Address 2</td><td><input type="text" id="address2" name="address2" /></td></tr>
        <tr><td class="ra">City</td><td><input type="text" id="city" name="city" maxlength="50" /></td>
            <td  class="ra">State</td><td class="la"><select id="state" name="state"><asp:Literal ID="ltrStateOpts" runat="server"></asp:Literal></select></td></tr>
        <tr><td class="ra">Zip</td><td class="la"><input type="text" id="zip" name="zip" size="9" /></td>
            <td class="ra">Cell Phone</td><td><input type="text" id="cellPhone" name="cellPhone" size="15" maxlength="50" /></td></tr>
        <tr><td class="ra">Work Phone</td><td><input type="text" id="workPhone" name="workPhone" size="15" maxlength="15" /></td>
            <td class="ra">Home Phone</td><td><input type="text" id="homePhone" name="homePhone" size="15" maxlength="15" /></td>
        </tr>
        <tr><td class="ra">E-Mail</td><td><input type="text" id="emailId" name="emailId" size="30" maxlength="80" /></td>
            <td class="ra">Program Name</td><td><select id="programGuid" name="programGuid" onchange="updateAmtType(this.value);"><asp:Literal ID="ltrPrograms" runat="server"></asp:Literal></select></td>
        </tr>
        <tr><td class="ra">Hours</td><td><input type="text" id="Hours" name="Hours" size="9" maxlength="10" /></td>
            <td class="ra">Hours Type</td><td><select id="hourType" name="hourType"><option value=""></option><option value="Day">Per Day</option>
            <option value="Week">Per Week</option><option value="Month">Per Month</option></select></td>
        </tr>
        <tr><td class="ra">Amount</td><td><input type="text" id="Amount" name="Amount" size="9" maxlength="10" /></td>
            <td class="ra">Amount Type</td><td><select id="amountType" name="amountType"><option value=""></option><option value="Hour">Per Hour</option><option value="Day">Per Day</option>
            <option value="Week">Per Week</option><option value="Month">Per Month</option></select></td>
        </tr>
        <tr>
            <td class="ra" colspan="4"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>
        
    </table>
</div>
</asp:Content>
