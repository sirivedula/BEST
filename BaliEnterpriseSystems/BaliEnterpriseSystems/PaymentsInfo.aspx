<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="PaymentsInfo.aspx.cs" Inherits="BaliEnterpriseSystems.PaymentsInfo" Title="BEST - Payments Information" EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
    var autoStudents = [];
    $(document).ready(function(){
        $('#bestpaymentDiv').css("display", "none");
        $('#paymentDate').mask('99/99/9999');
        $('#paymentDate').datepicker({showOn:'button', buttonImage:'images/date.png', buttonImageOnly:true, changeYear:true, changeMonth:true });        
    });
    
    function gridfillDefaults(rownum){
        $('#paymentDate').val(toMMddyyyy());
        var stdguid = $('#studentGuid').val();
        for(var i=0; i<autoStudents.length;i++){
            var stdx = autoStudents[i];
            if(stdx.value == stdguid){
                $('#studentTag1').val(stdx.label);
                break;
            }
        }
    }
    
    function addNew(){            
        BestJSGrid.addNew("bestpaymentDiv", 220, 350);
    }
    
    function toMMddyyyy(){
        var dd = new Date();
        var mm = dd.getMonth()+1;
        return (mm<9?'0'+mm:mm)+'/'+(dd.getDate()<9?'0'+dd.getDate():dd.getDate())+'/'+dd.getFullYear();
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "bestpaymentDiv", 220, 350);
    }
    
</script>
<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>
<asp:Literal ID="ltrScript" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:Literal ID="ltrValidateMsg" runat="server"></asp:Literal>
    <div class="MidCenDiv">
	    <div class="ContentCenDiv">
    	    <div class="ContentbrdrDiv">
			    <div class="LeftNav">
				    <ul>
                        <asp:Literal ID="ltrSubMenu" runat="server"></asp:Literal>
				    </ul>
			    </div>
                    <div><asp:Literal ID="Literal1" runat="server"></asp:Literal></div>
			        <div class="CAreaDiv">
                    <asp:Literal ID="ltrGrid" runat="server"></asp:Literal>
			        </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
<div id="bestpaymentDiv">
        <table>
        <tr>
            <td class="ra">Payment Type</td><td><select id="paymentTypeGuid" name="paymentTypeGuid"><asp:Literal ID="ltrPayTypes" runat="server"></asp:Literal></select></td>
        </tr>
        <tr>
            <td class="ra">Student Name</td>
		    <td><input id="studentTag1" /><input type="hidden" id="studentGuid" name="studentGuid" /></td>
        </tr>
        <tr>
            <td class="ra">Payment Date</td><td><input type="text" size="10" maxlength="10" id="paymentDate" name="paymentDate" /></td>
        </tr>
        <tr>
            <td class="ra">Amount</td><td><input type="text" id="amount" name="amount" size="10" maxlength="12" /></td>
        </tr>
        <tr>
            <td class="ra">Hours</td><td><input type="text" id="hours" name="hours" size="10" maxlength="12" /></td>
        </tr>
        <tr>
        <td class="ra" colspan="2"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>
        </table>
    </div>
</asp:Content>
