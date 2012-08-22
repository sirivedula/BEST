<%@ Page Title="Best - Export" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="BestExportToExcel.aspx.cs" Inherits="BaliEnterpriseSystems.BestExportToExcel"  EnableViewState="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    var rowCnt = 0;
    var jsExpFields = [];
    var curExpFields = [];
    
    $(document).ready(function() {
        BestJSGrid.requiredFields.push({ name: 'exportName', description: 'Export Name' });
    });
    
    function addNew() {
        BestJSGrid.addNew("bestExcelFieldsDiv", 600, 370);
        $('#exportType').val("Students");
        $("#tblExcelFields > tbody").html('');
        curExpFields = [];
    }
    
    function getExportFieldOpts(exportType) {
        var str = '<option value=""></option>';
        for (var x in selHTML) {
            if (selHTML[x].exportType == exportType) {
                str += '<option value="' + selHTML[x].aliasname + '.' + selHTML[x].fieldname + '">' + selHTML[x].displayname + '</option>';
            }
        }
        return str;
    }
    
    function editForm(rownum) {
        BestJSGrid.fillUIForm(rownum, "bestExcelFieldsDiv", 600, 370);
        $("#tblExcelFields > tbody").html('');
        var currow = gridJS.Rows[BestJSGrid.CurrentRow];
        if (typeof currow != 'undefined') {
            editGuid = currow["guidfield"];
            curExpFields = [];
            var idx = 0;
            for (var x in jsExpFields) {
                if (jsExpFields[x].exportguid == editGuid) {
                    var itemIdx = curExpFields.length;
                    addRow('edit');
                    curExpFields[itemIdx] = jsExpFields[x];
                    curExpFields[itemIdx].Index = idx;
                    $('#field' + idx).val(jsExpFields[x].fieldname);
                    $('#display' + idx).val(jsExpFields[x].displayname);
                    idx++;
                }
            }
        }
    }
    
    function getSeqIndex() {
        var idx = 0;
        for (var x in curExpFields) {
            if (curExpFields[x].isdeleted == 0) {
                idx++;
            }
        }
        return idx;
    }
    
    function addRow(mode) {
        var idx = curExpFields.length;
        var exptype = $('#exportType').val();
        var rowHTML = '<tr><td id="tdRow' + idx + '">#' + (getSeqIndex()+1) + '</td><td><select id="field' + idx + '" name="field' + idx + '" onchange="updFieldJS(' + idx + ',this,\'fieldname\');">' + getExportFieldOpts(exptype) + '</select></td><td><input type="text" id="display' + idx + '" name="display' + idx + '" onchange="updFieldJS(' + idx + ',this,\'displayname\')" /></td><td><a href="javascript:void(0);" onclick="deleteRow(' + idx + ');"><img src="images/cancel.png" alt="delete" /></a></td></tr>';
        var $added = $('#tblExcelFields > tbody:last').append(rowHTML);
        if (mode == 'add') {
            curExpFields[curExpFields.length] = { guidfield: "new", Index: getSeqIndex(), fieldname: "", displayname: "", exportguid: "", isnew: 1, isdeleted: 0 };
        }
    }

    function deleteRow(delIdx) {
        if (confirm("do you want to delete ?")) {
            var idx = curExpFields[delIdx].Index;
            curExpFields[delIdx].isdeleted = 1;
            $($('#tblExcelFields > tbody > tr')[idx]).empty().remove();
            idx = 0;
            for (var x in curExpFields) {
                if (curExpFields[x].isdeleted==0) {
                    curExpFields[x].Index = idx;
                    $('#tdRow' + x).html('#' + (idx + 1));
                    idx++;                    
                }
            }
        }
    }

    function updFieldJS(idx, fld, name) {
        curExpFields[idx][name] = $(fld).val();
        if (name == "fieldname") {
            var val = fld.options[fld.selectedIndex].text;
            curExpFields[idx]["displayname"] = val;
            $('#display' + idx).val(val);
        }
    }

    function fillCombo(expType) {
        
    }
    
    function beforeSave() {
        var expFieldData = "";
        for (var x in curExpFields) {
            /* Data Submit Format : guidfield fieldname displayname */
            if (!(curExpFields[x].isnew == 1 && curExpFields[x].isdeleted == 1)) {
                expFieldData += curExpFields[x].guidfield + '\t' + curExpFields[x].exportguid + '\t' + curExpFields[x].fieldname + '\t' + curExpFields[x].displayname + '\t' + curExpFields[x].isnew + '\t' + curExpFields[x].isdeleted + '\t' + curExpFields[x].Index + '\n';
            }
        }
        $("#hidExportData").val(expFieldData);
    }

    function SaveExport() {
        $('#SaveAndExport').val("1");
        BestJSGrid.Save();
    }
</script>
<asp:Literal ID="ltrExportScript" runat="server"></asp:Literal>
<asp:Literal ID="ltrMScript" runat="server"></asp:Literal>
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
<div id="addiframe"></div>
<input type="hidden" id="SaveAndExport" name="SaveAndExport" />
<input type="hidden" id="hidExportData" name="hidExportData" />
    <div id="bestExcelFieldsDiv" style="display:none;">
        <table><tr><td>Export Name</td><td><input type="text" id="exportName" name="exportName" maxlength="50" /></td></tr><tr><td>Export Title</td><td><input type="text" id="exportTitle" name="exportTitle" size="40" maxlength="50" /></td></tr><tr><td>Export Type</td><td><select id="exportType" name="exportType" onchange="fillCombo(this.value);"><option value="Students">Students</option><option value="Tutors">Tutors</option><option value="Payments">Payments</option><option value="Schedules">Schedules</option><option value="Change Audit">Change Audit</option></select></td></tr></table>
        <table id="tblExcelFields" style="width:99%;border:1px solid #999;"><thead style="font-weight:bold;text-align:center;"><tr><td style="border-bottom:1px solid #999;">#</td><td style="border-bottom:1px solid #999;">Field Name</td><td style="border-bottom:1px solid #999;">Header Name</td></tr></thead>
            <tbody>               
            </tbody>
            <tfoot><td><a href="javascript:void(0);" onclick="addRow('add');"><img src="images/add.png" alt="add" /></a></td></tfoot>
        </table>
        <table><tr><td><input type="button" id="btnSave" name="btnSave" value="Save" onclick="BestJSGrid.Save();"/></td><td><input type="button" id="btnSaveExp" value="Save & Export" onclick="SaveExport();"/></td></tr></table>
    </div>
    
<asp:Literal ID="ltrPageScript" runat="server"></asp:Literal>
</asp:Content>
