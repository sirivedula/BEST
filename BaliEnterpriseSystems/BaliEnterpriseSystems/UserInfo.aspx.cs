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
    public partial class UserInfo : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            if (! Utils.User.UserRoleByName("Setup - Users").allowView)
            {
                Response.Write("You do not have view rights for this page.");
                return;
            }
            ltrSubMenu.Text = UtilMenu.SetupSubMenu("userinfo");

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            ltrState.Text = Utils.StateOptions();

            if (IsPostBack)
            {
                BestUser bs = new BestUser();
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
                    if (!string.IsNullOrEmpty(isnew)) 
                    { 
                        bs.userName = Request.Form["g_userName"];
                        bs.emailId = Request.Form["g_emailId"];
                    }
                    if (string.IsNullOrEmpty(bs.userName))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("User Name is Required.");
                        cansave = false;
                    }
                    if (string.IsNullOrEmpty(bs.emailId))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("EMail Address is Required.");
                        cansave = false;
                    }

                    if (cansave)
                    {
                        bs.firstName = Request.Form["g_firstName"];
                        bs.lastName = Request.Form["g_lastName"];
                        bs.middleName = Request.Form["g_middleName"];
                        bs.address1 = Request.Form["g_address1"];
                        bs.address2 = Request.Form["g_address2"];
                        bs.city = Request.Form["g_city"];
                        bs.state = Request.Form["g_state"];
                        bs.zip = Request.Form["g_zip"];
                        bs.cellPhone = Request.Form["g_cellPhone"];
                        bs.workPhone = Request.Form["g_workPhone"];
                        bs.homePhone = Request.Form["g_homePhone"];
                        bs.gender = Request.Form["g_gender"];
                        bs.Centers = Request.Form["g_Centers"];
                        bs.userType = Request.Form["g_userType"];
                        string randPwd = RandomString(8);
                        bs.password = Utils.GetMD5Hash(randPwd);
                        bs.passwordExpiration = DateTime.Today.AddDays(3);

                        if (bs.CurrentRow.Save())
                        {
                            Utils.User.emailUtil.Send(bs.emailId, "BLC Login Information", @"<h2>Welcome to Bali Learning Center!</h2><br><h3>Your login information is enclosed.</h3>

<b>Accessing Your Account</b><br>
Step 1:<br>
Click the link below or enter the URL below into your web browser<br>
Address:	<a href=""http://best.vasbal.com"">Bali Learning Center Login</a><br><br>

Step 2:<br>
Enter the following user name and temporary password.<br>
User Name: <b>" + bs.userName + @"</b><br>
Password:   <b>" + randPwd + @"</b><br><br>

<h3>This temporary password expires in 24 hours.</h3><br><br>

You will be prompted to change your user name and password during your initial log in as well as answer a few security related questions. <br>
<br>

<br>
<br>
Thank you,<br>
Bali Learning Center", bs.firstName + " " + bs.lastName); 
                        }
                        else
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                        
                    }
                }

            }

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "User Information";
            bsGrid.GridTable = new BestUser();
            bsGrid.whereClause = "usertype not in ('Student', 'Tutor')";
            bsGrid.securityPage = "Setup - Users";
            bsGrid.AfterAddHTML="<input type=\"button\" id=\"btnReserPwd\" onclick=\"resetPassword();\" value=\"Reset Password\" />";
            ltrGrid.Text = bsGrid.ToHTML();

        }

        private readonly Random _rng = new Random();
        private const string _chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*()~-_+={[}}|;:<.>,/?";

        private string RandomString(int size)
        {
            char[] buffer = new char[size];

            for (int i = 0; i < size; i++)
            {
                buffer[i] = _chars[_rng.Next(_chars.Length)];
            }
            return new string(buffer);
        }

    }
}
