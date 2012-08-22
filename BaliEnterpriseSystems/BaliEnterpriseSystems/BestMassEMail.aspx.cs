using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using BaliEnterpriseSystems.BestObjects;
using System.Collections.Specialized;
using System.Data.OleDb;
using System.Data;

namespace BaliEnterpriseSystems
{
    public partial class BestMassEMail : System.Web.UI.Page
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
            ltrSubMenu.Text = UtilMenu.UtilityMenu("massemail");
            if (!Utils.User.UserRoleByName("Mass EMail").allowView)
            {
                ltrValidateMsg.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            string selWho = Request.Form["selWho"];
            string emailDesc = Request.Form["emailDesc"];
            string selFilter = Request.Form["selFilter"]??"";
            string filtervalue = Request.Form["filtervalue"];

            if (string.IsNullOrEmpty(selWho)) selWho = "Student";
            selWhoOpts.Text = "<option value=\"Student\" " + (selWho.Equals("Student")?"Selected" : "") + " >Student</option><option value=\"Tutor\" " + (selWho.Equals("Tutor")?"Selected" : "") + " >Tutor</option>";
            ltrFilters.Text = "<option value=\"\" " + (selFilter.Equals("") ? "Selected" : "") + " ></option><option value=\"School\" " + (selFilter.Equals("School") ? "Selected" : "") + " >School</option><option value=\"Grade\" " + (selFilter.Equals("Grade") ? "Selected" : "") + " >Grade</option>";

            FillEMailTemplates();
            ltrGrid.Text = EMailTargetHTML(selWho, selFilter, filtervalue);

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
            ltrLoadScript.Text = "<script type=\"text/javascript\">$(document).ready(function(){ $('#filtervalue').val('" + Utils.EnquoteJS(filtervalue) + @"'); 
$('#fromdate').val('" + fromdate + "'); $('#todate').val('" + todate + @"');
}); </script>";

            string sendClick = Request.Form["sendEMailClicked"]??"";
            if(sendClick.Equals("1"))
            {
                SendEMails();
            }
        }

        private void SendEMails()
        {
            /* Send EMails */
            string strRows = Request.Form["rowcount"];
            int rowCount;
            int.TryParse(strRows, out rowCount);
            List<BestField> bparams = new List<BestField>();
            string paramQs = "";
            for (int i = 0; i < rowCount; i++)
            {
                string chkStr = Request.Form["chk_" + i.ToString()]??"";
                if (chkStr.Equals("on"))
                {
                    BestField bsf = new BestField() { fieldName = "guidfield", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldType = "System.Guid" };
                    bsf.fieldValue = Request.Form["guid" + i.ToString()];
                    bparams.Add(bsf);
                    paramQs += "?,";
                }
            }
            paramQs = (paramQs.Length > 0) ? paramQs.Substring(0, paramQs.Length - 1) : "";
            string selWho = Request.Form["selWho"];
            if (bparams.Count > 0)
            {
                Dictionary<string, BMails> nvc = new Dictionary<string, BMails>();
                string emailBody = getEMailBody();

                if (selWho.Equals("Student"))
                {
                    BestStudents bs = new BestStudents();
                    bs.LoadRows("guidfield in (" + paramQs + ")", bparams);
                    for (int i = 0; i < bs.TableRows.Count; i++)
                    {
                        bs.currentRowId = i;
                        BMails bm = new BMails();
                        bm.emailbody = ReplaceParams(bs, emailBody);
                        bm.emailToName = bs.firstName + " " + bs.lastName;
                        nvc.Add(bs.emailId, bm);
                    }
                }
                else if (selWho.Equals("Tutor"))
                {
                    BestTutors bt = new BestTutors();
                    bt.LoadRows("guidfield in (" + paramQs + ")", bparams);
                    for (int i = 0; i < bt.TableRows.Count; i++)
                    {
                        bt.currentRowId = i;
                        BMails bm = new BMails();
                        bm.emailbody = ReplaceParams(bt, emailBody);
                        bm.emailToName = bt.firstName + " " + bt.lastName;
                        nvc.Add(bt.emailId, bm);
                    }
                }

                string emailSubject = Request.Form["emailSubject"] ?? "";
                string message = "Send EMail To:\n";
                foreach (string key in nvc.Keys)
                {
                    BMails bm = (BMails)nvc[key];
                    if (Utils.User.emailUtil.Send(key, emailSubject, bm.emailbody, bm.emailToName))
                    {
                        message += key + " " + bm.emailToName + "\n";
                    }
                }
                ltrValidateMsg.Text = Utils.InfoMessage(message);
            }
        }

        public class BMails
        {
            public string emailbody { get; set; }
            public string emailToName { get; set; }
        }

        private string getEMailBody()
        {
            string result = "";
            string emailTemp = Request.Form["selEmailTemplate"];
            string emailDesc = Request.Form["emailDesc"];
            if (!string.IsNullOrEmpty(emailTemp))
            {
                BestField bsf = new BestField() { fieldName = "emailtemp", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 };
                bsf.fieldValue = emailTemp;
                List<BestField> bparam = new List<BestField>();
                bparam.Add(bsf);
                BestEMailTemplate bet = new BestEMailTemplate();
                bet.LoadRows("emialTemplateName = ?", bparam);
                if (bet.HasRows)
                {
                    result = bet.TableRows[0].Fields["templateDescription"].fieldValue;
                }
            }
            else if (!string.IsNullOrEmpty(emailDesc))
            {
                result = emailDesc;
            }
            return result;
        }

        private string ReplaceParams(BestTable bsrow, string emailbody)
        {
            string result = emailbody;
            string name = bsrow.CurrentRow.Fields["firstName"].fieldValue + " " + bsrow.CurrentRow.Fields["lastName"].fieldValue;
            //{tutor}
            //{student}
            result = result.Replace("{tutor}", name);
            result = result.Replace("{student}", name);
            string fromdate = Request.Form["fromdate"] ?? "";
            string todate = Request.Form["todate"] ?? "";
            if (!string.IsNullOrEmpty(fromdate))
            {
                //{WeekStartDate}
                result = result.Replace("{WeekStartDate}", fromdate);
            }
            if (!string.IsNullOrEmpty(todate))
            {
                //{WeekEndDate}
                result = result.Replace("{WeekEndDate}", todate);
            }
            //{WeeklySchedule}
            if (emailbody.IndexOf("{WeeklySchedule}") > 0)
            {
                string tsql = "select Date, [Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday], stud1name, stud2name, stud3name, stud4name, stud5name from VBestSchedules where ";
                string guidstr = bsrow.CurrentRow.Fields["guidfield"].fieldValue;
                if (bsrow is BestStudents)
                {
                    tsql += "(stuGuid1='" + guidstr + "' or stuGuid2='" + guidstr + "' or stuGuid3='" + guidstr + "' or stuGuid4='" + guidstr + "' or stuGuid5='" + guidstr + "')";
                }
                else if (bsrow is BestTutors)
                {
                    tsql += " tutGuid='" + guidstr + "'";
                }
                tsql += @" and convert(datetime,date) between '" + fromdate + @"' and '" + todate + @"' order by convert(datetime, date), convert(numeric, schfrom)";

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
                    if (bsrow is BestStudents)
                    {
                        name = "";
                    }
                    else
                    {
                        name = " " + tblReader[8].ToString();
                        name += !string.IsNullOrEmpty(tblReader[9].ToString()) ? ", " + tblReader[9].ToString() : "";
                        name += !string.IsNullOrEmpty(tblReader[10].ToString()) ? ", " + tblReader[10].ToString() : "";
                        name += !string.IsNullOrEmpty(tblReader[11].ToString()) ? ", " + tblReader[11].ToString() : "";
                        name += !string.IsNullOrEmpty(tblReader[12].ToString()) ? ", " + tblReader[12].ToString() : "";
                    }
                    string trclass = (cnt % 2 == 0) ? "" : "trordd";
                    sbSchd.Append("<tr style=\"font-family:Tahoma;color:#FFF;font-size:12px;\"><td>" + (tblReader[0].ToString()) + "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[1].ToString()) + (!string.IsNullOrEmpty(tblReader[1].ToString()) ? name : "") + "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[2].ToString()) + (!string.IsNullOrEmpty(tblReader[2].ToString()) ? name : "") + "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[3].ToString()) + (!string.IsNullOrEmpty(tblReader[3].ToString()) ? name : "") + "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[4].ToString()) + (!string.IsNullOrEmpty(tblReader[4].ToString()) ? name : "") + "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[5].ToString()) + (!string.IsNullOrEmpty(tblReader[5].ToString()) ? name : "") + "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[6].ToString()) + (!string.IsNullOrEmpty(tblReader[6].ToString()) ? name : "") + "</td>");
                    sbSchd.Append("<td>" + Utils.ToTimeFormat(tblReader[7].ToString()) + (!string.IsNullOrEmpty(tblReader[7].ToString()) ? name : "") + "</td></tr>");
                    cnt++;
                }
                tblReader.Close();

                sbSchd.Append("</table>");
                result = result.Replace("{WeeklySchedule}", sbSchd.ToString());
            }
            result = result.Replace("\n\r", "<br />");

            return result;
        }

        private void FillEMailTemplates()
        {
            string emailTemp = Request.Form["selEmailTemplate"]??"";
            StringBuilder opts = new StringBuilder();
            opts.Append("<option value=\"\"></option>");
            BestEMailTemplate bem = new BestEMailTemplate();
            bem.LoadRows();
            for (int row = 0; row < bem.TableRows.Count; row++)
            {
                bem.currentRowId = row;
                opts.Append("<option value=\"" + HttpUtility.HtmlEncode(bem.emialTemplateName) + "\"");
                if (bem.emialTemplateName.Equals(emailTemp))
                {
                    opts.Append(" selected=\"selected\" ");
                }
                opts.Append(">" + HttpUtility.HtmlEncode(bem.emialTemplateName) + "</option>");
            }
            ltrEMailTempOpts.Text = opts.ToString();
        }

        private string EMailTargetHTML(string studTutor, string filter, string filterval)
        {
            StringBuilder result = new StringBuilder();
            result.Append("<table id=\"available\" class=\"bestgrid\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:80%;\"><tr><th><input type=\"checkbox\" id=\"checkAll\" onclick=\"ToggleCheck();\" /></th><th>Id</th><th>First Name</th><th>Last Name</th><th>EMail Address</th></tr>");
            int rowcount = 0;
            if (studTutor.Equals("Student"))
            {
                BestStudents bs = new BestStudents();
                if (!string.IsNullOrEmpty(filter) && !string.IsNullOrEmpty(filterval))
                {
                    BestField bfld = new BestField() { fieldName = "filterparam", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50, fieldType = "System.String" };
                    bfld.fieldValue = filterval;
                    List<BestField> bparam = new List<BestField>();
                    bparam.Add(bfld);
                    bparam.Add(Utils.User.CenterIdField);
                    if (filter.Equals("School"))
                    {
                        bs.LoadRows("school = ? and CenterId=?", bparam,"firstname,lastname");
                    }
                    else if (filter.Equals("Grade"))
                    {
                        bs.LoadRows("grade = ? and CenterId=?", bparam, "firstname,lastname");
                    }
                }
                else
                {
                    bs.LoadRows("CenterId=?",Utils.User.CIdParam,"firstname, lastname");
                }
                rowcount = bs.TableRows.Count;
                for (int row = 0; row < bs.TableRows.Count; row++)
                {
                    bs.currentRowId = row;
                    string trclass = (row % 2 == 0) ? "" : " class=\"gridodd\" ";
                    result.Append("<tr" + trclass + ">");
                    if (!string.IsNullOrEmpty(bs.emailId))
                    {
                        result.Append("<td><input type=\"checkbox\" id=\"chk_" + row.ToString() + "\" name=\"chk_" + row.ToString() + "\" /><input type=\"hidden\" id=\"guid" + row.ToString() + "\" name=\"guid" + row.ToString() + "\" value=\"" + HttpUtility.HtmlEncode(bs.guidfield.ToString()) + "\" /></td>");
                    }
                    else
                    {
                        result.Append("<td>&nbsp;</td>");
                    }
                    result.Append("<td>" + HttpUtility.HtmlEncode(bs.StudentId) + "</td><td>" + HttpUtility.HtmlEncode(bs.firstName) + "</td><td>" + HttpUtility.HtmlEncode(bs.lastName) + "</td><td>" + HttpUtility.HtmlEncode(bs.emailId) + "</td></tr>");
                }
            }
            else if (studTutor.Equals("Tutor"))
            {
                BestTutors bt = new BestTutors();
                bt.LoadRows("CenterId=?", Utils.User.CIdParam, "firstname,lastname");
                rowcount = bt.TableRows.Count;
                for (int row = 0; row < bt.TableRows.Count; row++)
                {
                    bt.currentRowId = row;
                    string trclass = (row % 2 == 0) ? "" : " class=\"gridodd\" ";
                    result.Append("<tr" + trclass + ">");
                    if (!string.IsNullOrEmpty(bt.emailId))
                    {
                        result.Append("<td><input type=\"checkbox\" id=\"chk_" + row.ToString() + "\" name=\"chk_" + row.ToString() + "\" /><input type=\"hidden\" id=\"guid" + row.ToString() + "\" name=\"guid" + row.ToString() + "\" value=\"" + HttpUtility.HtmlEncode(bt.guidfield.ToString()) + "\" /></td>");
                    }
                    else
                    {
                        result.Append("<td>&nbsp;</td>");
                    }
                    result.Append("<td>" + HttpUtility.HtmlEncode(bt.TutorId) + "</td><td>" + HttpUtility.HtmlEncode(bt.firstName) + "</td><td>" + HttpUtility.HtmlEncode(bt.lastName) + "</td><td>" + HttpUtility.HtmlEncode(bt.emailId) + "</td></tr>");
                }
            }
            result.Append("<input type=\"hidden\" id=\"rowcount\" name=\"rowcount\" value=\"" + rowcount.ToString() + "\" />");
            result.Append("</table>");
            return result.ToString();
        }
    }
}
