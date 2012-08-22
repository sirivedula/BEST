<%@ Page Title="Best - Mass EMail" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="BestMassEMail.aspx.cs" Inherits="BaliEnterpriseSystems.BestMassEMail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    .tblSelect { border:1px solid #999; border-radius:5px; font-family:Tahoma;}
    .tblSelect input {font-family:Tahoma;}
</style>
<script type="text/javascript">
    $(document).ready(function() {
        $('#fromdate,#todate').mask('99/99/9999');
        $('#fromdate,#todate').datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });
    });

    function submit() {
        $("form:first").submit();
    }
    function ToggleCheck() {
        $('#available').find('tbody').find('input:checkbox').each(function(idx, ele) {
            if ($(ele)[0].id != "checkAll") {
                if ($(ele).is(':checked')) {
                    $(ele).removeAttr('checked');
                } else {
                    $(ele).attr('checked', 'checked');
                }
            }
        });
    }
    function sendEMail() {
        var n = $('input:checked').length;
        if (n > 0) {
            var cansend = $('#selEmailTemplate').val().length > 0 || $('#emailDesc').val().length > 0;
            if (cansend) {
                $('#sendEMailClicked').val('1');
                submit();
            } else {
                alert('Please select EMail Template or Enter EMail Description');
            }
        } else {
            alert('Please select ' + $('#selWho').val());    
        }
    }
    function filterSubmit(filtval) {
        var selFiltval = $('#selFilter').val();
        if (selFiltval.length > 0 && filtval.length > 0) {
            submit();
        }
    }
</script>
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
			        <div>
			        <table class="tblSelect" cellpadding="0" cellspacing="0" style="padding:5px;">
			            <tr><td>Student/Tutor</td><td>EMail Template</td><td>Schedule From</td><td>Schedule To</td></tr>
			            <tr><td><select name="selWho" id="selWho" onchange="submit()"><asp:Literal ID="selWhoOpts" runat="server"></asp:Literal></select></td><td><select name="selEmailTemplate" id="selEmailTemplate"><asp:Literal ID="ltrEMailTempOpts" runat="server"></asp:Literal></select></td><td><input type="text" id="fromdate" name="fromdate" size="10" maxlength="10" /></td><td><input type="text" id="todate" name="todate" size="10" maxlength="10" /></td></tr>
			     <tr><td style="border-bottom:1px solid #999;">&nbsp;</td><td  style="border-bottom:1px solid #999;" colspan="3">(OR)</td></tr>
			     <tr><td style="vertical-align:top;white-space:nowrap;">EMail Subject</td><td colspan="3"><input type="text" name="emailSubject" id="emailSubject" size="40" maxlength="50" /></td></tr>
			     <tr><td style="vertical-align:top;white-space:nowrap;">EMail Description</td><td colspan="3"><textarea name="emailDesc" id="emailDesc" cols="40" rows="5"></textarea> </td></tr>
			            <tr><td colspan="2">Filter</td></tr>
			            <tr><td><select name="selFilter" id="selFilter"><asp:Literal ID="ltrFilters" runat="server"></asp:Literal></select></td><td colspan="3"><input type="text" id="filtervalue" name="filtervalue" onblur="filterSubmit(this.value)" />(input filter value and press tab)</td></tr>          
			            <tr><td>&nbsp;</td><td><input type="button" id="btnSend" value="Send" onclick="sendEMail()" /><input type="hidden" id="sendEMailClicked" name="sendEMailClicked" /></td></tr>
			        </table>
                        </div>
			        <hr />
                        <asp:Literal ID="ltrGrid" runat="server"></asp:Literal>
			        </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
