using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaliEnterpriseSystems.BestObjects;
using System.Text;
using System.Data.OleDb;

namespace BaliEnterpriseSystems
{
    public partial class StudentForm : System.Web.UI.Page
    {
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            ltrSubMenu.Text = UtilMenu.StudentMenu("studentinfo");
            string ms = Request.QueryString["ms"];
            ltrMScript.Text = Utils.MenuSelectScript(ms);

            string submitMode = Request["submitMode"];
            if (IsPostBack)
            {
                if (!string.IsNullOrEmpty(submitMode))
                {
                    if (submitMode.Equals("add"))                    
                    {
                        if (!Utils.User.UserRoleByName("Student - Information").allowAdd)
                        {
                            Response.Write("You do not have rights to add.");
                            return;
                        }
                    }

                    if (submitMode.Equals("edit"))
                    {
                        if (!Utils.User.UserRoleByName("Student - Information").allowEdit)
                        {
                            Response.Write("You do not have rights to edit.");
                            return;
                        }
                    }
                }
            }

            BestCenters bcs = new BestCenters();
            bcs.LoadRows();
            StringBuilder sbc = new StringBuilder();
            sbc.Append("<option value=\"\"></option>");
            for (int rnum = 0; rnum < bcs.TableRows.Count; rnum++)
            {
                string cid = bcs.TableRows[rnum].Fields["CenterId"].fieldValue;
                if (cid.Equals(Utils.User.CenterId))
                {
                    this.CenterId.Items.Add(cid);
                }
                //sbc.Append("<option value=\"" + HttpUtility.HtmlEncode(cid) + "\">" + HttpUtility.HtmlEncode(cid) + "</option>");
            }
            //this.ltrCenters.Text = sbc.ToString();
            this.ltrState.Text = Utils.StateOptions();

            StringBuilder jsbp = new StringBuilder();
            jsbp.Append("jsProg=[");
            StringBuilder sbp = new StringBuilder();
            sbp.Append("<option value=\"\"></option>");
            BestPrograms bps = new BestPrograms();
            bps.LoadRows();
            ListItem ltItem = new ListItem("", "");
            this.proposedProg.Items.Add(ltItem);
            for (int rnum = 0; rnum < bps.TableRows.Count; rnum++)
            {
                string optext = bps.TableRows[rnum].Fields["programName"].fieldValue + ":" + bps.TableRows[rnum].Fields["programType"].fieldValue + ": Per " + bps.TableRows[rnum].Fields["amountType"].fieldValue;
                string optval = bps.TableRows[rnum].Fields["guidfield"].fieldValue;
                sbp.Append("<option value=\"" + HttpUtility.HtmlEncode(optval) + "\">" + HttpUtility.HtmlEncode(optext) + "</option>");
                jsbp.Append("{\"guid\":\"" + optval + "\",\"amount\":\"" + bps.TableRows[rnum].Fields["amount"].fieldValue + "\",\"amountType\":\"" + bps.TableRows[rnum].Fields["amountType"].fieldValue + "\"}");
                if (rnum < bps.TableRows.Count - 1) jsbp.Append(",");
                ltItem = new ListItem(optext, optval);
                this.proposedProg.Items.Add(ltItem);
            }
            jsbp.Append("]");

            this.ltrprog1.Text = sbp.ToString();
            this.ltrRelation.Text = Utils.RelationshipOptions();
            
            if (!string.IsNullOrEmpty(submitMode) && submitMode.Equals("add") && !IsPostBack)
            {
                /* Get New Next Student ID */
                BestDatabase db = new BestDatabase();
                OleDbCommand myCmd = db.dbCmd;
                myCmd.CommandText = "Best_GetNextStudentId";
                this.CenterId.SelectedIndex = 0;                
                OleDbParameter p1 = new OleDbParameter("@xcenterid", OleDbType.VarChar, 10);                
                p1.Value = this.CenterId.Items[0].Value;
                myCmd.Parameters.Add(p1);
                myCmd.CommandType = System.Data.CommandType.StoredProcedure;
                OleDbDataReader read = myCmd.ExecuteReader();
                if (read.Read())
                {
                    string studentid = read.GetValue(0).ToString();
                    this.StudentId.Value = studentid;
                }
            }

            string studentguid = Request.QueryString["studentguid"];
            Guid studentGuid = Guid.NewGuid();
            if (!string.IsNullOrEmpty(studentguid))
            {
                studentGuid = new Guid(studentguid);
            }

