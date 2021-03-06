﻿var g_nameOnScheduler = "Balaji Musaboyina";
var g_curSTGuid = '9090-9090';
var g_IsStudent = true;

var STPlanInfo = [];

var aryTimes = ['600', '630', '700', '730', '800', '830', '900', '930', '1000', '1030', '1100', '1130', '1200', '1230', '1300', '1330', '1400', '1430', '1500', '1530', '1600', '1630', '1700', '1730', '1800', '1830', '1900', '1930', '2000', '2030', '2100', '2130', '2200'];

function STPlan(guid, stuguid, tutguid, sdate, sfrom, sto, idx) {
    this.guidfield = guid;
    this.stuGuid = stuguid;
    this.tutGuid = tutguid;
    this.schDay = sdate;
    this.schFrom = sfrom;
    this.schTo = sto;
    this.schId = idx;
    this.topx = 0;
    this.leftx = 0;
    this.isDeleted = 0;

    this.ToHTML = function() {
    return '<div style="position:absolute;top:' + this.topx + 'px;left:' + this.leftx + 'px;" id="timeSlice_' + this.schId + '"><div style="height:16px;width:70px;background-color:#D3E9DC;border:1px solid #6FA987;float:left;border-top-left-radius: 5px;border-top-right-radius: 5px;text-align:center;vertical-align:top;"><div style="float:right;"><img onclick="BestScheduler.deleteSTPlan(\'' + this.guidfield + '\');" style="cursor:pointer;" src="images/delete.png" alt="del" /></div><div style="float:left;padding-left:2px;">' + this.schFrom + '</div></div>' + this.InnerHTML() + '</div>';
    }


    this.InnerHTML = function() {
    return '<div style="background-color:#D3E9DC;border-top-left-radius: 5px;border-top-right-radius: 5px;border:1px solid #6FA987;font-size:12px;height:45px;width:70px;">' + g_nameOnScheduler + '</div>';
    }
}


