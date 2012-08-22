using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestDocuments : BestTable 
    {
        public BestDocuments()
        {
            this.TableName = "BestDocuments";
            this.SecurityPage = "Student - Documents";
            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });
            TableFields.Add(new BestField() 
            { 
                fieldName = "CenterId", 
                displayField = true, 
                fieldHeader = "Center Id", 
                fieldType = "System.String", 
                paramOledbType = System.Data.OleDb.OleDbType.VarChar, 
                fieldSize = 50 
            });
            TableFields.Add(new BestField() 
            { 
                fieldName = "StudentId", 
                displayField = true, 
                fieldHeader = "Student Id", 
                fieldType = "System.String", 
                paramOledbType = System.Data.OleDb.OleDbType.VarChar, 
                fieldSize = 50 
            });

            TableFields.Add(new BestField()
            {
                fieldName = "studentGuid",
                displayField = true,
                fieldHeader = "Student Name",
                fieldType = "System.Guid",
                paramOledbType = System.Data.OleDb.OleDbType.Guid,
                fieldSize = 40,
                displayFormatFunc = new Func<BestRow, object>((obj) =>
                {
                    BestRow bstd = (BestRow)obj;
                    List<BestField> bparams = new List<BestField>();
                    BestField guid = new BestField() { fieldName = "studentGuid", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                    guid.fieldValue = bstd.Fields["studentGuid"].fieldValue;
                    bparams.Add(guid);
                    BestStudents bpstd = new BestStudents();
                    bpstd.LoadRows("guidfield=?", bparams);
                    return bpstd.firstName + " " + bpstd.lastName;
                })
            });

            TableFields.Add(new BestField() 
            { 
                fieldName = "documentFile", 
                displayField = false, 
                fieldHeader = "documentFile",
                fieldType = "System.byte[]", 
                paramOledbType = System.Data.OleDb.OleDbType.LongVarBinary,
                fieldSize = -1 
            });
            TableFields.Add(new BestField() 
            { 
                fieldName = "documentFileSize", 
                displayField = false, 
                fieldHeader = "Document Size", 
                fieldType = "System.Decimal",
                paramOledbType = System.Data.OleDb.OleDbType.Decimal, 
                fieldSize = 18, Precision=18, scale=0 
            });
            TableFields.Add(new BestField() 
            { 
                fieldName = "documentTitle", 
                displayField = true, 
                fieldHeader = "Document Title",
                fieldType = "System.String", 
                paramOledbType = System.Data.OleDb.OleDbType.VarChar, 
                fieldSize = 50 
            });
            TableFields.Add(new BestField() 
            { 
                fieldName = "documentFileName", 
                displayField = true, 
                fieldHeader = "File Name", 
                fieldType = "System.String", 
                paramOledbType = System.Data.OleDb.OleDbType.VarChar, 
                fieldSize = 100 
            });
            TableFields.Add(new BestField()
            {
                fieldName = "documentDate",
                fieldHeader = "Doc Date",
                displayField = true,
                fieldType = "System.DateTime",
                paramOledbType = System.Data.OleDb.OleDbType.DBDate,
                fieldSize = 10,
                displayFormatFunc = new Func<BestRow,object>( (obj) => { DateTime dd = Convert.ToDateTime(obj.Fields["documentDate"].fieldValue); return dd.ToString("MM/dd/yyyy"); })
            });
            TableFields.Add(new BestField()
            {
                fieldName = "documentExpiry",
                fieldHeader = "Doc Expiry",
                displayField = true,
                fieldType = "System.DateTime",
                paramOledbType = System.Data.OleDb.OleDbType.DBDate,
                fieldSize = 10,
                displayFormatFunc = new Func<BestRow, object>((obj) => { DateTime dd = Convert.ToDateTime(obj.Fields["documentExpiry"].fieldValue); return dd.ToString("MM/dd/yyyy"); })
            });
            TableFields.Add(new BestField()
            {
                fieldSize = 1,
                fieldName = "showToStudent",
                fieldType = "System.Boolean",
                paramOledbType = System.Data.OleDb.OleDbType.Boolean,
                fieldHeader = "Show To Student",
                displayField = true
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
                return new Guid(CurrentRow.Fields["studentGuid"].fieldValue);
            }

            set
            {
                CurrentRow.Fields["studentGuid"].fieldValue = value.ToString();
            }
        }

        public DateTime documentDate
        {
            get
            {
                return Convert.ToDateTime(CurrentRow.Fields["documentDate"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["documentDate"].fieldValue = value.ToString("MM/dd/yyyy");
            }
        }

        public DateTime documentExpiry
        {
            get
            {
                return Convert.ToDateTime(CurrentRow.Fields["documentExpiry"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["documentExpiry"].fieldValue = value.ToString("MM/dd/yyyy");
            }
        }

        public string documentTitle
        {
            get
            {
                return CurrentRow.Fields["documentTitle"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["documentTitle"].fieldValue = value;
            }
        }

        private byte[] _documentFile;
        public byte[] documentFile
        {
            get { return _documentFile; }
            set
            {
                _documentFile = value;
            }
        }

        public string documentFileSize
        {
            get
            {
                return CurrentRow.Fields["documentFileSize"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["documentFileSize"].fieldValue = value;
            }
        }

        public string documentFileName
        {
            get
            {
                return CurrentRow.Fields["documentFileName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["documentFileName"].fieldValue = value;
            }
        }

        public bool showToStudent
        {
            get
            {
                return CurrentRow.Fields["showToStudent"].fieldValue.Equals("1");
            }
            set
            {
                CurrentRow.Fields["showToStudent"].fieldValue = (value) ? "1" : "0";
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
    }
}
