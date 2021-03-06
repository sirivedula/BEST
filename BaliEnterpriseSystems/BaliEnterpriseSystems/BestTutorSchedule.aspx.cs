﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.OleDb;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class BestTutorSchedule : System.Web.UI.Page
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
            ltrSubMenu.Text = UtilMenu.TutorMenu("tutorschedule");
            if (!Utils.User.UserRoleByName("Tutor - Schedule").allowView)
            {
                ltrValidateMsg.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);
            BestTutors bstd = new BestTutors();
            bstd.LoadRows("CenterId=?", Utils.User.CIdParam,"firstname");
            string selstudent = Request.Form["selTutor"];
            StringBuilder sb = new StringBuilder();
            string selName = "";
            string emailaddress = "";
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
                    emailaddress = bstd.TableRows[i].Fields["emailId"].fieldValue;
                    sb.Append(" selected ");
                }
                sb.Append(">" + HttpUtility.HtmlEncode(sname) + "</option>");
            }
            ltrTutorOpts.Text = sb.ToString();
            string fromdate = Request.Form["fromdate"] ?? "";
            string todate = Request.Form["todate"] ?? "";
            DateTime today = DateTime.Today;
            int curweek = ((int)today.DayOfWeek) * -1;
            if (string.IsNullOrEmpty(fromdate))
            {
                fromdate = today.AddDays(curweek).ToString("MM/dd/yyyy");
            }
            if (string.IsNullOrEmpty(todate))
            {
                todate = today.AddDays(curweek).AddDays(7).ToString("MM/dd/yyyy");
            }
            ltrLoadScript.Text = "<script type=\"text/javascript\">$(document).ready(function(){$('#fromdate').val('" + fromdate + "'); $('#todate').val('" + todate + @"');
}); </script>";
            if (!string.IsNullOrEmpty(selstudent))
            {
                string tsql = "select Date, [Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday],stud1name,stud2name,stud3name,stud4name,stud5name from VBestSchedules where ";
                tsql += "(tutGuid='" + selstudent + "') and convert(datetime,date) between '" + fromdate + @"' and '" + todate + @"' order by convert(datetime, date), convert(numeric, schfrom)";

                StringBuilder sbSchd = new StringBuilder();
                BestDatabase db = new BestDatabase();
                OleDbCommand myCmd = db.dbCmd;
                myCmd.CommandText = tsql;
                OleDbDataReader tblReader = myCmd.ExecuteReader(CommandBehavior.KeyInfo);
                //Retrieve column schema into a DataTable.
                DataTable schemaTable = tblReader.GetSchemaTable();

                sbSchd.Append("<table cellpadding=\"0\" style=\"padding:1px;font-family:Tahoma;font-size:12px;border:1px solid #999;background-color:#A11117\"><tr>");
                //For each field in the table...
                int fieldCnt = 0;
                foreach (DataRow myField in schemaTable.Rows)
                {
                    fieldCnt++; if (fieldCnt > 8) break;
                    sbSchd.Append("<th style=\"color:#000;background-color:#E9BA15;padding:2px;\">" + myField[0] + "</th>");
                }
                sbSchd.Append("</tr>");

                int cnt = 0;
                while (tblReader.Read())
                {
                    string name = " " + tblReader[8].ToString();
                    name += !string.IsNullOrEmpty(tblReader[9].ToString()) ? ", "+tblReader[9].ToString() : "";
                    name += !string.IsNullOrEmpty(tblReader[10].ToString()) ? ", "+tblReader[10].ToString() : "";
                    name += !string.IsNullOrEmpty(tblReader[11].ToString()) ? ", "+tblReader[11].ToString() : "";
                    name += !string.IsNullOrEmpty(tblReader[12].ToString()) ? ", "+tblReader[12].ToString() : "";
                    string trclass = (cnt % 2 == 0) ? "" : "trordd";
                    sbSchd.Append("<tr style=\"font-family:Tahoma;color:#FFF;font-size:12px;\"><td>" + (tblReader[0].ToString()) + "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[1].ToString()) + (!string.IsNullOrEmpty(tblReader[1].ToString())?name:"") +  "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[2].ToString()) + (!string.IsNullOrEmpty(tblReader[2].ToString())?name:"") +"</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[3].ToString()) + (!string.IsNullOrEmpty(tblReader[3].ToString())?name:"") +"</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[4].ToString()) + (!string.IsNullOrEmpty(tblReader[4].ToString())?name:"") +"</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[5].ToString()) + (!string.IsNullOrEmpty(tblReader[5].ToString())?name:"") +"</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[6].ToString()) + (!string.IsNullOrEmpty(tblReader[6].ToString())?name:"") +"</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[7].ToString()) + (!string.IsNullOrEmpty(tblReader[7].ToString())?name:"") +"</td></tr>");
                    cnt++;
                }
                tblReader.Close();

                sbSchd.Append("</table>");
                ltrTutorSchedule.Text = sbSchd.ToString();
                string sendEClick = Request.Form["sendEMailClick"] ?? "";
                if (!string.IsNullOrEmpty(sendEClick) && sendEClick.Equals("1") && emailaddress.Length > 0)
                {
                    string emailbody = "Dear " + selName + "<br />Following is your Schedule from " + fromdate + " to " + todate + ":<br />" + sbSchd.ToString() + "<br />Thank you<br />Bali Learning";
                    if (Utils.User.emailUtil.Send(emailaddress, "Schedule Info", emailbody, selName))
                    {
                        ltrEMessage.Text = "EMail Sent To: " + Server.HtmlEncode(emailaddress);
                    }
                }
            }
        }
    }
}
