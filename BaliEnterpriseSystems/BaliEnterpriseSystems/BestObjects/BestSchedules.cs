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
    public class BestSchedules : BestTable
    {

        public BestSchedules()
        {
            this.TableName = "BestSchedules";
            this.SecurityPage = "5.Schedules";

            TableFields.Add(new BestField() { fieldName = "guidfield", fieldHeader = "guid", displayField = false, fieldSize = 40, IsRequired = true, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "lastChange", fieldHeader = "Last Change", displayField = false, fieldSize = 20, IsRequired = true, fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", fieldHeader = "Last Change User", displayField = false, fieldSize = 128, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });

            TableFields.Add(new BestField() { fieldName = "tutGuid", fieldHeader = "Tutor Guid", displayField = false, fieldSize = 40, IsRequired = true, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "stuGuid1", fieldHeader = "Student Guid1", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "stuGuid2", fieldHeader = "Student Guid2", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "stuGuid3", fieldHeader = "Student Guid3", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "stuGuid4", fieldHeader = "Student Guid4", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "stuGuid5", fieldHeader = "Student Guid5", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "schDate", fieldHeader = "Schedule Date", displayField = true, fieldSize = 10, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "SchFrom", fieldHeader = "Schedule From", displayField = true, fieldSize = 4, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "SchTo", fieldHeader = "Schedule To", displayField = true, fieldSize = 4, IsRequired = true, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "isDeleted", fieldHeader = "Deleted ?", displayField = false, fieldSize = 4, IsRequired = false, fieldType = "System.Byte", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "attended1", fieldHeader = "Attended 1", displayField = false, fieldSize = 4, IsRequired = false, fieldType = "System.Int16", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "attended2", fieldHeader = "Attended 2", displayField = false, fieldSize = 4, IsRequired = false, fieldType = "System.Int16", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "attended3", fieldHeader = "Attended 3", displayField = false, fieldSize = 4, IsRequired = false, fieldType = "System.Int16", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "attended4", fieldHeader = "Attended 4", displayField = false, fieldSize = 4, IsRequired = false, fieldType = "System.Int16", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "attended5", fieldHeader = "Attended 5", displayField = false, fieldSize = 4, IsRequired = false, fieldType = "System.Int16", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "note1", fieldHeader = "Note1", displayField = false, fieldSize = 100, IsRequired = false, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "note2", fieldHeader = "Note2", displayField = false, fieldSize = 100, IsRequired = false, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "note3", fieldHeader = "Note3", displayField = false, fieldSize = 100, IsRequired = false, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "note4", fieldHeader = "Note4", displayField = false, fieldSize = 100, IsRequired = false, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "note5", fieldHeader = "Note5", displayField = false, fieldSize = 100, IsRequired = false, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar });
            TableFields.Add(new BestField() { fieldName = "progGuid1", fieldHeader = "Program Guid1", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "progGuid2", fieldHeader = "Program Guid2", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "progGuid3", fieldHeader = "Program Guid3", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "progGuid4", fieldHeader = "Program Guid4", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "progGuid5", fieldHeader = "Program Guid5", displayField = false, fieldSize = 40, IsRequired = false, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid });
            TableFields.Add(new BestField() { fieldName = "tutorattend", fieldHeader = "Tutor Attend", displayField = false, fieldSize = 4, IsRequired = false, fieldType = "System.Int16", paramOledbType = System.Data.OleDb.OleDbType.TinyInt });
            TableFields.Add(new BestField() { fieldName = "amount1", fieldHeader = "Amount1", displayField = false, fieldSize = 18, IsRequired = false, fieldType = "System.Decimal", Precision=18, scale=2, paramOledbType = System.Data.OleDb.OleDbType.Decimal });
            TableFields.Add(new BestField() { fieldName = "amount2", fieldHeader = "Amount2", displayField = false, fieldSize = 18, IsRequired = false, fieldType = "System.Decimal", Precision = 18, scale = 2, paramOledbType = System.Data.OleDb.OleDbType.Decimal });
            TableFields.Add(new BestField() { fieldName = "amount3", fieldHeader = "Amount3", displayField = false, fieldSize = 18, IsRequired = false, fieldType = "System.Decimal", Precision = 18, scale = 2, paramOledbType = System.Data.OleDb.OleDbType.Decimal });
            TableFields.Add(new BestField() { fieldName = "amount4", fieldHeader = "Amount4", displayField = false, fieldSize = 18, IsRequired = false, fieldType = "System.Decimal", Precision = 18, scale = 2, paramOledbType = System.Data.OleDb.OleDbType.Decimal });
            TableFields.Add(new BestField() { fieldName = "amount5", fieldHeader = "Amount5", displayField = false, fieldSize = 18, IsRequired = false, fieldType = "System.Decimal", Precision = 18, scale = 2, paramOledbType = System.Data.OleDb.OleDbType.Decimal });

            TableFields.Add(new BestField()
            {
                fieldName = "CenterId",
                fieldType = "System.String",
                fieldSize = 50,
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldHeader="Center Id",
                Precision = 50,
                scale = 0
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

        public Guid tutGuid
        {
            get
            {
                return new Guid(CurrentRow.Fields["tutGuid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["tutGuid"].fieldValue = value.ToString();
            }
        }

        public Guid stuGuid1
        {
            get
            {
                return new Guid(CurrentRow.Fields["stuGuid1"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["stuGuid1"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["stuGuid1"].fieldValue = null;
                }
            }
        }

        public Guid? stuGuid2
        {
            get
            {
                return new Guid(CurrentRow.Fields["stuGuid2"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["stuGuid2"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["stuGuid2"].fieldValue = null;
                }
            }
        }

        public Guid? stuGuid3
        {
            get
            {
                return new Guid(CurrentRow.Fields["stuGuid3"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["stuGuid3"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["stuGuid3"].fieldValue = null;
                }
            }
        }

        public Guid? stuGuid4
        {
            get
            {
                return new Guid(CurrentRow.Fields["stuGuid4"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["stuGuid4"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["stuGuid4"].fieldValue = null;
                }
            }
        }

        public Guid? stuGuid5
        {
            get
            {
                return new Guid(CurrentRow.Fields["stuGuid5"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["stuGuid5"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["stuGuid5"].fieldValue = null;
                }
            }
        }
        
        public string schDate
        {
            get
            {
                return CurrentRow.Fields["schDate"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["schDate"].fieldValue = value;
            }
        }

        public string schFrom
        {
            get
            {
                return CurrentRow.Fields["schFrom"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["schFrom"].fieldValue = value;
            }
        }

        public string schTo
        {
            get
            {
                return CurrentRow.Fields["schTo"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["schTo"].fieldValue = value;
            }
        }

        public string isDeleted
        {
            get
            {
                return CurrentRow.Fields["isDeleted"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["isDeleted"].fieldValue = value;
            }
        }

        public string attended1
        {
            get
            {
                return CurrentRow.Fields["attended1"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["attended1"].fieldValue = value;
            }
        }

        public string attended2
        {
            get
            {
                return CurrentRow.Fields["attended2"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["attended2"].fieldValue = value;
            }
        }

        public string attended3
        {
            get
            {
                return CurrentRow.Fields["attended3"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["attended3"].fieldValue = value;
            }
        }

        public string attended4
        {
            get
            {
                return CurrentRow.Fields["attended4"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["attended4"].fieldValue = value;
            }
        }

        public string attended5
        {
            get
            {
                return CurrentRow.Fields["attended5"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["attended5"].fieldValue = value;
            }
        }

        public string tutorattend
        {
            get
            {
                return CurrentRow.Fields["tutorattend"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["tutorattend"].fieldValue = value;
            }
        }
        public string note1
        {
            get
            {
                return CurrentRow.Fields["note1"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["note1"].fieldValue = value;
            }
        }

        public string note2
        {
            get
            {
                return CurrentRow.Fields["note2"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["note2"].fieldValue = value;
            }
        }

        public string note3
        {
            get
            {
                return CurrentRow.Fields["note3"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["note3"].fieldValue = value;
            }
        }

        public string note4
        {
            get
            {
                return CurrentRow.Fields["note4"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["note4"].fieldValue = value;
            }
        }

        public string note5
        {
            get
            {
                return CurrentRow.Fields["note5"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["note5"].fieldValue = value;
            }
        }

        public Guid? progGuid1
        {
            get
            {
                return new Guid(CurrentRow.Fields["progGuid1"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["progGuid1"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["progGuid1"].fieldValue = null;
                }
            }
        }

        public Guid? progGuid2
        {
            get
            {
                return new Guid(CurrentRow.Fields["progGuid2"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["progGuid2"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["progGuid2"].fieldValue = null;
                }
            }
        }

        public Guid? progGuid3
        {
            get
            {
                return new Guid(CurrentRow.Fields["progGuid3"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["progGuid3"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["progGuid3"].fieldValue = null;
                }
            }
        }

        public Guid? progGuid4
        {
            get
            {
                return new Guid(CurrentRow.Fields["progGuid4"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["progGuid4"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["progGuid4"].fieldValue = null;
                }
            }
        }

        public Guid? progGuid5
        {
            get
            {
                return new Guid(CurrentRow.Fields["progGuid5"].fieldValue);
            }

            set
            {
                if (value != null)
                {
                    CurrentRow.Fields["progGuid5"].fieldValue = value.ToString();
                }
                else
                {
                    CurrentRow.Fields["progGuid5"].fieldValue = null;
                }
            }
        }

        public Decimal Amount1
        {
            get
            {
                if(!string.IsNullOrEmpty(CurrentRow.Fields["Amount1"].fieldValue))
                {
                    return Convert.ToDecimal(CurrentRow.Fields["Amount1"].fieldValue);
                }
                return 0;
            }

            set
            {
                CurrentRow.Fields["Amount1"].fieldValue = value.ToString();
            }
        }

        public Decimal Amount2
        {
            get
            {
                if (!string.IsNullOrEmpty(CurrentRow.Fields["Amount2"].fieldValue))
                {
                    return Convert.ToDecimal(CurrentRow.Fields["Amount2"].fieldValue);
                }
                return 0;
            }

            set
            {
                CurrentRow.Fields["Amount2"].fieldValue = value.ToString();
            }
        }
        public Decimal Amount3
        {
            get
            {
                if (!string.IsNullOrEmpty(CurrentRow.Fields["Amount3"].fieldValue))
                {
                    return Convert.ToDecimal(CurrentRow.Fields["Amount3"].fieldValue);
                }
                return 0;
            }

            set
            {
                CurrentRow.Fields["Amount3"].fieldValue = value.ToString();
            }
        }

        public Decimal Amount4
        {
            get
            {
                if (!string.IsNullOrEmpty(CurrentRow.Fields["Amount4"].fieldValue))
                {
                    return Convert.ToDecimal(CurrentRow.Fields["Amount4"].fieldValue);
                }
                return 0;
            }

            set
            {
                CurrentRow.Fields["Amount4"].fieldValue = value.ToString();
            }
        }

        public Decimal Amount5
        {
            get
            {
                if (!string.IsNullOrEmpty(CurrentRow.Fields["Amount5"].fieldValue))
                {
                    return Convert.ToDecimal(CurrentRow.Fields["Amount5"].fieldValue);
                }
                return 0;
            }

            set
            {
                CurrentRow.Fields["Amount5"].fieldValue = value.ToString();
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
