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
    public partial class StudentDocuments : System.Web.UI.Page
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
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentdocument");
            if (!Utils.User.UserRoleByName("Student - Documents").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            string saveClicked = Request.Form["SaveClicked"] ?? "";
            if (IsPostBack && saveClicked.Equals("1"))
            {
                BestDocuments bs = new BestDocuments();
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
                        string guid = Request.Form["g_studentGuid"];
                        if (string.IsNullOrEmpty(guid))
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage("Student Name is Required.");
                            cansave = false;
                        }
                        bs.studentGuid = new Guid(guid);
                    }
                    if (cansave)
                    {
                        bool showToStudent = (Request.Form["g_showToStudent"] ?? "").ToLower().Equals("true");
                        bs.showToStudent = showToStudent;
                        string docdate = Request.Form["g_documentDate"];
                        if (!string.IsNullOrEmpty(docdate))
                        {
                            bs.documentDate = Convert.ToDateTime(docdate);
                        }
                        bs.documentTitle = Request.Form["g_documentTitle"];
                        string expdate = Request.Form["g_documentExpiry"];
                        if (!string.IsNullOrEmpty(expdate))
                        {
                            bs.documentExpiry = Convert.ToDateTime(expdate);
                        }
                        bs.CenterId = Utils.User.CenterId;
                        BestStudents bestStd = new BestStudents();
                        bestStd.LoadRows("guidfield=?", "studentguid", bs.studentGuid, "");
                        bs.StudentId = bestStd.StudentId;

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
            bsGrid.Title = "Student Documents";
            bsGrid.securityPage = "Student - Documents";
            bsGrid.GridTable = new BestDocuments();
            bsGrid.extraRowHTML = "<span><a href=\"javascript:void(0);\" onclick=\"showUploadDocument('[paramCID]','[paramSID]','[paramGuid]', [paramRowNum]);\" title=\"Upload Document\" ><img src=\"images\\folder_page.png\" alt=\"upload\" /></a></span><span><a href=\"javascript:void(0);\" onclick=\"DownloadDocument('[paramGuid]','[paramCID]','[paramSID]');\" title=\"Download Document\"><img src=\"images\\page_white_put.png\" alt=\"upload\" /></a></span>";
            bsGrid.whereClause = "";
            ltrGrid.Text = bsGrid.ToHTML();

        }
    }
}
