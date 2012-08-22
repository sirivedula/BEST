using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class SaveSTPlan : System.Web.UI.Page
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

            string schType = Request.Form["schType"];
            string schGuid = Request.Form["guidfield"];
            if (!string.IsNullOrEmpty(schType))
            {
                string tutGuid = Request.Form["tutGuid"];
                string stuGuid = Request.Form["stuGuid"];
                string schDay = Request.Form["schDay"];
                string schFrom = Request.Form["schFrom"];
                string schTo = Request.Form["schTo"];
                string isdelete = Request.Form["isDel"];
                BestSTPlan bstp = new BestSTPlan();
                if (Utils.IsGuid(schGuid))
                {
                    if (schType.Equals("Student") && !(Utils.User.UserRoleByName("Student - Planner").allowEdit))
                    {
                        Response.Write("{result:false,Message:'You do not have rights to edit.'}");
                        return;
                    }

                    if (schType.Equals("Tutor") && !(Utils.User.UserRoleByName("Tutor - Planner").allowEdit))
                    {
                        Response.Write("{result:false,Message:'You do not have rights to edit.'}");
                        return;
                    }
                    List<BestField> bparams = new List<BestField>();
                    BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                    guid.fieldValue = schGuid;
                    bparams.Add(guid);
                    bstp.LoadRows("guidfield = ?", bparams);
                    if (bstp.TableRows.Count > 0)
                    {
                        bstp.schDay = schDay;
                        bstp.schFrom = schFrom;
                        bstp.schTo = schTo;
                        bstp.CenterId = Utils.User.CenterId;
                        if (Utils.IsGuid(tutGuid))
                            bstp.tutorguid= new Guid(tutGuid);
                        if (Utils.IsGuid(stuGuid))
                            bstp.studentGuid = new Guid(stuGuid);
                        bstp.CurrentRow.Save();
                    }
                }
                else
                {
                    if (schType.Equals("Student") && !(Utils.User.UserRoleByName("Student - Planner").allowAdd))
                    {
                        Response.Write("{result:false,Message:'You do not have rights to edit.'}");
                        return;
                    }

                    if (schType.Equals("Tutor") && !(Utils.User.UserRoleByName("Tutor - Planner").allowAdd))
                    { 
                        Response.Write("{result:false,Message:'You do not have rights to edit.'}");
                        return;
                    }
                    bstp.guidfield = Guid.NewGuid();
                    bstp.schDay = schDay;
                    bstp.schFrom = schFrom;
                    bstp.schTo = schTo;
                    bstp.CenterId = Utils.User.CenterId;
                    if (Utils.IsGuid(tutGuid))
                        bstp.tutorguid = new Guid(tutGuid);
                    
                    if (Utils.IsGuid(stuGuid))
                        bstp.studentGuid = new Guid(stuGuid);
                }
                bstp.isDeleted = isdelete;

                if (bstp.CurrentRow.Save())
                {
                    Response.Write("{result:true,guid:'" + bstp.CurrentRow.Fields["guidfield"].fieldValue + "'}");
                }
                else
                {
                    Response.Write("{result:false,Message:'" + Utils.EnquoteJS(bstp.CurrentRow.lastError) + "'}");
                }
            }
        }
    }
}
