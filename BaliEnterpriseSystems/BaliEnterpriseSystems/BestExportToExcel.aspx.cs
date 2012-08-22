using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;
using System.Text;

namespace BaliEnterpriseSystems
{
    public partial class BestExportToExcel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.UtilityMenu("exportexcel");
            
            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            if (!Utils.User.UserRoleByName("Export To Excel").allowView)
            {
                ltrValidateMsg.Text = "You do not have rights to view.";
                return;
            }

            if (IsPostBack)
            {
                BestExports bs = new BestExports();
                string isnew = Request.Form["isnew"];
                bool cansave = true;
                Guid exportGuid = Guid.NewGuid();
                if (string.IsNullOrEmpty(isnew))
                {
                    List<BestField> bparams = new List<BestField>();
                    BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                    guid.fieldValue = Request.Form["guidfield"];
                    bparams.Add(guid);
                    if (Utils.IsGuid(guid.fieldValue))
                    {
                        exportGuid = new Guid(guid.fieldValue);
                    }

                    if (!string.IsNullOrEmpty(guid.fieldValue))
                    {
                        bs.LoadRows("guidfield=?", bparams);
                    }
                    else
                    {
                        string delguid = Request.Form["deleteguid"];
                        if (!string.IsNullOrEmpty(delguid))
                        {
                            bparams[0].fieldValue = delguid;
                            bs.LoadRows("guidfield=?", bparams);
                            bs.CurrentRow.IsDelete = true;
                            bs.CurrentRow.Save();
                        }
                        cansave = false;
                    }
                }
                else
                {
                    bs.guidfield = exportGuid;
                }

                if (cansave)
                {
                    if (!string.IsNullOrEmpty(isnew)) { bs.exportName = Request.Form["g_exportName"]; }                    
                    if (string.IsNullOrEmpty(bs.exportName))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Export Name is Required.");
                        cansave = false;
                    }
                    if (cansave)
                    {
                        bs.exportType = Request.Form["g_exportType"];
                        bs.exportTitle = Request.Form["g_exportTitle"];
                        if (!bs.CurrentRow.Save())
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                        else
                        {
                            /* Insert or Update Export Fields */
                            string FieldData = Request.Form["hidExportData"] ?? "";
                            if (!string.IsNullOrEmpty(FieldData))
                            {
                                string[] lines = FieldData.Split('\n');
                                int i = 0;
                                foreach (string line in lines)
                                {
                                    if (!string.IsNullOrEmpty(line))
                                    {
                                        string[] fields = line.Replace("\r","").Split('\t');
                                        //0.guidfield 1.exportguid 2.fieldname 3.displayname 4.isnew 5.isdeleted
                                        if (fields[4].Equals("1"))
                                        {
                                            if (fields[5].Equals("0") && (!string.IsNullOrEmpty(fields[2])))
                                            {
                                                /* Add New */
                                                BestExportFields bexpfld = new BestExportFields();
                                                bexpfld.exportguid = exportGuid;
                                                bexpfld.fieldName = fields[2];
                                                bexpfld.displayName = fields[3];
                                                int idx;
                                                int.TryParse(fields[6], out idx);
                                                bexpfld.Ordinal = idx;
                                                if (!bexpfld.CurrentRow.Save())
                                                {
                                                    ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                                                }
                                            }
                                        }
                                        else
                                        {
                                            /* Update */
                                            List<BestField> bparam = new List<BestField>();
                                            BestField fguid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                                            fguid.fieldValue = fields[0];
                                            bparam.Add(fguid);
                                            BestExportFields bsFields = new BestExportFields();
                                            bsFields.LoadRows("guidfield=?", bparam);
                                            bsFields.fieldName = fields[2];
                                            bsFields.displayName = fields[3];
                                            int idx;
                                            int.TryParse(fields[6], out idx);
                                            bsFields.Ordinal = idx;
                                            bsFields.CurrentRow.IsDelete = fields[5].Equals("1");
                                            if (!bsFields.CurrentRow.Save())
                                            {
                                                ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if ((Request.Form["SaveAndExport"] ?? "").Equals("1"))
                {
                    ltrExportScript.Text = @"<script type=""text/javascript"">$(document).ready(function(){
                            $('#addiframe').html('<iframe src = ""DownloadExport.aspx?exportguid=" + exportGuid + @""" /></iframe>');
                    });</script>";
                }
            }

            ltrPageScript.Text = "<script type=\"text/javascript\">" + ExportFieldJS() +"\n" + ExportMastTableJs() + "</script>";

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Export Information";
            bsGrid.securityPage = "Export To Excel";
            bsGrid.GridTable = new BestExports();
            bsGrid.extraRowHTML = "<a href=\"DownloadExport.aspx?exportguid=[paramGuid]\" ><img src=\"images\\xls.gif\" alt=\"runexport\" /></a>";
            ltrGrid.Text = bsGrid.ToHTML();
        }

        private string ExportFieldJS()
        {
            BestExportFields bexpFlds = new BestExportFields();
            bexpFlds.LoadRows("exportguid,ordinal");
            return "jsExpFields = [" + string.Join(",", bexpFlds.TableRows.Rows.Select(x => "{guidfield:" + Utils.EnquoteJS(x.Fields["guidfield"].fieldValue) + ",exportguid:" + Utils.EnquoteJS(x.Fields["exportguid"].fieldValue) + ",fieldname:" + Utils.EnquoteJS(x.Fields["fieldname"].fieldValue) + ",displayname:" + Utils.EnquoteJS(x.Fields["displayname"].fieldValue) + ",isnew:0,isdeleted:0,Index:\"" + x.Fields["ordinal"].fieldValue + "\"}").ToArray()) + "]";
        }

        private string ExportMastTableJs()
        {
            BestExportTables bexpTbl = new BestExportTables();
            bexpTbl.LoadRows("displayname");
            return "var selHTML = [" + string.Join(",", bexpTbl.TableRows.Rows.Select(x => "{fieldname:" + Utils.EnquoteJS(x.Fields["fieldname"].fieldValue) + ",displayname:" + Utils.EnquoteJS(x.Fields["displayname"].fieldValue) + ",aliasname:" + Utils.EnquoteJS(x.Fields["aliasname"].fieldValue) + ",exportType:" + Utils.EnquoteJS(x.Fields["exporttype"].fieldValue) + "}").ToArray()) + "]";
        }
    }
}
