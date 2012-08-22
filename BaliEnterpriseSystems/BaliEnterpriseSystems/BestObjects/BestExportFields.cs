using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestExportFields : BestTable
    {
        public BestExportFields()
        {
            this.TableName = "BestExportFields";
            this.SecurityPage = "Export To Excel";
            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });
            TableFields.Add(new BestField() { fieldName = "exportguid", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });

            TableFields.Add(new BestField() { fieldName = "fieldname", displayField = true, fieldHeader = "Field Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "displayname", displayField = true, fieldHeader = "Display Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "ordinal", displayField = true, fieldHeader = "Ordinal", fieldType = "System.Int32", paramOledbType = System.Data.OleDb.OleDbType.Integer, fieldSize = 6 });
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

        public Guid exportguid
        {
            get
            {
                return new Guid(CurrentRow.Fields["exportguid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["exportguid"].fieldValue = value.ToString();
            }
        }

        public string fieldName
        {
            get
            {
                return CurrentRow.Fields["fieldName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["fieldName"].fieldValue = value;
            }
        }


        public string displayName
        {
            get
            {
                return CurrentRow.Fields["displayName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["displayName"].fieldValue = value;
            }
        }

        public Int32 Ordinal
        {
            get
            {
                Int32 result;
                Int32.TryParse(CurrentRow.Fields["Ordinal"].fieldValue, out result);
                return result;
            }
            set
            {
                CurrentRow.Fields["Ordinal"].fieldValue = value.ToString();
            }
        }

    }
}
