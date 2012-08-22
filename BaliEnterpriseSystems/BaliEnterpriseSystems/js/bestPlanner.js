var PlannerDay = 1;
var PlannerWeek = 2;
var PlannerMonth = 3;

var timeModeHours = 1;
var timeModeHalfHours = 2;
var initialLoad = true;

var OneonOneDisplay = 1;
var GroupDisplay = 2;

var ScheduleInfo = [];
var autoStudents = [];
var autoTutors = [];
var StudentInfo = [];
var TutorInfo = [];
var StudentProgs = [];
var jsProg = [];

var aryTimes = [];

//var aryTimes = ['630', '730', '830', '930', '1030', '1130', '1230', '1330', '1430', '1530', '1630', '1730', '1830', '1930', '2030',  '2130']

//var aryTimes = ['600', '630', '700', '730', '800', '830', '900', '930', '1000', '1030', '1100', '1130', '1200', '1230', '1300', '1330', '1400', '1430', '1500', '1530', '1600', '1630', '1700', '1730', '1800', '1830', '1900', '1930', '2000', '2030', '2100', '2130', '2200']

var aryWeekNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
var aryMonthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
var aryWeeks = ["Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat"];
var aryMonths = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];

function setbackground(id) {
    $('#divAttend').css('font-weight', (id == 0) ? 'bold' : 'normal');
    $('#divInformed').css('font-weight', (id == 1) ? 'bold' : 'normal');
    $('#divAbsent').css('font-weight', (id == 2) ? 'bold' : 'normal');
}

function setProgramBold(divid, curguid){
	var cnodes = $('#'+divid)[0].childNodes;
	for(var j=0; j<cnodes.length; j++){
		if (cnodes[j].id == curguid){
			$(cnodes[j]).css('font-weight', 'bold');
		} else {
			$(cnodes[j]).css('font-weight', 'normal');
		}
	}
}

function StudentProg(guid, studguid, proguid, amount, Idx){
	this.guidfield = guid;
	this.studentguid = studguid;
	this.progGuid = proguid;
	this.Amount = amount;
	this.Index = Idx;
	
	this.ToHTML = function(divid){
		var result = '<span onclick="setProgramBold(\'' + divid + '\',\'' + this.guidfield + '\');" class="progShow" id="' + this.guidfield + '" title="';
		var temprog = Programs.FindByGuid(this.progGuid);
		if(typeof temprog != 'undefined'){
			result += temprog.ToHTML(this.Amount);
		}
		result += '">P' + this.Index + '</span>';
		return result;
	}
}

var StudentPrograms = function() {
	
	return {
		FindByGuid: function(sguid){
			var result = [];
			for(var x in StudentProgs){
				if(StudentProgs[x].studentguid == sguid){
					result.push(StudentProgs[x]);
				}
			}
			return result;
		}		
		,extendToStudProg: function() {
		    for (var x in StudentProgs) {
		        var objSProg = new StudentProg();
		        objSProg.progId = x;
		        jQuery.extend(objSProg, StudentProgs[x]);
		        StudentProgs[x] = objSProg;
		    }
		}
	}

} ();

function Program(pguid, amt, amtype, progname, progtype){
	this.guid = pguid;
	this.amount = amt;
	this.amountType = amtype;
	this.progName = progname;
	this.progType = progtype;
	
	this.ToHTML = function(Amount){
		return this.progName + ':' + this.progType + ':$'+Amount+' / '+ this.amountType;
	}
}

var Programs = function(){
	return {
		FindByGuid: function(pguid){
			return BestPlanner.find(jsProg, function(obj) { return (obj.guid == pguid); });
		}
		,extendToProgram: function(){
			for(var x in jsProg){
				var objProg = new Program()
				objProg.progId = x;
				jQuery.extend(objProg, jsProg[x]);
				jsProg[x] = objProg;
			}
		}
	}
}();

