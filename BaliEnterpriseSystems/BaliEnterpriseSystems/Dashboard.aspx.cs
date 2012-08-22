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
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            StringBuilder sbPersonal = new StringBuilder();
            sbPersonal.Append("<table class=\"tblpersonal\"><tr><td>Name</td><td>" + Utils.User.BestUser.firstName + " " + Utils.User.BestUser.lastName + "</td></tr>");
            sbPersonal.Append("<tr><td>Address</td><td>" + Utils.User.BestUser.address1 + " " + Utils.User.BestUser.address2 + "</td></tr>");
            sbPersonal.Append("<tr><td>&nbsp;</td><td>" + Utils.User.BestUser.city + " " + Utils.User.BestUser.state + " " + Utils.User.BestUser.zip + "</td></tr>");
            sbPersonal.Append("</table>");

            ltrPersonal.Text = sbPersonal.ToString();

            /*
            StringBuilder sbLogins = new StringBuilder();
            BestLogins bsLogin = new BestLogins();
            BestField fld = new BestField() { fieldName = "username", fieldType = "System.String", fieldSize = 128, paramOledbType = System.Data.OleDb.OleDbType.VarChar };
            fld.fieldValue = Utils.User.UserName;
            List<BestField> bparam = new List<BestField>();
            bparam.Add(fld);
            bsLogin.LoadRows("username=?", bparam , "logindate desc");
            int maxRows = bsLogin.TableRows.Count > 10 ? 10 : bsLogin.TableRows.Count;
            sbLogins.Append("<table class=\"tbllogins\"><tr><th>User Name</th><th>Login Date</th><th>Source IP</th><th>Login Valid</th><th>Server IP</th><tr>");
            for (int i = 0; i < maxRows; i++)
            {
                string logvalid = bsLogin.TableRows[i].Fields["loginvalid"].fieldValue.Equals("1") ? "True" : "False";
                string trclass = (i % 2 == 0) ? "" : "trordd";
                sbLogins.Append("<tr class=\"" + trclass + "\"><td>" + HttpUtility.HtmlEncode(bsLogin.TableRows[i].Fields["username"].fieldValue) + "</td>");
                sbLogins.Append("<td>" + HttpUtility.HtmlEncode(bsLogin.TableRows[i].Fields["logindate"].fieldValue) + "</td>");
                sbLogins.Append("<td>" + HttpUtility.HtmlEncode(bsLogin.TableRows[i].Fields["sourceip"].fieldValue) + "</td>");
                sbLogins.Append("<td>" + HttpUtility.HtmlEncode(logvalid) + "</td>");
                sbLogins.Append("<td>" + HttpUtility.HtmlEncode(bsLogin.TableRows[i].Fields["serverip"].fieldValue) + "</td></tr>");                      }
            sbLogins.Append("</table>");
            ltrLogins.Text = sbLogins.ToString();
            */

            string tsql;
            bool showSchedules = true;
            if (Utils.User.BestUser.userType.Equals("Student"))
            {
                showSchedules = (Utils.User.BestUser.studentGuid != null);
                tsql = @"select Date, [Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday] from 
            VBestSchedules where (stuGuid1='" + Utils.User.BestUser.studentGuid.ToString() + "' or stuGuid2='" + Utils.User.BestUser.studentGuid.ToString() + "' or stuGuid3='" + Utils.User.BestUser.studentGuid.ToString() + "' or stuGuid4='" + Utils.User.BestUser.studentGuid.ToString() + "' or stuGuid5='" + Utils.User.BestUser.studentGuid.ToString() + @" and convert(datetime,Date) >= cast(floor(cast(getdate() as float)) as datetime)
            order by Date, convert(numeric,schfrom)";
            }
            else
            {
                showSchedules = (Utils.User.BestUser.tutorGuid != null);
                tsql = @"select Date, [Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday] from 
            VBestSchedules where tutGuid='" + Utils.User.BestUser.tutorGuid.ToString() + @"' and convert(datetime,Date) >= cast(floor(cast(getdate() as float)) as datetime) order by convert(numeric,schfrom)";
            }

            StringBuilder sbSchd = new StringBuilder();
            if (showSchedules)
            {
                BestDatabase db = new BestDatabase();
                OleDbCommand myCmd = db.dbCmd;
                myCmd.CommandText = tsql;
                OleDbDataReader tblReader = myCmd.ExecuteReader(CommandBehavior.KeyInfo);
                //Retrieve column schema into a DataTable.
                DataTable schemaTable = tblReader.GetSchemaTable();

                sbSchd.Append("<table class=\"tbllogins\"><tr>");
                //For each field in the table...
                int fieldCnt = 0;
                foreach (DataRow myField in schemaTable.Rows)
                {
                    fieldCnt++; if (fieldCnt > 8) break;
                    sbSchd.Append("<th>" + myField[0] + "</th>");
                }
                sbSchd.Append("</tr>");

                int cnt = 0;
                while (tblReader.Read())
                {
                    string trclass = (cnt % 2 == 0) ? "" : "trordd";
                    sbSchd.Append("<tr class=\"" + trclass + "\"><td>" + (tblReader[0].ToString()) + "</td>");
                    sbSchd.Append("<td>" + ToTimeFormat(tblReader[1].ToString()) + "</td>");
                    sbSchd.Append("<td>" + ToTimeFormat(tblReader[2].ToString()) + "</td>");
                    sbSchd.Append("<td>" + ToTimeFormat(tblReader[3].ToString()) + "</td>");
                    sbSchd.Append("<td>" + ToTimeFormat(tblReader[4].ToString()) + "</td>");
                    sbSchd.Append("<td>" + ToTimeFormat(tblReader[5].ToString()) + "</td>");
                    sbSchd.Append("<td>" + ToTimeFormat(tblReader[6].ToString()) + "</td>");
                    sbSchd.Append("<td>" + ToTimeFormat(tblReader[7].ToString()) + "</td></tr>");
                    cnt++;
                }
                tblReader.Close();

                sbSchd.Append("</table>");
            }
            else
            {
                sbSchd.Append("<table class=\"tblpersonal\"><tr><td>Schedules</td></tr></table>");
            }
            ltrSchedule.Text = sbSchd.ToString();


            ltrMessage.Text = "<table class=\"tblpersonal\"><tr><td><div id=\"divRecMessage\">" + MessagesHTML(false) + "</div></td></tr></table>";

            ltrCommunication.Text = ComminicationHTML();
        }

        private string ToTimeFormat(string num)
        {
            string result = num;
            if (! string.IsNullOrEmpty(num))
            {
                int temp = int.Parse(num);
                if (temp > 1200)
                {
                    temp = temp - 1200;
                }
                result = (temp > 930) ? temp.ToString().Substring(0, 2) + ":" + temp.ToString().Substring(2, 2) : temp.ToString().Substring(0, 1) + ":" + temp.ToString().Substring(1, 2); 
            }
            return result;
        }

        private string MessagesHTML(bool IsSentMsg)
        {
            StringBuilder sbhtml = new StringBuilder();
            BestMessages bstMsgs = new BestMessages();
            if (IsSentMsg)
            {
                bstMsgs.LoadRows("messageFrom=?", "messageFrom", Utils.User.UserName, "messagedate desc");
            }
            else
            {
                bstMsgs.LoadRows("messageTo=?", "messageTo", Utils.User.UserName, "messagedate desc");
            }
            if (bstMsgs.TableRows.Count > 0)
            {
                sbhtml.Append("<table cellspacing=\"0\" cellpadding=\"0\" style=\"width:100%;\"><tr><th>" + (IsSentMsg?"Send Date":"Receive Date") + "</th><th>" + (IsSentMsg?"To":"From") + "</th><th>Message</th></tr>");
                for (int i = 0; i < bstMsgs.TableRows.Count; i++)
                {
                    bstMsgs.currentRowId = i;
                    sbhtml.Append("<td>" + HttpUtility.HtmlEncode(bstMsgs.messageDate.ToString("MM/dd/yyyy")) + "</td><td>");
                    if(IsSentMsg)
                    { sbhtml.Append(HttpUtility.HtmlEncode(bstMsgs.TableRows[i].Fields["messageTo"].displayFormatFunc.Invoke(bstMsgs.TableRows[i]).ToString()));
                    }
                    else
                    {
                        sbhtml.Append( bstMsgs.TableRows[i].Fields["messageFrom"].displayFormatFunc.Invoke(bstMsgs.TableRows[i]).ToString());
                    }
                    sbhtml.Append("</td><td>" + HttpUtility.HtmlEncode(bstMsgs.messageText) + "</td></tr>");
                }
                sbhtml.Append("</table>");
            }
            else
            {
                sbhtml.Append("You have No New Messages");
            }
            return sbhtml.ToString();
        }

        private string ComminicationHTML()
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("<table class=\"tblpersonal\">");
            BestUser buser = new BestUser();
            bool isStudent = (Utils.User.BestUser.userType.Equals("Student"));
            buser.LoadRows((isStudent ? "usertype != 'Student' and (centers='*' or ','+centers+',' like ','+?+',')" : "(centers='*' or ','+centers+',' like ','+?+',')"), "centerid", Utils.User.CenterId, "firstname");
            string optStr = string.Join("", buser.TableRows.Rows.Select( x => "<option value=\"" + HttpUtility.HtmlEncode(x.Fields["username"].fieldValue) + "\">" + HttpUtility.HtmlEncode(x.Fields["firstname"].fieldValue + " " + x.Fields["lastname"].fieldValue) + "</option>").ToArray());
            sb.Append("<tr><td style=\"text-align:right;\">Message To</td><td><select id=\"messageTo\"><option value=\"\"></option>" + optStr + "</select></td></tr>");
            sb.Append("<tr><td style=\"vertical-align:top;text-align:right;\">Message</td><td><textarea rows=\"5\" cols=\"40\" id=\"message\"></textarea></td></tr>");
            sb.Append("<tr><td>&nbsp;</td><td><input type=\"button\" onclick=\"sendMessage()\" value=\"Send\" /></td></tr>");

            sb.Append("<tr><td colspan=\"2\"><div id=\"divMessage\">" + MessagesHTML(true) + "</div></td></tr>");
            sb.Append("</table>");
            return sb.ToString();
        }
    }
}
