using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestUserPrefs : BestTable
    {
        public BestUserPrefs()
        {
            this.TableName = "BestUserPrefs";
            this.SecurityPage = "Setup - Center Information";
            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() 
            {   
                fieldName = "lastChangeUser", 
                displayField = false, 
                fieldHeader = "Last Change User", 
                fieldType = "System.String", 
                paramOledbType = System.Data.OleDb.OleDbType.VarChar, 
                fieldSize = 128 
            });
            TableFields.Add(new BestField()
            {
                fieldName = "UserName",
                displayField = false,
                fieldHeader = "User Name",
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldSize = 128
            });

            TableFields.Add(new BestField()
            {
                fieldName = "Name",
                displayField = false,
                fieldHeader = "Name",
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldSize = 50
            });
            TableFields.Add(new BestField()
            {
                fieldName = "Value",
                displayField = false,
                fieldHeader = "Value",
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldSize = 50
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

        public string UserName
        {
            get
            {
                return CurrentRow.Fields["UserName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["UserName"].fieldValue = value;
            }
        }

        public string Name
        {
            get
            {
                return CurrentRow.Fields["Name"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["Name"].fieldValue = value;
            }
        }

        public string Value
        {
            get
            {
                return CurrentRow.Fields["Value"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["Value"].fieldValue = value;
            }
        }
    }
}
