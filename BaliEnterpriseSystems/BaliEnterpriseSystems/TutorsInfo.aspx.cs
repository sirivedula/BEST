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
using System.Data.OleDb;
using System.Text;

namespace BaliEnterpriseSystems
{
    public partial class TutorsPageInfo : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.TutorMenu("tutorinfo");

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            if (!Utils.User.UserRoleByName("Tutor - Information").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }
            this.ltrStateOpts.Text = Utils.StateOptions();
            BestCenters bcs = new BestCenters();
            bcs.LoadRows();
            for (int rnum = 0; rnum < bcs.TableRows.Count; rnum++)
            {
                string cid = bcs.TableRows[rnum].Fields["CenterId"].fieldValue;
                if (cid.Equals(Utils.User.CenterId))
                {
                    this.CenterId.Items.Add(cid);
                }
            }

            string saveClicked = Request.Form["SaveClicked"] ?? "";
            if (IsPostBack && saveClicked.Equals("1"))
            {
                BestTutors bs = new BestTutors();
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
                    bs.TutorId = Request.Form["g_TutorId"];
                    bs.firstName = Request.Form["g_firstName"];
                    bs.lastName = Request.Form["g_lastName"];
                    bs.CenterId = this.CenterId.Value;

                    if (string.IsNullOrEmpty(bs.TutorId))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Tutor Id is Required.");
                        cansave = false;
                    }
                    if (string.IsNullOrEmpty(bs.firstName) && string.IsNullOrEmpty(bs.lastName))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("First Name or Last Name is required");
                        cansave = false;
                    }

                    if (cansave)
                    {
                        bs.middleName = Request.Form["g_middleName"];
                        bs.address1 = Request.Form["g_address1"];
                        bs.address2 = Request.Form["g_address2"];
                        bs.city = Request.Form["g_city"];
                        bs.state = Request.Form["g_state"];
                        bs.zip = Request.Form["g_zip"];
                        bs.cellPhone = Request.Form["g_cellPhone"];
                        bs.workPhone = Request.Form["g_workPhone"];
                        bs.homePhone = Request.Form["g_homePhone"];
                        bs.emailId = Request.Form["g_emailId"];
                        bs.gender = Request.Form["g_gender"];
                        bs.School = Request.Form["g_school"];
                        bs.yearGraduated = Request.Form["g_yearGraduated"];
                        bs.GPA = Request.Form["g_GPA"];
                        bs.Major = Request.Form["g_Major"];
                        bs.Expertise = Request.Form["g_Expertise"];
                        bs.learningStyle = Request.Form["g_learningStyle"];
                        bs.Matchup = Request.Form["g_Matchup"];
                        bs.gradeLevels = Request.Form["g_gradeLevels"];
                        bs.otherSkill = Request.Form["g_otherSkill"];
                        bs.programStyle = Request.Form["g_programStyle"];
                        string salary = Request.Form["g_salary"];
                        string perhour = Request.Form["g_perhour"];
                        if (!string.IsNullOrEmpty(salary))
                        {
                            bs.Salary = Convert.ToDecimal(salary);
                        }
                        if (!string.IsNullOrEmpty(perhour))
                        {
                            bs.PerHour = Convert.ToDecimal(perhour);
                        }
                        if (!string.IsNullOrEmpty(Request.Form["g_joinDate"]))
                        {
                            bs.joinDate = Convert.ToDateTime(Request.Form["g_joinDate"]);
                        }

                        if (!bs.CurrentRow.Save())
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                    }
                }
            }

            BestDatabase db = new BestDatabase();
            OleDbCommand myCmd = db.dbCmd;
            myCmd.CommandText = "Best_GetNextTutorId";            
            OleDbParameter p1 = new OleDbParameter("@makehigherthan", OleDbType.VarChar, 10);
            p1.Value = "T0";
            myCmd.Parameters.Add(p1);
            myCmd.CommandType = System.Data.CommandType.StoredProcedure;
            OleDbDataReader read = myCmd.ExecuteReader();
            string tutorid = "";
            if (read.Read())
            {
                tutorid = read.GetValue(0).ToString();
            }
            ltrLoadScript.Text = "<script type=\"text/javascript\">\n newtutorid='" + tutorid + "'\n</script>\n";

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Tutuor Information";
            bsGrid.GridTable = new BestTutors();
            bsGrid.securityPage = "Tutor - Information";
            ltrGrid.Text = bsGrid.ToHTML();
        }
    }
}
