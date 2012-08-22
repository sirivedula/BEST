<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="BestPaymentTypes.aspx.cs" Inherits="BaliEnterpriseSystems.BestPaymentTypes" Title="BEST - Payment Types" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
    $(document).ready(function(){
        $('#bestpaymentDiv').css("display", "none");
    });
    
    function addNew(){
        BestJSGrid.addNew("bestpaymentDiv", 150, 350);
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "bestpaymentDiv", 150, 350);
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
    <div id="bestpaymentDiv">
        <table>
        <tr>
            <td class="ra">Payment Type</td><td><input type="text" id="paymentType" name="paymentType" size="30" /></td>
        </tr>
        <tr>
        <td class="ra" colspan="2"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>
        </table>
    </div>
</asp:Content>