function Schedule(schguid, stguid1, stguid2, stguid3, stguid4, stguid5, tuguid, sdate, sfrom, sto, idx, schid){
	this.schGuid = schguid;
	this.stuGuid1 = stguid1;
	this.stuGuid2 = stguid2;
	this.stuGuid3 = stguid3;
	this.stuGuid4 = stguid4;
	this.stuGuid5 = stguid5;
	this.tutGuid = tuguid;
	this.schDate = sdate;
	this.schFrom = sfrom;
	this.schTo = sto;
	this.Index = idx;
	this.topx = 0;
	this.leftx = 0;
	this.isDeleted = 0;
	this.schId = schid;
	this.isnew = true;
	this.attend0 = 0;
	this.attend1 = 0;
	this.attend2 = 0;
	this.attend3 = 0;
	this.attend4 = 0;
	this.note0 = '';
	this.note1 = '';
	this.note2 = '';
	this.note3 = '';
	this.note4 = '';
	this.progGuid1 = '';
	this.progGuid2 = '';
	this.progGuid3 = '';
	this.progGuid4 = '';
	this.progGuid5 = '';
	this.attend5 = 0;
	
	this.StudentName = function(studguid) {
	    var studname = '';
	    var objStd = BestPlanner.find(StudentInfo, function(obj) { return (obj.guid == studguid); });
	    if (typeof objStd != 'undefined') {
	        studname = objStd.firstName + ' ' + objStd.lastName.substr(0, 1);
	        studname = studname.substr(0, 14);
	    }
	    return studname;
	}
	
	this.TutorName = function(){
		var tutorguid = this.tutGuid;
		var objTutor = BestPlanner.find(TutorInfo, function(obj){ return (obj.guid == tutorguid); });
		var tuname = '??';
		if(typeof objTutor != 'undefined'){
			tuname = objTutor.Id;
		}
		return tuname;
	}
	
	this.OneDesc = function(){
		var studname = '';
		var studguid = this.stuGuid1;
		var objStd = BestPlanner.find(StudentInfo, function(obj){ return (obj.guid == studguid ); });
		if(typeof objStd != 'undefined'){
			studname = objStd.firstName + ' ' + objStd.lastName.substr(0,1);
			studname = studname.substr(0,14);
		}
		return '<div style="white-space:nowrap;text-align:right;font-size:10px;cursor:pointer;font-size:12px;"><span style="color:#FFF;background-color:#90A087;font-size:12px;font-weight:bold;" onclick="BestPlanner.editSchedule(\'' + this.schId + '\');">+</span><span onclick="BestPlanner.updAttendance(\'' + this.schId + '\',0);" style="font-size:11px;padding-left:2px;' + (this.attend0==2?'color:#990000;':'') + '">' + studname + '</span> - <span style="text-align:left;font-weight:bold;" onclick="BestPlanner.updAttendance(\'' + this.schId + '\',5);">' + this.TutorName() + '</span></div>'
	}
	
	this.getDesc = function(){
		var stnames = new Array('', '', '', '', '');
		var stguids = new Array(this.stuGuid1, this.stuGuid2, this.stuGuid3, this.stuGuid4, this.stuGuid5);
		for(var i=0; i<5; i++){
			var objStd = BestPlanner.find(StudentInfo, function(obj){ return (obj.guid == stguids[i] ); });
			if(typeof objStd != 'undefined'){
				stnames[i] = objStd.firstName + ' ' + objStd.lastName.substr(0,1);
				stnames[i] = stnames[i].substr(0,14);
			}
		}
		var tutorguid = this.tutGuid;
		var objTutor = BestPlanner.find(TutorInfo, function(obj){ return (obj.guid == tutorguid); });
		var tuname = '??';
		if(typeof objTutor != 'undefined'){
			tuname = objTutor.Id;
		}
		var thtml = '<div style="background-color:#EEF0EC;border-right:1px solid #6FA987;border-top:1px solid #6FA987;border-bottom:1px solid #6FA987;float:left;padding-left:1px;padding-right:1px;border-top-left-radius: 5px;border-top-right-radius: 5px;font-size:12px;">';
		var stdCnt = 0;
		var first = true;
		for(var j=0; j<5; j++){
			if(stnames[j] != ''){
				thtml += '<div style="white-space:nowrap;text-align:right;font-size:9px;cursor:pointer;">' 
				if (first) {
					thtml += '<span style="color:#FFF;padding:1px;background-color:#90A087;font-size:12px;font-weight:bold;" onclick="BestPlanner.editSchedule(\'' + this.schId + '\');">+</span>';
					first = false;
				}
				thtml += '<span style="padding-left:1px;font-size:11px;" onclick="BestPlanner.updAttendance(\'' + this.schId + '\',\'' + j + '\');">' + stnames[j] + '</span></div>';
				stdCnt++;
				
			}
		}
		var padSize = (stdCnt * 4);
		thtml += '</div><div style="cursor:pointer;float:right;font-weight:bold;color:#2952A3;padding-top:' + padSize + 'px;" onclick="BestPlanner.updAttendance(\'' + this.schId + '\',5);">' + this.TutorName() + '</div>';
		return thtml;
	}
	
	this.getTimeHead = function(){
		return BestPlanner.formatTime(this.schFrom, true) + ' - ' +  BestPlanner.formatTime(this.schTo, true);
	}
	
	this.ToHTML = function(idx){
		return '<div style="position:absolute;top:'+this.topx+'px;left:'+this.leftx+'px;" id="timeSlice_'+this.schId + '">' + this.InnerHTML() + '</div>';
	}
	
	this.InnerHTML = function(){
		var clsnum = (this.schFrom%7 == 0) ? 2 : (this.schFrom%7); 
		clsname = 'day'+clsnum;
		var top1 = Number(this.topx)+14;
		var result;
		if(this.stuGuid1 != '' && this.stuGuid2=='') {
			result = '<span style="font-size:12px;background-color:#EEF0EC;border:1px solid #6FA987;float:left;border-top-left-radius: 5px;border-top-right-radius: 5px;">'+ this.OneDesc() + '</span>';
		} else {
			result = this.getDesc();
		}
		return result;
	}
}

