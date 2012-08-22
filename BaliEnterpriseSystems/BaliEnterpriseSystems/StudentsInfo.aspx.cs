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
using System.Text;
using System.Collections.Generic;

namespace BaliEnterpriseSystems
{
    public partial class StudentsPageInfo : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentinfo");
            if (!Utils.User.UserRoleByName("Student - Information").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            BestCenters bcs = new BestCenters();
            bcs.LoadRows();
            StringBuilder sbc = new StringBuilder();
            sbc.Append("<option value=\"\"></option>");
            for (int rnum = 0; rnum < bcs.TableRows.Count; rnum++)
            {
                string cid = bcs.TableRows[rnum].Fields["CenterId"].fieldValue;
                sbc.Append("<option value=\"" + HttpUtility.HtmlEncode(cid) + "\">" + HttpUtility.HtmlEncode(cid) + "</option>");
            }
            this.ltrCenters.Text = sbc.ToString();

            StringBuilder jsbp = new StringBuilder();
            jsbp.Append("jsProg=[");
            StringBuilder sbp = new StringBuilder();
            sbp.Append("<option value=\"\"></option>");
            BestPrograms bps = new BestPrograms();
            bps.LoadRows();
            for (int rnum = 0; rnum < bps.TableRows.Count; rnum++)
            {
                string optext = bps.TableRows[rnum].Fields["programName"].fieldValue + ":" + bps.TableRows[rnum].Fields["programType"].fieldValue + ": Per " + bps.TableRows[rnum].Fields["amountType"].fieldValue;
                string optval = bps.TableRows[rnum].Fields["guidfield"].fieldValue;
                sbp.Append("<option value=\"" + HttpUtility.HtmlEncode(optval) + "\">" + HttpUtility.HtmlEncode(optext) + "</option>");
                jsbp.Append("{\"guid\":\"" + optval + "\",\"amount\":\"" + bps.TableRows[rnum].Fields["amount"].fieldValue + "\",\"amountType\":\"" + bps.TableRows[rnum].Fields["amountType"].fieldValue + "\"}");
                if (rnum < bps.TableRows.Count - 1) jsbp.Append(",");

            }
            jsbp.Append("]");
            this.ltrProgScript.Text = "<script type=\"text/javascript\">" + jsbp.ToString() + "</script>";
            this.ltrPrograms.Text = sbp.ToString();

            this.ltrStateOpts.Text = Utils.StateOptions();          

            if (IsPostBack)
            {
                BestStudents bs = new BestStudents();
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
                    bs.StudentId = Request.Form["g_StudentId"];
                    bs.CenterId = Request.Form["g_CenterId"];
                    bs.firstName = Request.Form["g_firstName"];
                    bs.lastName = Request.Form["g_lastName"];
                    if (string.IsNullOrEmpty(bs.StudentId))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Student Id is Required.");
                        cansave = false;
                    }
                    if (string.IsNullOrEmpty(bs.CenterId))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Center Id is Required.");
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
                        bs.parentName = Request.Form["g_parentName"];
                        if(!string.IsNullOrEmpty(Request.Form["g_programGuid"]))
                            bs.programGuid = new Guid(Request.Form["g_programGuid"]);
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
                        bs.Hours = Request.Form["g_Hours"];
                        bs.hourType = Request.Form["g_hourType"];
                        bs.amountType = Request.Form["g_amountType"];
                        bs.Amount = Request.Form["g_Amount"];
                        string joinDate = Request.Form["g_joinDate"];
                        if (!string.IsNullOrEmpty(joinDate))
                        {
                            bs.joinDate = Convert.ToDateTime(joinDate);
                        }
                        string birthDate = Request.Form["g_birthDate"];
                        if (!string.IsNullOrEmpty(birthDate))
                        {
                            bs.joinDate = Convert.ToDateTime(birthDate);
                        }
                        
                            
                        if (!bs.CurrentRow.Save())
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                    }
                }
            }

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Students Information";
            bsGrid.GridTable = new BestStudents();
            bsGrid.securityPage = "Student - Information";
            ltrGrid.Text = bsGrid.ToHTML();

        }
    }
}
