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
    public class BestStudentGPA : BestTable
    {
        public BestStudentGPA()
        {
            this.TableName = "BestStudentGPA";
            this.SecurityPage = "Student - Information";

            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "StudentId", displayField = true, fieldHeader = "Student Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "assessmentDate", displayField = false, fieldHeader = "Assessment Date", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBDate, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "assessmentGPA", displayField = true, fieldHeader = "GPA", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "assessmentLevel", displayField = true, fieldHeader = "Assessment Level", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "studentguid", displayField = false, fieldHeader = "StudentGuid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
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

        public Guid studentGuid
        {
            get
            {
                return new Guid(CurrentRow.Fields["studentguid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["studentguid"].fieldValue = value.ToString();
            }
        }

        public DateTime assessmentDate
        {
            get
            {
                return Convert.ToDateTime(CurrentRow.Fields["assessmentDate"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["assessmentDate"].fieldValue = value.ToString("MM/dd/yyyy");
            }
        }

        public string assessmentGPA
        {
            get
            {
                return CurrentRow.Fields["assessmentGPA"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["assessmentGPA"].fieldValue = value;
            }
        }

        public string assessmentLevel
        {
            get
            {
                return CurrentRow.Fields["assessmentLevel"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["assessmentLevel"].fieldValue = value;
            }
        }

    }
}
