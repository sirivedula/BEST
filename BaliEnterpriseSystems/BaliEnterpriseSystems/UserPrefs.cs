using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public class UserPrefs
    {
        private BestUserPrefs userPrefs = new BestUserPrefs();
        private string _username { get; set; }
        public UserPrefs(string username)
        {
            _username = username;
            Reload();
        }

        public void SetPreference(string name, string value)
        {
            BestUserPrefs upf = new BestUserPrefs();
            BestField bfld = new BestField()
            {
                fieldName = "username",
                fieldSize = 128,
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar
            };
            bfld.fieldValue = _username;
            BestField bfld1 = new BestField() { fieldName = "Name", fieldSize = 50, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar };
            bfld1.fieldValue = name;
            List<BestField> bparam = new List<BestField>();
            bparam.Add(bfld);
            bparam.Add(bfld1);
            upf.LoadRows("username=? and name=?", bparam);
            upf.UserName = _username;
            upf.Name = name;
            upf.Value = value;
            upf.CurrentRow.Save();
            Reload();
        }

        private void Reload()
        {
            BestField bfld = new BestField()
            {
                fieldName = "username",
                fieldSize = 128,
                fieldType = "System.String",
                paramOledbType = System.Data.OleDb.OleDbType.VarChar
            };
            bfld.fieldValue = _username;
            List<BestField> bparam = new List<BestField>();
            bparam.Add(bfld);
            userPrefs.LoadRows("username=?", bparam, "name");
        }

        public string getPreference(string name)
        {
            string result = "";
            for (int i = 0; i < userPrefs.TableRows.Count; i++)
            {
                BestRow cur = userPrefs.TableRows[i];
                if (cur.Fields["username"].fieldValue.Equals(_username) && cur.Fields["name"].fieldValue.Equals(name))
                {
                    result = cur.Fields["value"].fieldValue;
                }
            }
            return result;
        }
    }
}
