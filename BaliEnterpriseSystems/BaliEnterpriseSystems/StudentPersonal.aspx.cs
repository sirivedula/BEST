using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class StudentPersonal : System.Web.UI.Page
    {
        BestStudents bstd = new BestStudents();

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentpersonal");
            if (!Utils.User.UserRoleByName("Student - Personal").allowView)
            {
                ltrPersonalData.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            if (Utils.User.BestUser.studentGuid != null)
            {
                BestField fld = new BestField()
                {
                    fieldName = "guidfield",
                    paramOledbType = System.Data.OleDb.OleDbType.Guid,
                    fieldType = "System.Guid",
                    fieldSize = 40
                };
                fld.fieldValue = Utils.User.BestUser.studentGuid.ToString();
                List<BestField> bparam = new List<BestField>();
                bparam.Add(fld);
                bstd.LoadRows("guidfield=?", bparam);
                setdata();
            }
        }

        private void setdata()
        {
            ltradd1.Text = bstd.address1;
            ltradd2.Text = bstd.address2;
            ltramount.Text = bstd.Amount;
            if (bstd.birthDate > DateTime.MinValue)
            ltrbdate.Text = bstd.birthDate.ToShortDateString();
            ltrcell.Text = bstd.cellPhone;
            ltrcid.Text = bstd.CenterId;
            ltrcity.Text = bstd.city;
            ltremail.Text = bstd.emailId;
            ltrfname.Text = bstd.firstName;
            ltrgender.Text = bstd.gender;
            ltrgard.Text = bstd.guardianName;
            ltrhomep.Text = bstd.homePhone;
            ltrhr.Text = bstd.Hours;
            ltrhrtype.Text = bstd.hourType;
            ltrjoindate.Text = bstd.joinDate.ToShortDateString();
            ltrlname.Text = bstd.lastName;
            ltrmidname.Text = bstd.middleName;
            ltrpname.Text = bstd.parentName;
            ltrsid.Text = bstd.StudentId;
            ltrwph.Text = bstd.workPhone;
            ltrzip.Text = bstd.zip;
        }
      

    }
}
