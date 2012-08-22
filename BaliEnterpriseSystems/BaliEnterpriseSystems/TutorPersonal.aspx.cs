using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;
namespace BaliEnterpriseSystems
{
    public partial class TutorPersonal : System.Web.UI.Page
    {
        BestTutors btu = new BestTutors();
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.TutorMenu("tutorpersonal");
            if (!Utils.User.UserRoleByName("Tutor - Personal").allowView)
            {
                ltrPersonalData.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            string tutorguid = Utils.User.BestUser.tutorGuid.ToString();

            BestField fld = new BestField()
            {
                fieldName = "guidfield",
                paramOledbType = System.Data.OleDb.OleDbType.Guid,
                fieldType = "System.Guid",
                fieldSize = 40
            };
            fld.fieldValue = tutorguid;
            List<BestField> bparam = new List<BestField>();
            bparam.Add(fld);
            btu.LoadRows("guidfield=?", bparam);
            setdata();

        }

        private void setdata()
        {
            ltrtid.Text = btu.TutorId;
            ltradd1.Text = btu.address1;
            ltradd2.Text = btu.address2;
            ltrcell.Text = btu.cellPhone;
            ltrcity.Text = btu.city;
            ltremail.Text = btu.emailId;
            ltrfname.Text = btu.firstName;
            ltrgender.Text = btu.gender;
            ltrhomep.Text = btu.homePhone;

            if(btu.joinDate > DateTime.MinValue)
                ltrjoindate.Text = btu.joinDate.ToString("MM/dd/yyyy");

            ltrlname.Text = btu.lastName;
            ltrmidname.Text = btu.middleName;
            ltrwph.Text = btu.workPhone;
            ltrzip.Text = btu.zip;
            ltrstate.Text = btu.state;
            ltrexper.Text = btu.Expertise;
            ltrgap.Text = btu.GPA;
            ltrgl.Text = btu.gradeLevels;
            ltrlst.Text = btu.learningStyle;
            ltrmajor.Text = btu.Major;
            ltrmatch.Text = btu.Matchup;
            ltros.Text = btu.otherSkill;
            ltrschool.Text = btu.School;
            ltrygard.Text = btu.yearGraduated;
            ltrpst.Text = btu.programStyle;

        }

    }
}
