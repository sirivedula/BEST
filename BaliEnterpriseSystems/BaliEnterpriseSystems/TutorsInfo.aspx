<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="TutorsInfo.aspx.cs" Inherits="BaliEnterpriseSystems.TutorsPageInfo" Title="BEST - Tutors Information"  EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
.ra {text-align:right;}
</style>
    <script type="text/javascript">
        var newtutorid = '';
        $(document).ready(function() {
            $('#cellPhone,#homePhone,#workPhone').mask('(999) 999-9999');
            $('#joinDate').mask('99/99/9999');
            $('#joinDate').datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });
            $('#divTutorsInfo').css("display", "none");
            BestJSGrid.requiredFields.push({ name: 'firstName', description: 'First Name' },
            { name: 'lastName', description: 'Last Name' },
            { name: 'cellPhone', description: 'Cell Phone' },
            { name: 'emailId', description: 'E-Mail Address' });
        });
    
    function addNew(){
        BestJSGrid.addNew("divTutorsInfo", 500, 700);
    }
    
    function editForm(rownum){
        BestJSGrid.fillUIForm(rownum, "divTutorsInfo", 500, 700);
    }

    var aryChks = ['chkReading', 'chkWriting', 'chkMath', 'chkSATMath', 'chkSATVerbal', 'chkPhonics', 'chkBioChem', 'chkOthers'];
    var aryLearns = ['chkShy','chkSocial','chkQuiet'];
    
    function beforeSave() {
        var expertise = '';
        for (var i = 0; i < aryChks.length; i++) {
            if ($('#' + aryChks[i])[0].checked) {
                expertise += aryChks[i] + '\t';
            }
        }
        $('#Expertise').val(expertise);
        var learnStyle = '';
        for (var i = 0; i < aryLearns.length; i++) {
            if ($('#' + aryLearns[i])[0].checked) {
                learnStyle += aryLearns[i] + '\t';
            }
        }
        $('#learningStyle').val(learnStyle);
    }

    function gridfillDefaults(rownum) {
        if (rownum == -1) $('#TutorId').val(newtutorid);

        var currow = gridJS.Rows[rownum];
        if (typeof(currow) != 'undefined') {
            var expertise = currow["Expertise"];
            var aryChks = expertise.split('\t');
            for (var i = 0; i < aryChks.length; i++) {
                $('#' + aryChks[i])[0].checked = true;
            }
            var learnStyle = currow["learningStyle"];
            var aryLearn = learnStyle.split('\t');
            for (var i = 0; i < aryLearn.length; i++) {
                $('#' + aryLearn[i])[0].checked = true;
            }
        }
    }
    
