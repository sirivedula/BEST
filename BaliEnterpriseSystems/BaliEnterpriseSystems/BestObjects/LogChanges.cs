using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class LogChanges : BestTable
    {
        public LogChanges()
        {
            base.TableName = "LogChanges";
            this.SecurityPage = "Change Log";
            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "StudentId", displayField = true, fieldHeader = "Student Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "Tablename", displayField = true, fieldHeader = "Table Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "Fieldname", displayField = true, fieldHeader = "Field Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "Oldvalue", displayField = true, fieldHeader = "Old Value", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "newvalue", displayField = true, fieldHeader = "New Value", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "ChangeDate", displayField = true, fieldHeader = "Change Date", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "ChangeType", displayField = true, fieldHeader = "Change Type", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50,
            displayFormatFunc= new Func<BestRow, object>((obj) =>
                      {
                          BestRow pd = (BestRow)obj;
                          if (pd.Fields["ChangeType"].fieldValue.Equals("I"))
                              return "Added";
                          else if (pd.Fields["ChangeType"].fieldValue.Equals("U"))
                              return "Edited";
                          else if (pd.Fields["ChangeType"].fieldValue.Equals("D"))
                              return "Deleted";
                          return "";
                      })
            });
            TableFields.Add(new BestField() { fieldName = "ChangedBy", displayField = true, fieldHeader = "Changed By", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
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

        public DateTime ChangeDate
        {
            get
            {
                return Convert.ToDateTime(CurrentRow.Fields["ChangeDate"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["ChangeDate"].fieldValue = value.ToString("MM/dd/yyyy HH:mm:ss");
            }
        }

        public string tableName
        {
            get
            {
                return CurrentRow.Fields["TableName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["TableName"].fieldValue = value;
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

        public string FieldName
        {
            get
            {
                return CurrentRow.Fields["FieldName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["FieldName"].fieldValue = value;
            }
        }

        public string OldValue
        {
            get
            {
                return CurrentRow.Fields["OldValue"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["OldValue"].fieldValue = value;
            }
        }

        public string NewValue
        {
            get
            {
                return CurrentRow.Fields["NewValue"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["NewValue"].fieldValue = value;
            }
        }

        public string ChangedBy
        {
            get
            {
                return CurrentRow.Fields["ChangedBy"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["ChangedBy"].fieldValue = value;
            }
        }

        public string ChangeType
        {
            get
            {
                return CurrentRow.Fields["ChangeType"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["ChangeType"].fieldValue = value;
            }
        }
    }
}