            StringBuilder jstdProg = new StringBuilder();
            StringBuilder jstdPick = new StringBuilder();
            StringBuilder jstdGPA = new StringBuilder();
            jstdProg.AppendLine("");
            jstdProg.Append("studentProg = [");
            jstdPick.AppendLine("");
            jstdPick.Append("pickupInfo = [");
            string jsSelState = "";
            jstdGPA.AppendLine("");
            jstdGPA.Append("studentGPA = [");

            if (submitMode.Equals("edit"))
            {
                /* Load Student Master */
                try
                {
                    List<BestField> bparams = new List<BestField>();
                    BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                    guid.fieldValue = studentguid;
                    bparams.Add(guid);
                    bstdMast.LoadRows("guidfield=?", bparams);
                    bstdPic.LoadRows("studentguid=?", bparams);
                    bstdPay.LoadRows("studentguid=?", bparams);
                    bstdRef.LoadRows("studentguid=?", bparams);
                    bstdProg.LoadRows("studentguid=?", bparams);
                    bstdPickup.LoadRows("studentguid=?", bparams);
                    bstdGPA.LoadRows("studentguid=?", bparams);
                    jsSelState = bstdMast.state;
                }
                catch (Exception ex)
                {
                    Response.Write("Error:" + HttpUtility.HtmlEncode(ex.Message));
                    return;
                }
                if (!IsPostBack)
                {
                    LoadForm(studentguid);
                }
            }

            if (IsPostBack)
            {
                doSave(studentGuid);
            }

            jstdProg.AppendLine(getStudentProgJS());
            jstdPick.AppendLine(getStudentPickupJS());
            jstdGPA.AppendLine(getStudentGPAJS());

            jstdProg.Append("]");
            jstdPick.Append("]");
            jstdGPA.Append("]");
            StringBuilder jsDateEvents = new StringBuilder();
            jsDateEvents.AppendLine("");
            jsDateEvents.AppendLine("$(document).ready(function(){");
            jsDateEvents.AppendLine("$('#" + this.cellPhone.ClientID + ",#" + this.homePhone.ClientID + ",#" + this.workPhone.ClientID + ",#contact0').mask('(999) 999-9999')");
            jsDateEvents.AppendLine("$('#" + this.joinDate.ClientID + ",#" + this.birthDate.ClientID + "').mask('99/99/9999');");
            jsDateEvents.AppendLine("$('#" + this.joinDate.ClientID + ",#" + this.birthDate.ClientID + "').datepicker({ showOn: 'button', buttonImage: 'images/date.png', buttonImageOnly: true, changeYear: true, changeMonth: true });");
            if (!string.IsNullOrEmpty(jsSelState))
            {
                jsDateEvents.AppendLine("$('#selState').val('" + jsSelState + "');");
            }
            jsDateEvents.AppendLine("$('#+" + this.firstName.ClientID + "').focus();");
            jsDateEvents.AppendLine("});");
            jsDateEvents.AppendLine("parentNameId = '" + this.parentName.ClientID + "';");
            jsDateEvents.AppendLine("payeenameId = '" + this.paymentname1.ClientID + "';");
            this.ltrProgScript.Text = "<script type=\"text/javascript\">" + jsbp.ToString() + jstdProg.ToString() + jstdPick.ToString() + jstdGPA.ToString() + jsDateEvents.ToString() + "</script>";

            if (submitMode.Equals("edit"))
            {
                this.ltrPhoto.Text = "<a href=\"UploadPhoto.aspx?sid=" + HttpUtility.UrlEncode(this.StudentId.Value) + "&cid=" + HttpUtility.UrlEncode(this.CenterId.Value) + "\" target=\"_blank\">Choose Photo</a>";
            }
            this.photoDisplay.Text = "<img id=\"empPhoto\" alt=\"Employee Photo\" src=\"getPhoto.aspx?sid=" + Server.UrlEncode(this.StudentId.Value) + "&cid=" + Server.UrlEncode(this.CenterId.Value) + "\" />";

        }

