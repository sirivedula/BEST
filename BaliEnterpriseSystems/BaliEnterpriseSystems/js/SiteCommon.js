var cntdimbody = 0;

function dimBody() {
    cntdimbody += 1;
    ajaxWait(true);
}

function undimBody() {
    cntdimbody -= 1;
    if (cntdimbody < 0)
        cntdimbody = 0;
    if (cntdimbody == 0)
        ajaxWait(false);
}

function ajaxWait(display) {
    if (display) { 
        showprogress("Saving...");
    } else {
        hideprogress(); 
    }
    return;
}

function hideprogress() {
    $('#progressbardiv').jqm().jqmHide();
}

function showprogress(msg) {
    var prgbar = document.getElementById('progressbarcontent');
    prgbar.innerHTML = msg;
    $('#progressbardiv').css('left', '40%').css('top','110px');
    $('#progressbardiv').jqm().jqmShow();
}

function randomString() {
    var chars = "!@#$%^&*()_+=<>?[]}{;0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
    var string_length = 16;
    var randomstring = '';
    for (var i = 0; i < string_length; i++) {
        var rnum = Math.floor(Math.random() * chars.length);
        randomstring += chars.substring(rnum, rnum + 1);
    }
    return randomstring;
}

function PrintTable(divId) {
    var thtml = '<style>.ra{text-align:right;} .tblreports { width:90%; font-size:9px;} .tblreports { background-color:#D3E9DC; font-family:Tahoma; border:1px solid #000; } .tblreports th { background-color:#6FA987; color:#ffffff; border-bottom:1px solid #6FA987; border-right:1px solid #6FA987; font-weight:bold; padding:2px; } .tblreports td { border-bottom:1px solid #6FA987; border-right:1px solid #6FA987; }</style>' + $('#' + divId).html();
    printNewWindow(thtml);
}

function printNewWindow(myhtml, hasBody, myheight, mywidth) {
    if (typeof myheight == 'undefined') { var myheight = "600" }
    if (typeof mywidth == 'undefined') { var mywidth = "1024" }
    var disp_setting = "toolbar=no,location=no,directories=yes,menubar=yes,";
    disp_setting += "scrollbars=yes,width=" + mywidth + ", height=" + myheight + ", left=100, top=25";
    var docprint = window.open("", "", disp_setting);
    docprint.document.open();
    docprint.document.write('<html><head><title>BEST</title>');
    if ((typeof hasBody == 'undefined') || (!hasBody)) {
        docprint.document.write('</head><body onLoad="self.print();">');
    }
    docprint.document.write(myhtml)
    docprint.document.write('</body></html>');
    docprint.document.close();
    docprint.focus();
    return docprint;
}
