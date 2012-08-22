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
using System.Collections.Generic;
using System.Data.OleDb;

namespace BaliEnterpriseSystems
{
    public partial class PaymentReports : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.PaymentMenu("paymentreports");
            if (!Utils.User.UserRoleByName("Payment - Reports").allowView)
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
            string incstd = Request.Form["incstudent"];
            if (string.IsNullOrEmpty(summaryby)) summaryby = "";
            if (string.IsNullOrEmpty(incstd)) incstd = "";

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
                    BestField bffromdate = new BestField() { fieldName = "fromdate", fieldSize = 40, fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp, displayField = false };
                    bffromdate.fieldValue = fromdate;

                    BestField bftodate = new BestField() { fieldName = "todate", fieldSize = 40, fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp, displayField = false };
                    bftodate.fieldValue = todate;
                                       
                    string tsql = "select paymentDate, bpd.amount, (firstname + ' ' + lastname) from BestPaymentDetails bpd inner join BestStudents bstd on bstd.guidfield = bpd.studentGuid where paymentdate >= ? and paymentdate <= ? AND BSTD.CENTERID=?";
                    if (!string.IsNullOrEmpty(summaryby))
                    {
                        tsql = "select [paramGroupBy], sum(bpd.amount) as payAmount [paramStudents] from BestPaymentDetails bpd inner join BestStudents bstd on bstd.guidfield = bpd.studentGuid where paymentdate >= ? and paymentdate <= ? AND BSTD.CENTERID=? group by [paramGroupBy] [paramStudents]";
                        if (summaryby.Equals("paymonth"))
                        {
                            tsql = tsql.Replace("[paramGroupBy]", "datename(MONTH, paymentDate)");
                        }
                        else if (summaryby.Equals("payweek"))
                        {
                        }
                        else if (summaryby.Equals("payyear"))
                        {
                            tsql = tsql.Replace("[paramGroupBy]", "year(paymentdate)");
                        }
                        else
                        {
                            tsql = tsql.Replace("[paramGroupBy]", "paymentdate");
                        }
                        if (incstd.Equals("on"))
                        {
                            tsql = tsql.Replace("[paramStudents]", ",(firstname + ' ' + lastname)");
                        }
                        else
                        {
                            tsql = tsql.Replace("[paramStudents]", "");
                        }
                    }
                    BestDatabase db = new BestDatabase();
                    OleDbCommand myCmd = db.dbCmd;
                    myCmd.CommandText = tsql;
                    myCmd.Parameters.Add(bffromdate.Param);
                    myCmd.Parameters.Add(bftodate.Param);
                    myCmd.Parameters.Add(Utils.User.CenterIdField.Param);

                    OleDbDataReader tblReader = myCmd.ExecuteReader();
                    double total = 0;
                    rowshtml.Append("<br /><div id=\"paymentReport\"><table class=\"tblreports\" cellspacing=\"0\" cellpadding=\"0\">");
                    rowshtml.Append("<thead><tr><td colspan=\"9\" style=\"font-weight:bold;font-size:12px;\">" + Utils.User.CenterId + " Payments Report</td></thead>");
                    rowshtml.Append("<tr><th style=\"text-align:center;\">Payment By</th>");
                    if (incstd.Equals("on"))
                    {
                        rowshtml.Append("<th style=\"text-align:center;\">Student Name</th>");
                    }
                    rowshtml.Append("<th style=\"text-align:center;\">Amount</th></tr>");
                    while (tblReader.Read())
                    {
                        string paydate = tblReader[0].ToString();
                        double payAmt = Convert.ToDouble(tblReader[1].ToString());
                        total += payAmt;
                        rowshtml.Append("<tr><td>" + paydate.Replace("12:00:00 AM","") + "</td>");
                        if (incstd.Equals("on"))
                        {
                            rowshtml.Append("<td>" + HttpUtility.HtmlEncode(tblReader[2].ToString()) + "</td>");
                        }
                        rowshtml.Append("<td class=\"ra\" style=\"padding-right:3px;\">" + payAmt.ToString("0.00") + "</td></tr>");
                    }
                    rowshtml.Append("<tr><th>Total</th>");
                    if (incstd.Equals("on")) rowshtml.Append("<th>&nbsp;</th>");
                    rowshtml.Append("<th class=\"ra\" style=\"padding-right:3px;\">" + total.ToString("0.00") + "</th></tr>");
                    rowshtml.Append("</table></div><br />");
                    rowshtml.Append("<div><input type=\"button\" value=\"Print\" onclick=\"PrintTable('paymentReport');\" /></div>");

                }
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<div class=\"centered\">");
            sb.Append("<table class=\"bestgrid\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">");
            sb.Append("<tr><td style=\"text-align:center;\" colspan=\"4\">Payment Reports</td></tr>");
            sb.Append("<tr><td>From Date <input type=\"text\" id=\"fromdate\" name=\"fromdate\" size=\"9\" maxlength=\"10\" value=\"" + fromdate + "\" /></td><td>To Date <input type=\"text\" id=\"todate\" name=\"todate\" size=\"9\" maxlength=\"10\" value=\"" + todate + "\" /></td></tr>");
            sb.Append("<tr><td>Summary By <select id=\"summaryby\" name=\"summaryby\"><option value=\"\"></option>");
            sb.Append("<option value=\"paydate\" " + (summaryby.Equals("paydate") ? " selected " : "") + ">Payment Date</option>"); 
            sb.Append("<option value=\"payweek\" " + (summaryby.Equals("payweek") ? " selected " : "") + ">Week</option>");
            sb.Append("<option value=\"paymonth\" " + (summaryby.Equals("paymonth") ? " selected " : "") + ">Month</option>");
            sb.Append("<option value=\"payyear\" " + (summaryby.Equals("payyear") ? " selected " : "") + ">Year</option>");
            sb.Append("</select></td>");
            sb.Append("<td><input type=\"checkbox\" id=\"incstudent\" name=\"incstudent\" " + (incstd.Equals("on") ? " checked " : "") + " /><label for=\"incstudent\">Include Student</label></td></tr>");
            sb.Append("<tr><td colspan=\"2\"><input type=\"button\" value=\"Report\" onclick=\"submit();\" /></td></tr>");
            sb.Append("</table>");
            ltrGrid.Text = sb.ToString() + rowshtml.ToString() + "</div>";

        }

    }
}