        private string getStudentProgJS()
        {
            StringBuilder sb = new StringBuilder();
            if (bstdProg.TableRows.Count == 0)
            {
                sb.Append("{ guid: \"newguid\", progGuid: \"\", isDeleted: false, Index:0 }");
            }
            else
            {
                for (int i = 0; i < bstdProg.TableRows.Count; i++)
                {
                    bstdProg.currentRowId = i;
                    BestRow trow = bstdProg.TableRows[i];
                    sb.Append("{guid:\"" + bstdProg.guidfield.ToString() + "\", progGuid:\"" + bstdProg.programguid.ToString() + "\", idDeleted:false, Index:" + i.ToString() + ",Amount:\"" + bstdProg.Amount.ToString("0.00") + "\"}");
                    if (i < bstdProg.TableRows.Count - 1) sb.Append(",");
                }
            }
            return sb.ToString();
        }

        private string getStudentPickupJS()
        {
            StringBuilder sb = new StringBuilder();
            if (bstdPickup.TableRows.Count == 0)
            {
                sb.Append("{ guid: \"newguid\", contactName: \"\", contactPhone:\"\", relationShip:\"\", isDeleted: false, Index:0 }");
            }
            else
            {
                for (int i = 0; i < bstdPickup.TableRows.Count; i++)
                {
                    BestRow trow = bstdPickup.TableRows[i];
                    sb.Append("{guid:\"" + trow.Fields["guidfield"].fieldValue + "\", contactName:\"" + trow.Fields["contactName"].fieldValue + "\", contactPhone:\"" + trow.Fields["contactPhone"].fieldValue + "\", relationShip:\"" + trow.Fields["relationShip"].fieldValue + "\", idDeleted:false, Index:" + i.ToString() + "}");
                    if (i < bstdPickup.TableRows.Count - 1) sb.Append(",");
                }
            }
            return sb.ToString();
        }

        private string getStudentGPAJS()
        {
            StringBuilder sb = new StringBuilder();
            if (bstdGPA.TableRows.Count == 0)
            {
                sb.Append("{guid:\"newguid\", AssessDate:\"\", GradeAvg:\"\", AssessLevel:\"\", isDeleted:false, Index: 0}");
            }
            else
            {
                for (int i = 0; i < bstdGPA.TableRows.Count; i++)
                {
                    BestRow trow = bstdGPA.TableRows[i];
                    sb.Append("{guid:\"" + trow.Fields["guidfield"].fieldValue + "\", AssessDate:\"" + trow.Fields["assessmentdate"].fieldValue.Replace(" 12:00:00 AM","") + "\", GradeAvg:\"" + trow.Fields["assessmentGPA"].fieldValue + "\", AssessLevel:\"" + trow.Fields["assessmentLevel"].fieldValue + "\", isDeleted:false, Index:" + i.ToString() + "}");
                    if (i < bstdGPA.TableRows.Count - 1) sb.Append(",");
                }
            }
            return sb.ToString();
        }

        private BestStudents _bstdMast;
        private BestStudents bstdMast
        {
            get
            {
                if (_bstdMast == null)
                {
                    _bstdMast = new BestStudents();
                }
                return _bstdMast;
            }
        }

        private BestStudentPrograms _bstdProg;
        public BestStudentPrograms bstdProg
        {
            get
            {
                if (_bstdProg == null)
                {
                    _bstdProg = new BestStudentPrograms();
                }
                return _bstdProg;
            }
        }

        private BestStudentPicture _bstdPic;
        private BestStudentPicture bstdPic
        {
            get
            {
                if (_bstdPic == null)
                {
                    _bstdPic = new BestStudentPicture();
                }
                return _bstdPic;
            }
        }

        private BestStudentPickup _bstdPickup;
        private BestStudentPickup bstdPickup
        {
            get
            {
                if (_bstdPickup == null)
                {
                    _bstdPickup = new BestStudentPickup();
                }
                return _bstdPickup;
            }
        }

        private BestStudentReference _bstdRef;
        private BestStudentReference bstdRef
        {
            get
            {
                if (_bstdRef == null)
                {
                    _bstdRef = new BestStudentReference();
                }
                return _bstdRef;
            }
        }

        private BestStudentPayment _bstdPay;
        private BestStudentPayment bstdPay
        {
            get
            {
                if (_bstdPay == null)
                {
                    _bstdPay = new BestStudentPayment();
                }
                return _bstdPay;
            }
        }

        private BestStudentGPA _bstdGPA;
        private BestStudentGPA bstdGPA
        {
            get
            {
                if (_bstdGPA == null)
                {
                    _bstdGPA = new BestStudentGPA();
                }
                return _bstdGPA;
            }
        }

