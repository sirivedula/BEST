<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="SchedulesInfo.aspx.cs" Inherits="BaliEnterpriseSystems.SchedulesInfo" Title="BEST - Schedules Information"  EnableViewState="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="Stylesheet" href="js/bestPlanner.css?20110530" />
<script src="js/bestPlanner.js?20111126" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#radio,#radioHrs,#show6To2Div").buttonset();

        $('#xCopyFromDate,#xCopyToDate').mask('99/99/9999');
        $('#xCopyFromDate,#xCopyToDate').datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });

        $('#tutorTag').autocomplete({ source: autoTutors, delay: 0, select:
			function(event, ui) {
			    $('#' + this.id + '0').val(ui.item.value);
			    $("#tutorTag").val(ui.item.label);
			    return false;
			}
        });
        $('#studentTag1,#studentTag2,#studentTag3,#studentTag4,#studentTag5').autocomplete({ source: autoStudents, delay: 0, select: function(event, ui) {
            $('#' + this.id + '0').val(ui.item.value);
            $(this).val(ui.item.label);

            var guid = ui.item.value;
            var stdprogs = StudentPrograms.FindByGuid(guid);
            var pid = 'progTag' + this.id.replace('studentTag', '');
            var innerhtml = '';
            var defaultPGuid = '';
            for (var x in stdprogs) {
                innerhtml += stdprogs[x].ToHTML(pid);
                if (defaultPGuid == '') defaultPGuid = stdprogs[x].guidfield;
            }
            $('#' + pid).html(innerhtml);
            setProgramBold(pid, defaultPGuid);
            return false;
        }
        });
    });
    
	function submit(){
		$('form:first').submit();
	}    
	
	function timeChangeSubmit(){
	    $('#hdTimeChangeClicked').val('1');
	    submit();
	}
	
	function Show6To9Submit(id){
	    $('#'+id).val('1');
	    submit();
	}
	
	function dayNavigation(direction){
	    $('#plannerDateNav').val( direction );
	    $('#curPlannerDate').val( BestPlanner.ToMMddyyyy(BestPlanner.plannerDate) );
	    submit();
	}

	function CopySchedules() {
	    $("#divCopySch").dialog({title:"Copy Schedules - Day or Week"});
	}

	function CopySchSubmit(copyType) {
	    $('#IsCopyDayorWeek').val(copyType);
	    $("#CopyFromWeekDate").val( $("#xCopyFromWeekDate").val());
	    $("#CopyToWeekDate").val( $("#xCopyToWeekDate").val());
	    $("#CopyFromDate").val( $("#xCopyFromDate").val());
	    $("#CopyToDate").val($("#xCopyToDate").val());
	    submit();
	} 
