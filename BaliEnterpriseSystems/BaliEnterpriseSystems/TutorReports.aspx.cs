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
using System.Text;
using BaliEnterpriseSystems.BestObjects;
using System.Data.OleDb;

namespace BaliEnterpriseSystems
{
    public partial class TutorReports : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.TutorMenu("tutorreports");
            if (!Utils.User.UserRoleByName("Tutor - Reports").allowView)
            {
                ltrValidateMsg.Text = "You do not have rights to view.";
                return;
            }            

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            string fromdate = Request.Form["fromdate"];
            if (string.IsNullOrEmpty(fromdate)) fromdate = DateTime.Today.ToString("MM/dd/yyyy");
            string todate = Request.Form["todate"];
            if (string.IsNullOrEmpty(todate)) todate = DateTime.Today.AddMonths(1).AddDays(-1).ToString("MM/dd/yyyy");

            StringBuilder rowshtml = new StringBuilder();
            if (IsPostBack)
            {
                bool canReport = true;
                if (!string.IsNullOrEmpty(fromdate))
                {
                    try
                    {
                        DateTime fromdt = Convert.ToDateTime(fromdate);
                    }
                    catch (Exception ex)
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage(ex.Message);
                        canReport = false;
                    }
                }
                else
                {
                    ltrValidateMsg.Text = Utils.WarningMessage("From Date is Required.");
                    canReport = false;
                }

