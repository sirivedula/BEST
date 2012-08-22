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
using System.Data.OleDb;
using System.Collections.Generic;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestField
    {
        private Func<BestRow, object> _formatFunc;

        public string fieldHeader
        {
            get;
            set;
        }

        public bool displayField
        {
            get;
            set;
        }

        public bool calcField
        {
            get;
            set;
        }

        public Func<BestRow, object> displayFormatFunc
        {
            get
            {
                return _formatFunc;
            }
            set
            {
                _formatFunc = value;
            }
        }

        public string fieldName
        {
            get;
            set;
        }

        public string fieldType
        {
            get;
            set;
        }

        public int fieldSize
        {
            get;
            set;
        }
        public byte Precision
        {
            get;
            set;
        }

        public byte scale
        {
            get;
            set;
        }

        public string fieldValue
        {
            get;
            set;
        }

        public string OldValue
        {
            get;
            set;
        }

        public bool IsRequired
        {
            get;
            set;
        }

        public bool hasChange
        {
            get
            {
                if (this.fieldValue != null)
                {
                    return !this.fieldValue.Equals(this.OldValue, StringComparison.InvariantCultureIgnoreCase);
                }
                else
                {
                    return (this.OldValue != null && this.fieldValue == null);
                }
            }
        }

        public bool IsPrimaryKey
        {
            get;
            set;
        }

        public OleDbType paramOledbType
        {
            get;
            set;
        }

        public OleDbParameter Param
        {
            get
            {
                object oledbvalue = null;
                if (this.fieldValue != null)
                {
                    oledbvalue = Utils.ToType(this.fieldValue, Type.GetType(this.fieldType));
                }
                OleDbParameter _param = new OleDbParameter(this.fieldName, this.paramOledbType, this.fieldSize, ParameterDirection.Input, this.IsRequired, this.Precision, this.scale, this.fieldName, DataRowVersion.Current, oledbvalue);

                return _param;
            }
        }

        public BestField Clone()
        {
            BestField bfld = (BestField)this.MemberwiseClone();

            return bfld;
        }
    }


    /* Best Fields Object */
    public class BestFields
    {
        private List<BestField> _fields = new List<BestField>();

        public BestField this[int i]
        {
            get
            {
                return _fields[i];
            }
        }

        public BestField this[string name]
        {
            get
            {
                BestField fld = new BestField();
                foreach (BestField field in _fields)
                {
                    if (field.fieldName.Equals(name, StringComparison.InvariantCultureIgnoreCase))
                    {
                        fld = field;
                        break;
                    }
                }
                return fld;
            }
        }

        public void Add(BestField field)
        {
            _fields.Add(field);
        }

        public void Clear()
        {
            _fields.Clear();
        }

        public int Count
        {
            get
            {
                return _fields.Count;
            }
        }
    }
}
