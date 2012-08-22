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
    public partial class SaveSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            string tutGuid = Request.Form["tutGuid"];
            string stuGuid1 = Request.Form["stuGuid1"];
            string stuGuid2 = Request.Form["stuGuid2"];
            string stuGuid3 = Request.Form["stuGuid3"];
            string stuGuid4 = Request.Form["stuGuid4"];
            string stuGuid5 = Request.Form["stuGuid5"];
            string schGuid = Request.Form["schGuid"];
            string schDate = Request.Form["schDate"];
            string schFrom = Request.Form["schFrom"];
            string schTo = Request.Form["schTo"];
            string isdelete = Request.Form["isDel"];
            string attend1 = Request.Form["attend0"];
            string attend2 = Request.Form["attend1"];
            string attend3 = Request.Form["attend2"];
            string attend4 = Request.Form["attend3"];
            string attend5 = Request.Form["attend4"];
            string note1 = Request.Form["note0"];
            string note2 = Request.Form["note1"];
            string note3 = Request.Form["note2"];
            string note4 = Request.Form["note3"];
            string note5 = Request.Form["note4"];
            string progGuid1 = Request.Form["progGuid1"];
            string progGuid2 = Request.Form["progGuid2"];
            string progGuid3 = Request.Form["progGuid3"];
            string progGuid4 = Request.Form["progGuid4"];
            string progGuid5 = Request.Form["progGuid5"];
            string tutorattend = Request.Form["tutorattend"];

            BestSchedules bsch = new BestSchedules();
            if (Utils.IsGuid(schGuid))
            {
                /* Update */
                if (!(Utils.User.UserRoleByName("5.Schedules").allowEdit))
                {
                    Response.Write("{result:false,Message:'You do not have rights to edit.'}");
                    return;
                }

                List<BestField> bparams = new List<BestField>();
                BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                guid.fieldValue = schGuid;
                bparams.Add(guid);
                bsch.LoadRows("guidfield = ?", bparams);
                if (bsch.TableRows.Count > 0)
                {
                    bsch.schDate = schDate;
                    bsch.schFrom = schFrom;
                    bsch.schTo = schTo;
                    if(! string.IsNullOrEmpty(isdelete))
                        bsch.isDeleted = isdelete;
                }
            }
            else
            {
                /* Add New */
                if (!(Utils.User.UserRoleByName("5.Schedules").allowAdd))
                {
                    Response.Write("{result:false,Message:'You do not have rights to add.'}");
                    return;
                }
                bsch.guidfield = Guid.NewGuid();
                bsch.schDate = schDate;
                bsch.schFrom = schFrom;
                bsch.schTo = schTo;
            }

            if (Utils.IsGuid(tutGuid))
                bsch.tutGuid = new Guid(tutGuid);

            bsch.stuGuid1 = new Guid(stuGuid1);
            if (Utils.IsGuid(stuGuid2))
                bsch.stuGuid2 = new Guid(stuGuid2);
            else
                bsch.stuGuid2 = null;

            if (Utils.IsGuid(stuGuid3))
                bsch.stuGuid3 = new Guid(stuGuid3);
            else
                bsch.stuGuid3 = null;

            if (Utils.IsGuid(stuGuid4))
                bsch.stuGuid4 = new Guid(stuGuid4);
            else
                bsch.stuGuid4 = null;

            if (Utils.IsGuid(stuGuid5))
                bsch.stuGuid5 = new Guid(stuGuid5);
            else
                bsch.stuGuid5 = null;

            bsch.isDeleted = isdelete;
            bsch.attended1 = attend1;
            if (!string.IsNullOrEmpty(attend2)) 
                bsch.attended2 = attend2;
            if (!string.IsNullOrEmpty(attend3)) 
            bsch.attended3 = attend3;
            if (!string.IsNullOrEmpty(attend4)) 
            bsch.attended4 = attend4;
            if (!string.IsNullOrEmpty(attend5)) 
            bsch.attended5 = attend5;
            if (!string.IsNullOrEmpty(note1)) 
                bsch.note1 = note1;
            if (!string.IsNullOrEmpty(note2)) 
                bsch.note2 = note2;
            if (!string.IsNullOrEmpty(note3)) 
                bsch.note3 = note3;
            if (!string.IsNullOrEmpty(note4)) 
                bsch.note4 = note4;
            if (!string.IsNullOrEmpty(note5)) 
                bsch.note5 = note5;

            if (!string.IsNullOrEmpty(progGuid1))
                bsch.progGuid1 = new Guid(progGuid1);
            else
                bsch.progGuid1 = null;

            if (!string.IsNullOrEmpty(progGuid2))
                bsch.progGuid2 = new Guid(progGuid2);
            else
                bsch.progGuid2 = null;

            if (!string.IsNullOrEmpty(progGuid3))
                bsch.progGuid3 = new Guid(progGuid3);
            else
                bsch.progGuid3 = null;

            if (!string.IsNullOrEmpty(progGuid4))
                bsch.progGuid4 = new Guid(progGuid4);
            else
                bsch.progGuid4 = null;

            if (!string.IsNullOrEmpty(progGuid5))
                bsch.progGuid5 = new Guid(progGuid5);
            else
                bsch.progGuid5 = null;
            if (!string.IsNullOrEmpty(tutorattend))
                bsch.tutorattend = tutorattend;

            if (!string.IsNullOrEmpty(stuGuid1) && !string.IsNullOrEmpty(progGuid1))
                bsch.Amount1 = getProgramAmount(bsch.stuGuid1, bsch.progGuid1);
            else
                bsch.Amount1 = 0;

            if (!string.IsNullOrEmpty(stuGuid2) && !string.IsNullOrEmpty(progGuid2))
                bsch.Amount2 = getProgramAmount(bsch.stuGuid2, bsch.progGuid2);
            else
                bsch.Amount2 = 0;

            if (!string.IsNullOrEmpty(stuGuid3) && !string.IsNullOrEmpty(progGuid3))
                bsch.Amount3 = getProgramAmount(bsch.stuGuid3, bsch.progGuid3);
            else
                bsch.Amount3 = 0;

            if (!string.IsNullOrEmpty(stuGuid4) && !string.IsNullOrEmpty(progGuid4))
                bsch.Amount4 = getProgramAmount(bsch.stuGuid4, bsch.progGuid4);
            else
                bsch.Amount4 = 0;

            if (!string.IsNullOrEmpty(stuGuid5) && !string.IsNullOrEmpty(progGuid5))
                bsch.Amount5 = getProgramAmount(bsch.stuGuid5, bsch.progGuid5);
            else
                bsch.Amount5 = 0;

            bsch.CenterId = Utils.User.CenterId;
            if (bsch.CurrentRow.Save())
            {
                Response.Write("{result:true,guid:'" + bsch.CurrentRow.Fields["guidfield"].fieldValue + "'}");
            }
            else
            {
                Response.Write("{result:false,Message:'" + Utils.EnquoteJS( bsch.CurrentRow.lastError )+ "'}");
            }
        }

        private Decimal getProgramAmount(Guid? stuguid, Guid? progGuid)
        {
            Decimal result = 0;

            BestField p1 = new BestField() { fieldName = "studentguid", fieldType = "System.Guid", fieldSize = 40, paramOledbType = System.Data.OleDb.OleDbType.Guid };
            p1.fieldValue = stuguid.ToString();
            BestField p2 = new BestField() { fieldName = "guidfield", fieldType = "System.Guid", fieldSize = 40, paramOledbType = System.Data.OleDb.OleDbType.Guid };
            p2.fieldValue = progGuid.ToString();
            List<BestField> bparams = new List<BestField>();
            bparams.Add(p1);
            bparams.Add(p2);

            BestStudentPrograms bstdProgs = new BestStudentPrograms();
            bstdProgs.LoadRows("studentguid=? and guidfield=?", bparams);
            if (bstdProgs.HasRows)
            {
                bstdProgs.currentRowId = 0;
                result = bstdProgs.Amount;
            }

            return result;
        }
    }
}
