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
    public class BestCenters : BestTable
    {

        public BestCenters()
        {
            this.TableName = "BestCenters";
            this.SecurityPage = "Setup - Center Information";
            TableFields.Add(new BestField(){ fieldName="guidfield", displayField=false, fieldHeader="Guid", fieldType="System.Guid", paramOledbType= System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField(){ fieldName="lastChange", displayField=false, fieldHeader="Last Change", fieldType="System.DateTime", paramOledbType= System.Data.OleDb.OleDbType.DBTime, fieldSize=20 });
            TableFields.Add(new BestField(){ fieldName="lastChangeUser", displayField=false, fieldHeader="Last Change User", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=128});
            TableFields.Add(new BestField(){ fieldName="CenterId", displayField=true, fieldHeader="Center Id", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField(){ fieldName="address1", displayField=true, fieldHeader="Address 1", fieldType="System.String", paramOledbType= System.Data.OleDb.OleDbType.VarChar, fieldSize=50});
            TableFields.Add(new BestField() { fieldName = "address2", displayField = true, fieldHeader = "Address 2", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "city", displayField = true, fieldHeader = "City", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "state", displayField = true, fieldHeader = "State", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 2 });
            TableFields.Add(new BestField() { fieldName = "zip", displayField = true, fieldHeader = "Zip", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
            TableFields.Add(new BestField() { fieldName = "contactName", displayField = true, fieldHeader = "Contact Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "contactEMail", displayField = true, fieldHeader = "Contact EMail", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 80 });
            TableFields.Add(new BestField() { fieldName = "contactPhone", displayField = true, fieldHeader = "Contact Phone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 15 });
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

        public string address1
        {
            get
            {
                return CurrentRow.Fields["address1"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["address1"].fieldValue = value;
            }
        }

        public string address2
        {
            get
            {
                return CurrentRow.Fields["address2"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["address2"].fieldValue = value;
            }
        }

        public string city
        {
            get
            {
                return CurrentRow.Fields["city"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["city"].fieldValue = value;
            }
        }

        public string state
        {
            get
            {
                return CurrentRow.Fields["state"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["state"].fieldValue = value;
            }
        }

        public string zip
        {
            get
            {
                return CurrentRow.Fields["zip"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["zip"].fieldValue = value;
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

        public string contactEMail
        {
            get
            {
                return CurrentRow.Fields["contactEMail"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["contactEMail"].fieldValue = value;
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

    }
}
