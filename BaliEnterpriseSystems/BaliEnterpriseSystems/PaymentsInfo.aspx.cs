using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Collections.Generic;
using BaliEnterpriseSystems.BestObjects;
using System.Text;

namespace BaliEnterpriseSystems
{
    public partial class PaymentsInfo : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.PaymentMenu("paymentdetails");
            if (!Utils.User.UserRoleByName("Payment - Details").allowView)
            {
                ltrGrid.Text = "You do not have rights to view.";
                return;
            }            

            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            string saveClicked = Request.Form["SaveClicked"] ?? "";
            if (IsPostBack && saveClicked.Equals("1"))
            {
                PaymentDetails bs = new PaymentDetails();
                string isnew = Request.Form["isnew"];
                bool cansave = true;
                if (string.IsNullOrEmpty(isnew))
                {
                    List<BestField> bparams = new List<BestField>();
                    BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                    guid.fieldValue = Request.Form["guidfield"];
                    bparams.Add(guid);

                    if (!string.IsNullOrEmpty(guid.fieldValue))
                    {
                        bs.LoadRows("guidfield=?", bparams);
                    }
                    else
                    {
                        string delguid = Request.Form["deleteguid"];
                        if (!string.IsNullOrEmpty(delguid))
                        {
                            bparams[0].fieldValue = delguid;
                            bs.LoadRows("guidfield=?", bparams);
                            bs.CurrentRow.IsDelete = true;
                            bs.CurrentRow.Save();
                        }
                        cansave = false;
                    }
                }

                if (cansave)
                {
                    string stdguid = Request.Form["g_studentGuid"];
                    string payguid = Request.Form["g_paymentTypeGuid"];
                    string amt = Request.Form["g_amount"];
                    string paydate = Request.Form["g_paymentDate"];
                    string hours = Request.Form["g_hours"];
                    if (string.IsNullOrEmpty(payguid))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Payment Type is Required.");
                        cansave = false;
                    }
                    if (string.IsNullOrEmpty(stdguid))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Student is Required.");
                        cansave = false;
                    }
                    if (string.IsNullOrEmpty(paydate))
                    {
                        ltrValidateMsg.Text = Utils.WarningMessage("Payment Date is Required.");
                        cansave = false;
                    }
                    if (cansave)
                    {
                        bs.studentGuid = new Guid(stdguid);
                        bs.paymentTypeGuid = new Guid(payguid);
                        bs.amount = amt;
                        Decimal dhours;
                        Decimal.TryParse(hours, out dhours);
                        bs.hours = dhours;
                        bs.paymentDate = Convert.ToDateTime(paydate);
                        bs.CenterId = Utils.User.CenterId;

                        if (!bs.CurrentRow.Save())
                        {
                            ltrValidateMsg.Text = Utils.WarningMessage(bs.CurrentRow.lastError);
                        }
                    }
                }
            }

            PaymentTypes bpayTypes = new PaymentTypes();
            bpayTypes.LoadRows();
            StringBuilder sbc = new StringBuilder();
            sbc.Append("<option value=\"\"></option>");
            for (int rnum = 0; rnum < bpayTypes.TableRows.Count; rnum++)
            {
                string paytype = bpayTypes.TableRows[rnum].Fields["paymentType"].fieldValue;
                string guid = bpayTypes.TableRows[rnum].Fields["guidfield"].fieldValue;
                sbc.Append("<option value=\"" + HttpUtility.HtmlEncode(guid) + "\">" + HttpUtility.HtmlEncode(paytype) + "</option>");
            }
            ltrPayTypes.Text = sbc.ToString();

            /* Auto Student */
            string autoSample = "{value:\"[paramValue]\", label:[paramLabel]}";
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("autoStudents = [");
            BestStudents bstd = new BestStudents();
            bstd.LoadRows("CenterId=?", Utils.User.CIdParam);
            for (int s = 0; s < bstd.TableRows.Count; s++)
            {
                string result = autoSample;
                result = result.Replace("[paramValue]", bstd.TableRows[s].Fields["guidfield"].fieldValue);
                result = result.Replace("[paramLabel]", Utils.EnquoteJS((bstd.TableRows[s].Fields["firstName"].fieldValue ?? "") + " " +
                    (bstd.TableRows[s].Fields["lastName"].fieldValue ?? "")));
                sb.Append(result);
                if (s < bstd.TableRows.Count - 1) sb.AppendLine(",");
            }
            sb.AppendLine("];");
            ltrScript.Text = @"<script type=""text/javascript"">
        $(document).ready(function(){ " + sb.ToString() + @" 
		$('#studentTag1').autocomplete( { source:autoStudents, delay: 0, select : function( event, ui){ 
			$('#studentGuid').val( ui.item.value );
			$( this ).val( ui.item.label ); 
			return false; 
		} } ); }); </script>";

            BestGrid bsGrid = new BestGrid();
            bsGrid.PageRequest = Page.Request;
            bsGrid.Title = "Payment Details";
            bsGrid.GridTable = new PaymentDetails();
            bsGrid.securityPage = "Payment - Details";
            ltrGrid.Text = bsGrid.ToHTML();
        }
    }
}
