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
    public partial class BestStudentPlan : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentplanner");
            if (!Utils.User.UserRoleByName("Student - Planner").allowView)
            {
                ltrValidateMsg.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);
            BestStudents bstd = new BestStudents();
            string studentLoginScript = "";
            if (Utils.User.BestUser.userType.Equals("Student"))
            {
                List<BestField> bparam = new List<BestField>();
                bparam.Add(new BestField() { fieldName = "studentGuid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
                bparam[0].fieldValue = Utils.User.BestUser.studentGuid.ToString();
                bstd.LoadRows("guidfield=?", bparam);
                studentLoginScript = "$('#tblStudentSel').css('display','none');";
            }
            else
            {
                bstd.LoadRows("CenterId=?", Utils.User.CIdParam);
            }
            string selstudent = Request.Form["selStudent"];
            StringBuilder sb = new StringBuilder();
            sb.Append("");
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
            ltrStudentOpts.Text = sb.ToString();
            StringBuilder sbInfo = new StringBuilder();
            sbInfo.Append("[");
            if (!string.IsNullOrEmpty(selstudent))
            {
                BestSTPlan bstPlan = new BestSTPlan();
                BestField bfield = new BestField() { fieldName = "studentguid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldType = "System.Guid" };
                bfield.fieldValue = selstudent;
                List<BestField> bparams = new List<BestField>();
                bparams.Add(bfield);
                bparams.Add(Utils.User.CenterIdField);
                bstPlan.LoadRows("studentguid=? and isdeleted=0 and centerid=?", bparams);
                string stplanInfo = "{guidfield:\"[paramguid]\",stuGuid:\"[paramstuGuid]\",schDay:\"[paramschDay]\",schFrom:\"[paramschFrom]\",schTo:\"[paramschTo]\"}";
                for (int i = 0; i < bstPlan.TableRows.Count; i++)
                {
                    string result = stplanInfo;
                    bstPlan.currentRowId = i;
                    result = result.Replace("[paramguid]", bstPlan.guidfield.ToString());
                    result = result.Replace("[paramstuGuid]", bstPlan.studentGuid.ToString());
                    result = result.Replace("[paramschDay]", bstPlan.schDay);
                    result = result.Replace("[paramschFrom]", bstPlan.schFrom);
                    result = result.Replace("paramschTo]", bstPlan.schTo);
                    sbInfo.Append(result);
                    if (i < bstPlan.TableRows.Count - 1)
                        sbInfo.Append(",");
                }

            }
            sbInfo.Append("]");

            ltrStdScript.Text = @"<script type=""text/javascript""> " + studentLoginScript + @"
g_nameOnScheduler = " + Utils.EnquoteJS(selName) + @";
g_curSTGuid = " + Utils.EnquoteJS(selstudent) + @";
g_IsStudent = true; 
STPlanInfo = " + sbInfo.ToString() + @"
</script>";
        }
    }
}
