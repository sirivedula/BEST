﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestExports : BestTable
    {
        public BestExports()
        {
            this.TableName = "BestExports";
            this.SecurityPage = "Export To Excel";
            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });

            TableFields.Add(new BestField() { fieldName = "exportName", displayField = true, fieldHeader = "Export Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "exportTitle", displayField = true, fieldHeader = "Export Title", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
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

        public string exportName
        {
            get
            {
                return CurrentRow.Fields["exportName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["exportName"].fieldValue = value;
            }
        }


        public string exportTitle
        {
            get
            {
                return CurrentRow.Fields["exportTitle"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["exportTitle"].fieldValue = value;
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
