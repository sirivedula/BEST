using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestLogins : BestTable
    {
        public BestLogins()
        {
            this.TableName = "BestLogins";
            this.overrideAdd = true;
            this.overrideDelete = false;
            this.overrideEdit = true;

            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "username", displayField = false, fieldHeader = "User Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });
            TableFields.Add(new BestField() { fieldName = "logindate", displayField = false, fieldHeader = "Login Date", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "sourceip", displayField = false, fieldHeader = "Source IP", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "loginvalid", displayField = false, fieldHeader = "Login Valid", fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.Integer, fieldSize = 2 });
            TableFields.Add(new BestField() { fieldName = "serverip", displayField = false, fieldHeader = "Server IP", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "sessionguid", displayField = false, fieldHeader = "Session Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "logoutdate", displayField = false, fieldHeader = "Logout Date", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "additionalInfo", displayField = false, fieldHeader = "Additional Info", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 1000 });
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

        public DateTime loginDate
        {
            get
            {
                string fldval = CurrentRow.Fields["logindate"].fieldValue;
                if (string.IsNullOrEmpty(fldval))
                {
                    return DateTime.MinValue;
                }
                else
                {
                    return Convert.ToDateTime(fldval);
                }
            }
            set
            {
                CurrentRow.Fields["logindate"].fieldValue = value.ToString("MM/dd/yyyy HH:mm:ss");
            }
        }

        public string UserName
        {
            get
            {
                return CurrentRow.Fields["username"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["username"].fieldValue = value;
            }
        }

        public Guid sessionguid
        {
            get
            {
                return new Guid(CurrentRow.Fields["sessionguid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["sessionguid"].fieldValue = value.ToString();
            }
        }

        public DateTime logoutdate
        {
            get
            {
                string fldval = CurrentRow.Fields["logoutdate"].fieldValue;
                if (string.IsNullOrEmpty(fldval))
                {
                    return DateTime.MinValue;
                }
                else
                {
                    return Convert.ToDateTime(fldval);
                }
            }
            set
            {
                CurrentRow.Fields["logoutdate"].fieldValue = value.ToString("MM/dd/yyyy HH:mm:ss");
            }
        }

        public string serverip
        {
            get
            {
                return CurrentRow.Fields["serverip"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["serverip"].fieldValue = value;
            }
        }

        public string sourceip
        {
            get
            {
                return CurrentRow.Fields["sourceip"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["sourceip"].fieldValue = value;
            }
        }

        public bool loginvalid
        {
            get
            {
                return CurrentRow.Fields["loginvalid"].fieldValue.Equals("1");
            }
            set
            {
                CurrentRow.Fields["loginvalid"].fieldValue = (value) ? "1" : "0";
            }
        }

        public string additionalInfo
        {
            get
            {
                return CurrentRow.Fields["additionalInfo"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["additionalInfo"].fieldValue = value;
            }
        }
    }
}
