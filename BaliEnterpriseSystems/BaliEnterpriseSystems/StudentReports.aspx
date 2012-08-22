<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="StudentReports.aspx.cs" Inherits="BaliEnterpriseSystems.StudentReports" Title="BEST - Student Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    .tblreports { width:90%; }
    .ra { text-align:right; }
</style>

<script type="text/javascript">
    $(document).ready(function(){
        $('#fromdate,#todate').mask('99/99/9999');
        $('#fromdate,#todate').datepicker({showOn:'button', buttonImage:'images/date.png', buttonImageOnly:true, changeYear:true, changeMonth:true });        
        $('#fromdate').focus();
    });
    
    function submit(){
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
</asp:Content>