</script>
<asp:Literal ID="ltrTimeSlices" runat="server">
</asp:Literal>
<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>    
<asp:Literal ID="ltrScript" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:Literal ID="ltrMsg" runat="server"></asp:Literal>
	<div style="border-top:5px solid #2952a3;width:100%;text-align:center;padding-bottom:100px;">
		<table style="width:100%;font-family:Tahoma;font-size:11px;" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td style="background-color:#fff;border-bottom:1px solid #884a0a;padding-top:2px;padding-bottom:2px;">
					<table style="font-family:Tahoma;font-size:11px;width:100%;" cellspacing="0" cellpadding="0" border="0">
					<tr>
					    <td>
					        <div style="float:left;padding-left:20px;">
					            <img alt="previous" src="images/date_previous.png" onclick="dayNavigation(-1);" class="imgarrows" title="Previous" />&nbsp;
					            <img class="imgarrows" src="images/date_next.png" onclick="dayNavigation(1);" title="Next" alt="Next" />&nbsp;
					            <a style="border:0px; text-decoration:none;" href="javascript:void(0);" onclick="CopySchedules();">
					            <img alt="Save" style="cursor:pointer;border:0px;" src="images/page_copy.png" title="Copy Schedules" /></a>&nbsp;
					            <a style="vertical-align:top;font-weight:bold;color:#fff;" href="javascript:void(0);" onclick="Save();" >Save</a>
					        </div>
					    </td>
					<td style="width:180px;"><div style="float:left;" id="show6To2Div"><asp:Literal ID="ltrshow6To2" runat="server"></asp:Literal></div>
					&nbsp;<div id="show2To9Div" style="float:right;"><asp:Literal ID="ltrshow2To9" runat="server"></asp:Literal></div></td>
					<td>
						<span style="font-family:Georgia;font-size:16px;padding-left:20px;width:100%;text-align:center;color:#FFF;font-weight:bold;text-decoration:underline;">Student Planner</span>
					</td>
					<td><div id="radioHrs"><asp:Literal ID="ltrTimeHrs" runat="server"></asp:Literal></div></td>
					<td><div id="radioOneorGroup"><asp:Literal ID="ltrOneorGroup" runat="server"></asp:Literal></div></td>
					<td style="text-align:right; padding-right:20px;">
						<div id="radio">
						    <asp:Literal ID="radioHtml" runat="server"></asp:Literal>
						</div>
					</td>
					</tr>
					</table>
				</td>
				<td><input type="text" id="search" size="7" />&nbsp;<img style="cursor:pointer;"src="images/search.png" alt="..." /></td>
			</tr>
			<tr>
				<td id="tdPlanner" style="vertical-align:top;width:100%;"><div id="divPlanner" style="border:1px solid #d9d9d9;background-color:#E9E9F3;">Planner Drawn Area</div></td>
				<td style="width:80px;vertical-align:top;" id="tdRest">Students & Tutors Area</td>
			</tr>
		</table>
		<input type="hidden" id="plannerDateNav" name="plannerDateNav" value="" />
		<input type="hidden" id="curPlannerDate" name="curPlannerDate" value="" />
	</div>
	
	<!-- Schedule Dialog Div -->
	<div style="display:none;" id="showScheduleDiv">
		<table>
			<tr>
				<td class="ra">Tutor</td>
				<td><input id="tutorTag" /><input type="hidden" id="tutorTag0" name="tutorTag0" /></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="ra">Student #1</td>
				<td><input id="studentTag1" /><input type="hidden" id="studentTag10" name="studentTag10" /></td>
				<td><div id="progTag1"></div></td>
			</tr>
			<tr>
				<td class="ra">Student #2</td>
				<td><input id="studentTag2" /><input type="hidden" id="studentTag20" name="studentTag20" /></td>
				<td><div id="progTag2"></div></td>
			</tr>
			<tr>
				<td class="ra">Student #3</td>
				<td><input id="studentTag3" /><input type="hidden" id="studentTag30" name="studentTag30" /></td>
				<td><div id="progTag3"></div></td>
			</tr>
			<tr>
				<td class="ra">Student #4</td>
				<td><input id="studentTag4" /><input type="hidden" id="studentTag40" name="studentTag40" /></td>
				<td><div id="progTag4"></div></td>
			</tr>
			<tr>
				<td class="ra">Student #5</td>
				<td><input id="studentTag5" /><input type="hidden" id="studentTag50" name="studentTag50" /></td>
				<td><div id="progTag5"></div></td>
			</tr>
			<tr><td class="ra" style="vertical-align:top;">From</td>
				<td style="line-height:17px;">
					<div style="line-height:17px;width:85px;"><div style="float:left;"><select id="fromHour" name="fromHour">
					<option value="630">6:30 AM</option>
<option value="700">7:00 AM</option>
<option value="730">7:30 AM</option>
<option value="800">8:00 AM</option>
<option value="830">8:30 AM</option>
<option value="900">9:00 AM</option>
<option value="930">9:30 AM</option>
<option value="1000">10:00 AM</option>
<option value="1030">10:30 AM</option>
<option value="1100">11:00 AM</option>
<option value="1130">11:30 AM</option>
<option value="1200">12:00 PM</option>
<option value="1230">12:30 PM</option>
<option value="1300">1:00 PM</option>
<option value="1330">1:30 PM</option>
<option value="1400">2:00 PM</option>
<option value="1430">2:30 PM</option>
<option value="1500">3:00 PM</option>
<option value="1530">3:30 PM</option>
<option value="1600">4:00 PM</option>
<option value="1630">4:30 PM</option>
<option value="1700">5:00 PM</option>
<option value="1730">5:30 PM</option>
<option value="1800">6:00 PM</option>
<option value="1830">6:30 PM</option>
<option value="1900">7:00 PM</option>
<option value="1930">7:30 PM</option>
<option value="2000">8:00 PM</option>
<option value="2030">8:30 PM</option>
<option value="2100">9:00 PM</option>
<option value="2130">9:30 PM</option>
<option value="2200">10:00 PM</option>
<option value="2230">10:30 PM</option>
</select>
</div>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr><td class="ra" style="vertical-align:top;">To</td>
				<td>
					<div style="line-height:17px;width:85px;"><div style="float:left;"><select id="toHour" name="toHour">
					<option value="630">6:30 AM</option>
