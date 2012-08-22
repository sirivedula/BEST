using System;
using System.Collections;
using System.Configuration;
using System.Data;
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
    public partial class Best : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            else if ((!Utils.User.BestUser.IsLoggedIn) && Utils.User.BestUser.initialPassword)
            {
                Response.Redirect("InitialPasswordChage.aspx");
            }
            else if (!Utils.User.BestUser.IsLoggedIn)
            {
                Response.Redirect("NotLoggedIn.aspx");
            }

            ltrUserName.Text = Utils.User.BestUser.userName;
            ltrMainMenu.Text = UtilMenu.MainMenu();
            string CenterId = "";
            if (HttpContext.Current.Session["UserCenter"] == null)
            {
                CenterId = Utils.User.BestUser.CurrentCenterId;
                HttpContext.Current.Session["UserCenter"] = CenterId;
            }
            CenterId = HttpContext.Current.Session["UserCenter"].ToString();
            if (string.IsNullOrEmpty(CenterId))
            {
                CenterId = "No Center Assigned";
            }
            ltrChangeCenter.Text = "<a href=\"ChangeCenter.aspx\" style=\"color:#fff;text-decoration:none;\"><img src=\"images/coins.png\" alt=\"center\" style=\"vertical-align:bottom;\"/>&nbsp;" + CenterId + "</a>";
        }
    }
}
