using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class SaveSendMessage : System.Web.UI.Page
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
			
			BestMessages bstMsg = new BestMessages();
			bstMsg.overrideAdd = true;
			string parentGuid = Request.Form["parentGuid"];
			if(! string.IsNullOrEmpty(parentGuid))
			{
				bstMsg.parentGuid = new Guid(parentGuid);
			}
			bstMsg.messageText = Request.Form["msgText"];
            bstMsg.messageFrom = Utils.User.UserName;
            bstMsg.messageTo = Request.Form["msgTo"];
            bstMsg.CenterId = Utils.User.CenterId;

            StringBuilder sbHtml = new StringBuilder();
            if (!bstMsg.CurrentRow.Save())
			{
				/* Return Message */
                sbHtml.Append("<div>Unable to send message.</div>");
			}
			
			/* Write HTML of Message */
            bstMsg.TableRows.Clear();
			bstMsg.LoadRows("messageFrom=?", "messageFrom", Utils.User.UserName, "messagedate desc");
			sbHtml.Append("<table cellspacing=\"0\" cellpadding=\"0\" style=\"width:100%;\"><tr><th>Sent Date</th><th>To</th><th>Message</th></tr>");
			for(int i=0; i < bstMsg.TableRows.Count; i++)
			{
				bstMsg.currentRowId = i;
                sbHtml.Append("<td>" + HttpUtility.HtmlEncode(bstMsg.messageDate.ToString("MM/dd/yyyy")) + "</td><td>" + HttpUtility.HtmlEncode(bstMsg.TableRows[i].Fields["messageTo"].displayFormatFunc.Invoke(bstMsg.TableRows[i]).ToString()) + "</td><td>" + HttpUtility.HtmlEncode(bstMsg.messageText) + "</td></tr>");
			}
			sbHtml.Append("</table>");

            Response.Write(sbHtml.ToString());
		}
    }
}
