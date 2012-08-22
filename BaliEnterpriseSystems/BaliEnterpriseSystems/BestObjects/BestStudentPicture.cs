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
    public class BestStudentPicture : BestTable
    {
        public BestStudentPicture()
        {
            this.TableName = "BestStudentPicture";
            this.SecurityPage = "Student - Information";

            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 });
            TableFields.Add(new BestField() { fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField() { fieldName = "StudentId", displayField = true, fieldHeader = "Student Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
            TableFields.Add(new BestField()
            {
                fieldName = "studentGuid",
                fieldHeader = "Student Name",
                displayField = true,
                fieldSize = 128,
                IsRequired = true,
                fieldType = "System.Guid",
                paramOledbType = System.Data.OleDb.OleDbType.Guid,
                displayFormatFunc = new Func<BestRow, object>((obj) =>
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

            TableFields.Add(new BestField() { fieldName = "picture", displayField = false, fieldHeader = "Photo", fieldType = "System.byte[]", paramOledbType = System.Data.OleDb.OleDbType.LongVarBinary, fieldSize = -1 });
            TableFields.Add(new BestField() { fieldName = "photoSize", displayField = false, fieldHeader = "Photo Size", fieldType = "System.Decimal", paramOledbType = System.Data.OleDb.OleDbType.Decimal, fieldSize = 18 });
            TableFields.Add(new BestField() { fieldName = "photoName", displayField = true, fieldHeader = "Photo Name", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 200 });
            //hobbies,personality,goals,learningstyle,tutorpreference,
            TableFields.Add(new BestField() { fieldName = "hobbies", displayField = false, fieldHeader = "Hobbies", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "personality", displayField = false, fieldHeader = "Personality", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "goals", displayField = false, fieldHeader = "Goals", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "learningstyle", displayField = false, fieldHeader = "Learning Style", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 500 });
            TableFields.Add(new BestField() { fieldName = "tutorpreference", displayField = false, fieldHeader = "Tutor Preference", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 });
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

        private byte[] _picture;
        public byte[] picture
        {
            get { return _picture; }
            set
            {
                _picture = value;
            }
        }

        public string photoSize
        {
            get
            {
                return CurrentRow.Fields["photoSize"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["photoSize"].fieldValue = value;
            }
        }
        public string photoName
        {
            get
            {
                return CurrentRow.Fields["photoName"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["photoName"].fieldValue = value;
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
        //hobbies,personality,goals,learningstyle,tutorpreference,

        public string hobbies
        {
            get
            {
                return CurrentRow.Fields["hobbies"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["hobbies"].fieldValue = value;
            }
        }

        public string personality
        {
            get
            {
                return CurrentRow.Fields["personality"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["personality"].fieldValue = value;
            }
        }

        public string goals
        {
            get
            {
                return CurrentRow.Fields["goals"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["goals"].fieldValue = value;
            }
        }

        public string learningstyle
        {
            get
            {
                return CurrentRow.Fields["learningstyle"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["learningstyle"].fieldValue = value;
            }
        }

        public string tutorpreference
        {
            get
            {
                return CurrentRow.Fields["tutorpreference"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["tutorpreference"].fieldValue = value;
            }
        }
    }
}
