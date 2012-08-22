using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestUser : BestTable
    {
        public BestUser()
        {
            this.TableName = "BestUsers";
            this.SecurityPage = "Setup - Users";
            this.IsLoggedIn = false;

            TableFields.Add(new BestField(){ fieldName="guidfield", displayField=false, fieldHeader="Guid", fieldType="System.Guid", paramOledbType= System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField(){ fieldName="lastChange", displayField=false, fieldHeader="Last Change", fieldType="System.DateTime", paramOledbType= System.Data.OleDb.OleDbType.DBTime, fieldSize=20 });
            TableFields.Add(new BestField(){ fieldName="lastChangeUser", displayField=false, fieldHeader="Last Change User", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=128});
            TableFields.Add(new BestField(){ fieldName="userName", displayField=true, fieldHeader="User Name", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=128});
            TableFields.Add(new BestField(){ fieldName="password", displayField=false, fieldHeader="User Name", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=128});
            TableFields.Add(new BestField(){ fieldName="tempPwd", displayField=false, fieldHeader="Temp Password", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="passwordExpiration", displayField=false, fieldHeader="Password Expiration", fieldType="System.DateTime", paramOledbType= System.Data.OleDb.OleDbType.DBTimeStamp, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="firstName", displayField=true, fieldHeader="First Name", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="lastName", displayField=true, fieldHeader="Last Name", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="middleName", displayField=true, fieldHeader="Middle Name", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="address1", displayField=true, fieldHeader="Address 1", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField() { fieldName = "address2", displayField = true, fieldHeader = "Address 2", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "city", displayField = true, fieldHeader = "City", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "state", displayField = true, fieldHeader = "State", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 2 });
            TableFields.Add(new BestField() { fieldName = "zip", displayField = true, fieldHeader = "Zip", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "cellPhone", displayField = true, fieldHeader = "Cell Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "workPhone", displayField = true, fieldHeader = "Work Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "homePhone", displayField = true, fieldHeader = "Home Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "emailId", displayField = true, fieldHeader = "Contact EMail", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 80 });
            TableFields.Add(new BestField() { fieldName = "securityQuestion1", displayField = false, fieldHeader = "SecurityQ1", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 300 });
            TableFields.Add(new BestField() { fieldName = "answer1", displayField = false, fieldHeader = "Answer1", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 10 });
            TableFields.Add(new BestField() { fieldName = "securityQuestion2", displayField = false, fieldHeader = "SecurityQ2", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 300 });
            TableFields.Add(new BestField() { fieldName = "answer2", displayField = false, fieldHeader = "Answer2", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 10 });
            TableFields.Add(new BestField() { fieldName = "gender", displayField = true, fieldHeader = "Gender", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 10 });
            TableFields.Add(new BestField() { fieldName = "Centers", displayField = true, fieldHeader = "Available to Centers", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 1000 });
            TableFields.Add(new BestField() { fieldName = "userType", displayField = true, fieldHeader = "User Type", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "logindisabled", displayField = true, fieldHeader = "Disabled?", fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.Integer, fieldSize = 2 });
            TableFields.Add(new BestField() { fieldName = "initialPassword", displayField = false, fieldHeader = "Initial Pwd?", fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.Integer, fieldSize = 1 });
            TableFields.Add(new BestField() { fieldName = "studentGuid", displayField = false, fieldHeader = "Student", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "TutorGuid", fieldSize = 40, paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldType = "System.Guid", displayField = false });
        }

        public Guid guidfield
        {
            get
            {
                return new Guid(CurrentRow.Fields["guidfield"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["guidfield"].fieldValue = value.ToString();
            }
        }

        public DateTime lastChange
        {
            get
            {
                return Convert.ToDateTime(CurrentRow.Fields["lastChange"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["lastChange"].fieldValue = value.ToString("MM/dd/yyyy HH:mm:ss");
            }
        }

        public string lastChangeUser
        {
            get
            {
                return CurrentRow.Fields["lastChangeUser"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["lastChangeUser"].fieldValue = value;
            }
        }

        public string userName
        {
            get
            {
                return CurrentRow.Fields["userName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["userName"].fieldValue = value;
            }

        }

        public string password
        {
            get
            {
                return CurrentRow.Fields["password"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["password"].fieldValue = value;
            }

        }

        public string tempPwd
        {
            get
            {
                return CurrentRow.Fields["tempPwd"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["tempPwd"].fieldValue = value;
            }

        }

        public DateTime passwordExpiration
        {
            get
            {
                var fldval = CurrentRow.Fields["passwordExpiration"].fieldValue;
                if (!string.IsNullOrEmpty(fldval))
                {
                    return Convert.ToDateTime(fldval);
                }
                else
                {
                    return DateTime.MinValue;
                }
            }

            set
            {
                CurrentRow.Fields["passwordExpiration"].fieldValue = value.ToString("MM/dd/yyyy");
            }

        }
                    
        public string firstName
        {
            get
            {
                return CurrentRow.Fields["firstName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["firstName"].fieldValue = value;
            }

        }

        public string lastName
        {
            get
            {
                return CurrentRow.Fields["lastName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["lastName"].fieldValue = value;
            }

        }

        public string middleName
        {
            get
            {
                return CurrentRow.Fields["middleName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["middleName"].fieldValue = value;
            }

        }

        public string address1
        {
            get
            {
                return CurrentRow.Fields["address1"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["address1"].fieldValue = value;
            }
        }

        public string address2
        {
            get
            {
                return CurrentRow.Fields["address2"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["address2"].fieldValue = value;
            }
        }

        public string city
        {
            get
            {
                return CurrentRow.Fields["city"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["city"].fieldValue = value;
            }
        }

        public string state
        {
            get
            {
                return CurrentRow.Fields["state"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["state"].fieldValue = value;
            }
        }

        public string zip
        {
            get
            {
                return CurrentRow.Fields["zip"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["zip"].fieldValue = value;
            }
        }

        public string cellPhone
        {
            get
            {
                return CurrentRow.Fields["cellPhone"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["cellPhone"].fieldValue = value;
            }
        }

        public string emailId
        {
            get
            {
                return CurrentRow.Fields["emailId"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["emailId"].fieldValue = value;
            }
        }

        public string workPhone
        {
            get
            {
                return CurrentRow.Fields["workPhone"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["workPhone"].fieldValue = value;
            }
        }

        public string homePhone
        {
            get
            {
                return CurrentRow.Fields["homePhone"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["homePhone"].fieldValue = value;
            }
        }

        public string securityQuestion1
        {
            get
            {
                return CurrentRow.Fields["securityQuestion1"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["securityQuestion1"].fieldValue = value;
            }
        }
        public string answer1
        {
            get
            {
                return CurrentRow.Fields["answer1"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["answer1"].fieldValue = value;
            }
        }
        public string securityQuestion2
        {
            get
            {
                return CurrentRow.Fields["securityQuestion2"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["securityQuestion2"].fieldValue = value;
            }
        }
        public string answer2
        {
            get
            {
                return CurrentRow.Fields["answer2"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["answer2"].fieldValue = value;
            }
        }

        public string gender
        {
            get
            {
                return CurrentRow.Fields["gender"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["gender"].fieldValue = value;
            }
        }

        public string Centers
        {
            get
            {
                return CurrentRow.Fields["Centers"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["Centers"].fieldValue = value;
            }
        }

        private List<UserRoles> _roles = new List<UserRoles>();

        public List<UserRoles> userRoles
        {
            get
            {
                return _roles;
            }
        }

        public string userType
        {
            get
            {
                return CurrentRow.Fields["userType"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["userType"].fieldValue = value;
            }
        }

        public bool logindisabled
        {
            get
            {
                return (CurrentRow.Fields["logindisabled"].fieldValue??"").Equals("1");
            }
            set
            {
                CurrentRow.Fields["logindisabled"].fieldValue = (value) ? "1" : "0";
            }
        }

        public bool initialPassword
        {
            get
            {
                return (CurrentRow.Fields["initialPassword"].fieldValue ?? "").Equals("1");
            }
            set
            {
                CurrentRow.Fields["initialPassword"].fieldValue = (value) ? "1" : "0";
            }
        }

        public bool IsLoggedIn
        {
            get;
            set;
        }

        public Guid? studentGuid
        {
            get
            {
                if (string.IsNullOrEmpty(CurrentRow.Fields["studentGuid"].fieldValue))
                    return null;
                return new Guid(CurrentRow.Fields["studentGuid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["studentGuid"].fieldValue = value.ToString();
            }
        }

        public Guid? tutorGuid
        {
            get
            {
                if (string.IsNullOrEmpty(CurrentRow.Fields["tutorGuid"].fieldValue))
                    return null;
                return new Guid(CurrentRow.Fields["tutorGuid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["tutorGuid"].fieldValue = value.ToString();
            }
        }

        public string CurrentCenterId
        {
            get
            {
                string result = "";
                if (IsLoggedIn)
                {
                    /* Is Student or Tutor Login then */
                    if (userType.Equals("Tutor") || userType.Equals("Student"))
                    {
                        result = this.Centers;
                    }
                    else
                    {
                        /* Get the Last Center User used */
                        UserPrefs up = new UserPrefs(this.userName);
                        result = up.getPreference("LastCenter");
                        if(string.IsNullOrEmpty(result))
                        {
                            if (this.Centers.Equals("*"))
                            {
                                BestCenters bcenter = new BestCenters();
                                bcenter.LoadRows("guidfield");
                                result = bcenter.TableRows[0].Fields["centerId"].fieldValue;
                            }
                            else
                            {
                                result = this.Centers.Split(',')[0];
                            }
                            up.SetPreference("LastCenter", result);
                        }
                    }
                }
                return result;
            }
        }

        public bool IsAllowedCenter(string centerid)
        {
            bool result = false;
            if (IsLoggedIn)
            {
                if (this.Centers.Equals("*"))
                {
                    result = true;
                }
                else if (this.userType.Equals("Student") || this.userType.Equals("Tutor"))
                {
                    result = this.Centers.Equals(centerid);
                }
                else
                {
                    string[] allowcenters = this.Centers.Split(',');
                    result = allowcenters.Contains(centerid);
                }
            }
            return result;
        }

        public bool IsStudent
        {
            get
            {
                return userType.Equals("Student");
            }
        }

        public bool IsTutor
        {
            get
            {
                return userType.Equals("Tutor");
            }
        }

    }
}
