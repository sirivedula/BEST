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
using System.Collections;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Text;

namespace BaliEnterpriseSystems.BestObjects
{
    public class BestGrid
    {
        public BestGrid()
        {
            this.whereClause = "";
            this.allowAdd = true;
            this.allowDelete = true;
            this.allowEdit = true;
        }

        public string orderby
        {
            get;
            set;
        }

        /* Grid To HTML */
        public string ToHTML()
        {
            StringBuilder gridhtml = new StringBuilder();
            gridhtml.Append("<div class=\"centered\">");
            gridhtml.Append("<table class=\"gridtitle\"><tr><td>" + HttpUtility.HtmlEncode(this.Title) + "</td></tr></table>");
            gridhtml.Append("<table id=\"tblGrid\" class=\"bestgrid\" style=\"width:100%;\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">");
            gridhtml.Append(SearchAndPageHTML());
            gridhtml.Append(HeaderHTML);
            gridhtml.Append(MakeRowsHTML);
            gridhtml.Append("</table>");
            if (GridTable.allowAdd && this.allowAdd)
            {
                gridhtml.Append("<span><input type=\"button\" id=\"btnAdd\" value=\"Add\" onclick=\"addNew();\" /></span>");
            }
            if (!string.IsNullOrEmpty(this.AfterAddHTML))
            {
                gridhtml.Append(this.AfterAddHTML);
            }
            gridhtml.Append("</div>");
            gridhtml.Append("<span><input type=\"hidden\" id=\"isnew\" name=\"isnew\" /><input type=\"hidden\" id=\"guidfield\" name=\"guidfield\" /><input type=\"hidden\" id=\"deleteguid\" name=\"deleteguid\" /></span>");
            gridhtml.Append(HiddenFields());
            /* Grid Java Script */
            gridhtml.Append(gridScript());

            return gridhtml.ToString();
        }

        /* Grid Table */
        public BestTable GridTable
        {
            get;
            set;
        }

        /* 1. Title of the Grid */
        public string Title
        {
            get;
            set;
        }

        public HttpRequest PageRequest
        {
            get;
            set;
        }

        private int startRec
        {
            get;
            set;
        }

        private int endRec
        {
            get;
            set;
        }

        private int TotalRec
        {
            get
            {
                return GridTable.TableRows.Count;
            }
        }

        private string perPage
        {
            get;
            set;
        }

        private string HeaderSortBy
        {
            get;
            set;
        }

        private string HeaderSortDir
        {
            get;
            set;
        }

        public string whereClause
        {
            get;
            set;
        }

        private List<BestField> _whereParams;
        public List<BestField> whereParams
        {
            get
            {
                return _whereParams;
            }
            set
            {
                _whereParams = value;
            }
        }

        private void filtertheSearch()
        {
            string inputstr = PageRequest.Form["searchValue"];
            string searchField = PageRequest.Form["searchField"];
            this.HeaderSortDir = PageRequest.Form["sortdir"];
            this.HeaderSortBy = PageRequest.Form["sortby"];
            if (string.IsNullOrEmpty(this.HeaderSortBy))
            {
                for (int cnt = 0; cnt < this.GridTable.TableFields.Count; cnt++ )
                {
                    if (this.GridTable.TableFields[cnt].displayField)
                    {
                        this.HeaderSortBy = this.GridTable.TableFields[cnt].fieldName;
                        break;
                    }
                }
            }
            if (string.IsNullOrEmpty(this.HeaderSortDir))
            {
                this.HeaderSortDir = "asc";
            }

            if (!string.IsNullOrEmpty(inputstr) && !string.IsNullOrEmpty(searchField))
            {
                List<BestField> listbfld = new List<BestField>();
                if (!string.IsNullOrEmpty(this.whereClause))
                {
                    searchField = this.whereClause + " and " + searchField;
                    for (int i = 0; i < this.whereParams.Count; i++)
                    {
                        listbfld.Add(this.whereParams[i]);
                    }                
                }
                BestField bfld = new BestField() { fieldName = searchField, displayField = false, fieldType = "System.String", paramOledbType = OleDbType.VarChar, fieldSize = 20 };
                bfld.fieldValue = inputstr + '%';
                listbfld.Add(bfld);
                if (this.hasCenterId())
                {
                    listbfld.Add(Utils.User.CenterIdField);
                    this.GridTable.LoadRows(searchField + " like ? and CenterId=?", listbfld, this.HeaderSortBy + " " + this.HeaderSortDir);
                }
                else
                {
                    this.GridTable.LoadRows(searchField + " like ?", listbfld, this.HeaderSortBy + " " + this.HeaderSortDir);
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(this.whereClause))
                {
                    if (hasCenterId())
                    {
                        _whereParams.Add(Utils.User.CenterIdField);
                        this.GridTable.LoadRows(this.whereClause + " and CenterId=?", this.whereParams, this.HeaderSortBy + " " + this.HeaderSortDir);
                    }
                    else
                    {
                        this.GridTable.LoadRows(this.whereClause, this.whereParams, this.HeaderSortBy + " " + this.HeaderSortDir);
                    }
                }
                else
                {
                    if (hasCenterId())
                    {
                        this.GridTable.LoadRows("CenterId=?",Utils.User.CIdParam, this.HeaderSortBy + " " + this.HeaderSortDir);
                    }
                    else
                    {
                        this.GridTable.LoadRows(this.HeaderSortBy + " " + this.HeaderSortDir);
                    }
                }
            }
        }

        private bool hasCenterId()
        {
            bool result = false;
            if (!(this.GridTable is BestCenters))
            {
                for (int i = 0; i < GridTable.TableFields.Count; i++)
                {
                    BestField bfld = GridTable.TableFields[i];
                    if (bfld.fieldName.Equals("CenterId", StringComparison.InvariantCultureIgnoreCase))
                    {
                        result = true;
                        break;
                    }
                }
            }
            return result;
        }

        /* 2. Search - Per Page - Page List */
        private string SearchAndPageHTML()
        {
            filtertheSearch();

            StringBuilder sb = new StringBuilder();
            this.perPage = PageRequest.Form["perpage"];
            UserPrefs up = new UserPrefs(Utils.User.UserName);
            string prefPerPage = up.getPreference(this.GridTable.TableName);
            if (string.IsNullOrEmpty(this.perPage))
            {
                this.perPage = string.IsNullOrEmpty(prefPerPage) ? "50" : prefPerPage;
            }
            if (! prefPerPage.Equals(this.perPage))
            {
                up.SetPreference(this.GridTable.TableName, this.perPage);
            }

            string[] aryPerPage = new string[] { "10", "20", "30", "40", "50", "70", "100" };

            sb.Append("<thead><tr><td colspan=\"" + (GridTable.TableFields.Count + 1).ToString() + "\">");
            sb.Append("<table class=\"gridpaging\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tr><td>Per Page</td><td>");
            sb.Append("<input type=\"hidden\" id=\"sortby\" name=\"sortby\"  value=\"" + HttpUtility.HtmlEncode(this.HeaderSortBy) + "\" /><input type=\"hidden\" id=\"sortdir\" name=\"sortdir\" value=\"" + HttpUtility.HtmlEncode(this.HeaderSortDir) + "\"/>");
            sb.Append("<select id=\"perpage\" name=\"perpage\" onchange=\"submit();\">");
            for (int i = 0; i < aryPerPage.Length; i++)
            {
                sb.Append("<option value=\"" + HttpUtility.HtmlEncode(aryPerPage[i]) + "\" " + (this.perPage.Equals(aryPerPage[i]) ? "selected" : "") + " >" + HttpUtility.HtmlEncode(aryPerPage[i]) + "</option>");
            }
            sb.Append("</select></td><td style=\"border-right:1px solid #333;\">&nbsp;</td>");
            sb.Append("<td>Search</td><td><select style=\"padding:2px;font-family:Tahoma;font-size:10px;\"  id=\"searchField\" name=\"searchField\" ><option value=\"\"></option>");
            string searchField = PageRequest.Form["searchField"];
            
            for(int j=0; j< GridTable.TableFields.Count; j++)
            {
                string fldname = GridTable.TableFields[j].fieldName.ToLower();
                if (!(fldname.Equals("guidfield") || fldname.Equals("lastchange") || fldname.Equals("lastchangeuser")))
                {
                    sb.Append("<option value=\"" + HttpUtility.HtmlEncode(fldname) + "\" " + ((!string.IsNullOrEmpty(searchField) && searchField.Equals(fldname, StringComparison.InvariantCultureIgnoreCase))? " selected " : "")  + ">" + HttpUtility.HtmlEncode( GridTable.TableFields[j].fieldHeader) + "</option>");
                }
            }
            string searchVal = PageRequest.Form["searchValue"];
            if (string.IsNullOrEmpty(searchVal)) searchVal = "";
            sb.Append("</select></td><td><input type=\"text\" style=\"padding:2px;font-family:Tahoma;font-size:10px;\" id=\"searchValue\" name=\"searchValue\" size=\"12\" maxlength=\"20\" value=\"" + HttpUtility.HtmlEncode(searchVal) + "\" /></td><td><a  href=\"javascript:void(0);\" onclick=\"submit();\"><img src=\"images\\zoom.png\" style=\"height:16px;width:16px;vertical-align:middle;border:0px;\" alt=\"search\" /></a></td>");

            /* Pages HTML */
            int perpage;
            int.TryParse(this.perPage, out perpage);
            this.startRec = 0;
            this.endRec = this.TotalRec;
            if (this.TotalRec > perpage)
            {
                sb.Append("<td style=\"border-right:1px solid #333;\">&nbsp;</td>");
                int numPages = (this.TotalRec / perpage) + 1;
                string cpage = PageRequest.Form["curpage"];
                int curpage;
                int.TryParse(cpage, out curpage);
                if (curpage > 1)
                {
                    sb.Append("<td><img src=\"images\\pagestart.png\" alt=\"start\" title=\"start page\" onclick=\"gotoPage(0);\" /></td>");
                    sb.Append("<td><img src=\"images\\pageprior.png\" alt=\"prior\" title=\"prior page\" onclick=\"gotoPage(-1);\" /></td>");
                }
                sb.Append("<td><select id=\"curpage\" name=\"curpage\" onchange=\"submit();\">");
                for (int pn = 1; pn <= numPages; pn++)
                {
                    sb.Append("<option value=\"" + pn.ToString() + "\" " + ((curpage==pn)?"selected":"")  + " >" + pn.ToString() + "</option>");
                }
                sb.Append("</select></td>");
                if (curpage != numPages)
                {
                    sb.Append("<td><img src=\"images\\pagenext.png\" alt=\"next\" title=\"next page\" onclick=\"gotoPage(1);\" /></td>");
                    sb.Append("<td><img src=\"images\\pageend.png\" alt=\"end\" title=\"end page\" onclick=\"gotoPage(" + numPages.ToString() + ");\" /></td>");
                }
                this.startRec = (curpage!=0) ? (curpage-1) * perpage : 0;
                this.endRec = this.startRec + perpage;
                if (this.endRec > this.TotalRec) this.endRec = this.TotalRec;
            }
            sb.Append("</tr></table>");
            sb.Append("</td></tr></thead>");
            return sb.ToString();
        }

        /* 3. Grid Headers */
        private string HeaderHTML
        {
            get
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<thead class=\"gridheader\"><tr>");
                for (int i = 0; i < GridTable.TableFields.Count; i++)
                {
                    BestField bfld = GridTable.TableFields[i];
                    if (bfld.displayField)
                    {
                        sb.Append("<th onclick=\"BestJSGrid.HeaderSort('" + bfld.fieldName +"');\">" + HttpUtility.HtmlEncode(bfld.fieldHeader));
                        if (this.HeaderSortBy.Equals(bfld.fieldName))
                        {
                            if (this.HeaderSortDir.Equals("asc"))
                            {
                                sb.Append("<span style=\"padding-left:5px;\"><img src=\"images/ARW03DN.png\" alt=\"\" /></span>");
                            }
                            else
                            {
                                sb.Append("<span style=\"padding-left:5px;\"><img src=\"images/ARW03UP.png\" alt=\"\" /></span>");
                            }
                        }
                        sb.Append("</th>");
                    }
                }
                sb.Append("<th>&nbsp;</th>");
                if (!string.IsNullOrEmpty(this.extraRowHTML))
                {
                    sb.Append("<th>&nbsp;</th>");
                }
                sb.Append("</tr></thead>");
                return sb.ToString();
            }
        }

