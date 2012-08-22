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
using BaliEnterpriseSystems.BestObjects;
using System.Collections.Generic;

namespace BaliEnterpriseSystems
{
    public partial class BestCenterPageInfo : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.SetupSubMenu("centers");
            if (!Utils.User.UserRoleByName("Setup - Center Information").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            ltrState.Text = Utils.StateOptions();

            string saveClicked = Request.Form["SaveClicked"] ?? "";
            if (IsPostBack && saveClicked.Equals("1"))
            {
                BestCenters bs = new BestCenters();
                string isnew = Request.Form["isnew"];
                bool cansave = true;
                if (string.IsNullOrEmpty(isnew))
                {
                    List<BestField> bparams = new List<BestField>();
                    BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                    guid.fieldValue = Request.Form["guidfield"];
                    bparams.Add(guid);

                    if (!string.IsNullOrEmpty(guid.fieldValue))
                    {
                        bs.LoadRows("guidfield=?", bparams);
                    }
                    else
                    {
                        string delguid = Request.Form["deleteguid"];
                        if (!string.IsNullOrEmpty(delguid))
                        {
                            bparams[0].fieldValue = delguid;
                            bs.LoadRows("guidfield=?", bparams);
                            bs.CurrentRow.IsDelete = true;
                            bs.CurrentRow.Save();
                        }
                        cansave = false;
                    }
                }

                if (cansave)
                {
                    if (!string.IsNullOrEmpty(isnew)) { bs.CenterId = Request.Form["g_CenterId"]; }
                    if (string.IsNullOrEmpty(bs.CenterId))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Center Id is Required.");
                        cansave = false;
                    }
                    if (cansave)
                    {
                        bs.address1 = Request.Form["g_address1"];
                        bs.address2 = Request.Form["g_address2"];
                        bs.city = Request.Form["g_city"];
                        bs.contactEMail = Request.Form["g_contactEMail"];
                        bs.contactName = Request.Form["g_contactName"];
                        bs.contactPhone = Request.Form["g_contactPhone"];
                        bs.state = Request.Form["g_state"];
                        bs.zip = Request.Form["g_zip"];

                        if (!bs.CurrentRow.Save())
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                    }
                }
            }

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Center Information";
            bsGrid.securityPage = "Setup - Center Information";
            bsGrid.GridTable = new BestCenters();
            ltrGrid.Text = bsGrid.ToHTML();

        }
    }
}
