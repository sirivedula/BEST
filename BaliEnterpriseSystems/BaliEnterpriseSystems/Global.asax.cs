using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Configuration;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception CurrentException = Server.GetLastError();
            string ErrorDetails = CurrentException.ToString();
            if (HttpContext.Current == null) return;

            string serverip = HttpContext.Current.Request.ServerVariables["LOCAL_ADDR"].ToString();
            var cUser = Utils.User;
            if (cUser != null)
            {
                ErrorDetails = "User Name:" + (cUser.BestUser.userName ?? "") + ErrorDetails;
            }
            if (HttpContext.Current.Request != null)
            {
                ErrorDetails = "<br />ServerIP:" + serverip + "<br />" + HttpUtility.HtmlEncode(ErrorDetails);
                ErrorDetails += "<br />Referrer:" + HttpUtility.HtmlEncode(HttpContext.Current.Request.UrlReferrer.ToString());
                ErrorDetails += "<br />User Agent:" + HttpUtility.HtmlEncode(HttpContext.Current.Request.UserAgent);
                ErrorDetails += "<br />User IP:" + HttpUtility.HtmlEncode(HttpContext.Current.Request.UserHostAddress);

                if (ConfigurationManager.AppSettings["ShowTerribleErrors"].Equals("true"))
                {
                    Response.Write(HttpUtility.HtmlEncode(ErrorDetails));
                }
                else
                {
                    // Send notification e-mail
                    string toaddress = ConfigurationManager.AppSettings["FromEMail"];
                    Utils.User.emailUtil.Send(toaddress, "Best - Error", ErrorDetails, "BEST");
                    if (!CurrentException.ToString().Contains("SiteError.aspx"))
                    {
                        Response.Redirect("SiteError.aspx");
                    }
                    else
                    {
                        Response.Write("There has been an error - Unable to redirect to the error notification page.");
                    }
                }
            }
        }

        protected void Session_End(object sender, EventArgs e)
        {
            if (HttpContext.Current != null)
            {
                var sessguid = HttpContext.Current.Session["SessionGuid"];
                if (sessguid != null)
                {
                    BestField sguid = new BestField() { fieldName = "sessionguid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 };
                    sguid.fieldValue = sessguid.ToString();
                    BestLogins bslog = new BestLogins();
                    List<BestField> bparam = new List<BestField>();
                    bparam.Add(sguid);
                    bslog.LoadRows("sessionguid=?", bparam);
                    if (bslog.TableRows.Count > 0)
                    {
                        bslog.logoutdate = DateTime.Now;
                        bslog.CurrentRow.Save();
                    }
                }
            }
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}