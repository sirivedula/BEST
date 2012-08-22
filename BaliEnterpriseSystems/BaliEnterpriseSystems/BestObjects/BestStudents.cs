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

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestStudents : BestTable
    {
        public BestStudents()
        {
            this.TableName = "BestStudents";
            this.SecurityPage = "Student - Information";

            TableFields.Add(new BestField(){ fieldName="guidfield", displayField=false, fieldHeader="Guid", fieldType="System.Guid", paramOledbType= System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField(){ fieldName="lastChange", displayField=false, fieldHeader="Last Change", fieldType="System.DateTime", paramOledbType= System.Data.OleDb.OleDbType.DBTime, fieldSize=20 });
            TableFields.Add(new BestField(){ fieldName="lastChangeUser", displayField=false, fieldHeader="Last Change User", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=128});

            TableFields.Add(new BestField(){ fieldName="StudentId", displayField=true, fieldHeader="Student Id", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="CenterId", displayField=true, fieldHeader="Center Id", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="firstName", displayField=true, fieldHeader="First Name", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="lastName", displayField=true, fieldHeader="Last Name", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="middleName", displayField=true, fieldHeader="Middle Name", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField() { fieldName = "parentName", displayField = true, fieldHeader = "Parent Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 80 });
            TableFields.Add(new BestField(){ fieldName="address1", displayField=false, fieldHeader="Address 1", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField() { fieldName = "address2", displayField = false, fieldHeader = "Address 2", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "city", displayField = false, fieldHeader = "City", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "state", displayField = false, fieldHeader = "State", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 2 });
            TableFields.Add(new BestField() { fieldName = "zip", displayField = false, fieldHeader = "Zip", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "cellPhone", displayField = true, fieldHeader = "Cell Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "workPhone", displayField = true, fieldHeader = "Work Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "homePhone", displayField = true, fieldHeader = "Home Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "emailId", displayField = true, fieldHeader = "Contact EMail", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 80 });
            TableFields.Add(new BestField() { fieldName = "gender", displayField = true, fieldHeader = "Gender", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 10 });
            TableFields.Add(new BestField() { fieldName = "programGuid", displayField = false, fieldHeader = "Program Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "Hours", displayField = false, fieldHeader = "Hours", fieldType = "System.Decimal", paramOledbType = System.Data.OleDb.OleDbType.Decimal, fieldSize = 18, Precision = 12, scale=2 });
            TableFields.Add(new BestField() { fieldName = "hourType", displayField = false, fieldHeader = "Hour Type", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 10 });
            TableFields.Add(new BestField() { fieldName = "Amount", displayField = false, fieldHeader = "Amount", fieldType = "System.Decimal", paramOledbType = System.Data.OleDb.OleDbType.Decimal, fieldSize = 18, Precision = 12, scale = 2 });
            TableFields.Add(new BestField() { fieldName = "amountType", displayField = false, fieldHeader = "Amount Type", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 10 });

            TableFields.Add(new BestField() { fieldName = "joinDate", displayField = false, fieldHeader = "Join Date", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBDate, fieldSize = 10 });
            TableFields.Add(new BestField() { fieldName = "birthDate", displayField = false, fieldHeader = "Birth Date", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBDate, fieldSize = 10 });

            TableFields.Add(new BestField() { fieldName = "guardianName", displayField = false, fieldHeader = "Guardian Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "school", displayField = false, fieldHeader = "School", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "grade", displayField = false, fieldHeader = "Grade", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
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

        public string StudentId
        {
            get
            {
                return CurrentRow.Fields["StudentId"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["StudentId"].fieldValue = value;
            }

        }

        public string CenterId
        {
            get
            {
                return CurrentRow.Fields["CenterId"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["CenterId"].fieldValue = value;
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

        public string parentName
        {
            get
            {
                return CurrentRow.Fields["parentName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["parentName"].fieldValue = value;
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

        public string Hours
        {
            get
            {
                return CurrentRow.Fields["Hours"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["Hours"].fieldValue = value;
            }
        }

        public string hourType
        {
            get
            {
                return CurrentRow.Fields["hourType"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["hourType"].fieldValue = value;
            }
        }

        public string Amount
        {
            get
            {
                return CurrentRow.Fields["Amount"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["Amount"].fieldValue = value;
            }
        }

        public string amountType
        {
            get
            {
                return CurrentRow.Fields["amountType"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["amountType"].fieldValue = value;
            }
        }

        public Guid programGuid
        {
            get
            {
                return new Guid(CurrentRow.Fields["programGuid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["programGuid"].fieldValue = value.ToString();
            }
        }

        public DateTime joinDate
        {
            get
            {
                string fldval = CurrentRow.Fields["joinDate"].fieldValue;
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
                CurrentRow.Fields["joinDate"].fieldValue = value.ToString("MM/dd/yyyy");
            }
        }

        public DateTime birthDate
        {
            get
            {
                string fldval = CurrentRow.Fields["birthDate"].fieldValue;
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
                CurrentRow.Fields["birthDate"].fieldValue = value.ToString("MM/dd/yyyy");
            }
        }

        public string guardianName
        {
            get
            {
                return CurrentRow.Fields["guardianName"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["guardianName"].fieldValue = value;
            }
        }

        public string School
        {
            get
            {
                return CurrentRow.Fields["School"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["School"].fieldValue = value;
            }
        }

        public string Grade
        {
            get
            {
                return CurrentRow.Fields["Grade"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["Grade"].fieldValue = value;
            }
        }
    }
}