        /* Make Rows */
        private string MakeRowsHTML
        {
            get
            {
                StringBuilder rowshtml = new StringBuilder();
                for (int r = this.startRec; r < this.endRec; r++)
                {
                    string srclass = " class=" + ((r % 2 == 0) ? "\"grideven\"" : "\"gridodd\"");
                    rowshtml.Append(RowHTML(r, GridTable.TableRows[r], srclass));
                }
                return rowshtml.ToString();
            }
        }

        /* 4. Make Data Rows */
        private string RowHTML(int rownum, BestRow brow, string srclass)
        {
            StringBuilder sb = new StringBuilder();            
            sb.Append("<tr" + srclass + ">");
            for (int i = 0; i < brow.Fields.Count; i++)
            {
                if (brow.Fields[i].displayField)
                {
                    sb.Append("<td>");
                    if (brow.Fields[i].displayFormatFunc != null)
                    {
                        sb.Append(brow.Fields[i].displayFormatFunc.Invoke(brow));
                    }
                    else
                    {
                        sb.Append(HttpUtility.HtmlEncode(brow.Fields[i].fieldValue));
                    }
                    string htmlname = "Field" + rownum.ToString() + "_" + i.ToString();
                    /*
                     * sb.Append("<input type=\"hidden\" id=\"" + htmlname + "\" name=\"" + htmlname + "\" value=\"" + HttpUtility.HtmlEncode(brow.Fields[i].fieldValue) + "\" />");
                     */
                    sb.Append("</td>" + '\n');
                }
            }
            sb.Append("<td>");
            if (GridTable.allowEdit && this.allowEdit)
            {
                sb.Append("<a href=\"javascript:void(0);\" onclick=\"editForm('" + rownum.ToString() + "');\"><img alt=\"edit\" style=\"border:0px;\" src=\"images/gridedit.png\" title=\"edit the record\" /></a>&nbsp;&nbsp;");
            }
            if (GridTable.allowDelete && this.allowDelete)
            {
                sb.Append("<a href=\"javascript:void(0);\" onclick=\"BestJSGrid.deleteRec('" + brow.Fields["guidfield"].fieldValue + "');\"><img src=\"images/cancel.png\" style=\"border:0px;\" alt=\"delete\" title=\"delete the record\" /></a></td>");
            }
            if (!string.IsNullOrEmpty(this.extraRowHTML))
            {
                string replExtraHTML = extraRowHTML.Replace("[paramGuid]", HttpUtility.UrlEncode(brow.Fields["guidfield"].fieldValue));
                replExtraHTML = replExtraHTML.Replace("[paramCID]", HttpUtility.UrlEncode(brow.Fields["CenterId"].fieldValue));
                replExtraHTML = replExtraHTML.Replace("[paramSID]", HttpUtility.UrlEncode(brow.Fields["StudentId"].fieldValue));
                replExtraHTML = replExtraHTML.Replace("[paramRowNum]", HttpUtility.UrlEncode(rownum.ToString()));
                sb.Append("<td>" + replExtraHTML + "</td>"); 
            }
            sb.Append("</tr>");

            return sb.ToString();
        }

