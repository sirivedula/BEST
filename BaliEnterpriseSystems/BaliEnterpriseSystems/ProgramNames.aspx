<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="ProgramNames.aspx.cs" Inherits="BaliEnterpriseSystems.ProgramNames" Title="BEST - Program Names" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
    <script type="text/javascript">
    $(document).ready(function(){
        $('#programNameDiv').css("display", "none");
    });
    
    function addNew(){
        BestJSGrid.addNew("programNameDiv", 200, 350);
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "programNameDiv", 200, 350);
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
    <div id="programNameDiv">
        <table>
        <tr>
            <td class="ra">Program Name</td><td><input type="text" id="programName" name="programName" size="30" /></td>
        </tr>
        <tr>
            <td class="ra">Program Type</td><td><select id="programType" name="programType">
            <asp:Literal ID="ltrprgTypeOptions" runat="server"></asp:Literal></select></td>
        </tr>
        <tr>
            <td class="ra">Amount</td><td><input type="text" id="amount" name="amount" size="10" maxlength="10" /></td>
        </tr>
        <tr>
            <td class="ra">Amount Type</td><td><select id="amountType" name="amountType">
            <option value=""></option><option value="Hour">Per Hour</option><option value="Day">Per Day</option>
            <option value="Week">Per Week</option><option value="Month">Per Month</option><option value="Year">Per Year</option><option value="OneTime">One Time</option></select></td>
        </tr>
        <tr>
        <td class="ra" colspan="2"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>
        </table>
    </div>

</asp:Content>
