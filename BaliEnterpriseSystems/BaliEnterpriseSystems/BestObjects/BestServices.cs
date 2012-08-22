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
    public class BestServices : BestTable
    {
        public BestServices()
        {
            this.TableName = "BestServices";
            this.SecurityPage = "Setup - Services";

            TableFields.Add(new BestField() { fieldName = "Service", fieldHeader = "Service Name", displayField=true, fieldSize=128, IsRequired=true, fieldType="System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "CenterId", fieldHeader = "Center ID", displayField = false, fieldSize = 128, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
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
