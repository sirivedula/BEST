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
using System.Net;
using System.Net.Mail;
using BaliEnterpriseSystems.BestObjects;
using System.Data.OleDb;
using System.Text;
using System.Collections.Specialized;
using System.Collections.Generic;

namespace BaliEnterpriseSystems
{
    public class UtilEMail
    {
        private string smtpHost;
        private string fromemail;
        private string frompwd;
        private string port;
        public string lastError;
        private string fromName;
        private bool enableSSL;

        public UtilEMail()
        {
            smtpHost = ConfigurationManager.AppSettings["SMTPHost"];
            fromemail = ConfigurationManager.AppSettings["FromEMail"];
            frompwd = ConfigurationManager.AppSettings["FromPassowrd"];
            port = ConfigurationManager.AppSettings["Port"];
            fromName = ConfigurationManager.AppSettings["FromName"];
            enableSSL = ConfigurationManager.AppSettings["enableSSL"].Equals("1");
        }

        public string ToAddress
        {
            get;
            set;
        }


        public bool Send(string toaddress, string subject, string body, string ToName)
        {
            var fromAddress = new MailAddress(this.fromemail, fromName);
            var toAddress = new MailAddress(toaddress, ToName);
            string fromPassword = this.frompwd;
            int iPort;
            int.TryParse(this.port, out iPort);
            var smtp = new SmtpClient
            {
                Host = this.smtpHost,
                Port = iPort,
                EnableSsl = enableSSL,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword),
                Timeout = 20000
            };

            bool result = true;
            BestTable tbl = new BestTable();
            OleDbCommand myCmd = tbl.dbCmd;
            myCmd.CommandText = "insert into BestLogs (message) values (?)";
            OleDbParameter p1 = new OleDbParameter("msg", OleDbType.VarChar, 9999999);

            try
            {
                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    IsBodyHtml = true,
                    Subject = subject,
                    Body = body
                })
                {
                    p1.Value = "From:" + fromAddress.DisplayName + " To:" + toaddress + " Subject:" + subject + " Body:" + body;
                    myCmd.Parameters.Add(p1);
                    myCmd.ExecuteNonQuery();
                    smtp.Send(message);
                }
            }
            catch (Exception ex)
            {
                result = false;
                lastError = ex.Message;
                myCmd.Parameters[0].Value = ex.ToString();
                myCmd.ExecuteNonQuery();
            }

            return result;
        }

        public bool SendMultiple(NameValueCollection ToAddrs, string subject, string body)
        {
            bool result = true;
            MailMessage mailMsg = new MailMessage();
            mailMsg.From = new MailAddress(this.fromemail, this.fromName);
            foreach(string key in ToAddrs.AllKeys)
            {
                mailMsg.To.Add( new MailAddress(key, ToAddrs[key]));
            }
            mailMsg.Subject = subject;
            mailMsg.Body = body;

            int iPort;
            int.TryParse(this.port, out iPort);
            var fromAddress = new MailAddress(this.fromemail, fromName);
            string fromPassword = this.frompwd;

            BestTable tbl = new BestTable();

            var smtp = new SmtpClient
            {
                Host = this.smtpHost,
                Port = iPort,
                EnableSsl = enableSSL,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword),
                Timeout = 20000
            };

            OleDbCommand myCmd = tbl.dbCmd;
            myCmd.CommandText = "insert into BestLogs (message) values (?)";
            OleDbParameter p1 = new OleDbParameter("msg", OleDbType.VarChar, 9999999);
            try
            {
                p1.Value = "From:" + fromAddress.DisplayName + " To:" + mailMsg.To.ToString() + " Subject:" + subject + " Body:" + body;
                myCmd.Parameters.Add(p1);
                myCmd.ExecuteNonQuery();
                smtp.Send(mailMsg);
            }
            catch (Exception ex)
            {
                result = false;
                lastError = ex.Message;
                myCmd.Parameters[0].Value = ex.ToString();
                myCmd.ExecuteNonQuery();
            }

            return result;

        }
    }
}
