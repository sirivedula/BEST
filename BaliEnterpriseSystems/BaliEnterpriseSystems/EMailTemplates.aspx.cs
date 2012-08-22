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
using System.Collections.Generic;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class EMailTemplates : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.SetupSubMenu("emailtemplate");
            if (!Utils.User.UserRoleByName("Setup - EMail Template").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            if (IsPostBack)
            {
                BestEMailTemplate bs = new BestEMailTemplate();
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
                    if (!string.IsNullOrEmpty(isnew)) { bs.emialTemplateName = Request.Form["g_emialTemplateName"]; }
                    if (string.IsNullOrEmpty(bs.emialTemplateName))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("EMial Template Name is Required.");
                        cansave = false;
                    }
                    if (cansave)
                    {
                        bs.templateDescription = Request.Form["g_templateDescription"];
                        if (!bs.CurrentRow.Save())
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                    }
                }
            }

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "EMail Templates Information";
            bsGrid.GridTable = new BestEMailTemplate();
            bsGrid.securityPage = "Setup - EMail Template";
            ltrGrid.Text = bsGrid.ToHTML();
        }
    }
}