        private void LoadForm(string studentguid)
        {
            this.CenterId.Value = bstdMast.CenterId;
            this.StudentId.Value = bstdMast.StudentId;
            this.firstName.Value = bstdMast.firstName;
            this.lastName.Value = bstdMast.lastName;
            this.middleName.Value = bstdMast.middleName;
            this.parentName.Value = bstdMast.parentName;
            if (bstdMast.joinDate > DateTime.MinValue)
                this.joinDate.Value = bstdMast.joinDate.ToString("MM/dd/yyyy");
            if (bstdMast.birthDate > DateTime.MinValue)
                this.birthDate.Value = bstdMast.birthDate.ToString("MM/dd/yyyy");
            this.address1.Value = bstdMast.address1;
            this.address2.Value = bstdMast.address2;
            this.city.Value = bstdMast.city;            
            this.zip.Value = bstdMast.zip;
            this.cellPhone.Value = bstdMast.cellPhone;
            this.workPhone.Value = bstdMast.workPhone;
            this.homePhone.Value = bstdMast.homePhone;
            this.emailId.Value = bstdMast.emailId;
            this.guardianName.Value = bstdMast.guardianName;
            this.Hours.Value = bstdMast.Hours;
            this.hourType.Value = bstdMast.hourType;
            this.gender.Value = bstdMast.gender;
            this.School.Value = bstdMast.School;
            this.Grade.Value = bstdMast.Grade;

            /* Save Student Picture & Hibbies */
            this.goals.Value = bstdPic.goals;
            this.hobbies.Value = bstdPic.hobbies;
            this.personality.Value = bstdPic.personality;
            this.tutorprefs.Value = bstdPic.tutorpreference;

            //referencedby, expectedDuration, blcRecommend, proposedProg, proposedHour, parentComments, parentExpects, emergName, emergPhone
            this.referencedby.Value = bstdRef.referencedby;
            this.attenduration.Value = bstdRef.expectedDuration;
            this.blcplan.Value = bstdRef.blcRecommend;
            this.proposedProg.Value = bstdRef.proposedProg;
            this.proposedHours.Value = bstdRef.proposedHour;
            this.parentComments.Value = bstdRef.parentComments;
            this.parentExpects.Value = bstdRef.parentExpects;
            this.emergName.Value = bstdRef.emergName;
            this.emergPhone.Value = bstdRef.emergPhone;
            this.healthConditions.Value = bstdRef.healthConditions;

            this.parentemail.Value = bstdPay.parentEmail;
            this.paymentname1.Value = bstdPay.Name;
            this.paymentmethod.Value = bstdPay.payMethod;
        }

        private void SavePrograms(Guid studentGuid)
        {
            string programsData = Request.Form["programsData"];
            if (!string.IsNullOrEmpty(programsData))
            {
                string[] aryProgs = programsData.Split('\n');
                for (int i = 0; i < aryProgs.Length; i++)
                {
                    string[] aryFields = aryProgs[i].Split('\t');
                    Decimal ddamt;
                    if (aryFields[0].Length > 16)
                    {
                        /* Edit or Delete */
                        BestStudentPrograms bstdProg = new BestStudentPrograms();
                        List<BestField> bparams = new List<BestField>();
                        BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                        guid.fieldValue = aryFields[0];
                        bparams.Add(guid);

                        if (!string.IsNullOrEmpty(guid.fieldValue))
                        {
                            bstdProg.LoadRows("guidfield=?", bparams);
                        }
                        bstdProg.programguid = (Guid)Utils.getNullableGuid(aryFields[1]);
                        Decimal.TryParse(aryFields[2], out ddamt);
                        bstdProg.Amount = ddamt;
                        bstdProg.CurrentRow.IsDelete = aryFields[3].Equals("true\r");
                        bstdProg.CurrentRow.Save();
                    }
                    else if(aryFields[0].Length != 0)
                    { 
                        /* Add */
                        Guid? programguid = Utils.getNullableGuid(aryFields[1]);
                        if (programguid != null)
                        {
                            BestStudentPrograms bstdProg = new BestStudentPrograms();
                            bstdProg.studentGuid = studentGuid;
                            bstdProg.programguid = new Guid(aryFields[1]);
                            Decimal.TryParse(aryFields[2], out ddamt);
                            bstdProg.Amount = ddamt;
                            bstdProg.StudentId = this.StudentId.Value;
                            bstdProg.CenterId = this.CenterId.Value;
                            bstdProg.CurrentRow.Save();
                        }
                    }
                }
            }
        }

