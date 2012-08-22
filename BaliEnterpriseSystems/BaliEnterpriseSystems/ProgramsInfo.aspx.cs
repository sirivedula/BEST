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
    public partial class ProgramsInfo : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.ProgramMenu("programtypes");
            if (!Utils.User.UserRoleByName("Program - Types").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }            

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            string saveClicked = Request.Form["SaveClicked"]??"";
            if (IsPostBack && saveClicked.Equals("1"))
            {
                ProgramTypes bs = new ProgramTypes();
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
                    bs.programType = Request.Form["g_programType"];
                    if (string.IsNullOrEmpty(bs.programType))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Program Type is Required.");
                        cansave = false;
                    }
                    if (cansave)
                    {
                        if (!bs.CurrentRow.Save())
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                    }
                }
            }

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Program Types Information";
            bsGrid.securityPage = "Program - Types";
            bsGrid.GridTable = new ProgramTypes();
            ltrGrid.Text = bsGrid.ToHTML();
        }
    }
}
