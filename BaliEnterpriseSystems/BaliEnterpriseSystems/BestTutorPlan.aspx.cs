using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class BestTutorPlan : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.TutorMenu("tutorplanner");
            if (!Utils.User.UserRoleByName("Tutor - Planner").allowView)
            {
                ltrValidateMsg.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);
            BestTutors bstd = new BestTutors();
            string tutorLoginScript = "";
            if (Utils.User.BestUser.userType.Equals("Tutor"))
            {
                List<BestField> bparam = new List<BestField>();
                bparam.Add(new BestField() { fieldName = "tutorGuid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
                bparam[0].fieldValue = Utils.User.BestUser.tutorGuid.ToString();
                bstd.LoadRows("guidfield=?", bparam);
                tutorLoginScript = "$('#tblStudentSel').css('display','none');";
            }
            else
            {
                bstd.LoadRows("CenterId=?", Utils.User.CIdParam);
            }
            string selstudent = Request.Form["selTutor"];
            StringBuilder sb = new StringBuilder();
            string selName = "";
            for (int i = 0; i < bstd.TableRows.Count; i++)
            {
                string sname = bstd.TableRows[i].Fields["firstname"].fieldValue + " " + bstd.TableRows[i].Fields["lastname"].fieldValue;
                string sguid = bstd.TableRows[i].Fields["guidfield"].fieldValue;
                sb.Append("<option value=\"" + HttpUtility.HtmlEncode(sguid) + "\"");
                if (string.IsNullOrEmpty(selstudent))
                {
                    selstudent = sguid;
                }
                if (sguid.Equals(selstudent))
                {
                    selName = sname;
                    sb.Append(" selected ");
                }
                sb.Append(">" + HttpUtility.HtmlEncode(sname) + "</option>");
            }
            ltrTutorOpts.Text = sb.ToString();
            StringBuilder sbInfo = new StringBuilder();
            sbInfo.Append("[");
            if (!string.IsNullOrEmpty(selstudent))
            {
                BestSTPlan bstPlan = new BestSTPlan();
                BestField bfield = new BestField() { fieldName = "tutorguid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldType = "System.Guid" };
                bfield.fieldValue = selstudent;
                List<BestField> bparams = new List<BestField>();
                bparams.Add(bfield);
                bparams.Add(Utils.User.CenterIdField);
                bstPlan.LoadRows("tutorguid=? and isdeleted=0 and centerid=?", bparams);
                string stplanInfo = "{guidfield:\"[paramguid]\",tutGuid:\"[paramstuGuid]\",schDay:\"[paramschDay]\",schFrom:\"[paramschFrom]\",schTo:\"[paramschTo]\"}";
                for (int i = 0; i < bstPlan.TableRows.Count; i++)
                {
                    string result = stplanInfo;
                    bstPlan.currentRowId = i;
                    result = result.Replace("[paramguid]", bstPlan.guidfield.ToString());
                    result = result.Replace("[paramstuGuid]", bstPlan.tutorguid.ToString());
                    result = result.Replace("[paramschDay]", bstPlan.schDay);
                    result = result.Replace("[paramschFrom]", bstPlan.schFrom);
                    result = result.Replace("paramschTo]", bstPlan.schTo);
                    sbInfo.Append(result);
                    if (i < bstPlan.TableRows.Count - 1)
                        sbInfo.Append(",");
                }

            }
            sbInfo.Append("]");
            ltrStdScript.Text = @"<script type=""text/javascript"">" + tutorLoginScript + @" g_nameOnScheduler = " + Utils.EnquoteJS(selName) + @";
g_curSTGuid = " + Utils.EnquoteJS(selstudent) + @";
g_IsStudent = false; 
STPlanInfo = " + sbInfo.ToString() + @"
</script>";
        }

    }
}