        private void SavePickupInfo(Guid studentGuid)
        {
            string pickupData = Request.Form["pickupInfoData"];
            if (!string.IsNullOrEmpty(pickupData))
            {
                string[] aryPick = pickupData.Split('\n');
                for (int i = 0; i < aryPick.Length; i++)
                {
                    string[] aryFields = aryPick[i].Split('\t');
                    if (aryFields[0].Length > 16)
                    {
                        /* Edit or Delete */
                        BestStudentPickup bstdPickup = new BestStudentPickup();
                        List<BestField> bparams = new List<BestField>();
                        BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                        guid.fieldValue = aryFields[0];
                        bparams.Add(guid);

                        if (!string.IsNullOrEmpty(guid.fieldValue))
                        {
                            bstdPickup.LoadRows("guidfield=?", bparams);
                        }
                        bstdPickup.contactName = aryFields[1];
                        bstdPickup.contactPhone = aryFields[2];
                        bstdPickup.relationship = aryFields[3];
                        bstdPickup.CurrentRow.IsDelete = aryFields[4].Equals("true\r");
                        bstdPickup.CurrentRow.Save();
                    }
                    else if (aryFields[0].Length != 0)
                    {
                        /* Add */
                        BestStudentPickup bstdPick = new BestStudentPickup();
                        bstdPick.CenterId = this.CenterId.Value;
                        bstdPick.studentGuid = studentGuid;
                        bstdPick.StudentId = this.StudentId.Value;
                        bstdPick.contactName = aryFields[1];
                        bstdPick.contactPhone = aryFields[2];
                        bstdPick.relationship = aryFields[3];
                        bstdPick.CurrentRow.Save();
                    }
                }
            }
        }

        private void SaveGPA(Guid studentGuid)
        {
            string assessmentData = Request.Form["assessmentData"];
            if (!string.IsNullOrEmpty(assessmentData))
            {
                string[] aryGPA = assessmentData.Split('\n');
                for (int i = 0; i < aryGPA.Length; i++)
                {
                    string[] aryFields = aryGPA[i].Split('\t');
                    if (aryFields[0].Length > 16)
                    {
                        /* Edit or Delete */
                        BestStudentGPA bstudGPA = new BestStudentGPA();
                        List<BestField> bparams = new List<BestField>();
                        BestField guid = new BestField() { fieldName = "guidfield", fieldSize = 40, fieldType = "System.Guid", paramOledbType = System.Data.OleDb.OleDbType.Guid, displayField = false };
                        guid.fieldValue = aryFields[0];
                        bparams.Add(guid);

                        if (!string.IsNullOrEmpty(guid.fieldValue))
                        {
                            bstudGPA.LoadRows("guidfield=?", bparams);
                        }
                        if (!string.IsNullOrEmpty(aryFields[1]))
                            bstudGPA.assessmentDate = Convert.ToDateTime(aryFields[1]);
                        bstudGPA.assessmentGPA = aryFields[2];
                        bstudGPA.assessmentLevel = aryFields[3];
                        bstudGPA.CurrentRow.IsDelete = aryFields[4].Equals("true\r");
                        bstudGPA.CurrentRow.Save();
                    }
                    else if (aryFields[0].Length != 0)
                    {
                        /* Add */
                        BestStudentGPA bstudGPA = new BestStudentGPA();
                        bstudGPA.studentGuid = studentGuid;
                        if(!string.IsNullOrEmpty( aryFields[1]))
                            bstudGPA.assessmentDate = Convert.ToDateTime(aryFields[1]);
                        bstudGPA.assessmentGPA = aryFields[2];
                        bstudGPA.assessmentLevel = aryFields[3];
                        bstudGPA.StudentId = this.StudentId.Value;
                        bstudGPA.CenterId = this.CenterId.Value;
                        bstudGPA.CurrentRow.Save();
                    }
                }
            }
        }

