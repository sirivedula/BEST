using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;
using System.Text;

namespace BaliEnterpriseSystems
{
    public partial class BestStudentUser : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentusers");
            if (!Utils.User.UserRoleByName("Student - Users").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }

            string ms = Request.QueryString["ms"];
            this.ltrMScript.Text = Utils.MenuSelectScript(ms);

            string saveClicked = Request.Form["SaveClicked"] ?? "";
            if (IsPostBack && saveClicked.Equals("1"))
            {
                BestField fld = new BestField() { fieldName = "guidfield", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldType = "System.Guid" };
                List<BestField> bparam = new List<BestField>();
                string delguid = Request.Form["deleteguid"];
                if (!string.IsNullOrEmpty(delguid))
                {
                    BestUser bsduser = new BestUser();
                    fld.fieldValue = delguid;
                    bparam.Add(fld);
                    bsduser.LoadRows("guidfield=?", bparam);
                    bsduser.CurrentRow.IsDelete = true;
                    if (!bsduser.CurrentRow.Save())
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage(bsduser.CurrentRow.lastError);
                    }
                }
                else
                {
                    string stdGud = Request.Form["studentTag10"];
                    if (!string.IsNullOrEmpty(stdGud))
                    {
                        fld.fieldValue = stdGud;
                        bparam.Add(fld);
                        BestStudents bstud = new BestStudents();
                        bstud.LoadRows("guidfield=?", bparam);
                        if (!bstud.CurrentRow.IsNew)
                        {
                            if (string.IsNullOrEmpty(bstud.emailId))
                            {
                                ltrValidateMsg.Text = Utils.WarningMessage("Student E-Mail Address is Required.");
                            }
                            else
                            {
                                BestUser bstuser = new BestUser();
                                bstuser.userName = bstud.emailId;
                                bstuser.firstName = bstud.firstName;
                                bstuser.lastName = bstud.lastName;
                                bstuser.address1 = bstud.address1;
                                bstuser.address2 = bstud.address2;
                                bstuser.city = bstud.city;
                                bstuser.state = bstud.state;
                                bstuser.zip = bstud.zip;
                                bstuser.cellPhone = bstud.cellPhone;
                                bstuser.workPhone = bstud.workPhone;
                                bstuser.homePhone = bstud.homePhone;
                                bstuser.studentGuid = bstud.guidfield;
                                bstuser.Centers = bstud.CenterId;

                                bstuser.emailId = bstud.emailId;
                                bstuser.userType = "Student";
                                string randPwd = RandomString(8);
                                bstuser.password = Utils.GetMD5Hash(randPwd);
                                bstuser.passwordExpiration = DateTime.Today.AddDays(3);
                                if (bstuser.CurrentRow.Save())
                                {
                                    Utils.User.emailUtil.Send(bstuser.emailId, "BLC Login Information", @"<h2>Welcome to Bali Learning Center!</h2><br><h3>Your login information is enclosed.</h3>

<b>Accessing Your Account</b><br>
Step 1:<br>
Click the link below or enter the URL below into your web browser<br>
Address:	<a href=""http://best.vasbal.com"">Bali Learning Center Login</a><br><br>

Step 2:<br>
Enter the following user name and temporary password.<br>
User Name: <b>" + bstuser.userName + @"</b><br>
Password:   <b>" + randPwd + @"</b><br><br>

<h3>This temporary password expires in 24 hours.</h3><br><br>

You will be prompted to change your user name and password during your initial log in as well as answer a few security related questions. <br>
<br>

<br>
<br>
Thank you,<br>
Bali Learning Center", bstuser.firstName + " " + bstuser.lastName);

                                    /* Create Studet - Personal Role  */
                                    List<BestField> bparams = new List<BestField>();
                                    BestField paramUName = new BestField() { fieldName = "username", fieldSize = 80, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, displayField = false };
                                    paramUName.fieldValue = bstuser.userName;
                                    BestField service = new BestField() { fieldName = "service", fieldSize = 80, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, displayField = false };
                                    bparams.Add(paramUName);
                                    bparams.Add(service);

                                    string[] aryRoles = { "2.Students", "Student - Personal", "Student - Planner" };
                                    for (int i = 0; i < aryRoles.Length; i++)
                                    {
                                        UserRoles urole = new UserRoles();
                                        bparams[1].fieldValue = aryRoles[i];
                                        urole.LoadRows("username = ? and service=?", bparams);
                                        if (urole.TableRows.Count == 0)
                                        {
                                            urole.Service = aryRoles[i];
                                            urole.UserName = bstuser.userName;
                                            urole.allowView = "1";
                                            urole.CurrentRow.Save();
                                        }
                                    }
                                }
                                else
                                {
                                    ltrValidateMsg.Text = Utils.WarningMessage( bstuser.CurrentRow.lastError);
                                }

                            }
                        }
                    }
                }
            }

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Student Users";
            bsGrid.securityPage = "Student - Users";
            BestUser bsuser = new BestUser();
            bsuser.overrideAdd = Utils.User.UserRoleByName("Student - Users").allowAdd;
            bsuser.overrideDelete = Utils.User.UserRoleByName("Student - Users").allowDelete;
            bsuser.overrideEdit = false;

            bsuser.TableFields["address1"].displayField = false;
            bsuser.TableFields["address2"].displayField = false;
            bsuser.TableFields["city"].displayField = false;
            bsuser.TableFields["zip"].displayField = false;
            bsuser.TableFields["state"].displayField = false;
            bsuser.TableFields["Centers"].displayField = false;
            bsGrid.GridTable = bsuser;
            bsGrid.whereClause = "usertype in ('Student')";
            ltrGrid.Text = bsGrid.ToHTML();

            /* Auto Student */
            StringBuilder sb = new StringBuilder();
            string autoSample = "{value:\"[paramValue]\", label:[paramLabel]}";
            sb.AppendLine("<script type=\"text/javascript\">");
            sb.AppendLine("autoStudents = [");
            BestStudents bstd = new BestStudents();
            bstd.LoadRows();
            for (int s = 0; s < bstd.TableRows.Count; s++)
            {
                string result = autoSample;
                result = result.Replace("[paramValue]", bstd.TableRows[s].Fields["guidfield"].fieldValue);
                result = result.Replace("[paramLabel]", Utils.EnquoteJS((bstd.TableRows[s].Fields["firstName"].fieldValue ?? "") + " " +
                    (bstd.TableRows[s].Fields["lastName"].fieldValue ?? "")));
                sb.Append(result);
                if (s < bstd.TableRows.Count - 1) sb.AppendLine(",");
            }
            sb.AppendLine("];");
            sb.AppendLine("</script>");
            this.ltrScript.Text = sb.ToString();
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