</script>
<asp:Literal ID="ltrLoadScript" runat="server"></asp:Literal>
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
<div id="divTutorsInfo">
    <table>
        <tr>
            <td class="ra">Tutor Id</td><td><input type="text" size="9" maxlength="10" id="TutorId" name="TutorId" /></td>
            <td class="ra">Center Id</td><td><select runat="server" id="CenterId" name="CenterId"></select></td>
        </tr>
        <tr><td class="ra">First Name *</td><td><input type="text" id="firstName" name="firstName" maxlength="50" /></td>
            <td class="ra">Last Name *</td><td><input type="text" id="lastName" name="lastName" maxlength="50" /></td></tr>
        <tr><td class="ra">Middle Name</td><td><input type="text" id="middleName" name="middleName" maxlength ="50" /></td>
            <td class="ra">Joining Date</td><td class="la"><input type="text" size="10" maxlength="10" id="joinDate" name="joinDate" /></td>
            </tr>
        <tr><td class="ra">Address 1</td><td><input type="text" id="address1" name="address2" maxlength="50" /></td>
            <td  class="ra">Address 2</td><td><input type="text" id="address2" name="address2" /></td></tr>
        <tr><td class="ra">City</td><td><input type="text" id="city" name="city" maxlength="50" /></td>
            <td  class="ra">State</td><td class="la"><select id="state" name="state"><asp:Literal ID="ltrStateOpts" runat="server"></asp:Literal></select></td></tr>
        <tr><td class="ra">Zip</td><td class="la"><input type="text" id="zip" name="zip" size="9" /></td>
            <td class="ra">Cell Phone *</td><td><input type="text" id="cellPhone" name="cellPhone" size="15" maxlength="50" /></td></tr>
        <tr><td class="ra">Work Phone</td><td><input type="text" id="workPhone" name="workPhone" size="15" maxlength="15" /></td>
            <td class="ra">Home Phone</td><td><input type="text" id="homePhone" name="homePhone" size="15" maxlength="15" /></td>
        </tr>
        <tr><td class="ra">E-Mail *</td><td><input type="text" id="emailId" name="emailId" size="30" maxlength="80" /></td>
            <td class="ra">Gender</td><td><select id="gender" name="gender"><option value=""></option><option value="Male">Male</option><option value="Female">Female</option></select></td>
        </tr>
        <tr>
            <td class="ra">School</td><td><input type="text" id="school" name="school" size="30" maxlength="50" /></td>
            <td class="ra">Year Graduated</td><td><input type="text" id="yearGraduated" name="yearGraduated" size="6" maxlength="4" /> </td>
        </tr>   
        <tr>
            <td class="ra">GPA</td><td><input type="text" id="GPA" name="GPA" size="6" maxlength="6" /></td>
            <td class="ra">Major</td><td><input type="text" id="Major" name="Major" size="30" maxlength="50" /></td>
        </tr>
        <tr>
            <td class="ra">Expertise</td><td colspan="3"><input type="hidden" id="Expertise" name="Expertise" /><input type="checkbox" id="chkReading" name="chkReading" /><label for="chkReading">Reading</label>&nbsp;<input type="checkbox" id="chkWriting" name="chkWriting" /><label for="chkWriting">Writing</label>&nbsp;<input type="checkbox" id="chkMath" name="chkMath" /><label for="chkMath">Math</label>&nbsp;<input type="checkbox" id="chkSATMath" name="chkSATMath" /><label for="chkSATMath">SAT Math</label><input type="checkbox" id="chkSATVerbal" name="chkSATVerbal" /><label for="chkSATVerbal">SAT Verbal</label><br /><input type="checkbox" id="chkPhonics" name="chkPhonics" /><label for="chkPhonics">Phonics</label>&nbsp; <input type="checkbox" id="chkBioChem" name="chkBioChem" /><label for="chkBioChem">Bio Chem Calculus</label><input type="checkbox" id="chkOthers" name="chkOthers" /><label for="chkOthers">Other</label><input type="text" id="otherSkill" name="otherSkill" /></td>            
        </tr>
        <tr>
            <td class="ra">Personal Learning Style</td><td><input type="hidden" id="learningStyle" name="learningStyle" /><input type="checkbox" id="chkShy" name="chkShy" /><label for="chkShy">Shy</label><input type="checkbox" id="chkSocial" name="chkSocial" /><label for="chkSocial">Social</label><input type="checkbox" id="chkQuiet" name="chkQuiet" /><label for="chkQuiet">Quiet</label></td>
            <td class="ra">Which Perfonalities <br />match-up with this tutor?</td><td><input type="text" id="Matchup" name="Matchup" /></td>
        </tr>
        <tr>
            <td class="ra">Grade Level</td><td><select id="gradeLevels" name="gradeLevels">
            <option value=""></option><option value="Elementary">Elementary</option><option value="Middle">Middle</option>
            <option value="High-School">High-School</option><option value="All">All</option>
            </select></td>
            <td class="ra">Program</td><td><select id="programStyle" name="programStyle"><option value=""></option>
            <option value="One-on-one">One-on-one</option><option value="Group">Group</option></select></td>
        </tr>
        <tr><td class="ra">Salary</td><td><input type="text" id="salary" name="salary" maxlength="10" size="15" /></td>
        <td class="ra">Per Hour</td><td><input type="text" id="perhour" name="perhour" size="15" maxlength="10" /></td></tr>
        <tr>
            <td class="ra" colspan="4"><input type="button" id="btnSave" onclick="BestJSGrid.Save();" value="Save" /></td>
        </tr>
    </table>
</div>

</asp:Content>
