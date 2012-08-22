
function submit(){
    $('form:first').submit();
}

function gotoPage(direction){
	if(direction == 1 || direction == -1){
		var cpage = Number($('#curpage').val()) + direction;
		$('#curpage').val(cpage);
	} else {
		if(direction == 0) 
			$('#curpage').val('1');
		else
			$('#curpage').val(direction);
	}
	submit();
}

var BestJSGrid = function() {
    var CurrentRow = -1;
    var requiredFields = []; //should contain a JS object {name:'',description:''}
    return {
        requiredFields: requiredFields
		  , fillUIForm: function(rownum, divname, hx, wx) {
		      if (typeof hx == 'undefined') hx = 200;
		      if (typeof wx == 'undefined') wx = 400;

		      $('#' + divname).dialog({ title: gridJS.title, height: hx, width: wx, modal: true });
		      this.CurrentRow = rownum;
		      var currow = gridJS.Rows[rownum];
		      if (typeof currow != 'undefined') {
		          for (fields in currow) {
		              $('#' + fields).val(currow[fields]);
		          }
		      } else {
		          $('input:not(:button)').val('');
		      }
		      if (typeof gridfillDefaults == 'function') {
		          gridfillDefaults(rownum);
		      }
		  }
		, Save: function() {
		    if (!this.validateRequired()) {
		        return false;
		    }
		    if (typeof beforeSave == 'function') {
		        beforeSave();
		    }
		    var hiddenFields = $(':hidden');
		    for (var x in hiddenFields) {
		        var theField = hiddenFields[x];
		        if (typeof theField.id != 'undefined') {
		            if (theField.id.indexOf('g_') == 0) {
		                var formInput = theField.id.replace('g_', '');
		                $(theField).val($('#' + formInput).val());
		            }
		        }
		    }

		    if (typeof afterGridSetValue == 'function') {
		        afterGridSetValue();
		    }

		    if (this.CurrentRow == -1) {
		        $('#isnew').val("true");
		        $('#guidfield').val('');
		    } else {
		        $('#isnew').val('');
		        var currow = gridJS.Rows[this.CurrentRow];
		        if (typeof currow != 'undefined') {
		            $('#guidfield').val(currow["guidfield"]);
		        } else {
		            $('#guidfield').val('');
		        }
		    }
			$("#SaveClicked").val("1");
		    $("form:first").submit();
		}
		, addNew: function(divname, hx, wx) {
		    this.fillUIForm(-1, divname, hx, wx);
		}
		, deleteRec: function(delguid) {
		    if (confirm("Do you want to delete?")) {
		        $('#deleteguid').val(delguid);
				$("#SaveClicked").val("1");
		        $("form:first").submit();
		    }
		}
		, validateRequired: function() {
		    var problem = false;
		    for (var counter = 0; counter < this.requiredFields.length; counter++) {
		        var fieldProblem = false;
		        var requiredInfo = requiredFields[counter];
		        if ($('#' + requiredInfo.name).val().replace(/^\s+/, '') == '') {
		            fieldProblem = true;
		        }
		        if (fieldProblem) {
		            alert(requiredInfo.description + ' is Required');
		            problem = true;
		            $('#' + requiredInfo.name).focus();
		            break;
		        }
		    }
		    return !problem;
		}
		, HeaderSort: function(newsortby) {
		    var cursortby = $('#sortby').val();
		    if (newsortby == cursortby) {
		        if ($('#sortdir').val() == 'desc') {
		            $('#sortdir').val('asc');
		        } else {
		            $('#sortdir').val('desc');
		        }
		    } else {
		        $('#sortdir').val('asc');
		    }
		    $('#sortby').val(newsortby);
		    $("form:first").submit();
		}
    }
} ();

