using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class BestStudentPictures : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentpicture");
            if (!Utils.User.UserRoleByName("Student - Pictures").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Student Pictures";
            bsGrid.securityPage = "Student - Pictures";            
            bsGrid.GridTable = new BestStudentPicture();
            bsGrid.allowAdd = false;
            bsGrid.allowEdit = false;
            bsGrid.allowDelete = false;

            bsGrid.extraRowHTML = "<a href=\"UploadPhoto.aspx?cid=[paramCID]&sid=[paramSID]\" target=\"_blank\"><img src=\"images\\user_edit.png\" alt=\"upload\" /></a>";
            ltrGrid.Text = bsGrid.ToHTML();


        }
    }
}
