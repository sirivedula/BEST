using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using BaliEnterpriseSystems.BestObjects;
using System.Collections.Generic;
using System.Text;

namespace BaliEnterpriseSystems
{
    public partial class StudentNotes : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentnotes");
            if (!Utils.User.UserRoleByName("Student - Notes").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }            

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            string saveClicked = Request.Form["SaveClicked"] ?? "";
            if (IsPostBack && saveClicked.Equals("1"))
            {
                BestStudentNotes bs = new BestStudentNotes();
                string isnew = Request.Form["isnew"];
                bool cansave = true;
                if (string.IsNullOrEmpty(isnew))
                {
                    List<BestField> bparams = new List<BestField>();
                    BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                    guid.fieldValue = Request.Form["guidfield"];
                    bparams.Add(guid);

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

                if (cansave)
                {
                    if (!string.IsNullOrEmpty(isnew)) { 
                        string guid = Request.Form["g_studentGuid"];
                        if (string.IsNullOrEmpty(guid))
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage("Student Name is Required.");
                            cansave = false;
                        }
                        bs.studentGuid = new Guid(guid);
                        BestStudents bestStd = new BestStudents();
                        bestStd.LoadRows("guidfield=?", "studentguid", bs.studentGuid, "");
                        bs.StudentId = bestStd.StudentId;
                    }
                    if (cansave)
                    {
                        string notedate = Request.Form["g_noteDate"];
                        if (!string.IsNullOrEmpty(notedate))
                        {
                            bs.noteDate = Convert.ToDateTime(notedate);
                        }
                        bs.notes = Request.Form["g_notes"];
                        bs.CenterId = Utils.User.CenterId;

                        if (!bs.CurrentRow.Save())
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                    }
                }
            }

            /* Auto Student */
            string autoSample = "{value:\"[paramValue]\", label:[paramLabel]}";
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("autoStudents = [");
            BestStudents bstd = new BestStudents();
            bstd.LoadRows("CenterId=?", Utils.User.CIdParam);
            for (int s = 0; s < bstd.TableRows.Count; s++)
            {
                string result = autoSample;
                result = result.Replace("[paramValue]", bstd.TableRows[s].Fields["guidfield"].fieldValue);
                result = result.Replace("[paramLabel]", Utils.EnquoteJS((bstd.TableRows[s].Fields["firstName"].fieldValue ?? "") + " " +
                    (bstd.TableRows[s].Fields["lastName"].fieldValue ?? "")));
                sb.Append(result);
                if (s < bstd.TableRows.Count - 1) sb.AppendLine(",");
            }
            sb.AppendLine("];");
            ltrScript.Text = @"<script type=""text/javascript"">
        $(document).ready(function(){ " + sb.ToString() + @" 
		$('#studentTag1').autocomplete( { source:autoStudents, delay: 0, select : function( event, ui){ 
			$('#studentGuid').val( ui.item.value );
			$( this ).val( ui.item.label ); 
			return false; 
		} } ); }); </script>";

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Student Notes";
            bsGrid.GridTable = new BestStudentNotes();
            bsGrid.securityPage = "Student - Notes";
            ltrGrid.Text = bsGrid.ToHTML();
        }
    }
}
