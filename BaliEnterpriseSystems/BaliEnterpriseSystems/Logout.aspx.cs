using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using BaliEnterpriseSystems.BestObjects;
using System.Collections.Generic;

namespace BaliEnterpriseSystems
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] != null)
            {

                var cUser = Utils.User.BestUser;
                if (cUser != null)
                {
                    var sessguid = HttpContext.Current.Session["SessionGuid"];
                    if (sessguid != null)
                    {
                        BestField sguid = new BestField() { fieldName = "sessionguid", fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, fieldSize = 40 };
                        sguid.fieldValue = sessguid.ToString();
                        BestLogins bslog = new BestLogins();
                        List<BestField> bparam = new List<BestField>();
                        bparam.Add(sguid);
                        bslog.LoadRows("sessionguid=?", bparam);
                        if (bslog.TableRows.Count > 0)
                        {
                            bslog.logoutdate = DateTime.Now;
                            bslog.CurrentRow.Save();
                        }
                    }

                }
            }

            Session.Contents.Abandon();
        }
    }
}
