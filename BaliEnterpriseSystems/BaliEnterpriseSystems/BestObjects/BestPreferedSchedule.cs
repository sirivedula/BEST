using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestPreferedSchedule : BestTable
    {
        public BestPreferedSchedule()
        {
            this.TableName = "BestPreferSchedule";
            this.SecurityPage = "Students - Prefered Schedules";

            TableFields.Add(new BestField() 
            { 
                fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 
            });
            
            TableFields.Add(new BestField() 
            { 
                fieldName = "lastChange", displayField = false, fieldHeader = "Last Change", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTime, fieldSize = 20 
            });
            
            TableFields.Add(new BestField() 
            { 
                fieldName = "lastChangeUser", displayField = false, fieldHeader = "Last Change User", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 128 
            });
            
            TableFields.Add(new BestField() 
            { 
                fieldName = "CenterId", displayField = true, fieldHeader = "Center Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 
            });
            
            TableFields.Add(new BestField() 
            { 
                fieldName = "StudentId", displayField = true, fieldHeader = "Student Id", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 50 
            });
            
            TableFields.Add(new BestField() 
            { 
                fieldName = "studentguid", displayField = false, fieldHeader = "StudentGuid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 
            });

            TableFields.Add(new BestField()
            {
                fieldName = "scheduleTime", fieldType = "System.String", paramOledbType=System.Data.OleDb.OleDbType.VarChar,
                fieldHeader = "Time", fieldSize=50, displayField=true
            });

            TableFields.Add(new BestField()
            {
                fieldName="weekDay", fieldHeader="Day", displayField=true, fieldType="System.Int", paramOledbType= System.Data.OleDb.OleDbType.Integer, fieldSize=6
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

        public string weekDay
        {
            get
            {
                return CurrentRow.Fields["weekDay"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["weekDay"].fieldValue = value;
            }
        }

        public string scheduleTime
        {
            get
            {
                return CurrentRow.Fields["scheduleTime"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["scheduleTime"].fieldValue = value;
            }
        }

    }
}
