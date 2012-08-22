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
using System.Collections.Generic;

namespace BaliEnterpriseSystems.BestObjects
{
    public class PaymentDetails : BestTable
    {
        public PaymentDetails()
        {
            this.TableName = "BestPaymentDetails";
            this.SecurityPage = "Payment - Details";

            TableFields.Add(new BestField() { fieldName = "paymentTypeGuid", fieldHeader = "Program Type", displayField = true, fieldSize = 128, IsRequired = true, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid,
                      displayFormatFunc = new Func<BestRow, object>((obj) =>
                      {
                          BestRow pd = (BestRow)obj;
                          List<BestField> bparams = new List<BestField>();
                          BestField guid = new BestField() { fieldName = "paymentTypeGuid", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                          guid.fieldValue = pd.Fields["paymentTypeGuid"].fieldValue;
                          bparams.Add(guid);
                          PaymentTypes bptype = new PaymentTypes();
                          bptype.LoadRows("guidfield=?", bparams);
                          return bptype.paymentType;
                      })
            });

            TableFields.Add(new BestField() { fieldName = "studentGuid", fieldHeader = "Student", displayField = true, fieldSize = 128, IsRequired = true, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, 
                displayFormatFunc = new Func<BestRow,object>((obj)=>
                    {
                        BestRow pd = (BestRow)obj;
                        List<BestField> bparams = new List<BestField>();
                        BestField guid = new BestField() { fieldName = "studentGuid", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                        guid.fieldValue = pd.Fields["studentGuid"].fieldValue;
                        bparams.Add(guid);
                        BestStudents bpstd = new BestStudents();
                        bpstd.LoadRows("guidfield=?", bparams);
                        return bpstd.firstName + " " + bpstd.lastName;
                    })
            });

            TableFields.Add(new BestField() { fieldName = "amount", fieldHeader = "Amount", displayField = true, fieldSize = 18, IsRequired = false, fieldType = "System.Decimal", paramOledbType = System.Data.OleDb.OleDbType.Decimal });
            TableFields.Add(new BestField() { fieldName = "paymentDate", fieldHeader = "Payment Date", displayField = true, fieldSize = 10, IsRequired = false, fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp,
           displayFormatFunc = new Func<BestRow,object>((obj)=>
                {
                    BestRow br = (BestRow) obj;
                    DateTime dt = Convert.ToDateTime(br.Fields["paymentDate"].fieldValue);
                    return dt.ToString("MM/dd/yyyy");
                })
            });

            TableFields.Add(new BestField() { fieldName = "guidfield", fieldHeader = "guid", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "lastChange", fieldHeader = "Last Change", displayField = false, fieldSize = 20, IsRequired = false, fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", fieldHeader = "Last Change User", displayField = false, fieldSize = 128, IsRequired = false, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "hours", fieldHeader = "Hours", displayField = true, fieldSize = 18, IsRequired = false, fieldType = "System.Decimal", paramOledbType = System.Data.OleDb.OleDbType.Decimal, Precision = 18, scale = 2 });
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
        }

        public Guid paymentTypeGuid
        {
            get
            {
                return new Guid(CurrentRow.Fields["paymentTypeGuid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["paymentTypeGuid"].fieldValue = value.ToString();
            }
        }

        public Guid studentGuid
        {
            get
            {
                return new Guid(CurrentRow.Fields["studentGuid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["studentGuid"].fieldValue = value.ToString();
            }
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

        public DateTime paymentDate
        {
            get
            {
                return Convert.ToDateTime(CurrentRow.Fields["paymentDate"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["paymentDate"].fieldValue = value.ToString("MM/dd/yyyy");
            }
        }

        public string amount
        {
            get
            {
                return CurrentRow.Fields["amount"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["amount"].fieldValue = value;
            }
        }

        public Decimal hours
        {
            get
            {
                return Convert.ToDecimal(CurrentRow.Fields["hours"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["hours"].fieldValue = value.ToString();
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
