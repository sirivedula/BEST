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
using System.Data.OleDb;
using System.Text;

namespace BaliEnterpriseSystems
{
    public partial class UserRolesInfo : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);
            ltrSubMenu.Text = UtilMenu.SetupSubMenu("userroles");
            if (!Utils.User.UserRoleByName("Setup - User Roles").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }            

            string username = Request.Form["userName"];
            if (!string.IsNullOrEmpty(username))
            {
                UserRoles uroles = new UserRoles();
                string insSQL = "insert into bestuserroles (service, username) (select bserv.service, ? from bestservices bserv left join bestuserroles bur on bur.service=bserv.service and bur.username = ? where bur.Service is null)";
                OleDbCommand myCmd = uroles.dbCmd;
                OleDbParameter p1 = new OleDbParameter("username0", OleDbType.VarChar, 200);
                p1.Value = username;
                OleDbParameter p2 = new OleDbParameter("username1", OleDbType.VarChar, 200);
                p2.Value = username;
                myCmd.Parameters.Add(p1);
                myCmd.Parameters.Add(p2);
                myCmd.CommandText = insSQL;
                try
                {
                    myCmd.ExecuteNonQuery();
                }
                catch { }
                string saveclicked = Request.Form["saveClicked"];
                bool canSave = (IsPostBack && ((!string.IsNullOrEmpty(saveclicked)) && saveclicked.Equals("1,")));

                List<BestField> bparams = new List<BestField>();
                BestField paramUName = new BestField() { fieldName = "username", fieldSize = 80, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, displayField = false };
                paramUName.fieldValue = username;
                bparams.Add(paramUName);
                uroles.LoadRows("username = ?", bparams, "service");

                StringBuilder sbg = new StringBuilder();
                sbg.Append("<table style=\"width:100%;\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"bestgrid\"><tr><th>Service Name</th><th>Allow View</th><th>Allow Add</th><th>Allow Edit</th><th>Allow Delete</th></tr>");
                for (int rnum = 0; rnum < uroles.TableRows.Count; rnum++)
                {
                    string srclass = " class=" + ((rnum % 2 == 0) ? "\"grideven\"" : "\"gridodd\"");
                    sbg.Append("<tr" + srclass + ">");
                    sbg.Append("<td>" + HttpUtility.HtmlEncode(uroles.TableRows[rnum].Fields["Service"].fieldValue) + "</td>");
                    BestRow curRow = uroles.TableRows[rnum];
                    if (canSave)
                    {
                        string allowview = Request.Form["view_" + rnum.ToString()];
                        string allowadd = Request.Form["add_" + rnum.ToString()];
                        string allowedit = Request.Form["edit_" + rnum.ToString()];
                        string allowdel = Request.Form["delete_" + rnum.ToString()];
                        if ((!string.IsNullOrEmpty(allowadd)) && allowadd.Equals("on"))
                        {
                            curRow.Fields["allowAdd"].fieldValue = "1";
                        }
                        else
                        {
                            curRow.Fields["allowAdd"].fieldValue = "0";
                        }

                        if ((!string.IsNullOrEmpty(allowdel)) && allowdel.Equals("on"))
                        {
                            curRow.Fields["allowDelete"].fieldValue = "1";
                        }
                        else
                        {
                            curRow.Fields["allowDelete"].fieldValue = "0";
                        }
                        if ((!string.IsNullOrEmpty(allowedit)) && allowedit.Equals("on"))
                        {
                            curRow.Fields["allowEdit"].fieldValue = "1";
                        }
                        else
                        {
                            curRow.Fields["allowEdit"].fieldValue = "0";
                        }
                        if ((!string.IsNullOrEmpty(allowview)) && allowview.Equals("on"))
                        {
                            curRow.Fields["allowView"].fieldValue = "1";
                        }
                        else
                        {
                            curRow.Fields["allowView"].fieldValue = "0";
                        }

                        curRow.Save();
                       

                    }
                    bool allowAdd = curRow.Fields["allowAdd"].fieldValue.Equals("1");
                    bool allowView = curRow.Fields["allowView"].fieldValue.Equals("1");
                    bool allowEdit = curRow.Fields["allowEdit"].fieldValue.Equals("1");
                    bool allowDelete = curRow.Fields["allowDelete"].fieldValue.Equals("1");                    
                    string rowguid = curRow.Fields["guidfield"].fieldValue;
                    sbg.Append("<input type=\"hidden\" id=\"guid_" + rnum.ToString() + "\" value=\"" + rowguid + "\" />");

                    sbg.Append("<td class=\"ca\"><input type=\"checkbox\" id=\"view_" + rnum.ToString() + "\" name=\"view_" + rnum.ToString() + "\" ");
                    if (allowView) { sbg.Append(" checked=\"checked\" "); }
                    sbg.Append(" /></td>");

                    sbg.Append("<td class=\"ca\"><input type=\"checkbox\" id=\"add_" + rnum.ToString() + "\" name=\"add_" + rnum.ToString() + "\" ");
                    if (allowAdd) { sbg.Append(" checked=\"checked\" "); }
                    sbg.Append(" /></td>");

                    sbg.Append("<td class=\"ca\"><input type=\"checkbox\" id=\"edit_" + rnum.ToString() + "\" name=\"edit_" + rnum.ToString() + "\" ");
                    if (allowEdit) { sbg.Append(" checked=\"checked\" "); }
                    sbg.Append(" /></td>");

                    sbg.Append("<td class=\"ca\"><input type=\"checkbox\" id=\"delete_" + rnum.ToString() + "\" name=\"delete_" + rnum.ToString() + "\" ");
                    if (allowDelete) { sbg.Append(" checked=\"checked\" "); }
                    sbg.Append(" /></td>");
                }
                /* TODO:User Rights  */
                sbg.Append("<tr><td colspan=\"5\"><input type=\"button\" id=\"btnSave\" name=\"btnSave\" onclick=\"doSave();\" value=\"Save\"  /></td></tr>");
                sbg.Append("</table>");
                ltrGrid.Text = sbg.ToString();
            }
            else
            {
                ltrGrid.Text = "<div style=\"height:200px;\"></div>";
            }
            BestUser buser = new BestUser();
            buser.LoadRows("usertype not  in ('Student', 'Tutor')", null);
            StringBuilder sb = new StringBuilder();
            sb.Append("<option value=\"\"></option>");
            for (int rownum = 0; rownum < buser.TableRows.Count; rownum++)
            {
                string uname = buser.TableRows[rownum].Fields["userName"].fieldValue;
                sb.Append("<option value=\"" + HttpUtility.HtmlEncode(uname) + "\" ");
                if (uname.Equals(username))
                {
                    sb.Append(" selected=\"selected\" ");
                }
                sb.Append(">" + HttpUtility.HtmlEncode(uname) + "</option>");
            }
            ltrSelectUser.Text = sb.ToString();
        }
    }
}
