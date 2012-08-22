using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestMessages : BestTable
    {
        public BestMessages()
        {
            this.TableName = "BestMessages";
            this.SecurityPage = "";

            TableFields.Add(new BestField() 
            { 
                fieldName = "guidfield", 
                displayField = false, 
                fieldHeader = "Guid", 
                fieldType = "System.Guid", 
                paramOledbType = System.Data.OleDb.OleDbType.Guid, 
                fieldSize = 40 
            });

            TableFields.Add(new BestField() 
            { 
                fieldName = "lastChange", 
                displayField = false, 
                fieldHeader = "Last Change", 
                fieldType = "System.DateTime", 
                paramOledbType = System.Data.OleDb.OleDbType.DBTime, 
                fieldSize = 20 
            });
            
            TableFields.Add(new BestField() 
            { 
                fieldName = "lastChangeUser", 
                displayField = false, 
                fieldHeader = "Last Change User", 
                fieldType = "System.String", 
                paramOledbType = System.Data.OleDb.OleDbType.VarChar, 
                fieldSize = 128 
            });

            TableFields.Add(new BestField() 
            {
                fieldName = "parentguid",
                displayField = false,
                fieldHeader = "Guid",
                fieldType = "System.Guid",
                paramOledbType = System.Data.OleDb.OleDbType.Guid,
                fieldSize = 40
            });

            TableFields.Add(new BestField() 
            { 
                fieldName = "messageDate", 
                displayField = true, 
                fieldHeader = "Message Date", 
                fieldType = "System.DateTime", 
                paramOledbType = System.Data.OleDb.OleDbType.DBTime, 
                fieldSize = 23 
            });

            TableFields.Add(new BestField() 
            { 
                fieldName = "messageText", 
                displayField = true, 
                fieldHeader = "Message", 
                fieldType = "System.String", 
                paramOledbType = System.Data.OleDb.OleDbType.VarChar, 
                fieldSize = 5000 
            });

            TableFields.Add(new BestField()
            {
                fieldName = "messageTo",
                displayField = false,
                fieldHeader = "To",
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldSize = 128,
                displayFormatFunc = new Func<BestRow,object>((obj) =>
                    {
                        BestRow pd = (BestRow)obj;
                        BestUser bstuser = new BestUser();
                        bstuser.LoadRows("username=?", "username", pd.Fields["messageTo"].fieldValue, "");
                        return bstuser.firstName + " " + bstuser.lastName;
                    })
            });

            TableFields.Add(new BestField()
            {
                fieldName = "messageFrom",
                displayField = false,
                fieldHeader = "From",
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldSize = 128,
                displayFormatFunc = new Func<BestRow, object>((obj) =>
                {
                    BestRow pd = (BestRow)obj;
                    BestUser bstuser = new BestUser();
                    bstuser.LoadRows("username=?", "username", pd.Fields["messageFrom"].fieldValue, "");
                    return bstuser.firstName + " " + bstuser.lastName;
                })
            });

            TableFields.Add(new BestField()
            {
                fieldName = "centerid",
                displayField = true,
                fieldHeader = "centerid",
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar,
                fieldSize = 50
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

        public string messageText
        {
            get
            {
                return CurrentRow.Fields["messageText"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["messageText"].fieldValue = value;
            }
        }

        public DateTime messageDate
        {
            get
            {
                return Convert.ToDateTime(CurrentRow.Fields["messageDate"].fieldValue);
            }
            set
            {
                CurrentRow.Fields["messageDate"].fieldValue = value.ToString("MM/dd/yyyy HH:mm:ss");
            }
        }

        public Guid? parentGuid
        {
            get
            {
                if (string.IsNullOrEmpty(CurrentRow.Fields["parentGuid"].fieldValue))
                {
                    return new Guid(CurrentRow.Fields["parentGuid"].fieldValue);
                }
                return null;
            }

            set
            {
                CurrentRow.Fields["parentGuid"].fieldValue = value.ToString();
            }
        }

        public String messageTo
        {
            get
            {
                return CurrentRow.Fields["messageTo"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["messageTo"].fieldValue = value;
            }
        }

        public string messageFrom
        {
            get
            {
                return CurrentRow.Fields["messageFrom"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["messageFrom"].fieldValue = value;
            }
        }

        public string CenterId
        {
            get { return CurrentRow.Fields["centerid"].fieldValue; }
            set { CurrentRow.Fields["centerid"].fieldValue = value; }
        }
    }
}
