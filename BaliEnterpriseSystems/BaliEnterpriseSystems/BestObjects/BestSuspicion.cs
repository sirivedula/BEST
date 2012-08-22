using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.OleDb;
using System.Data;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestSuspicion : BestTable
    {
        public BestSuspicion()
        {
            this.TableName = "BestSuspicion";
            this.overrideAdd = true;
            this.overrideDelete = true;
            this.overrideEdit = true;

            TableFields.Add(new BestField() { fieldName = "guidfield", displayField = false, fieldHeader = "Guid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 });
            TableFields.Add(new BestField() { fieldName = "target", displayField = false, fieldHeader = "Target", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 200 });
            TableFields.Add(new BestField() { fieldName = "score", displayField = false, fieldHeader = "Score", fieldType = "System.Int32", paramOledbType = System.Data.OleDb.OleDbType.Integer, fieldSize = 10 });
            TableFields.Add(new BestField() { fieldName = "logdate", displayField = false, fieldHeader = "Log Date", fieldType = "System.DateTime", paramOledbType = System.Data.OleDb.OleDbType.DBTimeStamp, fieldSize = 20 });
            TableFields.Add(new BestField() { fieldName = "reasoncode", displayField = false, fieldHeader = "Reason Code", fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar, fieldSize = 20 });
            
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

        public DateTime logdate
        {
            get
            {
                string fldval = CurrentRow.Fields["lastChange"].fieldValue;
                if (!string.IsNullOrEmpty(fldval))
                {
                    return Convert.ToDateTime(fldval);
                }
                else
                {
                    return DateTime.MinValue;
                }
            }
            set
            {
                CurrentRow.Fields["lastChange"].fieldValue = value.ToString("MM/dd/yyyy HH:mm:ss");
            }
        }

        public string target
        {
            get
            {
                return CurrentRow.Fields["target"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["target"].fieldValue = value;
            }
        }

        public string reasoncode
        {
            get
            {
                return CurrentRow.Fields["reasoncode"].fieldValue;
            }

            set
            {
                CurrentRow.Fields["reasoncode"].fieldValue = value;
            }
        }

        public Int32 score
        {
            get
            {
                int result;
                Int32.TryParse(CurrentRow.Fields["score"].fieldValue, out result);
                return result;
            }

            set
            {
                CurrentRow.Fields["score"].fieldValue = value.ToString();
            }
        }

        public Int32 GetScore(string target)
        {
            OleDbCommand myCmd = this.dbCmd;
            myCmd.CommandText = "Best_SuspectScore";
            myCmd.CommandType = System.Data.CommandType.StoredProcedure;

            OleDbParameter myparam = new OleDbParameter("@target", OleDbType.VarChar, 200, ParameterDirection.Input, false, 0, 0, "@target", DataRowVersion.Current, target);
            myCmd.Parameters.Add(myparam);
            OleDbDataReader oread = myCmd.ExecuteReader(CommandBehavior.SingleResult);
            myCmd.Parameters.Clear();
            oread.Read();
            Int32 sc = (Int32)oread[0];
            oread.Close();
            Random r = new Random((int)DateTime.Now.Ticks);
            if (r.Next(1, 5000) == 30)
            {
                ClearOld(DateTime.Now.AddDays(-16));
            }
            return sc;            
        }

        public void ClearOld(DateTime clearAllBefore)
        {
            OleDbCommand myCmd = this.dbCmd;
            myCmd.CommandText = "Delete from HRSuspicion where logdate < ?";
            OleDbParameter p1 = new OleDbParameter("logdate", OleDbType.DBTimeStamp, 20);
            p1.Value = clearAllBefore;
            myCmd.Parameters.Add(p1);
            myCmd.ExecuteNonQuery();
            myCmd.Parameters.Clear();
        }

    }
}
