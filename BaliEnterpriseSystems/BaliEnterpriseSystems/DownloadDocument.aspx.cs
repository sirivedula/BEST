using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;
using System.Data.OleDb;
using System.IO;

namespace BaliEnterpriseSystems
{
    public partial class DownloadDocument : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            var eDoc = new BestDocuments();
            OleDbCommand myCmd = eDoc.dbCmd;
            myCmd.CommandText = "select documentFileSize, documentFileName, documentFile from BestDocuments where centerid = ? and studentid = ? and guidfield=?";
            OleDbParameter sid = new OleDbParameter("studentid", OleDbType.VarChar, 50);
            sid.Value = Request.Form["sid"];
            OleDbParameter cid = new OleDbParameter("centerid", OleDbType.VarChar, 50);
            cid.Value = Request.Form["cid"];
            OleDbParameter guid = new OleDbParameter("guidfield", OleDbType.Guid, 40);
            guid.Value = new Guid(Request.Form["guid"]);

            myCmd.Parameters.Add(cid);
            myCmd.Parameters.Add(sid);
            myCmd.Parameters.Add(guid);
            OleDbDataReader readDoc = myCmd.ExecuteReader();
            if (readDoc.Read())
            {
                if (readDoc.GetValue(1).GetType() != Type.GetType("System.DBNull"))
                {
                    string docName = readDoc.GetString(1);
                    var tvalue = readDoc.GetValue(2);
                    docImage = (byte[])tvalue;

                    MemoryStream ms = new MemoryStream();
                    ms.Write(docImage, 0, docImage.Length);

                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.ContentType = "application/doc";
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + docName);

                    Response.OutputStream.Write(ms.ToArray(), 0, ms.ToArray().Length);
                    Response.Flush();
                    Response.Close();
                    ms.Close();
                }
            }
            else
            {
                Response.Write("No Document");
            }

        }

        private byte[] docImage
        {
            get;
            set;
        }

    }
}
