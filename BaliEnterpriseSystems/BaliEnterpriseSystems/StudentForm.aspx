<%@ Page Title="BEST - Student Form" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="StudentForm.aspx.cs" Inherits="BaliEnterpriseSystems.StudentForm" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    .tblHeader {background-color:#884a0a;color:#FFF;font-weight:bold;padding:2px;border-top-left-radius: 5px; border-top-right-radius: 5px;}
    input { font-family:Tahoma; }
</style>
    <script type="text/javascript">
        var jsProg = [];
        var programopts = '';
        var relationopts = '';
        var studentProg = [];
        var pickupInfo = [];
        var studentGPA = [];
        var parentNameId = 'parentName';
        var payeenameId = 'paymentname1';
        
        $(document).ready(function() {
            $('#assessdate0').mask('99/99/9999');
            $('#assessdate0').datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });

            programopts = $("#programname0").html().replace("selected", "");
            relationopts = $('#relationship0').html().replace("selected", "");
            fillPrograms();
            fillPickupInfo();
            fillStudentGPA();
        });

        function fillPrograms() {
            for (var x in studentProg) {
                var Idx = studentProg[x].Index;
                if (Number(x) > 0) {
                    var rowHTML = '<tr><td id="tdRow' + x + '">#' + (Idx + 1) + '</td>';
                    rowHTML += '<td>Program Name</td><td><select id="programname' + Idx + '" name="programname' + Idx + '" onchange="updateAmtType(this.value, \'' + Idx + '\', true);">' + programopts + '</select></td><td><input type="text" size="9" maxlength="10" id="tdAmount' + Idx + '" name="tdAmount' + Idx + '" onblur="updateProgramAmount(' + Idx + ',this.value);" /></td><td id="tdAmountType' + Idx + '">Per Hour</td><td><img src="images/cancel.png" alt="delete" onclick="deleteLine(' + x + ',studentProg,\'tblPrograms\');" />';
                    var $added = $('#tblPrograms > tbody:last').append(rowHTML);
                }
                $("#programname" + x).val(studentProg[x].progGuid);
                updateAmtType(studentProg[x].progGuid, x, false);
            }
        }

        function fillPickupInfo() {
            for (var x in pickupInfo) {
                var Idx = pickupInfo[x].Index;
                if (Number(x) > 0) {
                    var rowHTML = '<tr><td id="tdRow' + x + '">#' + (Idx + 1) + '</td>';
                    rowHTML += '<td class="ra">Name</td><td><input onblur="updatePickupInfo(' + x + ',\'contactName\', this.value);" type="text" id="pickupname' + Idx + '" name="pickupname' + Idx + '" /></td><td class="ra">Contact</td><td><input onblur="updatePickupInfo(' + x + ',\'contactPhone\', this.value);" type="text" size="15" id="contact' + Idx + '" name="contact' + Idx + '" /></td><td>Relationship</td><td><select onchange="updatePickupInfo(' + x + ',\'relationShip\', this.value);" id="relationship' + Idx + '" name="relationship' + Idx + '">' + relationopts + '</select></td><td><img src="images/cancel.png" alt="delete" onclick="deleteLine(' + x + ',pickupInfo,\'tblPickupInfo\');" />';
                    var $added = $('#tblPickupInfo > tbody:last').append(rowHTML);
                    $('#contact' + Idx).mask('(999) 999-9999');
                }
                $('#pickupname' + Idx).val(pickupInfo[x].contactName);
                $('#contact' + Idx).val(pickupInfo[x].contactPhone);
                $('#relationship' + Idx).val(pickupInfo[x].relationShip);
            }
        }

        function fillStudentGPA() {
            for (var x in studentGPA) {
                var Idx = studentGPA[x].Index;
                if (Number(x) > 0) {
                    var rowHTML = '<tr><td id="tdRow' + x + '">#' + (Idx + 1) + '</td>';
                    rowHTML += '<td class="ra">Assessment Date</td><td><input onchange="updateGPA(' + x + ',\'AssessDate\', this.value);" type="text" name="assessdate' + Idx + '" id="assessdate' + Idx + '" maxlength="10" size="9" /></td><td class="ra">Grade Point Average</td><td><input onblur="updateGPA(' + x + ',\'GradeAvg\', this.value);" type="text" id="gpa' + Idx + '" name="gpa' + Idx + '" size="8" maxlength="6" /></td><td>Assessment Level</td><td><select onchange="updateGPA(' + x + ',\'AssessLevel\', this.value);" id="assessLevel' + Idx + '" name="assessLevel' + Idx + '"><option value=""></option><option value="Below Grade Level">Below Grade Level</option><option value="At Grade Level">At Grade Level</option><option value="Advanced">Advanced</option></select></td>';
                    var $added = $('#tblAssessment > tbody:last').append(rowHTML);
                    $('#assessdate' + Idx).mask('99/99/9999');
                    $('#assessdate' + Idx).datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });
                }
                $('#assessdate' + Idx).val(studentGPA[x].AssessDate);
                $('#gpa' + Idx).val(studentGPA[x].GradeAvg);
                $('#assessLevel' + Idx).val(studentGPA[x].AssessLevel);
            }
        }

        function updateAmtType(proguid, progIdx, selChange) {
            var rowid = studentProg[progIdx].Index;
            studentProg[progIdx].progGuid = proguid;
            for (var x in jsProg) {
                if (jsProg[x].guid == proguid) {
                    $('#tdAmountType' + rowid).html(jsProg[x].amountType);
                    if (selChange) {
                        $('#tdAmount' + rowid).val(jsProg[x].amount);
                        studentProg[progIdx].Amount = jsProg[x].amount;
                    } else {
                        $('#tdAmount' + rowid).val(studentProg[progIdx].Amount);
                    }
                }
            }
        }

        function updateProgramAmount(idx, amount) {
            studentProg[idx].Amount = amount;
        }

        function deleteLine(jsIndex, jsObj, tblId) {
            if (confirm("do you want to delete " + tblId.replace("tbl","") + " ?")) {
                var idx = jsObj[jsIndex].Index;
                jsObj[jsIndex].isDeleted = true;
                $($('#'+tblId+'  > tbody > tr')[idx]).empty().remove();
                //Re Index After Remove
                idx = 0;
                for (var x in jsObj) {
                    if (!jsObj[x].isDeleted) {
                        jsObj[x].Index = idx;
                        idx++;
                        $("#tdRow" + x).html("#" + idx);
                    }
                }
            }
        }

        function addProgramLine() {
            var Idx = getIndex(studentProg);
            var newguid = randomString();
            var rowHTML = '<tr><td id="tdRow' + studentProg.length + '">#' + (Idx + 1) + '</td>';
            rowHTML += '<td>Program Name</td><td><select id="programname' + Idx + '" name="programname' + Idx + '" onchange="updateAmtType(this.value, \'' + studentProg.length + '\', true);">' + programopts + '</select></td><td><input type="text" size="9" maxlength="10" id="tdAmount' + Idx + '" name="tdAmount' + Idx + '" onblur="updateProgramAmount(' + Idx + ',this.value);" /></td><td id="tdAmountType' + Idx + '">Per Hour</td><td><img src="images/cancel.png" alt="delete" onclick="deleteLine(' + studentProg.length + ',studentProg,\'tblPrograms\');" />';
            var $added = $('#tblPrograms > tbody:last').append(rowHTML);
            studentProg[studentProg.length] = { guid: newguid, progGuid: "", isDeleted: false, Index: Idx };
        }

        function addPickupInfo() {
			var Idx = getIndex(pickupInfo);
			var newguid = randomString();
			var newindex = pickupInfo.length;
			var rowHTML = '<tr><td id="tdRow' + newindex + '">#' + (Idx + 1) + '</td>';
			rowHTML += '<td class="ra">Name</td><td><input onblur="updatePickupInfo(' + newindex + ',\'contactName\', this.value);" type="text" id="pickupname' + Idx + '" name="pickupname' + Idx + '" /></td><td class="ra">Contact</td><td><input onblur="updatePickupInfo(' + newindex + ',\'contactPhone\', this.value);" type="text" size="15" id="contact' + Idx + '" name="contact' + Idx + '" /></td><td>Relationship</td><td><select id="relationship' + Idx + '" name="relationship' + Idx + '" onchange="updatePickupInfo(' + newindex + ',\'relationShip\', this.value);">' + relationopts + '</select></td><td><img src="images/cancel.png" alt="delete" onclick="deleteLine(' + newindex + ',pickupInfo,\'tblPickupInfo\');" />';
			var $added = $('#tblPickupInfo > tbody:last').append(rowHTML);
			pickupInfo[newindex] = { guid: newguid, contactName: "", contactPhone: "", relationShip: "", isDeleted: false, Index: Idx };
			$('#contact' + Idx).mask('(999) 999-9999');
        }

        function addAssessment() {
            var Idx = getIndex(studentGPA);
            var newguid = randomString();
            var newindex = studentGPA.length;
            var rowHTML = '<tr><td id="tdRow' + newindex + '">#' + (Idx + 1) + '</td>';
            rowHTML += '<td class="ra">Assessment Date</td><td><input onchange="updateGPA(' + newindex + ',\'AssessDate\', this.value);" type="text" name="assessdate' + newindex + '" id="assessdate' + newindex + '" maxlength="10" size="9" /></td><td class="ra">Grade Point Average</td><td><input onblur="updateGPA(' + newindex + ',\'GradeAvg\', this.value);" type="text" id="gpa' + newindex + '" name="gpa' + newindex + '" size="8" maxlength="6" /></td><td>Assessment Level</td><td><select onchange="updateGPA(' + newindex + ',\'AssessLevel\', this.value);" id="assessLevel' + newindex + '" name="assessLevel' + newindex + '"><option value=""></option><option value="Below Grade Level">Below Grade Level</option><option value="At Grade Level">At Grade Level</option><option value="Advanced">Advanced</option></select></td>';
            var $added = $('#tblAssessment > tbody:last').append(rowHTML);
            studentGPA[newindex] = {guid:newguid, AssessDate:"", GradeAvg:"", AssessLevel:"", isDeleted:false, Index: Idx};
            $('#assessdate' + newindex).mask('99/99/9999');
            $('#assessdate' + newindex).datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });
        }

        function updateGPA(idx, fieldname, fieldval) {
            studentGPA[idx][fieldname] = fieldval;
        }

        function updatePickupInfo(idx, fieldname, fieldval) {
            pickupInfo[idx][fieldname] = fieldval;
        }

        function getIndex(jsObj) {
            var idx = 0;
            for (var x in jsObj) {
                if (!jsObj[x].isDeleted) {
                    idx++;
                }
            }
            return idx;
        }

        function fillParentInfo(target) {
            $('#' + target).val($('#'+ parentNameId).val());
            $('#' + target).focus();
        }

        function doSaveClick() {
            $("#doSave").val("1");
            /* Prepare Programs Save */
            var progData = "";
            for (var x in studentProg) {
                progData += studentProg[x].guid + '\t' + studentProg[x].progGuid + '\t' + studentProg[x].Amount + '\t' + studentProg[x].isDeleted + '\n';
            }
            var pickupData = "";
            for (var x in pickupInfo) {
                pickupData += pickupInfo[x].guid + '\t' + pickupInfo[x].contactName + '\t' + pickupInfo[x].contactPhone + '\t' + pickupInfo[x].relationShip + '\t' + pickupInfo[x].isDeleted + '\n';
            }
            var assessData = "";
            for (var x in studentGPA) {
                assessData += studentGPA[x].guid + '\t' + studentGPA[x].AssessDate + '\t' + studentGPA[x].GradeAvg + '\t' + studentGPA[x].AssessLevel + '\t' + studentGPA[x].isDeleted + '\n';
            }
            
            $('#programsData').val(progData);
            $('#pickupInfoData').val(pickupData);
            $('#assessmentData').val(assessData);
            $("form:first").submit();
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
    <div class="centered">
    <table cellpadding="0" cellspacing="0" style="padding-top:10px;">

<!-- Student Information -->
        <tr><td class="tblHeader">&nbsp;Student Infomation</td></tr>
        <tr><td>
            <table style="border:1px solid #aa4a0a;width:100%;background-color:#EEE;">
            <tr>                
                <td class="ra">Center Id *</td><td><select runat="server" id="CenterId" name="CenterId"></select></td>
<td class="ra">Student Id *</td><td><input runat="server" type="text" size="9" maxlength="10" id="StudentId" name="StudentId" /></td>            </tr>
            <tr>
                <td class="ra">First Name *</td><td><input runat="server" type="text" id="firstName" name="firstName" maxlength="50" /></td>            
                <td class="ra">Last Name *</td><td><input type="text" runat="server" id="lastName" name="lastName" maxlength="50" /></td>
            </tr>            
            <tr>
                <td class="ra">Middle Name</td><td><input runat="server" type="text" id="middleName" name="middleName" maxlength ="50" /></td>
                <td class="ra">Parent Name</td><td><input runat="server" type="text" name="parentName" id="parentName" maxlength="80" /></td>
            </tr>            
            <tr>
                <td class="ra">Joining Date</td><td><input runat="server" type="text" size="10" maxlength="10" id="joinDate" name="joinDate" /></td>
                <td class="ra">Birth Date</td><td><input runat="server" type="text" size="10" maxlength="10" id="birthDate" name="birthDate" /></td>
            </tr>            
            <tr>
                <td class="ra">Address 1</td><td><input runat="server" type="text" id="address1" name="address2" maxlength="50" /></td>
                <td class="ra">Address 2</td><td><input runat="server" type="text" id="address2" name="address2" /></td>
            </tr>            
            <tr>
                <td class="ra">City</td><td><input runat="server" type="text" id="city" name="city" maxlength="50" /></td>
                <td class="ra">State</td><td class="la"><select id="selState" name="selState"><asp:Literal ID="ltrState" runat="server"></asp:Literal></select>
                </td></tr>            
            <tr>
                <td class="ra">Zip</td><td class="la"><input runat="server" type="text" id="zip" name="zip" size="9" /></td>
                <td class="ra">Cell Phone</td><td><input runat="server" type="text" id="cellPhone" name="cellPhone" size="15" maxlength="50" /></td>
            </tr>            
            <tr>
                <td class="ra">Work Phone</td><td><input runat="server" type="text" id="workPhone" name="workPhone" size="15" maxlength="15" /></td>
                <td class="ra">Home Phone</td><td><input runat="server" type="text" id="homePhone" name="homePhone" size="15" maxlength="15" /></td>
            </tr>            
            <tr>
                <td class="ra">Student E-Mail</td><td><input runat="server" type="text" id="emailId" name="emailId" size="30" maxlength="80" /></td>            
                <td class="ra">Guardian's Name</td><td><input runat="server" type="text" name="guardianName" id="guardianName" maxlength="80" /></td>
            </tr>
            <tr>
               <td class="ra">Hours</td><td><input runat="server" type="text" id="Hours" name="Hours" size="9" maxlength="10" /></td>
               <td class="ra">Hours Type</td><td><select runat="server" id="hourType" name="hourType"><option value="">
                </option><option value="Day">Per Day</option>
                <option value="Week">Per Week</option><option value="Month">Per Month</option></select></td>            
        </tr>
        <tr><td class="ra">School</td><td><input runat="server" type="text" id="School" name="School" size="20" maxlength="50" /></td>
        <td class="ra">Grade</td><td><input runat="server" id="Grade" name="Grade" size="20" maxlength="50" /></td></tr>
        </table>
        </td></tr>

<!-- Program Information -->
        <tr><td style="line-height:4px;">&nbsp;</td></tr>
        <tr><td class="tblHeader">&nbsp;Program Infomation</td></tr>
            <tr><td><input type="hidden" id="programsData" name="programsData" />
            <table style="border:1px solid #884a0a;width:100%;background-color:#EEE;" id="tblPrograms">
            <tbody>
                <tr><td id="tdRow0">#1</td><td>Program Name</td><td><select id="programname0" name="programname0" onchange="updateAmtType(this.value, 0, true);"><asp:Literal ID="ltrprog1" runat="server"></asp:Literal></select></td><td><input type="text" size="9" maxlength="9" id="tdAmount0" name="tdAmount0" value="0.00" onblur="updateProgramAmount(0,this.value);" /></td><td id="tdAmountType0">Per Hour</td><td><img src="images/cancel.png" alt="delete" onclick="deleteLine(0,studentProg,'tblPrograms');" /></td></tr>
            </tbody>
            <tfoot><tr><td colspan="6"><a href="javascript:void(0);" onclick="addProgramLine();"><img src="images/add.png" alt="add" style="cursor:pointer;border:0px;" />&nbsp;<span  style="vertical-align:top;text-decoration:underline;cursor:pointer">Add Program</span></a></td></tr></tfoot>
            </table>
        </td></tr>

<!-- Picture & Hobbies Information -->
        <tr><td style="line-height:4px;">&nbsp;</td></tr>
        <tr><td class="tblHeader">&nbsp;Picture & Hobbies Infomation</td></tr>
            <tr><td>
            <table style="border:1px solid #884a0a;width:100%;background-color:#EEE;">
            <tr>
                <td><div style="height:100px;width:100px;border:1px solid #999;"><asp:Literal ID="photoDisplay" runat="server"></asp:Literal></div><asp:Literal ID="ltrPhoto" runat="server"></asp:Literal></td>
            <td>
                <table>
                <tr>
                    <td class="ra">Gender</td><td><select runat="server" id="gender" name="gender"><option value=""></option><option value="Male">Male</option><option value="Female">Female</option></select></td><td class="ra">Hobbiles</td><td><input runat="server" type="text" id="hobbies" name="hobbies" maxlength="100" size="20" /></td>
                </tr>
                <tr>
                    <td class="ra">Tutor Preferences</td><td><input type="text" runat="server" id="tutorprefs" name="tutorprefs" maxlength="100" size="20" /></td>
                    <td class="ra">Student Goals</td><td><input runat="server" type="text" id="goals" name="goals" maxlength="100" size="20" /></td>
                </tr>
                <tr>
                    <td class="ra">Personality</td><td><input runat="server" type="text" id="personality" name="personality" maxlength="100" size="20" /></td>
                    <td class="ra">Learning Style</td><td><input runat="server" type="text" id="learningstyle" name="learningstyle" maxlength="100" size="20" /></td>
                </tr>
                </table>
            </td></tr>
            </table>  
            </td></tr>

<!-- Pickup Information -->
            <tr><td style="line-height:4px;">&nbsp;</td></tr>
        <tr><td class="tblHeader">&nbsp;Pickup Infomation</td></tr>
            <tr><td><input type="hidden" id="pickupInfoData" name="pickupInfoData" />
            <table style="border:1px solid #884a0a;width:100%;background-color:#EEE;" id="tblPickupInfo"><tbody>
            <tr><td class="ra">#1</td><td class="ra">Name</td><td><input onblur="updatePickupInfo(0,'contactName', this.value);" type="text" id="pickupname0" name="pickupname0" /></td><td class="ra">Contact</td><td><input onblur="updatePickupInfo(0,'contactPhone', this.value);" type="text" size="15" id="contact0" name="contact0" /></td><td>Relationship</td><td><select id="relationship0" name="relationship0" onchange="updatePickupInfo(0,'relationShip', this.value);"><asp:Literal ID="ltrRelation" runat="server"></asp:Literal></select></td><td><img src="images/cancel.png" alt="delete" onclick="deleteLine(0, pickupInfo,'tblPickupInfo');" /></td></tr></tbody>
            <tfoot><tr><td colspan="6"><a href="javascript:void(0);" onclick="addPickupInfo();"><img src="images/add.png" alt="add" style="cursor:pointer;border:0px;" />&nbsp;<span  style="vertical-align:top;text-decoration:underline;cursor:pointer">Add Pickup Information</span></a></td>
            <td><a href="javascript:void(0);" onclick="fillParentInfo('pickupname0');" >click here if parent</a></td></tr></tfoot>
            </table>
            </td></tr>
<!-- Payment Information -->
            <tr><td style="line-height:4px;">&nbsp;</td></tr>
            <tr><td class="tblHeader">&nbsp;Payment Infomation</td></tr>
            <tr><td>
            <table style="border:1px solid #884a0a;width:100%;background-color:#EEE;"><tbody>
                <tr><td class="ra">Parent E-Mail</td><td><input type="text" runat="server" id="parentemail" name="parentemail" /></td><td class="ra">Name of the Person</td><td><input runat="server" type="text" id="paymentname1" name="paymentname1" /></td></tr>
                <tr><td class="ra">Prefered Method of Payment</td><td><input runat="server" type="text" id="paymentmethod" name="paymentmethod" /></td><td>&nbsp;</td><td>&nbsp;</td></tr></tbody>
                <tfoot><tr><td><a href="javascript:void(0);" onclick="fillParentInfo(payeenameId);" >click here if parent</a></td></tr></tfoot>
             </table>
            </td></tr>

<!-- Grade Point Average Information -->
            <tr><td style="line-height:4px;">&nbsp;</td></tr>
            <tr><td class="tblHeader">&nbsp;GPA Infomation</td></tr>
            <tr><td><input type="hidden" id="assessmentData" name="assessmentData" />
                <table style="border:1px solid #884a0a;width:100%;background-color:#EEE;" id="tblAssessment"><tbody>
                <tr><td>#1</td>
                    <td class="ra">Assessment Date</td><td><input onchange="updateGPA('0','AssessDate', this.value);" type="text" name="assessdate0" id="assessdate0" maxlength="10" size="9" /></td>
                    <td class="ra">Grade Point Average</td><td><input onblur="updateGPA('0','GradeAvg', this.value);" type="text" id="gpa0" name="gpa0" size="8" maxlength="6" /></td>              
                    <td>Assessment Level</td><td><select onchange="updateGPA('0','AssessLevel', this.value);" id="assessLevel0" name="assessLevel0"><option value=""></option><option value="Below Grade Level">Below Grade Level</option><option value="At Grade Level">At Grade Level</option><option value="Advanced">Advanced</option></select></td>
                </tr>
                </tbody>
                <tfoot><tr><td colspan="6"><a href="javascript:void(0);" onclick="addAssessment();"><img src="images/add.png" alt="add" style="cursor:pointer;border:0px;" />&nbsp;<span  style="vertical-align:top;text-decoration:underline;cursor:pointer">Add Assessment</span></a></td></tr></tfoot>
                </table>            
            </td></tr>
<!-- Information -->
            <tr><td style="line-height:4px;">&nbsp;</td></tr>
            <tr><td class="tblHeader">&nbsp;Reference & Comments Information</td></tr>
            <tr><td>
                <table style="border:1px solid #884a0a;width:100%;background-color:#EEE;" id="Table1"><tbody>
                    <tr><td class="ra">Referenced By</td><td><input runat="server" type="text" id="referencedby" name="referencedby" /></td>
                    <td class="ra">Expected duration</td><td><input runat="server" type="text" id="attenduration" name="attenduration" /></td></tr>
                    <tr><td class="ra">BLC Recommendations</td><td colspan="3"><input runat="server" type="text" id="blcplan" name="blcplan" size="40" maxlength="100" /></td></tr>
                    <tr><td class="ra">Proposed Program</td><td><select id="proposedProg" name="proposedProg" runat="server"></select></td><td class="ra">Hours</td><td><input runat="server" type="text" id="proposedHours" name="proposedHours" size="6" maxlength="10" /></td></tr>
                    <tr><td></td></tr>
                    <tr><td class="ra">Parent's Comments</td><td colspan="3"><input runat="server" type="text" id="parentComments" name="parentComments" size="40" maxlength="100" /></td></tr>
                    <tr><td class="ra">Parent's Expectations</td><td colspan="3"><input runat="server" type="text" id="parentExpects" name="parentExpects" size="40" maxlength="100" /></td></tr>
                    <tr><td class="ra">Emergency Contact Name</td><td><input runat="server" type="text" id="emergName" name="emergName" /></td><td class="ra">Phone Number</td><td><input runat="server" type="text" id="emergPhone" name="emergPhone" /></td></tr>
                    <tr><td class="ra">Health Conditions</td><td colspan="3"><input type="text" id="healthConditions" name="healthConditions" runat="server" size="50" maxlength="500" /></td></tr>
                    </tbody>
                </table>
            </td></tr>
            <tr><td>
                <table><tr>
                    <td><input type="hidden" id="doSave" name="doSave" />
                        <input type="button" id="btnSave1" value="Save" onclick="doSaveClick();"" />
                    </td></tr>
                </table>
</td></tr>
        </table>    
</div>
			        </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
