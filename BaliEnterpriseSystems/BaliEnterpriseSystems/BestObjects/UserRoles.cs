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
    public class UserRoles : BestTable
    {
        public UserRoles()
        {
            this.TableName = "BestUserRoles";
            this.overrideEdit = true;
            this.overrideAdd = true;
            this.overrideDelete = true;

            TableFields.Add(new BestField() { fieldName = "Service", fieldHeader = "Service Name", displayField = true, fieldSize = 128, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "userName", fieldHeader = "User Name", displayField = true, fieldSize = 128, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "allowView", fieldHeader = "Allow View", displayField = true, fieldSize = 6, IsRequired = true, fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "allowAdd", fieldHeader = "Allow Add", displayField = true, fieldSize = 6, IsRequired = true, fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "allowEdit", fieldHeader = "Allow Edit", displayField = true, fieldSize = 6, IsRequired = true, fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "allowDelete", fieldHeader = "Allow Delete", displayField = true, fieldSize = 6, IsRequired = true, fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });

            TableFields.Add(new BestField() { fieldName = "guidfield", fieldHeader = "guid", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "lastChange", fieldHeader = "Last Change", displayField = false, fieldSize = 20, IsRequired = false, fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", fieldHeader = "Last Change User", displayField = false, fieldSize = 128, IsRequired = false, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });	

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

        public string Service
        {
            get
            {
                return CurrentRow.Fields["Service"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["Service"].fieldValue = value;
            }
        }

        public string allowView
        {
            get
            {
                return CurrentRow.Fields["allowView"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["allowView"].fieldValue = value;
            }
        }

        public string AllowAdd
        {
            get
            {
                return CurrentRow.Fields["allowAdd"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["allowAdd"].fieldValue = value;
            }
        }

        public string AllowEdit
        {
            get
            {
                return CurrentRow.Fields["allowEdit"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["allowEdit"].fieldValue = value;
            }
        }

        public string AllowDelete
        {
            get
            {
                return CurrentRow.Fields["allowDelete"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["allowDelete"].fieldValue = value;
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
    }
}