<option value="700">7:00 AM</option>
<option value="730">7:30 AM</option>
<option value="800">8:00 AM</option>
<option value="830">8:30 AM</option>
<option value="900">9:00 AM</option>
<option value="930">9:30 AM</option>
<option value="1000">10:00 AM</option>
<option value="1030">10:30 AM</option>
<option value="1100">11:00 AM</option>
<option value="1130">11:30 AM</option>
<option value="1200">12:00 PM</option>
<option value="1230">12:30 PM</option>
<option value="1300">1:00 PM</option>
<option value="1330">1:30 PM</option>
<option value="1400">2:00 PM</option>
<option value="1430">2:30 PM</option>
<option value="1500">3:00 PM</option>
<option value="1530">3:30 PM</option>
<option value="1600">4:00 PM</option>
<option value="1630">4:30 PM</option>
<option value="1700">5:00 PM</option>
<option value="1730">5:30 PM</option>
<option value="1800">6:00 PM</option>
<option value="1830">6:30 PM</option>
<option value="1900">7:00 PM</option>
<option value="1930">7:30 PM</option>
<option value="2000">8:00 PM</option>
<option value="2030">8:30 PM</option>
<option value="2100">9:00 PM</option>
<option value="2130">9:30 PM</option>
<option value="2200">10:00 PM</option>
<option value="2230">10:30 PM</option>
</select></div>				
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
	</div>
	
	<input type="hidden" id="IsCopyDayorWeek" name="IsCopyDayorWeek" />
	<input type="hidden" name="CopyFromWeekDate" id="CopyFromWeekDate" />
	<input type="hidden" id="CopyToWeekDate" name="CopyToWeekDate" />
	<input type="hidden" name="CopyFromDate" id="CopyFromDate" />
	<input type="hidden" name="CopyToDate" id="CopyToDate" />
	
	<div id="divCopySch" style="display:none;">
	    <table style="width:100%;">
	        <tr><td>Copy Day</td><td>Copy Week</td></tr>
	        <tr><td><input type="text" id="xCopyFromDate" size="10" maxlength="10" /></td><td><select id="xCopyFromWeekDate" ><asp:Literal ID="ltrCopyFromWeek" runat="server"></asp:Literal></select>
</td></tr>
	        <tr><td><input type="text" id="xCopyToDate" size="10" maxlength="10" /></td><td><select id="xCopyToWeekDate" ><asp:Literal ID="ltrCopyToWeek" runat="server"></asp:Literal></select>
</td></tr>
            <tr><td><input type="button" value="Copy Day" onclick="CopySchSubmit('Day');" /></td><td><input type="button" value="Copy Week" onclick="CopySchSubmit('Week');" /></td></tr>
	    </table>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div id="attendanceDiv" style="text-align:center; font-family:Myriad Condensed Web;font-size:medium;display:none">
        <div id="divAttend" onclick="setbackground(0);" onmouseover="this.style.backgroundColor='#F9999F';" onmouseout="this.style.backgroundColor='#F4F0EC'" style="cursor:pointer;border-top:1px solid #000;border-left:1px solid #000;border-right:1px solid #000;">Attended</div>
        <div id="divInformed" onclick="setbackground(1);" onmouseover="this.style.backgroundColor='#F9999F';" onmouseout="this.style.backgroundColor='#F4F0EC'" style="cursor:pointer;border-top:1px solid #000;border-left:1px solid #000;border-right:1px solid #000;">Informed</div>
        <div id="divAbsent" onclick="setbackground(2);" onmouseover="this.style.backgroundColor='#F9999F';" onmouseout="this.style.backgroundColor='#F4F0EC'" style="cursor:pointer;border:1px solid #000;">Absent</div>
        <div style="font-size:small" id="divNotes">Notes: <input type="text" id="notes" name="notes" size="25" /></div>
    </div>
</asp:Content>
