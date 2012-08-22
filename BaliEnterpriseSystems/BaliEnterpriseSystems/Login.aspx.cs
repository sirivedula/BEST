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
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (string.IsNullOrEmpty(txtUserName.Text))
                {
                    ltrValidateMsg.Text = Utils.WarningMessage("User Name is Required.");
                }
                else if (string.IsNullOrEmpty(txtPassword.Text))
                {
                    ltrValidateMsg.Text = Utils.WarningMessage("Password is Required.");
                }
                else
                {
                    // validate the password
                    CurrentUser cu = new CurrentUser(txtUserName.Text);
                    if (txtPassword.Text.Trim() != "") //Distributed password attack mitigation
                    {
                        BestSuspicion bsusp = new BestSuspicion();
                        Int32 passScore = bsusp.GetScore(txtPassword.Text);
                        cu.SleepWithMax(passScore * 5, 20000);
                    }
                    if (cu.loginIsValid(txtPassword.Text))
                    {
                        Guid sessguid = Guid.NewGuid();
                        HttpContext.Current.Session["SessionGuid"] = sessguid;
                        logLogin(txtUserName.Text, true, sessguid);
                        HttpContext.Current.Session["CurrentUser"] = cu;
                        if (cu.BestUser.initialPassword)
                        {
                            Response.Redirect("InitialPasswordChage.aspx");
                        }
                        else
                        {
                            cu.BestUser.IsLoggedIn = true;
                            Response.Redirect("Dashboard.aspx?ms=1");
                        }
                    }
                    else
                    {
                        logLogin(txtUserName.Text, false, null);
                        ltrValidateMsg.Text = Utils.WarningMessage(cu.Error.Message);
                    }
                }
            }
            else
            {
                txtPassword.Text = "";
                txtUserName.Text = "";
            }
        }

        private void logLogin(string username, bool valid, Guid? sessionGuid)
        {
            BestLogins login = new BestLogins();
            login.UserName = username;
            login.serverip = HttpContext.Current.Request.ServerVariables["LOCAL_ADDR"].ToString();
            login.loginvalid = valid;
            login.sourceip = Request.UserHostAddress;
            login.additionalInfo = Request.UserAgent;
            if (sessionGuid.HasValue)
            {
                login.sessionguid = sessionGuid.Value;
                Session["BestSessionGuid"] = login.sessionguid;
            }
            login.CurrentRow.Save();
        }

    }
}
