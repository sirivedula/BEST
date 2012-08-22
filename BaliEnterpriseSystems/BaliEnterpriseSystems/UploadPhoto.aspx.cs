using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using BaliEnterpriseSystems.BestObjects;
using System.Data.OleDb;

namespace BaliEnterpriseSystems
{
    public partial class UploadPhoto : System.Web.UI.Page
    {
        private static System.Drawing.Image resizeImage(System.Drawing.Image imgToResize, Size size)
        {
            int sourceWidth = imgToResize.Width;
            int sourceHeight = imgToResize.Height;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = ((float)size.Width / (float)sourceWidth);
            nPercentH = ((float)size.Height / (float)sourceHeight);

            if (nPercentH < nPercentW)
                nPercent = nPercentH;
            else
                nPercent = nPercentW;

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap b = new Bitmap(destWidth, destHeight);
            Graphics g = Graphics.FromImage((System.Drawing.Image)b);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;

            g.DrawImage(imgToResize, 0, 0, destWidth, destHeight);
            g.Dispose();

            return (System.Drawing.Image)b;
        }
        public byte[] imageToByteArray(System.Drawing.Image imageIn)
        {
            var ms = new System.IO.MemoryStream();
            imageIn.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            return ms.ToArray();
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {

            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            BestField sid = new BestField() { fieldName = "studentid", fieldSize = 50, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar };
            sid.fieldValue = Request.QueryString["sid"];
            BestField cid = new BestField() { fieldName = "centerid", fieldSize = 50, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar };
            cid.fieldValue = Request.QueryString["cid"];
            BestStudentPicture studPic = new BestStudentPicture();
            List<BestField> bparams = new List<BestField>();
            bparams.Add(sid);
            bparams.Add(cid);
            studPic.LoadRows("studentid = ? and centerid = ?", bparams);
            object stdname = studPic.CurrentRow.Fields["studentGuid"].displayFormatFunc.Invoke(studPic.CurrentRow);
            ltrStdName.Text = stdname.ToString();

            if (!String.IsNullOrEmpty(Request.Form["uploadPhoto"]))
            {

                if (Request.Files.Count > 0)
                {
                    HttpPostedFile File = Request.Files[0];
                    if (File.ContentLength > 0)
                    {
                        string resizeTo = Request.Form["resizePhoto"];
                        int MaxDimension = 120;
                        int.TryParse(resizeTo, out MaxDimension);
                        MaxDimension = Math.Min(120, MaxDimension);
                        Size maxSize = new Size(MaxDimension, MaxDimension);
                        System.Drawing.Image myImage = System.Drawing.Image.FromStream(File.InputStream, false);
                        if (myImage.Height > maxSize.Height || myImage.Width > maxSize.Width)
                        {
                            //resize image
                            var hOver = Convert.ToDouble(myImage.Height) / Convert.ToDouble(maxSize.Height);
                            var wOver = Convert.ToDouble(myImage.Width) / Convert.ToDouble(maxSize.Width);
                            double pOver = Math.Max(hOver, wOver);
                            maxSize.Height = Convert.ToInt32(myImage.Height / pOver);
                            maxSize.Width = Convert.ToInt32(myImage.Width / pOver);
                            myImage = resizeImage(myImage, maxSize);
                        }

                        var imgByte = imageToByteArray(myImage); //new Byte[File.ContentLength];
                        File.InputStream.Read(imgByte, 0, imgByte.Length);
                        OleDbCommand myCmd = studPic.dbCmd;
                        if (studPic.CurrentRow.IsNew)
                        {
                            myCmd.CommandText = "insert into BestStudentPicture (picture, photosize, photoname, studentid, centerid) values (?,?,?,?,?)";
                        }
                        else
                        {
                            myCmd.CommandText = "update BestStudentPicture set picture = ?, photosize = ?, photoname = ? where studentid=? and centerid=?";
                        }
                        object tvalue = imgByte;
                        OleDbParameter p1 = new OleDbParameter("picture", OleDbType.LongVarBinary, -1, System.Data.ParameterDirection.Input, false, 0, 0, null, System.Data.DataRowVersion.Current, tvalue);
                        OleDbParameter p2 = new OleDbParameter("photosize", OleDbType.VarChar, 12);
                        p2.Value = File.ContentLength;
                        OleDbParameter p3 = new OleDbParameter("photoname", OleDbType.VarChar, 200);
                        p3.Value = File.FileName;
                        myCmd.Parameters.Clear();
                        myCmd.Parameters.Add(p1);
                        myCmd.Parameters.Add(p2);
                        myCmd.Parameters.Add(p3);
                        myCmd.Parameters.Add(sid.Param);
                        myCmd.Parameters.Add(cid.Param);
                        try
                        {
                            myCmd.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            this.errorDisplay.Text = "<div class=\"err\">There was an error saving the photo.<br />" + HttpUtility.HtmlEncode(ex.Message) + "</div>";
                        }
                    }
                }
            }
            this.defaultResizeOptionScript.Text = "<script type=\"text/javascript\">\nvar defaultSize = '90'; \n</script>";
            this.photoDisplay.Text = "<img id=\"empPhoto\" alt=\"Employee Photo\" src=\"getPhoto.aspx?sid=" + Server.UrlEncode(sid.fieldValue) + "&cid=" + Server.UrlEncode(cid.fieldValue) + "\" />";
        }
    }
}
