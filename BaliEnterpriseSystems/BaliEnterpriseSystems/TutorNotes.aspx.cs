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
    public partial class TutorNotes : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.TutorMenu("tutornotes");
            if (!Utils.User.UserRoleByName("Tutor - Notes").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            string saveClicked = Request.Form["SaveClicked"] ?? "";
            if (IsPostBack && saveClicked.Equals("1"))
            {
                BestTutorNotes bs = new BestTutorNotes();
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
                    if (!string.IsNullOrEmpty(isnew))
                    {
                        string guid = Request.Form["g_tutorGuid"];
                        if (string.IsNullOrEmpty(guid))
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage("Tutor Name is Required.");
                            cansave = false;
                        }
                        bs.tutorGuid = new Guid(guid);
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
            sb.AppendLine("autoTutors = [");
            BestTutors bstd = new BestTutors();
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
		$('#tutorTag1').autocomplete( { source:autoTutors, delay: 0, select : function( event, ui){ 
			$('#tutorGuid').val( ui.item.value );
			$( this ).val( ui.item.label ); 
			return false; 
		} } ); }); </script>";

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Tutor Notes";
            bsGrid.GridTable = new BestTutorNotes();
            bsGrid.securityPage = "Tutor - Notes";
            ltrGrid.Text = bsGrid.ToHTML();

        }
    }
}