        private void doSave(Guid studentGuid)
        {
            /* Saving New or Edit */
            string doSave = Request["doSave"];
            if (!string.IsNullOrEmpty(doSave) && doSave.Equals("1"))
            {
                /* Save Student Information */
                string centerid = this.CenterId.Items[this.CenterId.SelectedIndex].Value;
                bstdMast.guidfield = studentGuid;
                bstdMast.StudentId = this.StudentId.Value;
                bstdMast.CenterId = centerid;
                bstdMast.firstName = this.firstName.Value;
                bstdMast.lastName = this.lastName.Value;
                bstdMast.middleName = this.middleName.Value;
                bstdMast.parentName = this.parentName.Value;
                if (!string.IsNullOrEmpty(this.joinDate.Value))
                {
                    bstdMast.joinDate = Convert.ToDateTime(this.joinDate.Value);
                }
                if (!string.IsNullOrEmpty(this.birthDate.Value))
                {
                    bstdMast.birthDate = Convert.ToDateTime(this.birthDate.Value);
                }
                bstdMast.address1 = this.address1.Value;
                bstdMast.address2 = this.address2.Value;
                bstdMast.city = this.city.Value;
                bstdMast.state = Request.Form["selState"] ?? "";
                bstdMast.zip = this.zip.Value;
                bstdMast.cellPhone = this.cellPhone.Value;
                bstdMast.workPhone = this.workPhone.Value;
                bstdMast.homePhone = this.homePhone.Value;
                bstdMast.emailId = this.emailId.Value;
                bstdMast.guardianName = this.guardianName.Value;
                bstdMast.Hours = this.Hours.Value;
                bstdMast.hourType = this.hourType.Value;
                bstdMast.gender = this.gender.Value;
                bstdMast.School = this.School.Value;
                bstdMast.Grade = this.Grade.Value;

                /* Save Student Picture & Hibbies */
                bstdPic.studentGuid = studentGuid;
                bstdPic.StudentId = this.StudentId.Value;
                bstdPic.CenterId = centerid;
                bstdPic.goals = this.goals.Value;
                bstdPic.hobbies = this.hobbies.Value;
                bstdPic.personality = this.personality.Value;
                bstdPic.tutorpreference = this.tutorprefs.Value;

                //referencedby, expectedDuration, blcRecommend, proposedProg, proposedHour, parentComments, parentExpects, emergName, emergPhone
                bstdRef.referencedby = this.referencedby.Value;
                bstdRef.expectedDuration = this.attenduration.Value;
                bstdRef.blcRecommend = this.blcplan.Value;
                bstdRef.proposedProg = this.proposedProg.Value;
                bstdRef.proposedHour = this.proposedHours.Value;
                bstdRef.parentComments = this.parentComments.Value;
                bstdRef.parentExpects = this.parentExpects.Value;
                bstdRef.emergName = this.emergName.Value;
                bstdRef.emergPhone = this.emergPhone.Value;
                bstdRef.CenterId = centerid;
                bstdRef.studentGuid = studentGuid;
                bstdRef.StudentId = this.StudentId.Value;
                bstdRef.healthConditions = this.healthConditions.Value;

                bstdPay.CenterId = centerid;
                bstdPay.StudentId = this.StudentId.Value;
                bstdPay.studentGuid = studentGuid;
                bstdPay.parentEmail = this.parentemail.Value;
                bstdPay.Name = this.paymentname1.Value;
                bstdPay.payMethod = this.paymentmethod.Value;

                string errorMsg = "";
                if (bstdMast.CurrentRow.Save())
                {
                    SavePrograms(studentGuid);
                    SavePickupInfo(studentGuid);
                    SaveGPA(studentGuid);
                    bstdPay.CurrentRow.Save();
                    errorMsg = bstdPay.CurrentRow.lastError;
                    bstdPic.CurrentRow.Save();
                    errorMsg += bstdPic.CurrentRow.lastError;
                    bstdRef.CurrentRow.Save();
                    errorMsg += bstdRef.CurrentRow.lastError;
                    if (errorMsg.Length > 0)
                    {
                        OleDbCommand myCmd = bstdMast.dbCmd;
                        myCmd.CommandText = "insert into BestLogs (message) values (?)";
                        OleDbParameter p1 = new OleDbParameter("msg", OleDbType.VarChar, 9999999);
                        p1.Value = errorMsg;
                        myCmd.ExecuteNonQuery();
                    }
                    Response.Redirect("StudentsInfo.aspx?ms=3");
                }
            }
        }
    }
}
