using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BaliEnterpriseSystems
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            if (Request.Form.Count > 0)
            {
                string newPassword = Request.Form["newpassword"];
                var cUser = Utils.User;
 
                cUser.BestUser.password = Utils.GetMD5Hash(newPassword);
                cUser.BestUser.initialPassword = false;
                cUser.BestUser.passwordExpiration = DateTime.Today.AddDays(365);
                cUser.BestUser.overrideEdit = true;

                if (!cUser.BestUser.CurrentRow.Save())
                {
                    this.ChangePasswordMessage.Text = "<div class=\"err\">There was a problem changing your password.  Please try again.</div>";
                }
                else
                {
                    Response.Redirect("BestWelcome.aspx");
                }
            }
        }
    }
}
