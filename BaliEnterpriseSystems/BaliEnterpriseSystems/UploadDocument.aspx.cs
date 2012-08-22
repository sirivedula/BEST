using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public partial class UploadDocument : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            string centerid = Request.QueryString["cid"];
            string studid = Request.QueryString["sid"];
            string docGuid = Request.QueryString["guid"];
            if (centerid.Equals(Utils.User.CenterId))
            {
                if (string.IsNullOrEmpty(studid) && string.IsNullOrEmpty(docGuid))
                {
                    Response.Write("Document Details is not found");
                }
                else
                {
                    if (IsPostBack)
                    {
                        if (Request.Files.Count > 0)
                        {
                            BestField sid = new BestField() { fieldName = "studentid", fieldSize = 50, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar };
                            sid.fieldValue = Request.QueryString["sid"];
                            BestField cid = new BestField() { fieldName = "centerid", fieldSize = 50, fieldType = "System.String", paramOledbType = System.Data.OleDb.OleDbType.VarChar };
                            cid.fieldValue = Request.QueryString["cid"];
                            BestField docguid = new BestField() { fieldType = "System.Guid", fieldSize = 50, fieldName = "guidfield", paramOledbType = OleDbType.Guid };
                            docguid.fieldValue = docGuid;

                            BestDocuments bestDocs = new BestDocuments();
                            List<BestField> bparams = new List<BestField>();
                            bparams.Add(sid);
                            bparams.Add(cid);
                            bparams.Add(docguid);
                            bestDocs.LoadRows("studentid = ? and centerid = ? and guidfield=?", bparams);

                            OleDbCommand myCmd = bestDocs.dbCmd;
                            if (bestDocs.CurrentRow.IsNew)
                            {
                                this.errorDisplay.Text = "<div class=\"err\">Document Details Not Found</div>";
                            }
                            else
                            {
                                myCmd.CommandText = "update BestDocuments set documentFile = ?, documentFileSize = ?, documentFileName = ? where studentid=? and centerid=? and guidfield=?";

                                HttpPostedFile PostedFile = docFile.PostedFile;
                                byte[] docBytes = new byte[PostedFile.ContentLength];
                                HttpPostedFile uploadedImage = PostedFile;
                                uploadedImage.InputStream.Read(docBytes, 0, (int)PostedFile.ContentLength);

                                object tvalue = docBytes;
                                OleDbParameter p1 = new OleDbParameter("documentFile", OleDbType.LongVarBinary, -1, ParameterDirection.Input, false, 0, 0, null, DataRowVersion.Current, tvalue);
                                OleDbParameter p2 = new OleDbParameter("documentFileSize", OleDbType.VarChar, 12);
                                p2.Value = PostedFile.ContentLength;
                                OleDbParameter p3 = new OleDbParameter("documentFileName", OleDbType.VarChar, 100);
                                p3.Value = PostedFile.FileName;
                                myCmd.Parameters.Clear();
                                myCmd.Parameters.Add(p1);
                                myCmd.Parameters.Add(p2);
                                myCmd.Parameters.Add(p3);
                                myCmd.Parameters.Add(sid.Param);
                                myCmd.Parameters.Add(cid.Param);
                                myCmd.Parameters.Add(docguid.Param);
                                try
                                {
                                    myCmd.ExecuteNonQuery();
                                    this.errorDisplay.Text = "<div>Document Uploaded.</div><script type=\"text/javascript\">window.parent.closeUploadDoc();</script>";
                                }
                                catch (Exception ex)
                                {
                                    this.errorDisplay.Text = "<div class=\"err\">There was an error saving the photo.<br />" + HttpUtility.HtmlEncode(ex.Message) + "</div>";
                                }
                            }

                        }

                    }
                }
            }
            else
            {
                Response.Write("Center Information is not valid.");
            }

        }

    }
}
