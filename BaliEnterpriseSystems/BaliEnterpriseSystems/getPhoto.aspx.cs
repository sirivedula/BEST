using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;
using System.Data.OleDb;

namespace BaliEnterpriseSystems
{
    public partial class getPhoto : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            var ePhoto = new BestStudentPicture();
            OleDbCommand myCmd = ePhoto.dbCmd;
            myCmd.CommandText = "select photosize, photoname, picture from beststudentpicture where centerid = ? and studentid = ?";
            OleDbParameter sid = new OleDbParameter("studentid",OleDbType.VarChar, 50);
            sid.Value = Request.QueryString["sid"];
            OleDbParameter cid = new OleDbParameter("centerid", OleDbType.VarChar, 50);
            cid.Value = Request.QueryString["cid"];
            myCmd.Parameters.Add(cid);
            myCmd.Parameters.Add(sid);
            OleDbDataReader readphoto = myCmd.ExecuteReader();
            bool hasPhoto = false;
            if(readphoto.Read())
            {
                if (readphoto.GetValue(1).GetType() != Type.GetType("System.DBNull"))
                {
                    string photoname = readphoto.GetString(1);
                    var tvalue = readphoto.GetValue(2);
                    photo = (byte[])tvalue;
                    Response.AddHeader("content-disposition", "inline;filename=" + Server.UrlEncode(photoname));
                    Response.ContentType = "images/" + (System.IO.Path.GetExtension(photoname) ?? "jpg").ToLower();
                    Response.BinaryWrite(photo);
                    hasPhoto = true;
                }
            }
            
            if(! hasPhoto)
            {
                Response.AddHeader("content-disposition", "inline;filename=PhotoDoesNotExist.png");
                Response.ContentType = "image/png";
                Response.WriteFile(Server.MapPath("images/NoPhotoYet.png"));
                Response.End();
                return;

            }

        }

        private byte[] photo
        {
            get;
            set;
        }
    }
}
