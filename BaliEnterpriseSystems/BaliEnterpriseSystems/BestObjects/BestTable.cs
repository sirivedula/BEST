using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestTable : BestDatabase
    {
        private BestFields _fields = new BestFields();
        private BestRows _rows = new BestRows();

        public BestTable()
        {
            this.currentRowId = 0;
        }

        public string SecurityPage
        {
            get;
            set;
        }

        public string TableName
        {
            get;
            set;
        }

        public BestFields TableFields
        {
            get { return _fields; }
            set { _fields = value; }
        }        

        public BestRows TableRows
        {
            get
            {
                return _rows;
            }
        }

        public bool HasRows
        {
            get
            {
                return (TableRows.Count > 0);
            }
        }

        private BestRow NewRow()
        {
            BestRow brow = new BestRow();
            brow.bestTable = this;
            brow.IsNew = true;
            brow.Fields = CopyFields();
            return brow;
        }

        private BestFields CopyFields()
        {
            BestFields bfields = new BestFields();
            for (int i = 0; i < TableFields.Count; i++)
            {
                bfields.Add(TableFields[i].Clone());
            }
            return bfields;
        }

        public int currentRowId
        {
            get;
            set;
        }

        public BestRow CurrentRow
        {
            get
            {
                if (! HasRows)
                {
                    TableRows.Add(NewRow());
                }
                return TableRows[currentRowId];
            }
        }

        private void ConstructRow(BestRow brow, OleDbDataReader objDataReader)
        {
            brow.IsNew = false;
            for (int i = 0; i < brow.Fields.Count; i++ )
            {
                if (brow.Fields[i].fieldType.Equals("System.Byte"))
                {
                    brow.Fields[i].fieldValue = objDataReader[brow.Fields[i].fieldName].ToString().Equals("True")?"1":"0";
                    brow.Fields[i].OldValue = brow.Fields[i].fieldValue;
                }
                else
                {
                    brow.Fields[i].fieldValue = objDataReader[brow.Fields[i].fieldName].ToString();
                    brow.Fields[i].OldValue = brow.Fields[i].fieldValue;
                }
            }
        }

        private string fieldCSV
        {
            get
            {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < TableFields.Count; i++)
                {
                    sb.Append(TableFields[i].fieldName);
                    if (i < TableFields.Count - 1) sb.Append(",");
                }
                return sb.ToString();
            }
        }

        public void LoadRows(string orderby)
        {
            OleDbCommand myCmd = this.dbCmd;
            string sql = "select " + fieldCSV + " from " + this.TableName;
            if (! string.IsNullOrEmpty(orderby))
            {
                sql += " order by " + orderby.Replace("'","''");
            }
            myCmd.CommandText = sql;

            OleDbDataReader tblReader = myCmd.ExecuteReader();
            while (tblReader.Read())
            {
                BestRow tempRow = NewRow();
                this.ConstructRow(tempRow, tblReader);
                this.TableRows.Add(tempRow);
            }
            tblReader.Close();
        }

        public void LoadRows()
        {
            OleDbCommand myCmd = this.dbCmd;
            myCmd.CommandText = "select " + fieldCSV + " from " + this.TableName;
            OleDbDataReader tblReader = myCmd.ExecuteReader();
            while (tblReader.Read())
            {
                BestRow tempRow = NewRow();
                this.ConstructRow(tempRow, tblReader);
                this.TableRows.Add(tempRow);
            }
            tblReader.Close();
        }

        public void LoadRows(string whereclause, List<BestField> cmdParams, string orderby)
        {
            OleDbCommand myCmd = this.dbCmd;
            string sql = "select " + fieldCSV + " from " + this.TableName + " where " + whereclause;
            if(!string.IsNullOrEmpty(orderby))
            {
                sql += " order by " + orderby.Replace("'","''");
            }
            myCmd.CommandText = sql;
            if (cmdParams != null)
            {
                foreach (BestField cmdParam in cmdParams)
                {
                    myCmd.Parameters.Add(cmdParam.Param);
                }
            }
            OleDbDataReader tblReader = myCmd.ExecuteReader();
            while (tblReader.Read())
            {
                BestRow tempRow = NewRow();
                this.ConstructRow(tempRow, tblReader);
                this.TableRows.Add(tempRow);
            }
            tblReader.Close();
        }


        public void LoadRows(string whereclause, List<BestField> cmdParams)
        {
            OleDbCommand myCmd = this.dbCmd;
            myCmd.CommandText = "select " + fieldCSV + " from " + this.TableName + " where " + whereclause;
            if (cmdParams != null)
            {
                foreach (BestField cmdParam in cmdParams)
                {
                    myCmd.Parameters.Add(cmdParam.Param);
                }
            }
            OleDbDataReader tblReader = myCmd.ExecuteReader();
            while (tblReader.Read())
            {
                BestRow tempRow = NewRow();
                this.ConstructRow(tempRow, tblReader);
                this.TableRows.Add(tempRow);
            }
            tblReader.Close();
        }

        public void LoadRows(string whereclause, string param1, string value1, string orderby)
        {
            BestField bfld = new BestField() { fieldName = param1, fieldType="System.String", paramOledbType = OleDbType.VarChar, fieldSize = 50 };
            bfld.fieldValue = value1;
            List<BestField> bparam = new List<BestField>();
            bparam.Add(bfld);
            this.LoadRows(whereclause, bparam, orderby);
        }

        public void LoadRows(string whereclause, string param1, Guid value1, string orderby)
        {
            BestField bfld = new BestField() { fieldName = param1, fieldType ="System.Guid", paramOledbType = OleDbType.Guid, fieldSize = 50 };
            bfld.fieldValue = value1.ToString();
            List<BestField> bparam = new List<BestField>();
            bparam.Add(bfld);
            this.LoadRows(whereclause, bparam, orderby);
        }

        public bool allowAdd
        {
            get
            {
                if (overrideAdd.HasValue) return overrideAdd.Value;

                if (Utils.User != null)
                {
                    return Utils.User.UserRoleByName(this.SecurityPage).allowAdd;
                }
                return false;
            }
        }

        public bool allowEdit
        {
            get
            {
                if (overrideEdit.HasValue) return overrideEdit.Value;

                if (Utils.User != null)
                {
                    return Utils.User.UserRoleByName(this.SecurityPage).allowEdit;
                }
                return false;
            }
        }

        public bool allowDelete
        {
            get
            {
                if (overrideDelete.HasValue) return overrideDelete.Value;

                if (Utils.User != null)
                {
                    return Utils.User.UserRoleByName(this.SecurityPage).allowDelete;
                }
                
                return false;
            }
        }

        public bool? overrideAdd
        {
            get;
            set;
        }

        public bool? overrideEdit
        {
            get;
            set;
        }

        public bool? overrideDelete
        {
            get;
            set;
        }

    }


    /* Table Rows */
    public class BestRows
    {
        public List<BestRow> Rows = new List<BestRow>();
        
        public BestRow this[int i]
        {
            get
            {
                return Rows[i];
            }
        }

        public void Add(BestRow field)
        {
            Rows.Add(field);
        }

        public void Clear()
        {
            Rows.Clear();
        }

        public int Count
        {
            get
            {
                return Rows.Count;
            }
        }
    }

    /* Row */
    public class BestRow
    {
        public BestRow()
        {            
            lastError = "";
        }

        public BestFields Fields
        {
            get;
            set;
        }

        public bool IsNew
        {
            get;
            set;
        }

        public bool IsDelete
        {
            get;
            set;
        }

        public BestTable bestTable
        {
            get;
            set;
        }

        private bool HasChanges
        {
            get
            {
                bool changed = false;
                for (int i = 0; i < Fields.Count; i++)
                {
                    changed = changed || (Fields[i].hasChange);
                }
                return changed;
            }
        }

        private string _fieldQues;

        private string fieldQues
        {
            get
            {
                return _fieldQues;
            }
        }

        private List<OleDbParameter> _Params;
        private List<OleDbParameter> Params
        {
            get
            {
                if (_Params == null)
                {
                    _Params = new List<OleDbParameter>();
                }
                return _Params;
            }
        }

        private string InsfieldCSV()
        {
            string fieldList = "";
            _fieldQues = "";
            Params.Clear();
            for (int i = 0; i < Fields.Count; i++)
            {
                if (Fields[i].fieldValue != null)
                {
                    fieldList += Fields[i].fieldName + ",";
                    _fieldQues += "?,";
                    Params.Add(Fields[i].Param);
                }                
            }
            if (fieldList.Length > 0)
            {
                fieldList = fieldList.Substring(0, fieldList.Length - 1);
                _fieldQues = _fieldQues.Substring(0, _fieldQues.Length - 1);
            }
            return fieldList;
        }

        public string lastError
        {
            get;
            set;
        }

        private string updfieldSQL()
        {
            string fieldList = "";
            Params.Clear();
            for (int i = 0; i < Fields.Count; i++)
            {
                if (!(Fields[i].fieldName.Equals("guidfield")))
                {
                    if (Fields[i].hasChange)
                    {
                        fieldList += Fields[i].fieldName + " = ? ,";
                        Params.Add(Fields[i].Param);
                    }
                }
            }
            if (fieldList.Length > 0)
            {
                fieldList = fieldList.Substring(0, fieldList.Length - 1);
            }
            return fieldList;
        }

        public virtual bool Save()
        {
            bool result = true;
            if (IsDelete && bestTable.allowDelete)
            {                
                //Delete
                OleDbCommand myCmd = bestTable.dbCmd;
                myCmd.CommandText = "delete from " + bestTable.TableName + " where guidfield = ?";
                myCmd.Parameters.Add(Fields["guidfield"].Param);
                try
                {
                    myCmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lastError += ex.Message;
                    result = false;
                }

            }
            else if (IsNew && bestTable.allowAdd)
            {
                //Insert 
                OleDbCommand myCmd = bestTable.dbCmd;
                myCmd.CommandText = "insert into " + bestTable.TableName + "(" + this.InsfieldCSV() + ") values (" + fieldQues + ")";
                for(int i=0; i<Params.Count;i++)
                {
                    myCmd.Parameters.Add(Params[i]);
                }
                try
                {
                    myCmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    lastError += ex.Message;
                    result = false;
                }
            }
            else if (HasChanges && bestTable.allowEdit)
            {
                //Update
                OleDbCommand myCmd = bestTable.dbCmd;
                myCmd.CommandText = "update " + bestTable.TableName + " set " + updfieldSQL() + " where guidfield = ?";
                for (int i = 0; i < Params.Count; i++)
                {
                    myCmd.Parameters.Add(Params[i]);
                }
                myCmd.Parameters.Add(Fields["guidfield"].Param);

                try
                {
                    myCmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lastError += ex.Message;
                    result = false;
                }

            }
            return result;
        }

        public virtual bool canDelete()
        {
            return true;
        }

    }
}
