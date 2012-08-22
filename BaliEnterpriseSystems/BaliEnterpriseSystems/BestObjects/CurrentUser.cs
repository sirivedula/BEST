using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using BaliEnterpriseSystems.BestObjects;
using System.Data.OleDb;

namespace BaliEnterpriseSystems.BestObjects
{
    public class CurrentUser
    {
        private string _IPAddress;
        private BestUser _bestuser;

        public UtilEMail emailUtil = new UtilEMail();

        public CurrentUser(string username)
        {
            this.UserName = username;
        }

        public BestUser BestUser
        {
            get
            {
                if (_bestuser == null)
                {
                    _bestuser = new BestUser();
                    BestField p1 = new BestField() { fieldName = "username", fieldSize = 40, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, displayField = false };
                    p1.fieldValue = this.UserName;
                    List<BestField> listp = new List<BestField>();
                    listp.Add(p1);
                    _bestuser.LoadRows("username = ?", listp);
                }
                return _bestuser;
            }
        }

        private ApplicationException _error;
        public ApplicationException Error
        {
            get
            {
                return _error;
            }
        }

        private string hashedPassword(string pwd)
        {
            return Utils.GetMD5Hash(pwd);            
        }

        public Boolean loginIsValid(string password)
        {
            if (BestUser.logindisabled)
            {
                _error = new ApplicationException("Your account has been disabled the administrator.");
                return false;
            }
            string checkPassword = password;
            if (String.IsNullOrEmpty(this.BestUser.password) || !this.BestUser.password.Equals(this.hashedPassword(checkPassword), StringComparison.InvariantCulture))
            {
                _error = new ApplicationException("The username and/or password is not correct.");
                return false;
            }
            //check for account expiration
            if (this.BestUser.passwordExpiration < DateTime.Today)
            {
                _error = new ApplicationException("This account has expired.  Please contact your center.");
                return false;
            }
            return true;
        }

        public bool loggedIn
        {
            get;
            set;
        }

        public string IPAddress
        {
            get { return _IPAddress; }
            set { _IPAddress = value; }
        }

        public void SleepWithMax(Int32 sleepMilliseconds, Int32 maxMillisecondstosleep)
        {
            System.Threading.Thread.Sleep(Math.Min(sleepMilliseconds, maxMillisecondstosleep));
        }


        /* Current User will be the person who logged-in into the System. */
        /* Implements Each Page Secure and Allow View, Add, Edit, Delete Rights */
        private List<CurrentUserRole> curuserRoles = null;

        public CurrentUserRole UserRoleByName(string rolename)
        {
            CurrentUserRole result = new CurrentUserRole();
            if (curuserRoles == null)
            {
                curuserRoles = new List<CurrentUserRole>();
                OleDbCommand myCmd = new BestDatabase().dbCmd;
                myCmd.CommandText = "select service, allowadd, allowedit, allowdelete, allowview from BestUserRoles where username = ?";
                OleDbParameter p1 = new OleDbParameter("username", OleDbType.VarChar, 200);
                p1.Value = this.UserName;
                myCmd.Parameters.Add(p1);
                OleDbDataReader reader = myCmd.ExecuteReader();
                while (reader.Read())
                {
                    CurrentUserRole trole = new CurrentUserRole();
                    trole.service = reader.GetValue(0).ToString();
                    trole.allowAdd = reader.GetValue(1).ToString().Equals("True");
                    trole.allowEdit = reader.GetValue(2).ToString().Equals("True");
                    trole.allowDelete = reader.GetValue(3).ToString().Equals("True");
                    trole.allowView = reader.GetValue(4).ToString().Equals("True");
                    curuserRoles.Add(trole);
                }
            }

            foreach (CurrentUserRole role in curuserRoles)
            {
                if (role.service.Equals(rolename))
                {
                    result = role;
                }
            }

            return result;
        }

        public string UserName
        {
            set;
            get;
        }

        public string CenterId
        {
            get
            {
                return HttpContext.Current.Session["UserCenter"].ToString();
            }
        }

        public List<BestField> CIdParam
        {
            get
            {
                List<BestField> lstParam = new List<BestField>();
                BestField bfld = new BestField()
                {
                    fieldName = "CenterId",
                    fieldSize = 50,
                    fieldType = "System.String",
                    paramOledbType = OleDbType.VarChar
                };
                bfld.fieldValue = this.CenterId;
                lstParam.Add(bfld);
                return lstParam;
            }
        }

        public BestField CenterIdField
        {
            get
            {
                BestField bfld = new BestField()
                {
                    fieldName = "CenterId",
                    fieldSize=50,
                    fieldType = "System.String",
                    paramOledbType = OleDbType.VarChar
                };
                bfld.fieldValue = this.CenterId;
                return bfld;
            }
        }

        public string[] Services
        {
            get
            {
                string[] result = { "1.Programs", "2.Students", "3.Tutors", "4.Payments", "5.Schedules", "6.Setup", 
                                    "Payment - Details", "Payment - Reports", "Payment - Types", "Program - Information",
                                    "Program - Types", "Schedules - Attendance", "Setup - Center Information", "Setup - EMail Template",
                                    "Setup - Services", "Setup - User Roles", "Setup - Users", "Student - Information", 
                                    "Student - Notes", "Student - Reports", "Tutor - Information", "Tutor - Reports" };
                return result;
            }
        }
    }

    public class CurrentUserRole
    {
        public string service;
        public bool allowAdd;
        public bool allowEdit;
        public bool allowView;
        public bool allowDelete;

        public CurrentUserRole()
        {
            service = "";
            allowAdd = false;
            allowDelete = false;
            allowEdit = false;
            allowView = false;
        }
    }
}