                if (!string.IsNullOrEmpty(todate))
                {
                    try
                    {
                        DateTime todt = Convert.ToDateTime(todate);
                    }
                    catch (Exception ex)
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage(ex.Message);
                        canReport = false;
                    }
                }
                else
                {
                    ltrValidateMsg.Text = Utils.WarningMessage("To Date is Required.");
                    canReport = false;
                }

                if (canReport)
                {
                    BestField bffromdate = new BestField() { fieldName = "fromdate", fieldSize = 40, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, displayField = false };
                    bffromdate.fieldValue = fromdate.Substring(6, 4) + fromdate.Substring(0, 2) + fromdate.Substring(3, 2);

                    BestField bftodate = new BestField() { fieldName = "todate", fieldSize = 40, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, displayField = false };
                    bftodate.fieldValue = todate.Substring(6, 4) + todate.Substring(0, 2) + todate.Substring(3, 2);

                    BestField GuidField = new BestField(){ fieldName="guidfield", fieldSize=40, fieldType="System.Guid", paramOledbType= OleDbType.Guid, displayField=false};
                    string tutorGuid = Request.Form["TutorGuid"]??"";
                    GuidField.fieldValue = tutorGuid;

                    string tsql = @"Select schdate, tutorid, BestTutors.firstName + ' ' + BestTutors.lastName as tutorName,
(select BestStudents.firstName + ' ' + SubString(BestStudents.lastName,1,1) From BestStudents where BestStudents.guidField = BestSchedules.stuguid1) as name1,
(select BestStudents.firstName + ' ' + SubString(BestStudents.lastName,1,1) From BestStudents where BestStudents.guidField = BestSchedules.stuguid2) as name2,
(select BestStudents.firstName + ' ' + SubString(BestStudents.lastName,1,1) From BestStudents where BestStudents.guidField = BestSchedules.stuguid3) as name3,
(select BestStudents.firstName + ' ' + SubString(BestStudents.lastName,1,1) From BestStudents where BestStudents.guidField = BestSchedules.stuguid4) as name4,
(select BestStudents.firstName + ' ' + SubString(BestStudents.lastName,1,1) From BestStudents where BestStudents.guidField = BestSchedules.stuguid5) as name5,
case BestSchedules.tutorattend when 0 then 1 when 1 then 1 when 2 then 0 end as tutorattend,
BestTutors.perHour, BestTutors.salary 
From BestSchedules 
Inner Join BestTutors on BestTutors.guidfield = BestSchedules.tutGuid
where BestSchedules.schdate >= ? and BestSchedules.schdate <= ? and BestTutors.CenterId = ?";
                    if(! string.IsNullOrEmpty(tutorGuid))
                    {
                        tsql += " and BestTutors.guidfield = ? ";
                    }
                    tsql += " order by tutorname, schdate";

                    BestDatabase db = new BestDatabase();
                    OleDbCommand myCmd = db.dbCmd;
                    myCmd.CommandText = tsql;
                    myCmd.Parameters.Add(bffromdate.Param);
                    myCmd.Parameters.Add(bftodate.Param);
                    myCmd.Parameters.Add(Utils.User.CenterIdField.Param);
                    if (!string.IsNullOrEmpty(tutorGuid))
                    {
                        myCmd.Parameters.Add(GuidField.Param);
                    }
                    OleDbDataReader tblReader = myCmd.ExecuteReader();
                    int Cnt = 0;
                    string tutorName = "";
                    string tutorid = "";
                    rowshtml.Append("<br /><div id=\"tutorReport\"><table class=\"tblreports\" cellspacing=\"0\" cellpadding=\"0\">");
                    rowshtml.Append("<thead><tr><td colspan=\"9\" style=\"font-weight:bold;font-size:12px;\">" + Utils.User.CenterId + " Tutors Report</td></thead>");

                    rowshtml.Append("<tr>");
                    rowshtml.Append("<th>Date</th>");
                    rowshtml.Append("<th>Tutor Id</th>");
                    rowshtml.Append("<th>Tutor Name</th>");
                    rowshtml.Append("<th>Students</th>");
                    rowshtml.Append("<th>Hours</th>");
                    rowshtml.Append("<th>Per Hour</th>");
                    rowshtml.Append("<th>Amount</th>");
                    rowshtml.Append("<th>Salary</th>");
                    rowshtml.Append("</tr>");
                    Decimal totalHrs = 0;
                    Decimal totalAmount = 0;
                    bool showSalary = true;
                    Decimal grandTotal = 0;
                    Decimal salaryTotal = 0;
                    while (tblReader.Read())
                    {
                        string tutid = tblReader[1].ToString();
                        if (!tutorid.Equals(tutid) && (Cnt > 0))
                        {
                            rowshtml.Append("<tr><td  style=\"text-align:right;background-color:#fff;font-weight:bold;\" colspan=\"4\">" + tutorName + " Totals</td><td  style=\"text-align:right;background-color:#fff;font-weight:bold;\" >" + totalHrs.ToString("0") + "</td>");
                            rowshtml.Append("<td  style=\"text-align:right;background-color:#fff;font-weight:bold;\" >" + totalAmount.ToString("$0.00") + "</td><td style=\"text-align:right;background-color:#fff;font-weight:bold;\" colspan=\"2\">&nbsp;</td></tr>");
                            totalHrs = 0;
                            totalAmount = 0;
                            showSalary = true;
                        }
                        tutorid = tutid;
                        Cnt++;
                        string schdate = tblReader[0].ToString();
                        schdate = schdate.Substring(4, 2) + "/" + schdate.Substring(6, 2) + "/" + schdate.Substring(0, 4);

                        tutorName = tblReader[2].ToString();
                        string name1 = tblReader[3].ToString();
                        string name2 = tblReader[4].ToString();
                        string name3 = tblReader[5].ToString();
                        string name4 = tblReader[6].ToString();
                        string name5 = tblReader[7].ToString();
                        string studentNames = name1;
                        if(!string.IsNullOrEmpty(name2)) studentNames += ", " + name2 ;
                        if(!string.IsNullOrEmpty(name3)) studentNames += ", " + name3 ;
                        if(!string.IsNullOrEmpty(name4)) studentNames += ", " + name4 ;
                        if(!string.IsNullOrEmpty(name5)) studentNames += ", " + name5 ;

                        string tutAttend = tblReader[8].ToString();
                        string perhour = tblReader[9].ToString();
                        string salary = tblReader[10].ToString();
                        Decimal perHour;
                        Decimal.TryParse(perhour, out perHour);
                        Decimal Salary;
                        Decimal.TryParse(salary, out Salary);
                        Decimal attendHour;
                        Decimal.TryParse(tutAttend, out attendHour);
                        totalHrs += attendHour;
                        totalAmount += (perHour * attendHour);
                        grandTotal += (perHour * attendHour);

                        rowshtml.Append("<tr><td>" + schdate + "</td>");
                        rowshtml.Append("<td>" + tutorid + "</td>");
                        rowshtml.Append("<td>" + tutorName + "</td>");
                        rowshtml.Append("<td>" + studentNames + "</td>");
                        rowshtml.Append("<td style=\"text-align:right;\">" + attendHour.ToString("0") + "</td>");
                        rowshtml.Append("<td style=\"text-align:right;\">" + perHour.ToString("$0.00") + "</td>");
                        rowshtml.Append("<td style=\"text-align:right;\">" + (attendHour * perHour).ToString("$0.00") + "</td>");
                        if (showSalary)
                        {
                            salaryTotal += Salary;
                            rowshtml.Append("<td style=\"text-align:right;\">" + ((Salary > 0) ? Salary.ToString("$0.00") : "") + "</td>");
                        }
                        else
                        {
                            rowshtml.Append("<td>&nbsp;</td>");
                        }
                        showSalary = false;
                    }
                    rowshtml.Append("<tr><td  style=\"text-align:right;background-color:#fff;font-weight:bold;\" colspan=\"4\">" + tutorName + " Totals</td><td style=\"text-align:right;background-color:#fff;font-weight:bold;\" >" + totalHrs.ToString("0") + "</td>");
                    rowshtml.Append("<td style=\"text-align:right;background-color:#fff;font-weight:bold;\" >" + totalAmount.ToString("$0.00") + "</td><td style=\"text-align:right;background-color:#fff;font-weight:bold;\" colspan=\"2\">&nbsp;</td></tr>");

                    rowshtml.Append("<tr><td style=\"font-weight:bold;\">Grand Total</td><td>" + Server.HtmlEncode(fromdate + " to " + todate) + "</td><td colspan=\"5\" style=\"text-align:right;font-weight:bold;\">" + grandTotal.ToString("$0.00") + "</td><td style=\"text-align:right;font-weight:bold;\">" + salaryTotal.ToString("$0.00") + "</td></tr>");
                    rowshtml.Append("</table></div><br />");
                    rowshtml.Append("<div><input type=\"button\" value=\"Print\" onclick=\"PrintTable('tutorReport');\" /></div>");

                }
            }
        
            StringBuilder sb = new StringBuilder(); 
            sb.Append("<div class=\"centered\">");
            sb.Append("<table class=\"bestgrid\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">");
            sb.Append("<tr><td style=\"text-align:center;\" colspan=\"2\">Tutor Reports</td></tr>");
            sb.Append("<tr><td>From Date <input type=\"text\" id=\"fromdate\" name=\"fromdate\" size=\"9\" maxlength=\"10\" value=\"" + fromdate + "\" /></td><td>To Date <input type=\"text\" id=\"todate\" name=\"todate\" size=\"9\" maxlength=\"10\" value=\"" + todate + "\" /></td></tr>");
            sb.Append("<tr><td colspan=\"2\">Tutor <select id=\"TutorGuid\" name=\"TutorGuid\">" + TutorOptions() + "</select></td></tr>");
            sb.Append("<tr><td colspan=\"2\" style=\"text-align:center;\" ><input type=\"button\" value=\"Submit\" onclick=\"submit();\" /></td></tr>");
            sb.Append("</table>");

            ltrGrid.Text = sb.ToString() + rowshtml.ToString() + "</div>";

        }

        private string TutorOptions()
        {
            StringBuilder sb = new StringBuilder();
            string tutorguid = Request.Form["TutorGuid"] ?? "";
            sb.Append("<option value=\"\"></option>");
            BestTutors bs = new BestTutors();
            bs.LoadRows("CenterId=?", "centerid", Utils.User.CenterId, "firstname");
            sb.Append(string.Join("", bs.TableRows.Rows.Select(x => "<option value=\"" + Server.HtmlEncode(x.Fields["guidfield"].fieldValue) + "\" " + (tutorguid.Equals(x.Fields["guidfield"].fieldValue) ? "selected" : "") + " >" + Server.HtmlEncode(x.Fields["firstname"].fieldValue + " " + x.Fields["lastname"].fieldValue) + "</option>").ToArray()));

            return sb.ToString();
        }

    }
}
