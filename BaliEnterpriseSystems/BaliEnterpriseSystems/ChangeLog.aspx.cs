using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class ChangeLog : System.Web.UI.Page
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
            ltrSubMenu.Text = UtilMenu.UtilityMenu("changelog");
            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            if (!Utils.User.UserRoleByName("Change Log").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Change Log";
            bsGrid.securityPage = "Change Log";            
            bsGrid.GridTable = new LogChanges();
            bsGrid.allowAdd = false;
            bsGrid.allowDelete = false;
            bsGrid.allowEdit = false;
            ltrGrid.Text = bsGrid.ToHTML();
        }
    }
}
