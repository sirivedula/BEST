using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace BaliEnterpriseSystems
{
    public class UtilMenu
    {
        public static string MainMenu()
        {
            string result = "";
            UserPrefs up = new UserPrefs(Utils.User.UserName);

            result += "<li><a id=\"liMenu1\" href=\"Dashboard.aspx?ms=1\"><b id=\"bleft1\"></b><span>Dashboard</span><b id=\"bright1\"></b></a></li>";
            string progsub = up.getPreference("ProgramSubMenu");
            if (string.IsNullOrEmpty(progsub)) progsub = "ProgramsInfo.aspx";

            if (Utils.User.UserRoleByName("1.Programs").allowView)
                result += "<li><a id=\"liMenu2\" href=\"" + progsub + "?ms=2\"><b id=\"bleft2\"></b><span>Programs</span><b id=\"bright2\"></b></a></li>";

            string studhref = (Utils.User.BestUser.userType.Equals("Student") ? "StudentPersonal.aspx" : "StudentsInfo.aspx");
            string studsub = up.getPreference("StudentSubMenu");
            if (string.IsNullOrEmpty(studsub)) studsub = studhref;

            if (Utils.User.UserRoleByName("2.Students").allowView)
                result += "<li><a id=\"liMenu3\" href=\"" + studsub + "?ms=3\"><b id=\"bleft3\"></b><span>Students</span><b id=\"bright3\"></b></a></li>";
            string tutorhref = (Utils.User.BestUser.userType.Equals("Tutor") ? "TutorPersonal.aspx" : "TutorsInfo.aspx");
            string tutorsub = up.getPreference("TutorSubMenu");
            if (string.IsNullOrEmpty(tutorsub)) tutorsub = tutorhref;

            if (Utils.User.UserRoleByName("3.Tutors").allowView)
                result += "<li><a id=\"liMenu4\" href=\"" + tutorsub + "?ms=4\"><b id=\"bleft4\"></b><span>Tutors</span><b id=\"bright4\"></b></a></li>";

            if (Utils.User.UserRoleByName("5.Schedules").allowView)
                result += "<li><a id=\"liMenu5\" href=\"SchedulesInfo.aspx?ms=5\"><b id=\"bleft5\"></b><span>Schedules</span><b id=\"bright5\"></b></a></li>";

            string paysub = up.getPreference("PaymentSubMenu");
            if (string.IsNullOrEmpty(paysub)) paysub = "BestPaymentTypes.aspx";
            if (Utils.User.UserRoleByName("4.Payments").allowView)
                result += "<li><a id=\"liMenu6\" href=\"" + paysub + "?ms=6\"><b id=\"bleft6\"></b><span>Payments</span><b id=\"bright6\"></b></a></li>";

            string utilsub = up.getPreference("UtilitySubMenu");
            if (string.IsNullOrEmpty(utilsub)) utilsub = "BestMassEMail.aspx";
            if (Utils.User.UserRoleByName("7.Utility").allowView)
                result += "<li><a id=\"liMenu8\" href=\"" + utilsub + "?ms=8\"><b id=\"bleft8\"></b><span>Utilities</span><b id=\"bright8\"></b></a></li>";

            string setupsub = up.getPreference("SetupSubMenu");
            if (string.IsNullOrEmpty(setupsub)) setupsub = "BestServicesInfo.aspx";

            if (Utils.User.UserRoleByName("6.Setup").allowView)
                result += "<li><a id=\"liMenu7\" href=\"" + setupsub + "?ms=7\"><b id=\"bleft7\"></b><span>Setup</span><b id=\"bright7\"></b></a></li>";

            return result;
        }

        public static string SetupSubMenu(string curmenu)
        {
            string result = "";
            UserPrefs up = new UserPrefs(Utils.User.UserName);

            if (Utils.User.UserRoleByName("Setup - Services").allowView)
                if (curmenu.Equals("services"))
                {
                    up.SetPreference("SetupSubMenu", "BestServicesInfo.aspx");
                    result += "<li><a href=\"BestServicesInfo.aspx?ms=7\" class=\"Selected\"><b class=\"LC\"></b><span>Services</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestServicesInfo.aspx?ms=7\"><b class=\"LC\"></b><span>Services</span></a></li>";

            if (Utils.User.UserRoleByName("Setup - Center Information").allowView)
                if (curmenu.Equals("centers"))
                {
                    up.SetPreference("SetupSubMenu", "BestCenterInfo.aspx");
                    result += "<li><a href=\"BestCenterInfo.aspx?ms=7\" class=\"Selected\"><b class=\"LC\"></b><span>Center Information</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestCenterInfo.aspx?ms=7\"><b class=\"LC\"></b><span>Center Information</span></a></li>";

            if (Utils.User.UserRoleByName("Setup - Users").allowView)
                if (curmenu.Equals("userinfo"))
                {
                    up.SetPreference("SetupSubMenu", "UserInfo.aspx");
                    result += "<li><a href=\"UserInfo.aspx?ms=7\" class=\"Selected\"><b class=\"LC\"></b><span>Users</span></a></li>";
                }
                else
                    result += "<li><a href=\"UserInfo.aspx?ms=7\"><b class=\"LC\"></b><span>Users</span></a></li>";

            if (Utils.User.UserRoleByName("Setup - User Roles").allowView)
                if (curmenu.Equals("userroles"))
                {
                    up.SetPreference("SetupSubMenu", "UserRolesInfo.aspx");
                    result += "<li><a href=\"UserRolesInfo.aspx?ms=7\" class=\"Selected\"><b class=\"LC\"></b><span>User Roles</span></a></li>";
                }
                else
                    result += "<li><a href=\"UserRolesInfo.aspx?ms=7\"><b class=\"LC\"></b><span>User Roles</span></a></li>";

            if (Utils.User.UserRoleByName("Setup - EMail Template").allowView)
                if (curmenu.Equals("emailtemplate"))
                {
                    up.SetPreference("SetupSubMenu", "EMailTemplates.aspx");
                    result += "<li><a href=\"EMailTemplates.aspx?ms=7\" class=\"Selected\"><b class=\"LC\"></b><span>EMail Templates</span></a></li>";
                }
                else
                    result += "<li><a href=\"EMailTemplates.aspx?ms=7\"><b class=\"LC\"></b><span>EMail Templates</span></a></li>";

            return result;
        }

        public static string ProgramMenu(string curmenu)
        {
            string result = "";
            UserPrefs up = new UserPrefs(Utils.User.UserName);

            if (Utils.User.UserRoleByName("Program - Types").allowView)
                if (curmenu.Equals("programtypes"))
                {
                    up.SetPreference("ProgramSubMenu", "ProgramsInfo.aspx");
                    result += "<li><a href=\"ProgramsInfo.aspx?ms=2\" class=\"Selected\"><b class=\"LC\"></b><span>Program Types</span></a></li>";
                }
                else
                    result += "<li><a href=\"ProgramsInfo.aspx?ms=2\"><b class=\"LC\"></b><span>Program Types</span></a></li>";

            if (Utils.User.UserRoleByName("Program - Information").allowView)
                if (curmenu.Equals("programinfo"))
                {
                    up.SetPreference("ProgramSubMenu", "ProgramNames.aspx");
                    result += "<li><a href=\"ProgramNames.aspx?ms=2\" class=\"Selected\"><b class=\"LC\"></b><span>Programs Information</span></a></li>";
                }
                else
                    result += "<li><a href=\"ProgramNames.aspx?ms=2\"><b class=\"LC\"></b><span>Programs Information</span></a></li>";

            return result;
        }

        public static string StudentMenu(string curmenu)
        {
            string result = "";
            UserPrefs up = new UserPrefs(Utils.User.UserName);

            if (Utils.User.UserRoleByName("Student - Personal").allowView)
                if (curmenu.Equals("studentpersonal"))
                {
                    up.SetPreference("StudentSubMenu", "StudentPersonal.aspx");
                    result += "<li><a href=\"StudentPersonal.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>Personal Info</span></a></li>";
                }
                else
                    result += "<li><a href=\"StudentPersonal.aspx?ms=3\"><b class=\"LC\"></b><span>Personal Info</span></a></li>";

            if (Utils.User.UserRoleByName("Student - Information").allowView)
                if (curmenu.Equals("studentinfo"))
                {
                    up.SetPreference("StudentSubMenu", "StudentsInfo.aspx");
                    result += "<li><a href=\"StudentsInfo.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>Student Info</span></a></li>";
                }
                else
                    result += "<li><a href=\"StudentsInfo.aspx?ms=3\"><b class=\"LC\"></b><span>Student Info</span></a></li>";

            if (Utils.User.UserRoleByName("Student - Schedule").allowView)
                if (curmenu.Equals("studentschedule"))
                {
                    up.SetPreference("StudentSubMenu", "BestStudentSchedule.aspx");
                    result += "<li><a href=\"BestStudentSchedule.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>Student Schedule</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestStudentSchedule.aspx?ms=3\"><b class=\"LC\"></b><span>Student Schedule</span></a></li>";

            if (Utils.User.UserRoleByName("Student - Notes").allowView)
                if (curmenu.Equals("studentnotes"))
                {
                    up.SetPreference("StudentSubMenu", "StudentNotes.aspx");
                    result += "<li><a href=\"StudentNotes.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>Student Notes</span></a></li>";
                }
                else
                    result += "<li><a href=\"StudentNotes.aspx?ms=3\"><b class=\"LC\"></b><span>Student Notes</span></a></li>";

            if (Utils.User.UserRoleByName("Student - Reports").allowView)
                if (curmenu.Equals("studentreports"))
                {
                    up.SetPreference("StudentSubMenu", "StudentReports.aspx");
                    result += "<li><a href=\"StudentReports.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>Student Reports</span></a></li>";
                }
                else
                    result += "<li><a href=\"StudentReports.aspx?ms=3\"><b class=\"LC\"></b><span>Student Reports</span></a></li>";

            if (Utils.User.UserRoleByName("Student - Pictures").allowView)
                if (curmenu.Equals("studentpicture"))
                {
                    up.SetPreference("StudentSubMenu", "BestStudentPictures.aspx");
                    result += "<li><a href=\"BestStudentPictures.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>Student Pictures</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestStudentPictures.aspx?ms=3\"><b class=\"LC\"></b><span>Student Picture</span></a></li>";

            if (Utils.User.UserRoleByName("Student - Users").allowView)
                if (curmenu.Equals("studentusers"))
                {
                    up.SetPreference("StudentSubMenu", "BestStudentUser.aspx");
                    result += "<li><a href=\"BestStudentUser.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>Student Users</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestStudentUser.aspx?ms=3\"><b class=\"LC\"></b><span>Student Users</span></a></li>";

            string displayname = (Utils.User.BestUser.IsStudent ? "My Planner" : "Student Planner");

            if (Utils.User.UserRoleByName("Student - Planner").allowView)
                if (curmenu.Equals("studentplanner"))
                {
                    up.SetPreference("StudentSubMenu", "BestStudentPlan.aspx");
                    result += "<li><a href=\"BestStudentPlan.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>" + displayname + "</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestStudentPlan.aspx?ms=3\"><b class=\"LC\"></b><span>" + displayname + "</span></a></li>";

            displayname = (Utils.User.BestUser.IsStudent ? "My Documents" : "Student Documents");
            if (Utils.User.UserRoleByName("Student - Documents").allowView)
                if (curmenu.Equals("studentdocument"))
                {
                    up.SetPreference("StudentSubMenu", "StudentDocuments.aspx");
                    result += "<li><a href=\"StudentDocuments.aspx?ms=3\" class=\"Selected\"><b class=\"LC\"></b><span>" + displayname + "</span></a></li>";
                }
                else
                    result += "<li><a href=\"StudentDocuments.aspx?ms=3\"><b class=\"LC\"></b><span>" + displayname + "</span></a></li>";

            if (Utils.User.UserRoleByName("Payment - Details").allowView)
                result += "<li><a href=\"PaymentsInfo.aspx?ms=6\"><b class=\"LC\"></b><span>Payment Details</span></a></li>";

            return result;
        }

        public static string TutorMenu(string curmenu)
        {
            string result = "";
            UserPrefs up = new UserPrefs(Utils.User.UserName);

            if (Utils.User.UserRoleByName("Tutor - Personal").allowView)
                if (curmenu.Equals("tutorpersonal"))
                {
                    up.SetPreference("TutorSubMenu", "TutorPersonal.aspx");
                    result += "<li><a href=\"TutorPersonal.aspx?ms=4\" class=\"Selected\"><b class=\"LC\"></b><span>Personal Info</span></a></li>";
                }
                else
                    result += "<li><a href=\"TutorPersonal.aspx?ms=4\"><b class=\"LC\"></b><span>Personal Info</span></a></li>";

            if (Utils.User.UserRoleByName("Tutor - Information").allowView)
                if (curmenu.Equals("tutorinfo"))
                {
                    up.SetPreference("TutorSubMenu", "TutorsInfo.aspx");
                    result += "<li><a href=\"TutorsInfo.aspx?ms=4\" class=\"Selected\"><b class=\"LC\"></b><span>Tutors Info</span></a></li>";
                }
                else
                    result += "<li><a href=\"TutorsInfo.aspx?ms=4\"><b class=\"LC\"></b><span>Tutors Info</span></a></li>";

            if (Utils.User.UserRoleByName("Tutor - Schedule").allowView)
                if (curmenu.Equals("tutorschedule"))
                {
                    up.SetPreference("TutorSubMenu", "BestTutorSchedule.aspx");
                    result += "<li><a href=\"BestTutorSchedule.aspx?ms=4\" class=\"Selected\"><b class=\"LC\"></b><span>Tutor Schedule</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestTutorSchedule.aspx?ms=4\"><b class=\"LC\"></b><span>Tutor Schedule</span></a></li>";

            if (Utils.User.UserRoleByName("Tutor - Reports").allowView)
                if (curmenu.Equals("tutorreports"))
                {
                    up.SetPreference("TutorSubMenu", "TutorReports.aspx");
                    result += "<li><a href=\"TutorReports.aspx?ms=4\" class=\"Selected\"><b class=\"LC\"></b><span>Tutor Reports</span></a></li>";
                }
                else
                    result += "<li><a href=\"TutorReports.aspx?ms=4\"><b class=\"LC\"></b><span>Tutor Reports</span></a></li>";

            if (Utils.User.UserRoleByName("Tutor - Users").allowView)
                if (curmenu.Equals("tutorusers"))
                {
                    up.SetPreference("TutorSubMenu", "TutorUsers.aspx");
                    result += "<li><a href=\"TutorUsers.aspx?ms=4\" class=\"Selected\"><b class=\"LC\"></b><span>Tutor Users</span></a></li>";
                }
                else
                    result += "<li><a href=\"TutorUsers.aspx?ms=4\"><b class=\"LC\"></b><span>Tutor Users</span></a></li>";

            string displayname = (Utils.User.BestUser.userType.Equals("Tutor") ? "My Planner" : "Tutor Planner");
            if (Utils.User.UserRoleByName("Tutor - Planner").allowView)
                if (curmenu.Equals("tutorplanner"))
                {
                    up.SetPreference("TutorSubMenu", "BestTutorPlan.aspx");
                    result += "<li><a href=\"BestTutorPlan.aspx?ms=4\" class=\"Selected\"><b class=\"LC\"></b><span>" + displayname + "</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestTutorPlan.aspx?ms=4\"><b class=\"LC\"></b><span>" + displayname + "</span></a></li>";

            if (Utils.User.UserRoleByName("Tutor - Notes").allowView)
                if (curmenu.Equals("tutortnotes"))
                {
                    up.SetPreference("TutorSubMenu", "TutorNotes.aspx");
                    result += "<li><a href=\"TutorNotes.aspx?ms=4\" class=\"Selected\"><b class=\"LC\"></b><span>Tutor Notes</span></a></li>";
                }
                else
                    result += "<li><a href=\"TutorNotes.aspx?ms=4s\"><b class=\"LC\"></b><span>Tutor Notes</span></a></li>";

            return result;
        }

        public static string PaymentMenu(string curmenu)
        {
            string result = "";
            UserPrefs up = new UserPrefs(Utils.User.UserName);

            if (Utils.User.UserRoleByName("Payment - Types").allowView)
                if (curmenu.Equals("paymenttypes"))
                {
                    up.SetPreference("PaymentSubMenu", "BestPaymentTypes.aspx");
                    result += "<li><a href=\"BestPaymentTypes.aspx?ms=6\" class=\"Selected\"><b class=\"LC\"></b><span>Payment Types</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestPaymentTypes.aspx?ms=6\"><b class=\"LC\"></b><span>Payment Types</span></a></li>";

            if (Utils.User.UserRoleByName("Payment - Details").allowView)
                if (curmenu.Equals("paymentdetails"))
                {
                    up.SetPreference("PaymentSubMenu", "PaymentsInfo.aspx");
                    result += "<li><a href=\"PaymentsInfo.aspx?ms=6\" class=\"Selected\"><b class=\"LC\"></b><span>Payment Details</span></a></li>";
                }
                else
                    result += "<li><a href=\"PaymentsInfo.aspx?ms=6\"><b class=\"LC\"></b><span>Payment Details</span></a></li>";

            if (Utils.User.UserRoleByName("Payment - Reports").allowView)
                if (curmenu.Equals("paymentreports"))
                {
                    up.SetPreference("PaymentSubMenu", "PaymentReports.aspx");
                    result += "<li><a href=\"PaymentReports.aspx?ms=6\" class=\"Selected\"><b class=\"LC\"></b><span>Payment Reports</span></a></li>";
                }
                else
                    result += "<li><a href=\"PaymentReports.aspx?ms=6\"><b class=\"LC\"></b><span>Payment Reports</span></a></li>";

            return result;
        }

        public static string UtilityMenu(string curmenu)
        {
            string result = "";
            UserPrefs up = new UserPrefs(Utils.User.UserName);

            if (Utils.User.UserRoleByName("Mass EMail").allowView)
                if (curmenu.Equals("massemail"))
                {
                    up.SetPreference("UtilitySubMenu", "BestMassEMail.aspx");
                    result += "<li><a href=\"BestMassEMail.aspx?ms=8\" class=\"Selected\"><b class=\"LC\"></b><span>Mass EMail</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestMassEMail.aspx?ms=8\"><b class=\"LC\"></b><span>Mass EMail</span></a></li>";

            if(Utils.User.UserRoleByName("Export To Excel").allowView)
                if (curmenu.Equals("exportexcel"))
                {
                    up.SetPreference("UtilitySubMenu", "BestExportToExcel.aspx");
                    result += "<li><a href=\"BestExportToExcel.aspx?ms=8\" class=\"Selected\"><b class=\"LC\"></b><span>Export To Excel</span></a></li>";
                }
                else
                    result += "<li><a href=\"BestExportToExcel.aspx?ms=8\"><b class=\"LC\"></b><span>Export To Excel</span></a></li>";

            if (Utils.User.UserRoleByName("Change Log").allowView)
                if (curmenu.Equals("changelog"))
                {
                    up.SetPreference("UtilitySubMenu", "ChangeLog.aspx");
                    result += "<li><a href=\"ChangeLog.aspx?ms=8\" class=\"Selected\"><b class=\"LC\"></b><span>Change Log</span></a></li>";
                }
                else
                    result += "<li><a href=\"ChangeLog.aspx?ms=8\"><b class=\"LC\"></b><span>Change Log</span></a></li>";
            return result;
        }

    }
}
