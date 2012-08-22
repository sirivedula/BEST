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
    public class BestStudentReference : BestTable
    {
        public BestStudentReference()
        {
            this.TableName = "BestStudentReference";
            this.SecurityPage = "Student - Information";

            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "StudentId", displayField = true, fieldHeader = "Student Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "studentguid", displayField = false, fieldHeader = "StudentGuid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });

            //referencedby, expectedDuration, blcRecommend, proposedProg, proposedHour, parentComments, parentExpects, emergName, emergPhone
            TableFields.Add(new BestField() { fieldName = "referencedby", displayField = true, fieldHeader = "referencedby", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 100 });
            TableFields.Add(new BestField() { fieldName = "expectedDuration", displayField = true, fieldHeader = "expectedDuration", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "blcRecommend", displayField = true, fieldHeader = "blcRecommend", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "proposedProg", displayField = true, fieldHeader = "proposedProg", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "proposedHour", displayField = true, fieldHeader = "proposedHour", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "parentComments", displayField = true, fieldHeader = "parentComments", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "parentExpects", displayField = true, fieldHeader = "parentExpects", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "emergName", displayField = true, fieldHeader = "emergName", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "emergPhone", displayField = true, fieldHeader = "emergPhone", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField()
            {
                fieldHeader = "Health Conditions",
                fieldName="healthConditions",
                displayField=false,
                fieldSize = 500,
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar
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

        //referencedby, expectedDuration, blcRecommend, proposedProg, proposedHour, parentComments, parentExpects, emergName, emergPhone

        public string referencedby
        {
            get
            {
                return CurrentRow.Fields["referencedby"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["referencedby"].fieldValue = value;
            }
        }

        public string expectedDuration
        {
            get
            {
                return CurrentRow.Fields["expectedDuration"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["expectedDuration"].fieldValue = value;
            }
        }

        public string blcRecommend
        {
            get
            {
                return CurrentRow.Fields["blcRecommend"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["blcRecommend"].fieldValue = value;
            }
        }

        public string proposedProg
        {
            get
            {
                return CurrentRow.Fields["proposedProg"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["proposedProg"].fieldValue = value;
            }
        }

        public string proposedHour
        {
            get
            {
                return CurrentRow.Fields["proposedHour"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["proposedHour"].fieldValue = value;
            }
        }

        public string parentComments
        {
            get
            {
                return CurrentRow.Fields["parentComments"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["parentComments"].fieldValue = value;
            }
        }

        public string parentExpects
        {
            get
            {
                return CurrentRow.Fields["parentExpects"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["parentExpects"].fieldValue = value;
            }
        }

        public string emergName
        {
            get
            {
                return CurrentRow.Fields["emergName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["emergName"].fieldValue = value;
            }
        }

        public string emergPhone
        {
            get
            {
                return CurrentRow.Fields["emergPhone"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["emergPhone"].fieldValue = value;
            }
        }

        public string healthConditions
        {
            get
            {
                return CurrentRow.Fields["healthConditions"].fieldValue;
            }
            set
            {
                CurrentRow.Fields["healthConditions"].fieldValue = value;
            }
        }

    }
}