        /* 5. New Hidden Row 
         * Will open new page and save it. Even Update will also go to the new page and save it.
         * Do not need to be on the same page - make it simple.
         */

        private string gridScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<script type=\"text/javascript\">");
            sb.AppendLine("gridJS = {title:" + Utils.EnquoteJS(this.Title) + ",");
            sb.AppendLine("Rows:[");
            for (int r = 0; r < GridTable.TableRows.Count; r++)
            {
                BestRow brow = GridTable.TableRows[r];
                sb.Append("{");
                for (int c = 0; c < brow.Fields.Count; c++)
                {
                    if (brow.Fields[c].paramOledbType == OleDbType.DBDate)
                    {
                        if (!string.IsNullOrEmpty(brow.Fields[c].fieldValue))
                        {
                            DateTime dd = Convert.ToDateTime(brow.Fields[c].fieldValue);
                            sb.Append(Utils.EnquoteJS(brow.Fields[c].fieldName) + ":" + Utils.EnquoteJS(dd.ToString("MM/dd/yyyy")));
                        }
                        else
                        {
                            sb.Append(Utils.EnquoteJS(brow.Fields[c].fieldName) + ":" + "\"\"");
                        }
                    }
                    else
                    {
                        sb.Append(Utils.EnquoteJS(brow.Fields[c].fieldName) + ":" + Utils.EnquoteJS(brow.Fields[c].fieldValue));
                    }
                    if (c < brow.Fields.Count - 1) sb.Append(",");
                }
                sb.AppendLine("}");
                if (r < GridTable.TableRows.Count - 1) sb.Append(",");
            }
            sb.Append("]}");
            sb.Append("</script>");
            return sb.ToString();
        }

        private string HiddenFields()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<span>");
            for (int c = 0; c < GridTable.TableFields.Count; c++)
            {
                sb.Append("<input type=\"hidden\" id=\"g_" + GridTable.TableFields[c].fieldName + "\" name=\"g_" + GridTable.TableFields[c].fieldName + "\" />");
            }
            sb.Append("</span>");
            return sb.ToString();
        }

        public string securityPage
        {
            get;
            set;
        }

        public string AfterAddHTML
        {
            get;
            set;
        }

        public string extraRowHTML
        {
            get;
            set;
        }

        public bool allowAdd
        {
            get;
            set;
        }

        public bool allowEdit
        {
            get;
            set;
        }

        public bool allowDelete
        {
            get;
            set;
        }
    
    }

}
