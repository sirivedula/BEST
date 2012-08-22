<%@ Page Title="BEST - Student Plan" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="BestStudentPlan.aspx.cs" Inherits="BaliEnterpriseSystems.BestStudentPlan" EnableViewState="false"  ValidateRequest ="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/BestSTPlan.js?20110606" type="text/javascript"></script>
    <link rel="Stylesheet" href="js/bestPlanner.css?20110606" />
    
<script type="text/javascript">
    $(document).ready(function() {
        BestScheduler.Show();
        BestScheduler.extendToSchedule();

        setTimeout("BestScheduler.DrawSchedules();", 200);
    });
    function submit() {
        $("form:first").submit();
    }
</script>
<asp:Literal ID="ltrStdScript" runat="server">
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
            <div class="centered">
                <table id="tblStudentSel"><tr><td style="text-align:center;">Student: <select onchange="submit();" id="selstudent" name="selstudent"><asp:Literal ID="ltrStudentOpts" runat="server"></asp:Literal></select></td></tr>
                <tr><td>
	            <div style="border-top:5px solid #2952a3;width:100%;text-align:center;">
		            <table style="width:100%;font-family:Tahoma;font-size:11px;" cellspacing="0" cellpadding="0" border="0">
			            <tr>
				            <td id="tdPlanner" style="vertical-align:top;width:100%;">
					            <div id="divPlanner" style="border:1px solid #d9d9d9;background-color:#E9E9F3;">Planner Drawn Area</div>
				            </td>
			            </tr>
		            </table>            		
	            </div>       
	            </td></tr></table>
	        </div>
			        </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
