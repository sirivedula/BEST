using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class changeCenter : System.Web.UI.Page
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
            var cUser = Utils.User;

            BestCenters bcenters = new BestCenters();
            bcenters.LoadRows();
            string CenterId = HttpContext.Current.Session["UserCenter"].ToString();

            ltrCenters.Text = string.Join("", bcenters.TableRows.Rows.Select(
                x => (cUser.BestUser.IsAllowedCenter(x.Fields["CenterId"].fieldValue) ?  "<option value=\"" + HttpUtility.HtmlEncode(x.Fields["CenterId"].fieldValue) + "\" " + (x.Fields["CenterId"].fieldValue.Equals(CenterId) ? "selected" :"")  + " >" + HttpUtility.HtmlEncode(x.Fields["CenterId"].fieldValue) + "</option>" : "")
                ).ToArray());

            if (IsPostBack)
            {
                string centerid = Request.Form["centerid"];
                if (! string.IsNullOrEmpty(centerid))
                {
                    HttpContext.Current.Session["UserCenter"] = centerid;
                    UserPrefs up = new UserPrefs(Utils.User.UserName);
                    up.SetPreference("LastCenter", centerid);
                    Response.Redirect("Dashboard.aspx");
                }
            }
        }        
    }
}
