using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestSTPlan : BestTable
    {
        public BestSTPlan()
        {
            this.TableName = "BestSTPlans";
            this.SecurityPage = "Student - Planner";
            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "StudentId", displayField = true, fieldHeader = "Student Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "schDay", displayField = true, fieldHeader = "Day", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "schFrom", displayField = true, fieldHeader = "From", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "schTo", displayField = true, fieldHeader = "To", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "studentguid", displayField = true, fieldHeader = "Student Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "tutorguid", displayField = true, fieldHeader = "Tutor Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "isDeleted", fieldHeader = "Deleted ?", displayField = false, fieldSize = 4, IsRequired = false, fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
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
        public Guid tutorguid
        {
            get
            {
                return new Guid(CurrentRow.Fields["tutorguid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["tutorguid"].fieldValue = value.ToString();
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
        public string schDay
        {
            get
            {
                return CurrentRow.Fields["schday"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["schday"].fieldValue = value;
            }
        }
        public string schFrom
        {
            get
            {
                return CurrentRow.Fields["schfrom"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["schfrom"].fieldValue = value;
            }
        }
        public string schTo
        {
            get
            {
                return CurrentRow.Fields["schTo"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["schTo"].fieldValue = value;
            }
        }

        public string isDeleted
        {
            get
            {
                return CurrentRow.Fields["isDeleted"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["isDeleted"].fieldValue = value;
            }
        }
    }
}