var BestScheduler = function() {
    var editTimeSlice = '';
    return {
        saveToDB: function(objSch) {
            var tempSch = objSch;
            var params = {};
            params.schType = (g_IsStudent ? "Student" : "Tutor");
            params.tutGuid = tempSch.tutGuid;
            params.stuGuid = tempSch.stuGuid;
            params.guidfield = tempSch.guidfield;
            params.schDay = tempSch.schDay;
            params.schFrom = tempSch.schFrom;
            params.schTo = tempSch.schTo;
            params.isDel = tempSch.isDeleted;
            $.post("SaveSTPlan.aspx", params, function(data) {
                var tempSch = objSch;
                var jsonObj;
                eval('jsonObj=' + data);
                if (jsonObj.result) {
                    var guidfield = tempSch.guidfield;
                    var idx = BestPlanner.findIndex(STPlanInfo, function(obj) { return (obj.guidfield == guidfield); });
                    if (idx > -1) {
                        tempSch.guidfield = jsonObj.guid;
                        $('#timeSlice_' + objSch.schId).data(tempSch);
                        STPlanInfo[idx] = tempSch;
                    }
                } else {
                    alert(jsonObj.Message);
                    $("form:first").submit();
                }
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
		    for (var x in STPlanInfo) {
		        var objSch = new STPlan();
		        objSch.schId = x;
		        jQuery.extend(objSch, STPlanInfo[x]);
		        STPlanInfo[x] = objSch;
		    }
		}

		, updSTPlanInfo: function(objSch) {
		    var guidfield = objSch.guidfield;
		    var idx = this.findIndex(STPlanInfo, function(obj) { return (obj.guidfield == guidfield); });
		    if (idx > -1) {
		        STPlanInfo[idx] = objSch;
		    }
		}
		
		, deleteSTPlan: function(guid){
		    var idx = this.findIndex(STPlanInfo, function(obj) { return (obj.guidfield == guid); });
		    if (idx > -1) {
		        STPlanInfo[idx].isDeleted = 1;
				this.clearAllSchedules();
				var ndivslice = 'divSlice_' + STPlanInfo[idx].schDay + '_' + STPlanInfo[idx].schFrom;
				this.ReDraw(ndivslice);
				this.saveToDB(STPlanInfo[idx]);				
		    }
		}

		, AddSTPlan: function(sguid, tguid, sdate, sfrom, sto) {
		    var divslice = 'divSlice_' + sdate + '_' + sfrom
		    var schId = STPlanInfo.length;
		    var pk = randomString();
		    var newSch = new STPlan(pk, sguid, tguid, sdate, sfrom, sto, schId);
		    STPlanInfo[STPlanInfo.length] = newSch;
		    this.ReDraw(divslice);
		    this.saveToDB(newSch);
		}

		, ReDraw: function(divslice) {
		    this.clearAllSchedules();
		    this.DrawSchedules();
		}

		, clearAllSchedules: function() {
		    for (var schIdx in STPlanInfo) {
		        var objSch = STPlanInfo[schIdx];
		        var datetimediv = 'divSlice_' + objSch.schDay + '_' + objSch.schFrom;
		        $('#' + datetimediv).html('');
		    }
		}

		, Show: function() {
		    /* Week Planner Drawing */
		    var weekHtml = '<table class="weekTable" cellspacing="0" cellpadding="0" border="0"><tr><td style="width:45px;" id="tdTimes">&nbsp;</td>';

		    var curweek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		    for (var i = 0; i < curweek.length; i++) {
		        weekHtml += '<td id="tdWeek_' + curweek[i] + '">&nbsp;</td>';
		    }
		    weekHtml += '</tr></table>';
		    $('#tdPlanner').html(weekHtml);

		    this.DrawTimeSlice('tdTimes');

		    for (var j = 0; j < curweek.length; j++) {
		        var tdId = 'tdWeek_' + curweek[j];
		        this.DrawPlannerDay(tdId, curweek[j]);
		    }
		}

		, DrawTimeSlice: function(tdId) {
		    tdSliceHtml = '<div class="tdHeadTitle">&nbsp;</div>';
		    for (var tslice = 0; tslice < aryTimes.length; tslice++) {
		        tdSliceHtml += '<div id="tdSlice_' + aryTimes[tslice] + '" class="tdSlice">' + this.formatTime(aryTimes[tslice], true) + '</div>';
		    }
		    $('#' + tdId).html(tdSliceHtml);
		}

		, AddToScheduler: function(divSlice) {
		    var sdate = divSlice.id.split('_')[1];
		    var ftime = divSlice.id.split('_')[2];
		    var ttime = Number(ftime) + 100;
		    var sguid = '';
		    var tguid = '';
		    if (g_IsStudent) {
		        sguid = g_curSTGuid;
		    } else {
		        tguid = g_curSTGuid;
		    }
		    BestScheduler.AddSTPlan(sguid, tguid, sdate, ftime, ttime);
		}

		, DrawPlannerDay: function(tdId, theDay) {
		    plannerHtml = '<div class="tdHeadTitle">' + theDay + '</div>';
		    var dropDivs = '';
		    var tdWidth = $('#' + tdId).width()
		    for (var tslice = 0; tslice < aryTimes.length; tslice++) {
		        var divclass = (tslice % 2 == 0) ? "scaleeven" : "scaleodd";
		        var sliceId = 'divSlice_' + theDay + '_' + aryTimes[tslice];
		        plannerHtml += '<div class="' + divclass + '" id="' + sliceId + '" ondblclick="BestScheduler.AddToScheduler(this);">&nbsp;</div>';
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
		                    var odivslice = 'divSlice_' + objSch.schDay + '_' + objSch.schFrom;
		                    var ndivslice = 'divSlice_' + curDate + '_' + curFrom
		                    objSch.schDay = curDate;
		                    objSch.schFrom = curFrom;
		                    objSch.schTo = Number(curFrom) + 100;
		                    $('#timeSlice_' + objSch.schId).data(objSch);
		                    BestScheduler.clearAllSchedules();
		                    BestScheduler.updSTPlanInfo(objSch);
		                    BestScheduler.ReDraw(ndivslice);
		                    BestScheduler.saveToDB(objSch);
		                }
		            }
		        }
		    });
		}

		, DrawSchedules: function() {
		    for (var cnt in STPlanInfo) {
				if(STPlanInfo[cnt].isDeleted==0){
					this.ShowSTPlan(STPlanInfo[cnt]);
				}
		    }
		}

		, ShowSTPlan: function(objSch) {
		    var slicediv = '#divSlice_' + objSch.schDay + '_' + objSch.schFrom;
		    var schLeft = $(slicediv).position()['left'];
		    var schTop = $(slicediv).position()['top'];

		    objSch.leftx = schLeft;
		    objSch.topx = schTop;
		    $(slicediv).append(objSch.ToHTML());
		    $('#timeSlice_' + objSch.schId).draggable({ grid: [5, 5] });
		    $('#timeSlice_' + objSch.schId).data(objSch);
		}

} // end return
    } ();    // end Best Planner function object
