﻿using System;
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
    public class BestStudentPickup : BestTable
    {
        public BestStudentPickup()
        {
            this.TableName = "BestStudentPickup";
            this.SecurityPage = "Student - Information";

            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "StudentId", displayField = true, fieldHeader = "Student Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "studentguid", displayField = false, fieldHeader = "StudentGuid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "contactName", displayField = true, fieldHeader = "Contact Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "contactPhone", displayField = true, fieldHeader = "Contact Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "relationship", displayField = true, fieldHeader = "Relationship", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
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

        public string contactName
        {
            get
            {
                return CurrentRow.Fields["contactName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["contactName"].fieldValue = value;
            }
        }

        public string contactPhone
        {
            get
            {
                return CurrentRow.Fields["contactPhone"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["contactPhone"].fieldValue = value;
            }
        }

        public string relationship
        {
            get
            {
                return CurrentRow.Fields["relationship"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["relationship"].fieldValue = value;
            }
        }
    }
}
