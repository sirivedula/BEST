<%@ Page Title="" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="BestStudentSchedule.aspx.cs" Inherits="BaliEnterpriseSystems.BestStudentSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    $(document).ready(function() {
        $('#fromdate,#todate').mask('99/99/9999');
        $('#fromdate,#todate').datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });
    });

    function submit() {
        $("form:first").submit();
    }

    function SendEMail() {
        $('#sendEMailClick').val("1");
        submit();
    }
    
</script>

<asp:Literal ID="ltrStdScript" runat="server">
</asp:Literal>
<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>

<asp:Literal ID="ltrLoadScript" runat="server"></asp:Literal>
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
            <div class="centered">
                <table id="tblStudentSel"><tr><td colspan="3" style="text-align:center;">Student: <select onchange="submit();" id="selstudent" name="selstudent"><asp:Literal ID="ltrStudentOpts" runat="server"></asp:Literal></select></td></tr>
                <tr><td style="text-align:right;"><input type="text" id="fromdate" name="fromdate" size="10" maxlength="10" /></td><td><input type="text" id="todate" name="todate" size="10" maxlength="10" /></td><td><input type="button" id="btnRefresh" value="Refresh" onclick="submit();" /></td></tr>
                <tr><td colspan="3">
	            <div style="border-top:5px solid #2952a3;width:100%;text-align:center;">
		            <table style="width:100%;font-family:Tahoma;font-size:11px;" cellspacing="0" cellpadding="0" border="0">
			            <tr>
				            <td id="tdPlanner" style="vertical-align:top;width:100%;">
                                <asp:Literal ID="ltrSchdules" runat="server">
                                </asp:Literal>				            
                            </td>
			            </tr>
		            </table>            		
	            </div>       
	            </td></tr>
	            <tr><td colspan="3"><asp:Literal ID="ltrEMessage" runat="server"></asp:Literal></td></tr>
	            <tr><td colspan="3"><input id="sendEMailClick" name="sendEMailClick"  type="hidden" /><input type="button" id="btnEMail" value="Send EMail" onclick="SendEMail();"/></td></tr>
	            </table>
	        </div>
			        </div>
		    </div>
	    </div>    	
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
