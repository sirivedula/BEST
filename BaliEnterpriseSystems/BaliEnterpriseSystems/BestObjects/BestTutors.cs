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
    public class BestTutors : BestTable
    {
        public BestTutors()
        {
            this.TableName = "BestTutors";
            this.SecurityPage = "Tutor - Information";

            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });

            TableFields.Add(new BestField() { fieldName = "TutorId", displayField = true, fieldHeader = "Tutor Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "firstName", displayField = true, fieldHeader = "First Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "lastName", displayField = true, fieldHeader = "Last Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "middleName", displayField = true, fieldHeader = "Middle Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "address1", displayField = true, fieldHeader = "Address 1", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "address2", displayField = true, fieldHeader = "Address 2", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "city", displayField = true, fieldHeader = "City", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "state", displayField = true, fieldHeader = "State", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 2 });
            TableFields.Add(new BestField() { fieldName = "zip", displayField = true, fieldHeader = "Zip", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "cellPhone", displayField = true, fieldHeader = "Cell Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "workPhone", displayField = true, fieldHeader = "Work Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "homePhone", displayField = true, fieldHeader = "Home Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "emailId", displayField = true, fieldHeader = "Contact EMail", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 80 });
            TableFields.Add(new BestField() { fieldName = "gender", displayField = true, fieldHeader = "Gender", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 10 });
            TableFields.Add(new BestField() { fieldName = "joinDate", displayField = false, fieldHeader = "Join Date", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBDate, fieldSize = 10 });

            TableFields.Add(new BestField()
            {
                fieldName = "school", fieldSize=50, fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar,
                displayField=false, fieldHeader="School"
            });

            TableFields.Add(new BestField()
            {
                fieldHeader="Year Graduated", displayField=false, paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldType="System.String", fieldSize=50, fieldName = "yearGraduated"
            });

            TableFields.Add(new BestField()
            {
                fieldName = "GPA",
                fieldSize = 50,
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                displayField = false,
                fieldHeader = "GPA"
            });

            TableFields.Add(new BestField()
            {
                fieldHeader = "Majot",
                displayField = false,
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldType = "System.String",
                fieldSize = 50,
                fieldName = "Major"
            });

            TableFields.Add(new BestField()
            {
                fieldName = "Expertise",
                fieldSize = 50,
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                displayField = false,
                fieldHeader = "Expertise"
            });

            TableFields.Add(new BestField()
            {
                fieldHeader = "learningStyle",
                displayField = false,
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldType = "System.String",
                fieldSize = 50,
                fieldName = "learningStyle"
            });

            TableFields.Add(new BestField()
            {
                fieldName = "matchup",
                fieldSize = 50,
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                displayField = false,
                fieldHeader = "matchup"
            });

            TableFields.Add(new BestField()
            {
                fieldHeader = "gradeLevels",
                displayField = false,
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldType = "System.String",
                fieldSize = 50,
                fieldName = "gradeLevels"
            });

            TableFields.Add(new BestField()
            {
                fieldName = "otherSkill",
                fieldSize = 50,
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                displayField = false,
                fieldHeader = "otherSkill"
            });

            TableFields.Add(new BestField()
            {
                fieldHeader = "programStyle",
                displayField = false,
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldType = "System.String",
                fieldSize = 50,
                fieldName = "programStyle"
            });

            TableFields.Add(new BestField() 
            { 
                fieldName = "salary", 
                displayField = false, 
                fieldHeader = "Salary", 
                fieldType = "System.Decimal",
                Precision = 18,
                scale = 2,
                paramOledbType = System.Data.OleDb.OleDbType.Decimal, 
                fieldSize = 18 
            });

            TableFields.Add(new BestField()
            {
                fieldName = "perhour",
                displayField = false,
                fieldHeader = "Per Hour",
                fieldType = "System.Decimal",
                Precision = 18,
                scale = 2,
                paramOledbType = System.Data.OleDb.OleDbType.Decimal,
                fieldSize = 18
            });
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

        public string TutorId
        {
            get
            {
                return CurrentRow.Fields["TutorId"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["TutorId"].fieldValue = value;
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

        public DateTime joinDate
        {
            get
            {
                if (string.IsNullOrEmpty(CurrentRow.Fields["joinDate"].fieldValue))
                {
                    return DateTime.MinValue;
                }
                return Convert.ToDateTime(CurrentRow.Fields["joinDate"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["joinDate"].fieldValue = value.ToString("MM/dd/yyyy");
            }
        }

        public string School
        {
            get
            {
                return CurrentRow.Fields["school"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["school"].fieldValue = value;
            }
        }

        public string yearGraduated
        {
            get
            {
                return CurrentRow.Fields["yearGraduated"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["yearGraduated"].fieldValue = value;
            }
        }

        public string GPA
        {
            get
            {
                return CurrentRow.Fields["GPA"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["GPA"].fieldValue = value;
            }
        }

        public string Major
        {
            get
            {
                return CurrentRow.Fields["Major"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["Major"].fieldValue = value;
            }
        }

        public string Expertise
        {
            get
            {
                return CurrentRow.Fields["Expertise"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["Expertise"].fieldValue = value;
            }
        }

        public string learningStyle
        {
            get
            {
                return CurrentRow.Fields["learningStyle"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["learningStyle"].fieldValue = value;
            }
        }

        public string Matchup
        {
            get
            {
                return CurrentRow.Fields["matchup"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["matchup"].fieldValue = value;
            }
        }

        public string gradeLevels
        {
            get
            {
                return CurrentRow.Fields["gradeLevels"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["gradeLevels"].fieldValue = value;
            }
        }

        public string otherSkill
        {
            get
            {
                return CurrentRow.Fields["otherSkill"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["otherSkill"].fieldValue = value;
            }
        }

        public string programStyle
        {
            get
            {
                return CurrentRow.Fields["programStyle"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["programStyle"].fieldValue = value;
            }
        }

        public Decimal Salary
        {
            get
            {
                if (!string.IsNullOrEmpty(CurrentRow.Fields["salary"].fieldValue))
                    return Convert.ToDecimal(CurrentRow.Fields["salary"].fieldValue);
                return 0;
                
            }
            set
            {
                CurrentRow.Fields["salary"].fieldValue = value.ToString();
            }
        }

        public Decimal PerHour
        {
            get
            {
                if (!string.IsNullOrEmpty(CurrentRow.Fields["perhour"].fieldValue))
                    return Convert.ToDecimal(CurrentRow.Fields["perhour"].fieldValue);
                return 0;

            }
            set
            {
                CurrentRow.Fields["perhour"].fieldValue = value.ToString();
            }
        }
    }
}
