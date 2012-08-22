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
using System.Net.Mail;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestEMail
    {
        public BestEMail()
        {

        }

        public void SendEMail()
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(this.ToMail);
            mail.From = new MailAddress(this.FromMail);
            mail.Subject = this.Subject;
            mail.Body = this.Body;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = ConfigurationManager.AppSettings["SMTP"];
            smtp.Send(mail);
        }

        public string ToMail
        {
            get;
            set;
        }

        public string Subject
        {
            get;
            set;
        }

        public string Body
        {
            get;
            set;
        }

        public string FromMail
        {
            get;
            set;
        }
    }
}