var BestPlanner = function() {
    var plannerMode; //Day, Week, Month
    var plannerDate;
    var plannerTimeMode;
    var beginTime = 6;
    var endTime = 22;
    var addDivSlice = "";
    var editTimeSlice = '';
    var plannerDisplay;
    return {
        saveToDB: function(objSch) {
            var tempSch = objSch;
            var params = {};
            params.tutGuid = tempSch.tutGuid;
            params.stuGuid1 = tempSch.stuGuid1;
            params.stuGuid2 = tempSch.stuGuid2;
            params.stuGuid3 = tempSch.stuGuid3;
            params.stuGuid4 = tempSch.stuGuid4;
            params.stuGuid5 = tempSch.stuGuid5;
            params.schGuid = tempSch.schGuid;
            params.schDate = tempSch.schDate;
            params.schFrom = tempSch.schFrom;
            params.schTo = tempSch.schTo;
            params.isDel = tempSch.isDeleted;
            params.attend0 = tempSch.attend0;
            params.attend1 = tempSch.attend1;
            params.attend2 = tempSch.attend2;
            params.attend3 = tempSch.attend3;
            params.attend4 = tempSch.attend4;
            params.note0 = tempSch.note0;
            params.note1 = tempSch.note1;
            params.note2 = tempSch.note2;
            params.note3 = tempSch.note3;
            params.note4 = tempSch.note4;
			params.progGuid1 = tempSch.progGuid1;
			params.progGuid2 = tempSch.progGuid2;
			params.progGuid3 = tempSch.progGuid3;
			params.progGuid4 = tempSch.progGuid4;
			params.progGuid5 = tempSch.progGuid5;
			params.tutorattend = tempSch.attend5;
			
			dimBody();
            $.post("SaveSchedule.aspx", params, function(data) {
                var tempSch = objSch;
                var jsonObj;
				try
				{
					eval('jsonObj=' + data);
					if (jsonObj.result) {
						var schguid = tempSch.schGuid;
						var idx = BestPlanner.findIndex(ScheduleInfo, function(obj) { return (obj.schGuid == schguid); });
						if (idx > -1) {
							tempSch.schGuid = jsonObj.guid;
							$('#timeSlice_' + objSch.schId).data(tempSch);
							ScheduleInfo[idx] = tempSch;
						}
					} else {
						alert(jsonObj.Message);
						$("form:first").submit();
					}
				} catch(ex){
				  alert(data);
				  $("form:first").submit();
				}
				undimBody();
            });
        }
		, find: function(objList, delegate) {
		    for (var icnt in objList) {
		        if (delegate(objList[icnt])) {
		            return objList[icnt];
		        }
		    }
		}

		, findIndex: function(objList, delegate) {
		    for (var icnt in objList) {
		        if (delegate(objList[icnt])) {
		            return icnt;
		        }
		    }
		    return -1;
		}

		, formatTime: function(strTime, zeroAdd) {
		    var itime = Number(strTime);
		    var stime = new String((itime > 1230) ? (itime - 1200) : itime);
		    var start = (stime.length > 3) ? 2 : 1;
		    stime = stime.substr(0, start) + ((zeroAdd) ? ":" + stime.substr(start, 2) : "");
		    return stime;
		}

		, extendToSchedule: function() {
		    for (var x in ScheduleInfo) {
		        var objSch = new Schedule();
		        objSch.schId = x;
		        jQuery.extend(objSch, ScheduleInfo[x]);
		        ScheduleInfo[x] = objSch;
		    }
		}

		, updAttendance: function(schId, stdnum) {
		    this.editTimeSlice = schId;
		    var objSch = $('#timeSlice_' + this.editTimeSlice).data();
		    if (objSch != null) {
		        var divSlice = '#divSlice_' + objSch.schDate + '_' + objSch.schFrom;
		        var dleft = $(divSlice).position()["left"] + 10;
		        var dtop = $(divSlice).position()["top"] + 10;
		        var name = "";
				if (stdnum == 5) {
					name = objSch.TutorName();
				} else {
					name = objSch.StudentName(objSch["stuGuid" + (Number(stdnum) + 1)]);
				}
		        $('#attendanceDiv').dialog({ draggable: false, autoOpen: true, title: 'Attendance - ' + name, position: [dleft, dtop],
		            open: function(event, ui) {
		                //Set the DB Values
		                setbackground(objSch["attend" + stdnum]);
		                $('#notes').val(objSch["note" + stdnum]);
		            },
		            buttons: [{ text: "OK", click: function() {
		                var attend = $('#divAttend').css('font-weight');
		                var inform = $('#divInformed').css('font-weight');
		                objSch["attend" + stdnum] = (attend=="bold" || attend=="700") ? "0" : ( (inform=="bold" || inform=="700") ? "1" : "2");
		                objSch["note" + stdnum] = $('#notes').val();
		                BestPlanner.saveToDB(objSch);
		                $(this).dialog("close");
		            } }]
		            });
		        }
		    }

		, updScheduleInfo: function(objSch) {
		    var schguid = objSch.schGuid;
		    var idx = this.findIndex(ScheduleInfo, function(obj) { return (obj.schGuid == schguid); });
		    if (idx > -1) {
		        ScheduleInfo[idx] = objSch;
		    }
		}

		, AddSchedule: function(sguid1, sguid2, sguid3, sguid4, sguid5, tguid, sdate, sfrom, sto) {
		    var divslice = 'divSlice_' + sdate + '_' + sfrom
		    var theIndex = this.MaxIndex(divslice);
		    var pk = randomString();
		    var schid = ScheduleInfo.length;
		    var newSch = new Schedule(pk, sguid1, sguid2, sguid3, sguid4, sguid5, tguid, sdate, sfrom, sto, theIndex, schid);
			this.UpdateProgram(newSch);
		    ScheduleInfo[ScheduleInfo.length] = newSch;
		    this.saveToDB(newSch);
		    this.ReDraw(divslice);
			this.RefreshTutorHours();
		}
		
		, UpdateProgram: function(objSch){
			for(var i=1; i<6;i++){
				var cnodes = $('#progTag'+i)[0].childNodes;
				for(var j=0; j<cnodes.length; j++){
					if (objSch["stuGuid"+i] != ""){
						var fontwt = $(cnodes[j]).css('font-weight');
						if(fontwt == "700" || fontwt == "bold"){
							objSch["progGuid"+i] = cnodes[j].id;
						}
					}
				}
			}
		}

		, ReDraw: function(divslice) {
		    this.setDivAdjustment(divslice);
		    this.DrawSchedules();
		}

		, UpdateSchedule: function(stguid1, stguid2, stguid3, stguid4, stguid5, tuguid, tfrom, tto) {
		    var objSch = $('#timeSlice_' + this.editTimeSlice).data();
		    if (typeof objSch != 'undefined') {
		        objSch.stuGuid1 = stguid1;
		        objSch.stuGuid2 = stguid2;
		        objSch.stuGuid3 = stguid3;
		        objSch.stuGuid4 = stguid4;
		        objSch.stuGuid5 = stguid5;
		        objSch.tutGuid = tuguid;
				this.UpdateProgram(objSch);
		        if (objSch.schFrom != tfrom) {
		            /* Time Changed */
		            var odivslice = 'divSlice_' + objSch.schDate + '_' + objSch.schFrom;
		            var ndivslice = 'divSlice_' + objSch.schDate + '_' + tfrom
		            var theIndex = this.MaxIndex(ndivslice);
		            objSch.schFrom = tfrom;
		            objSch.schTo = tto;
		            objSch.Index = theIndex;
		            $('#timeSlice_' + objSch.schId).data(objSch);
		            this.updScheduleInfo(objSch);
		            this.ReIndex(odivslice);
		            this.ReDraw(ndivslice);
		        } else {
		            /* Same Time */
		            this.ShowSchedule(objSch);
		        }
		        this.saveToDB(objSch);
				this.RefreshTutorHours();
		    }
		}
		
		, DeleteSchedule: function(){
		    var objSch = $('#timeSlice_' + this.editTimeSlice).data();
		    if (typeof objSch != 'undefined') {
				objSch.isDeleted = 1;
				this.updScheduleInfo(objSch);
				var divslice = 'divSlice_' + objSch.schDate + '_' + objSch.schFrom;
				this.ReIndex(divslice);
		        this.saveToDB(objSch);
				$('#timeSlice_' + this.editTimeSlice).html('');
				this.ReDraw(divslice);
			}
		}

		, DrawPlannerDay: function(tdId, theDay) {
		    var weekname = aryWeeks[theDay.getDay()];
		    var plannerHtml = '<div class="tdHeadTitle">' + weekname + ' - ' + this.ToMMddyyyy(theDay) + '</div>';
		    var dropDivs = '';
		    var tdWidth = $('#' + tdId).width()
		    for (var tslice = 0; tslice < aryTimes.length; tslice++) {
		        var divclass = (tslice % 2 == 0) ? "scaleeven" : "scaleodd";
		        var sliceId = 'divSlice_' + this.ToyyyyMMdd(theDay) + '_' + aryTimes[tslice];
		        plannerHtml += '<div class="' + divclass + '" id="' + sliceId + '" ondblclick="BestPlanner.PopupSchedule(this);">&nbsp;</div>';
		        dropDivs += '#' + sliceId + ',';
		    }
		    $('#' + tdId).html(plannerHtml);

		    dropDivs = dropDivs.substr(0, dropDivs.length - 1);
		    $(dropDivs).droppable({
		        hoverClass: "ui-state-active",
		        drop: function(event, ui) {
		            /* Drag and Drop then setup to new from time, to time and ReDraw */
		            var divSlice = '#' + $(this)[0].id;
		            var timeSlice = '#' + ui.draggable[0].id;
		            var curDate = divSlice.split('_')[1];
		            var curFrom = divSlice.split('_')[2];

		            var objSch = $(timeSlice).data();
		            if (typeof objSch != 'undefined') {
		                if (objSch.schDate != curDate || objSch.schFrom != curFrom) {
		                    var odivslice = 'divSlice_' + objSch.schDate + '_' + objSch.schFrom;
		                    var ndivslice = 'divSlice_' + curDate + '_' + curFrom
		                    var theIndex = BestPlanner.MaxIndex(ndivslice);
		                    objSch.schDate = curDate;
		                    objSch.schFrom = curFrom;
		                    objSch.schTo = Number(curFrom) + 100;
		                    objSch.Index = theIndex;
		                    $('#timeSlice_' + objSch.schId).data(objSch);
		                    BestPlanner.updScheduleInfo(objSch);
		                    BestPlanner.ReIndex(odivslice);
		                    BestPlanner.saveToDB(objSch);
		                    BestPlanner.ReDraw(ndivslice);
		                }
		            }
		        }
		    });
		}

		, setEditStudentText: function(textboxId, studentGuid, progGuid) {
			var pid = 'progTag' + textboxId.replace('studentTag', '');
		    if (typeof studentGuid != 'undefined' && studentGuid != '') {
		        $('#' + textboxId + '0').val(studentGuid);
		        var objStd = BestPlanner.find(StudentInfo, function(obj) { return (obj.guid == studentGuid); });
		        if (typeof objStd != 'undefined') {
		            $('#' + textboxId).val(objStd.firstName + " " + objStd.lastName);
					/* Set Student Programs */
					var stdprogs = StudentPrograms.FindByGuid(studentGuid);
					var innerhtml = '';
					for (var x in stdprogs) {
						innerhtml += stdprogs[x].ToHTML(pid);
					}
					$('#' + pid).html(innerhtml);
					setProgramBold(pid, progGuid);					
		        } else {
		            $('#' + textboxId).val('');
					$('#' + pid).html('');
		        }
		    } else {
				$('#' + textboxId).val('');
				$('#' + pid).html('');
			}
		}

		, editSchedule: function(schId) {
		    this.editTimeSlice = schId;
		    var objSch = $('#timeSlice_' + this.editTimeSlice).data();
		    if (objSch != null) {
		        var divSlice = '#divSlice_' + objSch.schDate + '_' + objSch.schFrom;
		        var dleft = $(divSlice).position()["left"] + 10;
		        var dtop = $(divSlice).position()["top"];
				if(dtop > 300) dtop = dtop - 300;
				
		        $('#fromHour').val(objSch.schFrom);
		        var ttime = Number(objSch.schFrom) + 100;
		        $('#toHour').val(ttime);
		        $('#studentTag10,#studentTag20,#studentTag30,#studentTag40,#studentTag50,#tutorTag0').val('');
		        $('#studentTag1,#studentTag2,#studentTag3,#studentTag4,#studentTag5,#tutorTag').val('');
		        BestPlanner.setEditStudentText('studentTag1', objSch.stuGuid1, objSch.progGuid1);
		        BestPlanner.setEditStudentText('studentTag2', objSch.stuGuid2, objSch.progGuid2);
		        BestPlanner.setEditStudentText('studentTag3', objSch.stuGuid3, objSch.progGuid3);
		        BestPlanner.setEditStudentText('studentTag4', objSch.stuGuid4, objSch.progGuid4);
		        BestPlanner.setEditStudentText('studentTag5', objSch.stuGuid5, objSch.progGuid5);
		        $('#tutorTag0').val(objSch.tutGuid);
		        var tutorGuid = objSch.tutGuid;
		        var objTut = BestPlanner.find(TutorInfo, function(obj) { return (obj.guid == tutorGuid); });
		        if (objTut) {
		            $('#tutorTag').val(objTut.Name);
		        }

		        $('#showScheduleDiv').dialog({ draggable: false, autoOpen: true, width: 350, height: 215, title: 'Edit Schedule', position: [dleft, dtop],
		            buttons: [{ text: "Delete", click: function() {
		                BestPlanner.DeleteSchedule();
						$(this).dialog("close");
		            }
		            }
					, { text: "OK", click: function() {
					    if (BestPlanner.canSave()) {
					        var stguid1 = $('#studentTag10').val();
					        var stguid2 = $('#studentTag20').val();
					        if ($('#studentTag2').val() == "") stguid2 = '';
					        var stguid3 = $('#studentTag30').val();
					        if ($('#studentTag3').val() == "") stguid3 = '';
					        var stguid4 = $('#studentTag40').val();
					        if ($('#studentTag4').val() == "") stguid4 = '';
					        var stguid5 = $('#studentTag50').val();
					        if ($('#studentTag5').val() == "") stguid5 = '';

					        var tuguid = $('#tutorTag0').val();
					        var tfrom = $('#fromHour').val();
					        var tto = $('#toHour').val();
					        BestPlanner.UpdateSchedule(stguid1, stguid2, stguid3, stguid4, stguid5, tuguid, tfrom, tto);

					        $(this).dialog("close");
					    }
					} }]
		        });
		        $('#showScheduleDiv').css('height', '215px');
		    }
		}

		, PopupSchedule: function(divSlice) {
		    BestPlanner.addDivSlice = divSlice.id;
		    var dleft = $(divSlice).position()["left"] + 10;
		    var dtop = $(divSlice).position()["top"] - 10;
		    var ftime = divSlice.id.split('_')[2];
		    var ttime = Number(ftime) + 100;
		    $('#fromHour').val(ftime);
		    $('#toHour').val(ttime);
		    $('#studentTag10,#studentTag20,#studentTag30,#studentTag40,#studentTag50,#tutorTag0').val('');
		    $('#studentTag1,#studentTag2,#studentTag3,#studentTag4,#studentTag5,#tutorTag').val('');
			$('#progTag1,#progTag2,#progTag3,#progTag4,#progTag5').html('');
			
		    $('#showScheduleDiv').dialog({ draggable: false, position: [dleft, dtop], autoOpen: true, width: 350, height: 215, title: 'Add Schedule',
		        buttons: [{
		            text: "OK", click: function() {
		                if (BestPlanner.canSave()) {
					        var stguid1 = $('#studentTag10').val();
					        var stguid2 = $('#studentTag20').val();
					        if ($('#studentTag2').val() == "") stguid2 = '';
					        var stguid3 = $('#studentTag30').val();
					        if ($('#studentTag3').val() == "") stguid3 = '';
					        var stguid4 = $('#studentTag40').val();
					        if ($('#studentTag4').val() == "") stguid4 = '';
					        var stguid5 = $('#studentTag50').val();
					        if ($('#studentTag5').val() == "") stguid5 = '';

		                    var tuguid = $('#tutorTag0').val();
		                    var tfrom = $('#fromHour').val();
		                    var tto = $('#toHour').val();
		                    var sdate = BestPlanner.ToyyyyMMdd(BestPlanner.selectDate());
							var numFrom = Number(tfrom);
							var numTo = Number(tto);
							for(var schCounter = numFrom; schCounter < numTo; schCounter+=100){
								tfrom = schCounter;
								tto = schCounter + 100;
								BestPlanner.AddSchedule(stguid1, stguid2, stguid3, stguid4, stguid5, tuguid, sdate, tfrom, tto);
							}
		                    $(this).dialog("close");
		                }
		            } }]
		        });
		        $('#showScheduleDiv').css('height', '215px');
		    }

		, selectDate: function() {
		    var datepart = BestPlanner.addDivSlice.split('_')[1];
		    var tempdate = new Date(datepart.substr(4, 2) + '/' + datepart.substr(6, 2) + '/' + datepart.substr(0, 4));
		    return tempdate;
		}

		, canSave: function() {
		    if ($('#studentTag1').val().length == 0) {
		        alert('Select the Student');
		        $('#studentTag1').focus();
		        return false;
		    }
		    if ($('#fromHour').val().length == 0) {
		        alert('Select the From Time');
		        $('#fromHour').focus();
		        return false;
		    }
		    if ($('#toHour').val().length == 0) {
		        alert('Select the To Time');
		        $('#toHour').focus();
		        return false;
		    }
			var numFrom = Number($('#fromHour').val());
			var numTo = Number($('#toHour').val());
			if(numFrom > numTo){
				alert("From Time is greater than To Time");
				return false;
			}
			if ((numTo-numFrom) % 100 != 0){
				alert("You Can schedule only Hourly");
				return false;
			}
		    return true;
		}
		
		,RefreshTutorHours : function(){
		    var tutorsHtml = '';
		    for (var x in TutorInfo) {
				var hrsCount = this.getTutorHours(TutorInfo[x].guid);
		        tutorsHtml += '<div class="TutorsDiv" id="TUDiv_' + x + '"><b>' + hrsCount + '</b> - ' + TutorInfo[x].Name + '</div>';
		    }
		    $('#tdRest').html('<div>' + tutorsHtml + '</div>');
		}
		
		,getTutorHours : function(tutorGuid){
			var count = 0;
			for(var x in ScheduleInfo){
				if(ScheduleInfo[x].tutGuid == tutorGuid){
					count++;
				}
			}
			return count;
		}

		, Show: function() {
			this.RefreshTutorHours();
		    var tdId;
		    if (this.plannerMode == PlannerDay) {

		        /* Day Planner Drawing */
		        var dayhtml = '<table class="weekTable" cellspacing="0" cellpadding="0" border="0"><tr><td style="width:45px;" id="tdTimes">&nbsp;</td>';
		        tdId = 'tdWeek_' + this.ToyyyyMMdd(this.plannerDate);
		        dayhtml += '<td id="' + tdId + '">&nbsp;</td></tr></table>';
		        $('#tdPlanner').html(dayhtml);
		        this.DrawTimeSlice('tdTimes');
		        this.DrawPlannerDay(tdId, this.plannerDate);

		    } else if (this.plannerMode == PlannerWeek) {

		        /* Week Planner Drawing */
		        var curday;
		        var weekHtml = '<table class="weekTable" cellspacing="0" cellpadding="0" border="0"><tr><td style="width:45px;" id="tdTimes">&nbsp;</td>';

		        var curweek = this.plannerDate.getDay() * -1;
		        for (var i = curweek; i < curweek + 7; i++) {
		            curday = new Date(this.plannerDate);
		            curday.setDate(curday.getDate() + i);
		            weekHtml += '<td id="tdWeek_' + this.ToyyyyMMdd(curday) + '">&nbsp;</td>';
		        }
		        weekHtml += '</tr></table>';
		        $('#tdPlanner').html(weekHtml);

		        this.DrawTimeSlice('tdTimes');

		        for (var j = curweek; j < curweek + 7; j++) {
		            curday = new Date(this.plannerDate);
		            curday.setDate(curday.getDate() + j);
		            tdId = 'tdWeek_' + +this.ToyyyyMMdd(curday);
		            this.DrawPlannerDay(tdId, curday);
		        }


		    } else if (this.plannerMode == PlannerMonth) {

		        /* Month Planner Drawing */
		        monthtml = '<table class="monthTable" cellspacing="0" cellpadding="0" border="0"><tr>';
		        var curmonth = aryMonthNames[this.plannerDate.getMonth()];
		        var year = this.plannerDate.getFullYear();
		        var month = this.plannerDate.getMonth();
		        var month1st = new Date(month + '/01/' + year);
		        var dd = new Date(year, month, 0);
		        var maxDays = dd.getDate();
		        monthtml += '<th colspan="7" style="font-weight:bold;text-align:center;">' + curmonth + '</th><tr>';
		        // Step 1. Sun Mon Tue Wed Thu Fri Sat
		        for (var i = 0; i < 7; i++) {
		            monthtml += '<th>' + aryWeekNames[i] + '</th>';
		        }
		        monthtml += '</tr>';

		        monthtml += this.MonthHTML();
		        // Step 2. Draw Month Cells
		        monthtml += '</table>';
		        $('#tdPlanner').html(monthtml);

		    }
		}

		, DrawTimeSlice: function(tdId) {
		    tdSliceHtml = '<div class="tdHeadTitle">&nbsp;</div>';
		    for (var tslice = 0; tslice < aryTimes.length; tslice++) {
		        tdSliceHtml += '<div id="tdSlice_' + aryTimes[tslice] + '" class="tdSlice">' + this.formatTime(aryTimes[tslice], true) + '</div>';
		    }
		    $('#' + tdId).html(tdSliceHtml);
		}

		, ToMMddyyyy: function(day) {
		    return day.getMonth() + 1 + '/' + day.getDate() + '/' + day.getFullYear();
		}

		, ToyyyyMMdd: function(day) {
		    var mm = day.getMonth() + 1;
		    mm = (mm > 9 ? mm : '0' + mm);
		    var dd = (day.getDate() > 9 ? day.getDate() : '0' + day.getDate());
		    return day.getFullYear() + '' + mm + '' + dd;
		}

		, DrawSchedules: function(init) {
		    this.fixDivHighWidth();
		    if (this.plannerMode == PlannerWeek) {
		        var curweek = this.plannerDate.getDay() * -1;
		        var fromDate = new Date(this.plannerDate);
		        fromDate.setDate(fromDate.getDate() + curweek);
		        var toDate = new Date(this.plannerDate);
		        toDate.setDate(toDate.getDate() + curweek + 7);
		        var fromYY = this.ToyyyyMMdd(fromDate);
		        var toYY = this.ToyyyyMMdd(toDate);

		        for (var cnt in ScheduleInfo) {
		            if (this.plannerMode == PlannerWeek) {
		                var objSch = ScheduleInfo[cnt]
		                if (objSch.schDate >= fromYY && objSch.schDate <= toYY) {
							if (objSch.isDeleted == 0){
								this.ShowSchedule(objSch);
							}
		                }
		            }
		        }
		    } else if (this.plannerMode == PlannerDay) {
		        for (var cnt in ScheduleInfo) {
					var objSch = ScheduleInfo[cnt];
		            var curday = this.ToyyyyMMdd(this.plannerDate);
		            if (curday == objSch.schDate) {
						if (objSch.isDeleted == 0){
							this.ShowSchedule(objSch);
						}
		            }
		        }
		    }
			if(typeof init != 'undefined'){
				initialLoad = init;
			}
		}

		, schedulePerRow: function() {
		    if (this.plannerTimeMode == timeModeHalfHours) {
		        return 999;
		    } else {
		        if (this.plannerMode == PlannerWeek) {
		            return 4;
		        } else if (this.plannerMode == PlannerDay) {
		            return 10;
		        } else {
		            return 1;
		        }
		    }
		}

		, getUpperSliceTop : function(divslice, idx){
			var upperIdx = idx - this.schedulePerRow();
			var sliceDate = divslice.split("_")[1];
			var sliceFrom = divslice.split("_")[2];
			found = false;
			var topx = 0;
			for (var cnt in ScheduleInfo) {
				var objSch = ScheduleInfo[cnt];
				if (sliceDate == objSch.schDate && sliceFrom == objSch.schFrom && objSch.Index == upperIdx) {
					found = true;
					topx = objSch.topx + $('#timeSlice_'+objSch.schId).height();
					break;
				}
			}
			return topx;
		}
		
		, ShowSchedule: function(objSch) {
		    var slicediv = '#divSlice_' + objSch.schDate + '_' + objSch.schFrom;
		    if (typeof $(slicediv)[0] != "undefined") {
		        var Idx = Number(objSch.Index);
		        var perRow = this.schedulePerRow();
		        var schLeft = $(slicediv).position()['left'] + ((Idx % perRow) * 115);
		        var schTop = $(slicediv).position()['top'];
				if (Idx >= perRow) {
					schTop = this.getUpperSliceTop(slicediv, Idx) + 5;
				}
		        objSch.leftx = schLeft;
		        objSch.topx = schTop;
				
		        if (objSch.isnew) {
		            $(slicediv).append(objSch.ToHTML(Idx));
		            $('#timeSlice_' + objSch.schId).draggable({ grid: [5, 5] });
					if (!initialLoad && objSch.isnew){
						$('#timeSlice_' + objSch.schId).css('color', this.randColor());
					}
		            objSch.isnew = false;
		            $('#timeSlice_' + objSch.schId).data(objSch);
		        } else {
		            $('#timeSlice_' + objSch.schId).html(objSch.InnerHTML());
		            $('#timeSlice_' + objSch.schId).css('left', objSch.leftx + 'px').css('top', objSch.topx + 'px');
		        }
				
		    }
		}
		, randColor : function() {
			var letters = '0123456789ABCDEF'.split('');
			var color = '#';
			for (var i = 0; i < 6; i++ ) {
				color += letters[Math.round(Math.random() * 15)];
			}
			return color;
		}
		, Divide: function(numerator, denominator) {
		    var remainder = numerator % denominator;
		    var quotient = (numerator - remainder) / denominator;
		    if (quotient >= 0)
		        quotient = Math.floor(quotient);
		    else  // negative
		        quotient = Math.ceil(quotient);

		    return quotient;
		}

		, MaxIndex: function(slicediv) {
		    var slicedate = slicediv.split('_')[1];
		    var slicetime = slicediv.split('_')[2];
		    var Count = 0;
		    if (typeof slicedate != 'undefined' && typeof slicetime != 'undefined') {
		        for (var cnt in ScheduleInfo) {
		            if (ScheduleInfo[cnt].schDate == slicedate) {
		                if (slicetime == ScheduleInfo[cnt].schFrom) {
		                    Count++;
		                }
		            }
		        }
		    }
		    return Count;
		}

		, ReIndex: function(slicediv) {
		    var slicedate = slicediv.split('_')[1];
		    var slicetime = slicediv.split('_')[2];
		    var Count = 0;
		    if (typeof slicedate != 'undefined' && typeof slicetime != 'undefined') {
		        for (var cnt in ScheduleInfo) {
					var objSch = ScheduleInfo[cnt]; 
		            if (objSch.schDate == slicedate) {
		                if (slicetime == objSch.schFrom && objSch.isDeleted==0) {
		                    ScheduleInfo[cnt].Index = Count;
		                    Count++;
		                }
		            }
		        }
		    }
		}

		, fixDivHighWidth: function() {
		    var aryTimeSlice = [];
		    var fromYY = this.ToyyyyMMdd(this.plannerDate);
		    var toYY = this.ToyyyyMMdd(this.plannerDate);
		    if (this.plannerMode == PlannerWeek) {
		        var curweek = this.plannerDate.getDay() * -1;
		        var fromDate = new Date(this.plannerDate);
		        fromDate.setDate(fromDate.getDate() + curweek);
		        var toDate = new Date(this.plannerDate);
		        toDate.setDate(toDate.getDate() + curweek + 7);
		        fromYY = this.ToyyyyMMdd(fromDate);
		        toYY = this.ToyyyyMMdd(toDate);
		    }
		    for (var schIdx in ScheduleInfo) {
		        var objSch = ScheduleInfo[schIdx];
		        if (objSch.schDate >= fromYY && objSch.schDate <= toYY) {
		            var datetimediv = 'divSlice_' + objSch.schDate + '_' + objSch.schFrom;
		            if (!this.findInArray(aryTimeSlice, datetimediv)) {
		                aryTimeSlice.push(datetimediv);
		                this.setDivAdjustment(datetimediv);
		            }
		        }
		    }
		}

		, setDivAdjustment: function(divSlice) {
		    var maxPlans = this.MaxIndex(divSlice);
		    var datepart = divSlice.split('_')[1]; // yyyyMMdd format
		    var timepart = divSlice.split('_')[2];
		    var perRow = this.schedulePerRow();
		    var numRows = this.Divide(maxPlans, perRow);
		    var curDay = new Date(datepart.substr(4, 2) + '/' + datepart.substr(6, 2) + '/' + datepart.substr(0, 4));
		    var adjWidth = (maxPlans <= perRow) ? (maxPlans * 115) : (perRow * 115);
		    this.setDivWidth(curDay, adjWidth);
		    var adjHeight;

		    //if (this.plannerDisplay == OneonOneDisplay) {
		        //OneonOneDisplay
		    //    adjHeight = (maxPlans > perRow) ? ((numRows + 1) * 20) : 20;
		    //} else {
		        //GroupDisplay = 2;
		        adjHeight = (maxPlans > perRow) ? ((numRows + 1) * 50) : 70;
		    //}

		    this.setDivHeight(timepart, adjHeight);
		}

		, findInArray: function(aryObj, item) {
		    var arylength = aryObj.length;
		    for (var i = 0; i < arylength; i++) {
		        if (aryObj[i] === item) {
		            return true;
		        }
		    }
		    return false;
		}

		, setDivHeight: function(timeSlice, divH) {
		    if (this.plannerTimeMode != timeModeHalfHours) {
		        var tdDivH = $('#tdSlice_' + timeSlice).height();
		        if (tdDivH < divH) {
		            $('#tdSlice_' + timeSlice).css('height', divH + 'px');
		        }
		    }
		    var divId;
		    var curDivH;
		    if (this.plannerMode == PlannerWeek) {
		        var curweek = this.plannerDate.getDay() * -1;
		        for (var i = curweek; i < curweek + 7; i++) {
		            var curday = new Date(this.plannerDate);
		            curday.setDate(curday.getDate() + i);
		            divId = 'divSlice_' + this.ToyyyyMMdd(curday) + '_' + timeSlice;
		            if (this.plannerTimeMode == timeModeHalfHours) {
		                //TODO : set div height
		            } else {
		                curDivH = $('#' + divId).height();
		                if (curDivH < divH) {
		                    $('#' + divId).css('height', divH + 'px');
		                }
		            }
		        }
		    } else if (this.plannerMode == PlannerDay) {
		        divId = 'divSlice_' + this.ToyyyyMMdd(this.plannerDate) + '_' + timeSlice;
		        curDivH = $('#' + divId).height();
		        if (this.plannerTimeMode == timeModeHalfHours) {
		            //TODO : set div height
		        } else {
		            if (curDivH < divH) {
		                $('#' + divId).css('height', divH + 'px');
		            }
		        }
		    }
		}

		, setDivWidth: function(theDay, divW) {
		    if (this.plannerMode == PlannerWeek) {
		        for (var tslice = 0; tslice < aryTimes.length; tslice++) {
		            var sliceId = 'divSlice_' + this.ToyyyyMMdd(theDay) + '_' + aryTimes[tslice];
		            var curDivW = $('#' + sliceId).width();
		            if (curDivW < divW) {
		                $('#' + sliceId).css('width', divW + 'px');
		            }
		        }
		    } else if (this.plannerMode == PlannerDay) {
		        $('#tdWeek_' + this.ToyyyyMMdd(theDay)).css('width', '100%');
		    }
		}

		, monthLength: function(month, year) {
		    var dd = new Date(year, month, 0);
		    return dd.getDate();
		}

		, MonthHTML: function() {
		    var m = this.plannerDate.getMonth();
		    var y = this.plannerDate.getFullYear();
		    var curdate = new Date();
		    curdate.setDate(1);
		    curdate.setMonth(m);
		    curdate.setFullYear(y);

		    var x = 7; // Saturday = 6 Start of the Week
		    var s = (curdate.getDay() - x) % 7;
		    if (s < 0) s += 7;
		    var dm = this.monthLength(m, y);

		    h = '<tbody><tr>';

		    for (var i = s; i > 0; i--) {
		        h += this.setCell(0, dm - i + 1, (s - i + x) % 7);
		    }

		    dm = this.monthLength(m + 1, y);
		    for (var i = 1; i <= dm; i++) {
		        if ((s % 7) == 0) { h += '<\/tr><tr>'; s = 0; }
		        h += this.setCell(1, i, (s + x) % 7);
		        s++;
		    }
		    var j = 1;
		    for (var i = s; i < 7; i++) {
		        h += this.setCell(9, j, (i + x) % 7);
		        j++;
		    }
		    h += '<\/tr><\/tbody>';
		    return h;
		}

		, setCell: function(f, day, col) {
		    var c = [];
		    var t = '<td';
		    if (f == 0) c.push('previous');
		    if (col == 0 || col == 6) c.push('weekend');
		    if (f == 9) c.push('next');
		    if (c.length > 0) t += ' class="' + c.join(' ') + '"';
		    t += '><span class="date">' + day + '<\/span><div class="day"><\/div><\/td>';
		    return t;
		}

} // end return
    } ();                       // end Best Planner function object
