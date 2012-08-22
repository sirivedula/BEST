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
    public partial class SchedulesInfo : System.Web.UI.Page
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

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            if (!Utils.User.UserRoleByName("5.Schedules").allowView)
            {
                ltrMsg.Text = "You do not have rights to view.";
                return;
            }
            
            /* Copy Schedule */
            string copySchType = Request.Form["IsCopyDayorWeek"] ?? "";
            if (!string.IsNullOrEmpty(copySchType))
            {
                doCopySchedule(copySchType);
            }

            string selPlan = Request.Form["planRadio"];
            if (string.IsNullOrEmpty(selPlan)) selPlan = "week";
            string thtml = "<input type=\"radio\" id=\"radio1\" name=\"planRadio\" onclick=\"submit();\" value=\"day\"" + ((!string.IsNullOrEmpty(selPlan) && selPlan.Equals("day")) ? " checked=\"checked\"" : "") + " /><label for=\"radio1\">Day</label>";
            thtml += "<input type=\"radio\" id=\"radio2\" name=\"planRadio\" onclick=\"submit();\" value=\"week\"" + ((string.IsNullOrEmpty(selPlan) || selPlan.Equals("week")) ? " checked=\"checked\"" : "") + "/><label for=\"radio2\">Week</label>";
            thtml += "<input type=\"radio\" id=\"radio3\" name=\"planRadio\" onclick=\"submit();\" value=\"month\"" + ((!string.IsNullOrEmpty(selPlan) && selPlan.Equals("month")) ? " checked=\"checked\"" : "") + " /><label for=\"radio3\">Month</label>";
            radioHtml.Text = thtml;

            string selHrs = Request.Form["rdoHours"];
            if (string.IsNullOrEmpty(selHrs)) selHrs = "0";
            string timechangeclick = Request.Form["hdTimeChangeClicked"];
            if (!string.IsNullOrEmpty(timechangeclick) && timechangeclick.Equals("1"))
            {
                selHrs = (selHrs.Equals("1"))?"0":"1";
            }
            ltrTimeHrs.Text = "<input type=\"hidden\" id=\"hdTimeChangeClicked\" name=\"hdTimeChangeClicked\" /><input type=\"radio\" id=\"rdoHrs\" name=\"rdoHours\" onclick=\"timeChangeSubmit();\" value=\"" + selHrs + "\" checked=\"checked\" /><label for=\"rdoHrs\">" + (selHrs.Equals("0")?"00:30":"00:00") + "</label>";

            string show6to2Clicked = Request.Form["hdshow6to2"];
            string show6to2 = Request.Form["radioshow6to2"]??"";
            //if (string.IsNullOrEmpty(show6to2)) show6to2 = "1";
            if (!string.IsNullOrEmpty(show6to2Clicked) && show6to2Clicked.Equals("1"))
            {
                show6to2 = (show6to2.Equals("0")||show6to2.Equals("")) ? "1" : "0";
            }

            ltrshow6To2.Text = "<input type=\"hidden\" id=\"hdshow6to2\" name=\"hdshow6to2\" /><input type=\"radio\" id=\"rdoshow6to2\" name=\"radioshow6to2\" onclick=\"Show6To9Submit('hdshow6to2');\" value=\"" + show6to2 + "\"" + ((show6to2.Equals("1")) ? " checked=\"checked\"" : "") + " /><label for=\"rdoshow6to2\">6AM-2PM</label>";

            string timemodeStr = "BestPlanner.plannerTimeMode = ";
            StringBuilder sbTimeSlice = new StringBuilder();
            sbTimeSlice.AppendLine("<script type=\"text/javascript\">");
            sbTimeSlice.Append("aryTimes = [");

            if(selHrs.Equals("0"))
            {
                if(show6to2.Equals("1"))
                {
                  sbTimeSlice.Append("'630', '730', '830', '930', '1030', '1130', '1230', '1330',");
                }
                sbTimeSlice.Append("'1430', '1530', '1630', '1730', '1830', '1930', '2030', '2130'");
                timemodeStr += "timeModeHours;";
            }
            else
            {                
                if(show6to2.Equals("1"))
                {
                  sbTimeSlice.Append(" '600', '630', '700', '730', '800', '830', '900', '930', '1000', '1030', '1100', '1130', '1200', '1230', '1300', '1330', '1400' ");
                }
                if (show6to2.Equals("1"))
                    sbTimeSlice.Append(",");
                else
                    sbTimeSlice.Append("'1400', ");

                sbTimeSlice.Append("'1430', '1500', '1530', '1600', '1630', '1700', '1730', '1800', '1830', '1900', '1930', '2000', '2030', '2100', '2130', '2200'");
                timemodeStr += "timeModeHalfHours;";
            }
            sbTimeSlice.AppendLine("]; </script>");
            ltrTimeSlices.Text = sbTimeSlice.ToString();

            string plannerdateNav = Request.Form["plannerDateNav"];
            string curPlannerDate = Request.Form["curPlannerDate"];
            string plannerdate;
            DateTime fromDate, toDate;
            // Array days = Enum.GetValues(GetType(DayOfWeek));

            fromDate = DateTime.Today;
            toDate = fromDate;
            if (string.IsNullOrEmpty(plannerdateNav))
                plannerdateNav = "0";

            if (string.IsNullOrEmpty(curPlannerDate))
                curPlannerDate = DateTime.Today.ToString("MM/dd/yyyy");

            int direction;
            int.TryParse(plannerdateNav, out direction);
            DateTime today = Convert.ToDateTime(curPlannerDate);
            if (selPlan.Equals("day"))
            {
                today = today.AddDays(direction);
                fromDate = today;
                toDate = fromDate;
            }
            else if (string.IsNullOrEmpty(selPlan) || selPlan.Equals("week"))
            {
                today = today.AddDays(direction * 7);

                int curweek = ((int)today.DayOfWeek) * -1;
                fromDate = today.AddDays(curweek);
                toDate = fromDate.AddDays(7);
            }
            else if (selPlan.Equals("month"))
            {
                today = today.AddMonths(direction);
            }
            plannerdate = today.ToString("MM/dd/yyyy");

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(plannerData(fromDate, toDate));

            /* Auto Student and Tutors */
            sb.AppendLine(StudentAndTutors());
            
            /* StudentProgs */
            sb.AppendLine(StudentPrograms());

            sb.AppendLine("$(document).ready(function(){");
            sb.AppendLine("BestPlanner.plannerDate = new Date('" + plannerdate  + "');");
            if (string.IsNullOrEmpty(selPlan) || selPlan.Equals("day"))
                sb.AppendLine("BestPlanner.plannerMode = PlannerDay;");
            else if (selPlan.Equals("week"))
                sb.AppendLine("BestPlanner.plannerMode = PlannerWeek;");
            else if (selPlan.Equals("month"))
                sb.AppendLine("BestPlanner.plannerMode = PlannerMonth;");
            //sb.AppendLine("BestPlanner.plannerDisplay = " + (plannerDisplay.Equals("oneby") ? "OneonOneDisplay" : "GroupDisplay") + ";");
            sb.AppendLine(timemodeStr);
            sb.AppendLine("BestPlanner.Show();");
            sb.AppendLine("BestPlanner.extendToSchedule();");
            sb.AppendLine("setTimeout(\"BestPlanner.DrawSchedules(false);\", 200);");
            sb.AppendLine("StudentPrograms.extendToStudProg();");
            sb.AppendLine("Programs.extendToProgram();");
            sb.AppendLine("});");
            sb.AppendLine("</script>");
            ltrScript.Text = sb.ToString();

            WeekCopyHTML(today);
        }

        private string plannerData(DateTime fromDate, DateTime toDate)
        {
            StringBuilder jsSb = new StringBuilder();
            jsSb.AppendLine("<script type=\"text/javascript\">");
            string scheduleSample = "{schGuid:\"[paramSchGuid]\",stuGuid1:\"[paramStuGuid1]\",stuGuid2:\"[paramStuGuid2]\",stuGuid3:\"[paramStuGuid3]\",stuGuid4:\"[paramStuGuid4]\",stuGuid5:\"[paramStuGuid5]\",tutGuid:\"[paramTutGuid]\",schDate:\"[paramSchDate]\",schFrom:\"[paramSchFrom]\",schTo:\"[paramSchTo]\", isDeleted:\"[paramIsDel]\", Index:\"[paramIndex]\", schId:[paramSchId], attend0:\"[paramAttend0]\", attend1:\"[paramAttend1]\", attend2:\"[paramAttend2]\", attend3:\"[paramAttend3]\", attend4:\"[paramAttend4]\", note0:\"[paramNote0]\", note1:\"[paramNote1]\", note2:\"[paramNote2]\", note3:\"[paramNote3]\", note4:\"[paramNote4]\", progGuid1:\"[paramprogGuid1]\", progGuid2:\"[paramprogGuid2]\", progGuid3:\"[paramprogGuid3]\", progGuid4:\"[paramprogGuid4]\", progGuid5:\"[paramprogGuid5]\"}";
            BestSchedules bsch = new BestSchedules();
            List<BestField> paramSch = new List<BestField>();
            paramSch.Add(new BestField { fieldName = "fromDate", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldValue = fromDate.ToString("yyyyMMdd") });
            paramSch.Add(new BestField { fieldName = "toDate", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldValue = toDate.ToString("yyyyMMdd") });
            paramSch.Add(Utils.User.CenterIdField);
            bsch.LoadRows("schdate>=? and schdate<=? and isdeleted=0 and centerid=?", paramSch, "schdate,schfrom");

            /* Schedules into JavaScript */
            jsSb.AppendLine("ScheduleInfo = [");
            int idx = 0;
            string curdate = "";
            for (int i = 0; i < bsch.TableRows.Count; i++)
            {
                bsch.currentRowId = i;
                var datetimeSlice = bsch.schDate + bsch.schFrom;
                if (!curdate.Equals(datetimeSlice))
                {
                    curdate = datetimeSlice;
                    idx = 0;
                }
                else
                {
                    idx++;
                }
                jsSb.Append(ReplaceSchedule(bsch.TableRows[i], scheduleSample, idx, i));
                if (i < bsch.TableRows.Count - 1) jsSb.AppendLine(",");
            }
            jsSb.AppendLine("];");

            return jsSb.ToString();
        }

        private string StudentAndTutors()
        {
            StringBuilder jsSb = new StringBuilder();

            string autoSample = "{value:\"[paramValue]\", label:[paramLabel]}";
            jsSb.AppendLine("autoStudents = [");
            BestStudents bstd = new BestStudents();
            bstd.LoadRows("CenterId=?", Utils.User.CIdParam, "firstname");
            for (int s = 0; s < bstd.TableRows.Count; s++)
            {
                string result = autoSample;
                bstd.currentRowId = s;
                result = result.Replace("[paramValue]", bstd.guidfield.ToString());
                result = result.Replace("[paramLabel]", Utils.EnquoteJS((bstd.firstName ?? "") + " " +
                    (bstd.lastName ?? "")));
                jsSb.Append(result);
                if (s < bstd.TableRows.Count - 1) jsSb.AppendLine(",");
            }
            jsSb.AppendLine("];");

            BestTutors bstut = new BestTutors();
            bstut.LoadRows("CenterId=?", Utils.User.CIdParam,"firstname");
            jsSb.AppendLine("autoTutors = [");
            for (int s = 0; s < bstut.TableRows.Count; s++)
            {
                string result = autoSample;
                bstut.currentRowId = s;
                result = result.Replace("[paramValue]", bstut.guidfield.ToString());
                result = result.Replace("[paramLabel]", Utils.EnquoteJS((bstut.firstName ?? "") + " " + (bstut.lastName ?? "").Substring(0, 1) + "-" + bstut.TutorId));
                jsSb.Append(result);
                if (s < bstut.TableRows.Count - 1) jsSb.AppendLine(",");
            }
            jsSb.AppendLine("];");

            string studentSample = "{\"firstName\":[paramFirst], \"lastName\":[paramLast], \"guid\":\"[paramGuid]\"}";
            jsSb.AppendLine("StudentInfo = [");
            for (int s = 0; s < bstd.TableRows.Count; s++)
            {
                string result = studentSample;
                bstd.currentRowId = s;
                result = result.Replace("[paramGuid]", bstd.guidfield.ToString());
                result = result.Replace("[paramFirst]", Utils.EnquoteJS(bstd.firstName?? ""));
                result = result.Replace("[paramLast]", Utils.EnquoteJS(bstd.lastName?? ""));
                jsSb.Append(result);
                if (s < bstd.TableRows.Count - 1) jsSb.AppendLine(",");
            }

            jsSb.AppendLine("];");
            string tutorSample = "{\"Name\":[paramName], \"Id\":\"[paramId]\",\"guid\":\"[paramGuid]\"}";
            jsSb.AppendLine("TutorInfo = [");
            for (int s = 0; s < bstut.TableRows.Count; s++)
            {
                string result = tutorSample;
                bstut.currentRowId = s;
                result = result.Replace("[paramGuid]", bstut.guidfield.ToString());
                result = result.Replace("[paramName]", Utils.EnquoteJS((bstut.firstName?? "") + " " + (bstut.lastName?? "").Substring(0,1) + "-" + bstut.TutorId));
                result = result.Replace("[paramId]", bstut.TutorId);
                jsSb.Append(result);
                if (s < bstut.TableRows.Count - 1) jsSb.AppendLine(",");
            }
            jsSb.AppendLine("];");

            return jsSb.ToString();
        }

        private string StudentPrograms()
        {
            StringBuilder sbprog = new StringBuilder();
            BestStudentPrograms bstdProg = new BestStudentPrograms();
            bstdProg.LoadRows("CenterId=? and programguid in (select guidfield from bestprograms where amountType not in ('OneTime', 'Year'))", Utils.User.CIdParam, "studentguid");
            sbprog.AppendLine("StudentProgs = [");
            string firstguid = "";
            int sequence = 0;
            for (int i = 0; i < bstdProg.TableRows.Count; i++)
            {
                bstdProg.currentRowId = i;
                if (!firstguid.Equals(bstdProg.studentGuid.ToString()))
                {
                    sequence = 0;
                    firstguid = bstdProg.studentGuid.ToString();
                }
                sequence++;
                sbprog.Append("{guidfield:\"" + bstdProg.guidfield.ToString() + "\",studentguid:\"" + bstdProg.studentGuid.ToString() + "\", progGuid:\"" + bstdProg.programguid.ToString() + "\", Amount:" + bstdProg.Amount.ToString("0.00") + ", Index:" + sequence.ToString() + "}");
                if (i < bstdProg.TableRows.Count - 1) sbprog.Append(",");
            }
            sbprog.AppendLine("]");

            sbprog.AppendLine("jsProg=[");
            BestPrograms bps = new BestPrograms();
            bps.LoadRows();
            for (int rnum = 0; rnum < bps.TableRows.Count; rnum++)
            {
                bps.currentRowId = rnum;
                sbprog.Append("{guid:\"" + bps.guidfield.ToString() + "\",amount:\"" + bps.amount + "\",amountType:\"" + bps.amountType + "\",progName:\"" + bps.programName + "\",progType:\"" + bps.programType + "\"}");
                if (rnum < bps.TableRows.Count - 1) sbprog.Append(",");
            }
            sbprog.Append("]");

            return sbprog.ToString();
        }

        private string ReplaceSchedule(BestRow bs, string sample, int idx, int schId)
        {
            string result = sample;
            result = result.Replace("[paramSchGuid]", bs.Fields["guidfield"].fieldValue);
            result = result.Replace("[paramStuGuid1]", bs.Fields["stuGuid1"].fieldValue??"");
            result = result.Replace("[paramStuGuid2]", bs.Fields["stuGuid2"].fieldValue??"");
            result = result.Replace("[paramStuGuid3]", bs.Fields["stuGuid3"].fieldValue??"");
            result = result.Replace("[paramStuGuid4]", bs.Fields["stuGuid4"].fieldValue??"");
            result = result.Replace("[paramStuGuid5]", bs.Fields["stuGuid5"].fieldValue??"");
            result = result.Replace("[paramTutGuid]", bs.Fields["tutGuid"].fieldValue??"");
            result = result.Replace("[paramSchDate]", bs.Fields["schDate"].fieldValue ?? "");
            result = result.Replace("[paramSchFrom]", bs.Fields["schFrom"].fieldValue ?? "");
            result = result.Replace("[paramSchTo]", bs.Fields["schTo"].fieldValue ?? "");
            result = result.Replace("[paramIndex]", idx.ToString());
            string isdeleted = bs.Fields["isDeleted"].fieldValue??"";
            result = result.Replace("[paramIsDel]", isdeleted);
            result = result.Replace("[paramSchId]", schId.ToString());

            result = result.Replace("[paramAttend0]", bs.Fields["attended1"].fieldValue);
            result = result.Replace("[paramAttend1]", bs.Fields["attended2"].fieldValue);
            result = result.Replace("[paramAttend2]", bs.Fields["attended3"].fieldValue);
            result = result.Replace("[paramAttend3]", bs.Fields["attended4"].fieldValue);
            result = result.Replace("[paramAttend4]", bs.Fields["attended5"].fieldValue);

            result = result.Replace("[paramNote0]", bs.Fields["note1"].fieldValue ?? "");
            result = result.Replace("[paramNote1]", bs.Fields["note2"].fieldValue ?? "");
            result = result.Replace("[paramNote2]", bs.Fields["note3"].fieldValue ?? "");
            result = result.Replace("[paramNote3]", bs.Fields["note4"].fieldValue ?? "");
            result = result.Replace("[paramNote4]", bs.Fields["note5"].fieldValue ?? "");

            result = result.Replace("[paramprogGuid1]", bs.Fields["progGuid1"].fieldValue ?? "");
            result = result.Replace("[paramprogGuid2]", bs.Fields["progGuid2"].fieldValue ?? "");
            result = result.Replace("[paramprogGuid3]", bs.Fields["progGuid3"].fieldValue ?? "");
            result = result.Replace("[paramprogGuid4]", bs.Fields["progGuid4"].fieldValue ?? "");
            result = result.Replace("[paramprogGuid5]", bs.Fields["progGuid5"].fieldValue ?? "");
            
            return result;
        }

        private void WeekCopyHTML(DateTime plannerDate)
        {
            StringBuilder sb = new StringBuilder();
            /*  4 Weeks Back dates & 4 weeks forward dates */
            DateTime sunday = plannerDate.AddDays(((int)plannerDate.DayOfWeek) * -1);
            for (int dayCounter = 0; dayCounter < 4; dayCounter++)
            {
                sb.Append("<option value=\"" + sunday.ToString("MM/dd/yyyy") + "\" " + (dayCounter==0?"selected":"") + ">" + sunday.ToString("MM/dd/yyyy") + " - " + sunday.AddDays(6).ToString("MM/dd/yyyy") + "</option>");
                sunday = sunday.AddDays(-7);
            }
            this.ltrCopyFromWeek.Text = sb.ToString();
            sb.Remove(0, sb.Length);
            sunday = plannerDate.AddDays(((int)plannerDate.DayOfWeek) * -1);
            for (int dayCounter = 1; dayCounter < 5; dayCounter++)
            {
                sunday = sunday.AddDays(7);
                sb.Append("<option value=\"" + sunday.ToString("MM/dd/yyyy") + "\" " + (dayCounter==1?"selected":"")  + ">" + sunday.ToString("MM/dd/yyyy") + " - " + sunday.AddDays(6).ToString("MM/dd/yyyy") + "</option>");
            }
            this.ltrCopyToWeek.Text = sb.ToString();
        }

        private void doCopySchedule(string copyType)
        {
            if (copyType.Equals("Week"))
            {
                string weekFrom = Request.Form["CopyFromWeekDate"] ?? "";
                string weekTo = Request.Form["CopyToWeekDate"] ?? "";
                if (!string.IsNullOrEmpty(weekFrom) && !string.IsNullOrEmpty(weekTo))
                {
                    BestDatabase db = new BestDatabase();
                    OleDbCommand myCmd = db.dbCmd;
                    myCmd.CommandText = "CopySchedules";
                    myCmd.CommandType = CommandType.StoredProcedure;
                    myCmd.Parameters.Add(new OleDbParameter("BeginDate", weekFrom));
                    myCmd.Parameters.Add(new OleDbParameter("ToDate", weekTo));
                    myCmd.Parameters.Add(new OleDbParameter("CopyType", copyType));
                    try
                    {
                        myCmd.ExecuteNonQuery();
                        ltrMsg.Text = Utils.InfoMessage("Schedules Copied From" + weekFrom + " to " + weekTo);
                    }
                    catch (Exception ex)
                    {
                        ltrMsg.Text = Utils.WarningMessage(ex.Message);
                    }
                }

            }
            else if(copyType.Equals("Day"))
            {
                string dayFrom = Request.Form["CopyFromDate"] ?? "";
                string dayTo = Request.Form["CopyToDate"] ?? "";
                if (!string.IsNullOrEmpty(dayFrom) && !string.IsNullOrEmpty(dayTo))
                {
                    BestDatabase db = new BestDatabase();
                    OleDbCommand myCmd = db.dbCmd;
                    myCmd.CommandText = "CopySchedules";
                    myCmd.CommandType = CommandType.StoredProcedure;
                    myCmd.Parameters.Add(new OleDbParameter("BeginDate", dayFrom));
                    myCmd.Parameters.Add(new OleDbParameter("ToDate", dayTo));
                    myCmd.Parameters.Add(new OleDbParameter("CopyType", copyType));
                    try
                    {
                        myCmd.ExecuteNonQuery();
                        ltrMsg.Text = Utils.InfoMessage("Schedules Copied From" + dayFrom + " to " + dayTo);
                    }
                    catch (Exception ex)
                    {
                        ltrMsg.Text = Utils.WarningMessage(ex.Message);
                    }
                }

            }

        }

    }
}
