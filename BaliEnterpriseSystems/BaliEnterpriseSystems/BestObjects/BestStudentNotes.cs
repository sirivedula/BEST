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

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestStudentNotes : BestTable
    {
        public BestStudentNotes()
        {
            this.TableName = "BestStudentNotes";
            this.SecurityPage = "Student - Notes";

            TableFields.Add(new BestField() { fieldName = "guidfield", fieldHeader = "guid", displayField = false, fieldSize = 40, IsRequired = true, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "lastChange", fieldHeader = "Last Change", displayField = false, fieldSize = 20, IsRequired = true, fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", fieldHeader = "Last Change User", displayField = false, fieldSize = 128, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });

            TableFields.Add(new BestField() { fieldName = "studentGuid", fieldHeader = "Student Name", displayField = true, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayFormatFunc = new Func<BestRow,object>( (obj) =>
                {
                    BestRow bstd = (BestRow)obj;
                    List<BestField> bparams = new List<BestField>();
                    BestField guid = new BestField() { fieldName = "studentGuid", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                    guid.fieldValue = bstd.Fields["studentGuid"].fieldValue;
                    bparams.Add(guid);
                    BestStudents bpstd = new BestStudents();
                    bpstd.LoadRows("guidfield=?", bparams);
                    return bpstd.firstName + " " + bpstd.lastName;
                })}); 

            TableFields.Add(new BestField() { fieldName = "noteDate", fieldHeader = "Note Date", displayField = true, fieldSize = 20, IsRequired = true, fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBDate });
            TableFields.Add(new BestField() { fieldName = "notes", fieldHeader = "Notes", displayField = true, fieldSize = 9000, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar});
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "StudentId", displayField = true, fieldHeader = "Student Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });

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
                return new Guid(CurrentRow.Fields["studentGuid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["studentGuid"].fieldValue = value.ToString();
            }
        }

        public DateTime noteDate
        {
            get
            {
                return Convert.ToDateTime(CurrentRow.Fields["noteDate"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["noteDate"].fieldValue = value.ToString("MM/dd/yyyy");
            }
        }

        public string notes
        {
            get
            {
                return CurrentRow.Fields["notes"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["notes"].fieldValue = value;
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
    }
}
