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
using System.Data.OleDb;

namespace BaliEnterpriseSystems
{
    public partial class StudentReports : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentreports");
            if (!Utils.User.UserRoleByName("Student - Reports").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }            

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);
            StringBuilder rowshtml = new StringBuilder();
            string fromdate = Request.Form["fromdate"];
            if (string.IsNullOrEmpty(fromdate)) fromdate = DateTime.Today.ToString("MM/dd/yyyy");
            string todate = Request.Form["todate"];
            if (string.IsNullOrEmpty(todate)) todate = DateTime.Today.AddMonths(1).AddDays(-1).ToString("MM/dd/yyyy");
            string summaryby = Request.Form["summaryby"];
            if (string.IsNullOrEmpty(summaryby)) summaryby = "";
            bool chkStudentName = (Request.Form["chkStudentName"] ?? "").Equals("on");
            bool chkParentName = (Request.Form["chkParentName"] ?? "").Equals("on");
            bool chkAddress = (Request.Form["chkAddress"]??"").Equals("on");
            bool chkTutorName = (Request.Form["chkTutorName"]??"").Equals("on");
            bool chkTotalHours = (Request.Form["chkTotalHours"]??"").Equals("on");
            bool chkTotalAmountPaid = (Request.Form["chkTotalAmountPaid"]??"").Equals("on");
            bool chkTotalAmountCharged = (Request.Form["chkTotalAmountCharged"]??"").Equals("on");
            bool chkAmountDue = (Request.Form["chkAmountDue"]??"").Equals("on");
            bool chkPayDate = (Request.Form["chkPayDate"]??"").Equals("on");
            bool chkProgramDesc = (Request.Form["chkProgramDesc"]??"").Equals("on");
            bool chkNotes = (Request.Form["chkNotes"] ?? "").Equals("on");

            if (!IsPostBack)
            {
                chkStudentName = true;
                chkTotalHours = true;
                chkTotalAmountPaid = true;
                chkTotalAmountCharged = true;
                chkAmountDue = true;
                chkPayDate = true;
            }

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

                    BestField GuidField = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = OleDbType.Guid, displayField = false };
                    string StudentGuid = Request.Form["StudentGuid"] ?? "";
                    GuidField.fieldValue = StudentGuid;

                    string tsql = "select  schdate,   studentid,   BestStudents.firstName + ' ' + BestStudents.lastName as StudentName,   BestStudents.ParentName, BestStudents.address1 + ' ' + BestStudents.address2 as address,   BestStudents.city + ' ' + BestStudents.state + ' ' + BestStudents.zip as csz,   BestStudents.homephone as homephone, BestStudents.workphone as workphone, BestStudents.emailid,   case when trantype='Scheduled' then isnull(vbest.amount,0) else 0 end as tobecharged,   case when trantype!='Scheduled' then vbest.amount else 0 end as paid,   vbest.hours,   case trantype when 'Scheduled' then   case vbest.attendance when 0 then 'Attended' when 1 then 'Informed' when 2 then 'Absent' end   else 'Payment' end transType,   bprog.programName + ':' + bprog.programType programName,   BestTutors.firstName + ' ' + BestTutors.lastName as TutorName,   vbest.note from VBestSchedulesAndPayments vbest   inner join BestStudents on beststudents.guidfield = vbest.studentguid   left join BestPrograms bprog on bprog.guidfield = vbest.programguid   left join BestTutors on BestTutors.guidfield = vbest.tutGuid where schdate >= ? and schdate <= ? and BestStudents.CenterId=? " ;
                    if (!string.IsNullOrEmpty(StudentGuid))
                    {
                        tsql = tsql + " and BestStudents.guidfield=? ";
                    }
                    tsql += " order by StudentName, schDate";

                    BestDatabase db = new BestDatabase();
                    OleDbCommand myCmd = db.dbCmd;
                    myCmd.CommandText = tsql;
                    myCmd.Parameters.Add(bffromdate.Param);
                    myCmd.Parameters.Add(bftodate.Param);
                    myCmd.Parameters.Add(Utils.User.CenterIdField.Param);
                    if (!string.IsNullOrEmpty(StudentGuid))
                    {
                        myCmd.Parameters.Add(GuidField.Param);
                    }
                    OleDbDataReader tblReader = myCmd.ExecuteReader();
                    double total = 0;
                    double chargedTotal = 0;
                    double totalHours = 0;
                    int colSpan = 0;
                    rowshtml.Append("<br /><div id=\"studentReport\"><table class=\"tblreports\" cellspacing=\"0\" cellpadding=\"0\">");
                    rowshtml.Append("<thead><tr><td colspan=\"9\" style=\"font-weight:bold;font-size:12px;\">" + Utils.User.CenterId + " Students Report</td></thead>");
                    rowshtml.Append("<tr>");
                    if (chkPayDate)
                    {
                        rowshtml.Append("<th>Date</th>");
                        colSpan++;
                    }
                    rowshtml.Append("<th>Student Id</th>");
                    colSpan++;
                    if (chkStudentName)
                    {
                        rowshtml.Append("<th>Student Name</th>");
                        colSpan++;
                    }
                    if (chkParentName)
                    {
                        rowshtml.Append("<th>Parent Name</th>");
                        colSpan++;
                    }
                    if (chkAddress)
                    {
                        rowshtml.Append("<th>Contact Info</th>");
                        rowshtml.Append("<th>Home Phone</th>");
                        rowshtml.Append("<th>Work Phone</th>");
                        rowshtml.Append("<th>E-Mail Id</th>");
                        colSpan += 4;
                    }
                    if (chkProgramDesc)
                    {
                        rowshtml.Append("<th>Program Name</th>");
                        colSpan++;
                    }
                    if (chkTutorName)
                    {
                        rowshtml.Append("<th>Tutor Name</th>");
                        colSpan++;
                    }
                    if (chkNotes)
                    {
                        rowshtml.Append("<th>Notes</th>");
                        colSpan++;
                    }
                    rowshtml.Append("<th>Trans Type</th>");
                    colSpan++;

                    rowshtml.Append("<th>Charged Amount</th>");
                    rowshtml.Append("<th>Amount Paid</th>");
                    rowshtml.Append("<th>Hours</th>");
                    rowshtml.Append("<th>Balance</th>");

                    rowshtml.Append("</tr>");
                    string studentid = "";
                    int Cnt = 0;
                    string studName = "";
                    double grandTotal = 0;
                    while (tblReader.Read())
                    {
                        string stuid = tblReader[1].ToString();
                        if (!studentid.Equals(stuid) && (Cnt > 0))
                        {
                            /* Totals for the Student */
                            rowshtml.Append("<tr><td style=\"text-align:right;background-color:#fff;font-weight:bold;\" colspan=\"" + colSpan.ToString() + "\">" + studName + " Total&nbsp;</td>");
                            if (chkTotalAmountCharged)
                            {
                                rowshtml.Append("<td class=\"ra\" style=\"background-color:#fff;padding-right:3px;\">" + chargedTotal.ToString("$0.00") + "</td>");
                            }
                            else
                            {
                                rowshtml.Append("<td>&nbsp;</td>");
                            }
                            if (chkTotalAmountPaid)
                            {
                                rowshtml.Append("<td class=\"ra\" style=\"background-color:#fff;padding-right:3px;\">" + total.ToString("$0.00") + "</td>");
                            }
                            else
                            {
                                rowshtml.Append("<td>&nbsp;</td>");
                            }
                            if (chkTotalHours)
                            {
                                rowshtml.Append("<td class=\"ra\" style=\"background-color:#fff;padding-right:3px;\">" + totalHours.ToString("0") + "</td>");
                            }
                            else
                            {
                                rowshtml.Append("<td>&nbsp;</td>");
                            }
                            if (chkAmountDue)
                            {
                                rowshtml.Append("<td class=\"ra\" style=\"white-space:nowrap;background-color:#fff;padding-right:3px;\">" + (total - chargedTotal).ToString("$0.00") + "</td>");
                            }
                            else
                            {
                                rowshtml.Append("<td>&nbsp;</td>");
                            }
                            rowshtml.Append("</tr>");
                            chargedTotal = 0;
                            total = 0;
                            totalHours = 0;
                        }
                        studentid = stuid;
                        Cnt++;
                        string paydate = tblReader[0].ToString();
                        paydate = paydate.Substring(4, 2) + "/" + paydate.Substring(6, 2) + "/" + paydate.Substring(0, 4);
                        studName = tblReader[2].ToString();
                        string parentName = tblReader[3].ToString();
                        string address = tblReader[4].ToString() + " " + tblReader[5].ToString();
                        string homephone = tblReader[6].ToString();
                        string workphone = tblReader[7].ToString();
                        string emailid = tblReader[8].ToString();
                        string tranType = tblReader[12].ToString();

                        Double chargedAmt = 0;
                        Double.TryParse(tblReader[9].ToString(), out chargedAmt);
                        if (tranType.Equals("Informed"))
                        {
                            chargedAmt = 0;
                        }
                        Double payAmt = 0;
                        Double.TryParse(tblReader[10].ToString(), out payAmt);
                        Double hours = 0;
                        Double.TryParse(tblReader[11].ToString(), out hours);
                        totalHours += hours;
                        string progName = tblReader[13].ToString();
                        string tutorName = tblReader[14].ToString();
                        string notes = tblReader[15].ToString();
                        total += payAmt;
                        chargedTotal += chargedAmt;
                        grandTotal += chargedAmt;
                        string strPayAmt = (payAmt > 0) ? payAmt.ToString("$0.00") : "&nbsp;";
                        string strChargedAmt = (chargedAmt > 0) ? chargedAmt.ToString("$0.00") : "&nbsp;";

                        rowshtml.Append("<tr>");
                        if (chkPayDate)
                        {
                            rowshtml.Append("<td>" + paydate + "</td>");
                        }
                        rowshtml.Append("<td>" + HttpUtility.HtmlEncode(stuid) + "</td>");
                        if (chkStudentName)
                        {
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(studName) + "</td>");
                        }
                        if (chkParentName)
                        {
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(parentName) + "</td>");
                        }
                        if (chkAddress)
                        {
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(address) + "</td>");
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(homephone) + "</td>");
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(workphone) + "</td>");
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(emailid) + "</td>");
                        }
                        if (chkProgramDesc)
                        {
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(progName) + "</td>");
                        }
                        if (chkTutorName)
                        {
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(tutorName) + "</td>");
                        }
                        if (chkNotes)
                        {
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(notes) + "</td>");
                        }
                        rowshtml.Append("<td>" + HttpUtility.HtmlEncode(tranType) + "</td>");
                        rowshtml.Append("<td class=\"ra\" style=\"padding-right:3px;\">" + strChargedAmt + "</td>");
                        rowshtml.Append("<td class=\"ra\" style=\"padding-right:3px;\">" + strPayAmt + "</td>");
                        rowshtml.Append("<td class=\"ra\">" + HttpUtility.HtmlEncode(hours.ToString("0")) + "</td></tr>");
                    }

                    rowshtml.Append("<tr><td style=\"text-align:right;background-color:#fff;font-weight:bold;\" colspan=\"" + colSpan.ToString() + "\">" + studName + " Total&nbsp;</td>");
                    if (chkTotalAmountCharged)
                    {
                        rowshtml.Append("<td class=\"ra\" style=\"background-color:#fff;padding-right:3px;\">" + chargedTotal.ToString("$0.00") + "</td>");
                    }
                    else
                    {
                        rowshtml.Append("<td>&nbsp;</td>");
                    }
                    if (chkTotalAmountPaid)
                    {
                        rowshtml.Append("<td class=\"ra\" style=\"background-color:#fff;padding-right:3px;\">" + total.ToString("$0.00") + "</td>");
                    }
                    else
                    {
                        rowshtml.Append("<td>&nbsp;</td>");
                    }
                    if (chkTotalHours)
                    {
                        rowshtml.Append("<td class=\"ra\" style=\"background-color:#fff;padding-right:3px;\">" + totalHours.ToString("0") + "</td>");
                    }
                    else
                    {
                        rowshtml.Append("<td>&nbsp;</td>");
                    }
                    if (chkAmountDue)
                    {
                        rowshtml.Append("<td class=\"ra\" style=\"white-space:nowrap;background-color:#fff;padding-right:3px;\">" + (total - chargedTotal).ToString("0.00") + "</td>");
                    }
                    else
                    {
                        rowshtml.Append("<td>&nbsp;</td>");
                    }
                    rowshtml.Append("</tr>");
                    rowshtml.Append("<tr><td style=\"font-weight:bold;\">Grand Total</td><td>" + Server.HtmlEncode(fromdate + " to " + todate) + "</td><td colspan=\"3\" style=\"text-align:right;font-weight:bold;\">" + grandTotal.ToString("$0.00") + "</td></tr>");
                    rowshtml.Append("</table></div><br />");
                    rowshtml.Append("<div><input type=\"button\" value=\"Print\" onclick=\"PrintTable('studentReport');\" /></div>");
                }
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<div class=\"centered\">");
            sb.Append("<table class=\"bestgrid\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">");
            sb.Append("<tr><td style=\"text-align:center;\" colspan=\"4\">Student Reports</td></tr>");
            sb.Append("<tr><td>From Date <input type=\"text\" id=\"fromdate\" name=\"fromdate\" size=\"9\" maxlength=\"10\" value=\"" + Server.HtmlEncode(fromdate) + "\" /></td><td>To Date <input type=\"text\" id=\"todate\" name=\"todate\" size=\"9\" maxlength=\"10\" value=\"" + Server.HtmlEncode(todate) + "\" /></td>");
            sb.Append("<td>Summary By <select id=\"summaryby\" name=\"summaryby\"><option value=\"\"></option>");
            sb.Append("<option value=\"paydate\" " + (summaryby.Equals("paydate") ? " selected " : "") + ">Payment Date</option>");
            sb.Append("<option value=\"payweek\" " + (summaryby.Equals("payweek") ? " selected " : "") + ">Week</option>");
            sb.Append("<option value=\"paymonth\" " + (summaryby.Equals("paymonth") ? " selected " : "") + ">Month</option>");
            sb.Append("<option value=\"payyear\" " + (summaryby.Equals("payyear") ? " selected " : "") + ">Year</option>");
            sb.Append("</select></td></tr>");

            sb.Append("<tr><td><input type=\"checkbox\" id=\"chkStudentName\" name=\"chkStudentName\" " + (chkStudentName ? "checked=\"checked\"" : "") + " /><label for=\"chkStudentName\">Student Name</lable></td><td><input type=\"checkbox\" id=\"chkParentName\" name=\"chkParentName\" " + (chkParentName ? "checked=\"checked\"" : "") + " /><label for=\"chkParentName\">Parent Name</label></td><td><input type=\"checkbox\" id=\"chkAddress\" name=\"chkAddress\" " + (chkAddress ? "checked=\"checked\"" : "") + " /><label for=\"chkAddress\">Contact Info</label></td></tr>");
            sb.Append("<tr><td><input type=\"checkbox\" name=\"chkTutorName\" id=\"chkTutorName\" " + (chkTutorName ? "checked=\"checked\"" : "") + " /><label for=\"chkTutorName\">Tutor name</label></td><td><input type=\"checkbox\" id=\"chkTotalHours\" name=\"chkTotalHours\" " + (chkTotalHours ? "checked=\"checked\"" : "") + " /><lable for=\"chkTotalHours\">Total Hours</label></td><td><input type=\"checkbox\" id=\"chkTotalAmountPaid\" name=\"chkTotalAmountPaid\" " + (chkTotalAmountPaid ? "checked=\"checked\"" : "") + " /><label for=\"chkTotalAmountPaid\">Total Amount Paid</lable></td></tr>");
            sb.Append("<tr><td><input type=\"checkbox\" id=\"chkTotalAmountCharged\" name=\"chkTotalAmountCharged\" " + (chkTotalAmountCharged ? "checked=\"checked\"" : "") + " /><label for=\"chkTotalAmountCharged\">Total Amount Charged</label></td><td><input type=\"checkbox\" id=\"chkAmountDue\" name=\"chkAmountDue\" " + (chkAmountDue ? "checked=\"checked\"" : "") + " /><label for=\"chkAmountDue\">Amount Due</label></td><td><input type=\"checkbox\" id=\"chkPayDate\" name=\"chkPayDate\" " + (chkPayDate ? "checked=\"checked\"" : "") + " /><label for=\"chkPayDate\">Payment Date</label></td></tr>");
            sb.Append("<tr><td><input type=\"checkbox\" id=\"chkProgramDesc\" name=\"chkProgramDesc\" " + (chkProgramDesc ? "checked=\"checked\"" : "") + " /><label for=\"chkProgramDesc\">Program Description</label></td><td><input type=\"checkbox\" id=\"chkNotes\" name=\"chkNotes\" " + (chkNotes ? "checked=\"checked\"" : "") + " /><label for=\"chkNotes\">Additional notes</label></td>");
            sb.Append("<td>Student <select id=\"StudentGuid\" name=\"StudentGuid\">" + StudentOptions() + "</select></td></tr>");

            sb.Append("<tr><td colspan=\"3\" style=\"text-align:center;\" ><input type=\"button\" value=\"Submit\" onclick=\"submit();\" /></td></tr>");
            sb.Append("</table>");
            ltrGrid.Text = sb.ToString() + rowshtml.ToString() + "</div>";

        }

        private string StudentOptions()
        {
            StringBuilder sb = new StringBuilder();
            string stuguid = Request.Form["StudentGuid"] ?? "";
            sb.Append("<option value=\"\"></option>");
            BestStudents bs = new BestStudents();
            bs.LoadRows("CenterId=?", "centerid", Utils.User.CenterId, "firstname");
            sb.Append(string.Join("", bs.TableRows.Rows.Select(x => "<option value=\"" + Server.HtmlEncode(x.Fields["guidfield"].fieldValue) + "\" " + (stuguid.Equals(x.Fields["guidfield"].fieldValue)?"selected":"") + " >" + Server.HtmlEncode(x.Fields["firstname"].fieldValue + " " + x.Fields["lastname"].fieldValue) + "</option>").ToArray()));

            return sb.ToString();
        }
    }
}
