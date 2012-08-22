using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestExportTables : BestTable
    {
        public BestExportTables()
        {
            this.TableName = "BestExportTables";
            this.SecurityPage = "Export To Excel";
            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });

            TableFields.Add(new BestField() { fieldName = "fieldname", displayField = true, fieldHeader = "Field Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "aliasname", displayField = true, fieldHeader = "Alias Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "displayname", displayField = true, fieldHeader = "Display Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "exportType", displayField = true, fieldHeader = "Export Type", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });

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

        public string fieldname
        {
            get
            {
                return CurrentRow.Fields["fieldname"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["fieldname"].fieldValue = value;
            }
        }


        public string aliasname
        {
            get
            {
                return CurrentRow.Fields["aliasname"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["aliasname"].fieldValue = value;
            }
        }

        public string displayname
        {
            get
            {
                return CurrentRow.Fields["displayname"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["displayname"].fieldValue = value;
            }
        }

        public string exportType
        {
            get
            {
                return CurrentRow.Fields["exportType"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["exportType"].fieldValue = value;
            }
        }
    }
}
