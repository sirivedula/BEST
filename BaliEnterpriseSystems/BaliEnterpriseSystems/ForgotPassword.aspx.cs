using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (emailid.Value.Length == 0)
                {
                    ltrMsg.Text = "EMail address can not be blank.";
                }
                else
                {                    
                    BestUser bsUser = new BestUser();
                    bsUser.LoadRows("emailid=?", "emailid", emailid.Value, "username");
                    bsUser.currentRowId = 0;
                    try
                    {
                        if (!bsUser.CurrentRow.IsNew)
                        {
                            bsUser.overrideEdit = true;
                            string randPwd = RandomString(8);
                            bsUser.password = Utils.GetMD5Hash(randPwd);
                            bsUser.passwordExpiration = DateTime.Today.AddDays(7);
                            CurrentUser CUser = new CurrentUser(bsUser.userName);
                            if (bsUser.CurrentRow.Save())
                            {
                                ltrMsg.Text = "Password Reset done and an email sent to you. <a href=\"Login.aspx\">Please Login</a>" ;
                                CUser.emailUtil.Send(bsUser.emailId, "BLC Login Information", @"<h2>Password Reset</h2><br><h3>Your login information is enclosed.</h3>

<b>Accessing Your Account</b><br>
Step 1:<br>
Click the link below or enter the URL below into your web browser<br>
Address:	<a href=""http://best.vasbal.com"">Bali Learning Center Login</a><br><br>

Step 2:<br>
Enter the following user name and temporary password.<br>
User Name: <b>" + bsUser.userName + @"</b><br>
Password:   <b>" + randPwd + @"</b><br><br>

<h3>This temporary password expires in 24 hours.</h3><br><br>

You will be prompted to change your user name and password during your initial log in as well as answer a few security related questions. <br>
<br>

<br>
<br>
Thank you,<br>
Bali Learning Center", bsUser.firstName + " " + bsUser.lastName);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ltrMsg.Text = ex.Message;
                    }
                }
            }
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
