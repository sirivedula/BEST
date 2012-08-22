using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;
using System.IO;
using System.Text;
using System.Data.OleDb;

namespace BaliEnterpriseSystems
{
    public partial class DownloadExport : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }

            string exportguid = Request.Form["exportguid"];
            if (string.IsNullOrEmpty(exportguid))
            {
                exportguid = Request.QueryString["exportguid"];
            }

            if (!string.IsNullOrEmpty(exportguid))
            {
                List<BestField> bparam = new List<BestField>();
                BestField fld = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid };
                fld.fieldValue = exportguid;
                bparam.Add(fld);
                BestExports bexp = new BestExports();
                bexp.LoadRows("guidfield=?", bparam);
                BestExportFields bexpFields = new BestExportFields();
                bexpFields.LoadRows("exportguid=?", bparam, "ordinal");
                string selfields = string.Join(",", bexpFields.TableRows.Rows.Select(x => x.Fields["fieldname"].fieldValue).ToArray());
                selfields = ReplaceT1(selfields);
                string headers = "\"" + string.Join("\",\"",bexpFields.TableRows.Rows.Select(x=>x.Fields["displayname"].fieldValue).ToArray()) + "\"\n";
                string filedata = getExportData(bexp.exportType, selfields);
                byte[] bytedata = strToByteArray(filedata);

                MemoryStream ms = new MemoryStream();
                byte[] bytes = strToByteArray(headers);
                ms.Write(bytes, 0, bytes.Length);
                ms.Write(bytedata, 0, bytedata.Length);
                string dest = bexp.exportType + DateTime.Today.ToString("MMddyyyy") + ".csv";

                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/csv";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + dest);
                Response.OutputStream.Write(ms.ToArray(), 0, ms.ToArray().Length);
                Response.Flush();
                Response.Close();
                ms.Close();
            }
        }

        private string getExportData(string exptype, string fields)
        {
            StringBuilder sb = new StringBuilder();
            string tsql = "";
            if (exptype.Equals("Payments"))
            {
                tsql = "select " + fields + " From (" +  UtilExporter.PaymentSQL() + ") t1";
            }
            else if (exptype.Equals("Students"))
            {
                tsql = "select " + fields + " From (" + UtilExporter.StudentSQL() + ") t1";
            }
            else if (exptype.Equals("Tutors"))
            {
                tsql = "select " + fields + " From (" + UtilExporter.TutorSQL() + ") t1";
            }
            else if (exptype.Equals("Change Audit"))
            {
                tsql = "select " + fields + " From (" + UtilExporter.ChangeAuditSQL() + ") t1";
            }
            else if (exptype.Equals("Schedules"))
            {
                tsql = "select " + fields + " From (" + UtilExporter.ScheduleSQL() + ") t1";
            }

            if (tsql.Length > 0)
            {
                BestTable tbl = new BestTable();
                OleDbCommand myCmd = tbl.dbCmd;
                myCmd.CommandText = "insert into BestLogs (message) values (?)";
                OleDbParameter p1 = new OleDbParameter("msg", OleDbType.VarChar, 9999999);
                p1.Value = tsql;
                myCmd.Parameters.Add(p1);
                myCmd.ExecuteNonQuery();

                myCmd.Parameters.Clear();
                myCmd.CommandText = tsql;
                OleDbDataReader expReader = myCmd.ExecuteReader();
                string aline = "";
                while (expReader.Read())
                {
                    aline = "";
                    for (int i = 0; i < expReader.FieldCount; i++)
                    {
                        object val = expReader.GetValue(i);
                        aline += "\"" + (val.ToString()) + "\",";
                    }
                    sb.AppendLine(aline);
                }
                expReader.Close();
            }
            return sb.ToString();
        }

        private string ReplaceT1(string fields)
        {
            string result = fields;
            string[] aryReplaces = { "BestStudents.", "BestStudentGPA.", "BestStudentNotes.", "BestStudentPickup.", "BestStudentPayment.", "BestStudentReference.", "BestStudentPicture.", "BestStudentPrograms.", "BestTutors.", "BestPaymentDetails.", "BestPaymentTypes.", "BestSchedules" };

            for (int i = 0; i < aryReplaces.Length; i++)
            {
                result = result.Replace(aryReplaces[i], "t1.");
            }

            return result;
        }

        byte[] strToByteArray(string str)
        {
            System.Text.ASCIIEncoding enc = new System.Text.ASCIIEncoding();
            return enc.GetBytes(str);
        }
    }
}
