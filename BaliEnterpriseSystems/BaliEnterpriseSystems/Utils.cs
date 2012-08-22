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
using System.Security.Cryptography;
using System.Text;
using System.Reflection;
using System.ComponentModel;
using BaliEnterpriseSystems.BestObjects;

namespace BaliEnterpriseSystems
{
    public static class Utils
    {
        public static CurrentUser User
        {
            get
            {
                if (HttpContext.Current.Session != null)
                {
                    var cuser = HttpContext.Current.Session["CurrentUser"];
                    if (cuser != null)
                    {
                        return (CurrentUser)cuser;
                    }
                }
                return null;
            }
        }

        public static bool IsGuid(string guid)
        {
            bool result=true;
            if (!string.IsNullOrEmpty(guid))
            {
                try
                {
                    Guid tmp = new Guid(guid);
                }
                catch (Exception ex)
                {
                    result = false;
                }
            }
            else
            {
                result = false;
            }
            return result;
        }

        public static Guid? getNullableGuid(string guid)
        {
            if (string.IsNullOrEmpty(guid))
            {
                return null;
            }
            try
            {
                Guid result = new Guid(guid);
                return result;
            }
            catch (Exception)
            {
                return null;
            }
        }


        public static string WarningMessage(string warning)
        {
            string result = warning;
            if (result.Contains("IX_"))
            {
                result = "Can not add duplicate record, because it is already exists.";
            }
                
            return @"<div class=""ui-widget"">
                <div class=""ui-state-error ui-corner-all"" style=""width:70%;margin-left:200px;margin-top: 5px; padding: 0 .7em;""> 
                <p><span class=""ui-icon ui-icon-alert"" style=""float: left; margin-right: .3em;""></span> 
                <strong>Alert:</strong>" + HttpUtility.HtmlEncode(result) + @"</p>
                </div>
            </div>";
        }

        public static string InfoMessage(string warning)
        {
            string result = warning;
            if (result.Contains("IX_"))
            {
                result = "Can not add duplicate record, because it is already exists.";
            }

            return @"<div class=""ui-widget"">
                <div class=""ui-state-highlight ui-corner-all"" style=""width:70%;margin-left:200px;margin-top: 5px; padding: 0 .7em;""> 
                <p><span class=""ui-icon ui-icon-info"" style=""float: left; margin-right: .3em;""></span> 
                " + HttpUtility.HtmlEncode(result).Replace("\n", "<br />") + @"</p>
                </div>
            </div>";
        }

        public static string GetMD5Hash(string input)
        {
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            byte[] bs = Encoding.UTF8.GetBytes(input + "874987^&*Masala Hash To Password Best75938*&*$");
            bs = md5.ComputeHash(bs);
            StringBuilder sb = new StringBuilder();
            foreach (byte b in bs)
            {
                sb.Append(b.ToString("x2").ToLower());
            }
            string password = sb.ToString();
            return password;
        }

        public static string EnquoteJS(string s)
        {
            if (s == null || s.Length == 0)
            {
                return "\"\"";
            }
            char c;
            int i;
            int len = s.Length;
            StringBuilder sb = new StringBuilder(len + 4);
            string t;

            sb.Append('"');
            for (i = 0; i < len; i += 1)
            {
                c = s[i];
                if ((c == '\\') || (c == '"') || (c == '>'))
                {
                    sb.Append('\\');
                    sb.Append(c);
                }
                else if (c == '\b')
                    sb.Append("\\b");
                else if (c == '\t')
                    sb.Append("\\t");
                else if (c == '\n')
                    sb.Append("\\n");
                else if (c == '\f')
                    sb.Append("\\f");
                else if (c == '\r')
                    sb.Append("\\r");
                else
                {
                    if (c < ' ')
                    {
                        //t = "000" + Integer.toHexString(c); 
                        string tmp = new string(c, 1);
                        t = "000" + int.Parse(tmp, System.Globalization.NumberStyles.HexNumber);
                        sb.Append("\\u" + t.Substring(t.Length - 4));
                    }
                    else
                    {
                        sb.Append(c);
                    }
                }
            }
            sb.Append('"');
            return sb.ToString();
        } 

        public static bool IsNullableType(Type theType)
        {
            return (theType.IsGenericType && theType.GetGenericTypeDefinition().Equals(typeof(Nullable<>)));
        }

        public static string GenericArgType(Type theType)
        {
            Type[] t = theType.GetGenericArguments();
            if (t.Length > 0)
            {
                return t[0].Name;
            }
            return "";
        }

        public static string ToTimeFormat(string num)
        {
            string result = num;
            if (!string.IsNullOrEmpty(num))
            {
                int temp = int.Parse(num);
                if (temp > 1230)
                {
                    temp = temp - 1200;
                }
                result = (temp > 930) ? temp.ToString().Substring(0, 2) + ":" + temp.ToString().Substring(2, 2) : temp.ToString().Substring(0, 1) + ":" + temp.ToString().Substring(1, 2);
            }
            return result;
        }

        public static object ToType(string val, Type ty)
        {
            string myTypeName = ty.Name.ToUpper();
            Type ovType = ty;
            if (IsNullableType(ty))
            {
                myTypeName = GenericArgType(ty).ToUpper();
            }
            if (IsNullableType(ty))
            {
                if (String.IsNullOrEmpty(val))
                {
                    return null;
                }
                NullableConverter nc = new NullableConverter(ty);
                ovType = nc.UnderlyingType;
            }
            switch (myTypeName)
            {
                case "BOOLEAN":
                    switch (val.ToUpper())
                    {

                        case "1":
                        case "-1":
                        case "T":
                        case "TRUE":
                        case "Y":
                        case "YES":
                            return true;
                        default:
                            return false;
                    }
                case "DATETIME":
                    if ((val??"").Equals(""))
                    {
                        return DateTime.MinValue;
                    }
                    break;
                case "BYTE":
                case "DECIMAL":
                case "INT32":
                case "INT16":
                case "SBYTE":
                case "SHORT":
                case "USHORT":
                case "FLOAT":
                case "DOUBLE":
                case "LONG":
                case "ULONG":
                    if (val.Equals(""))
                    {
                        return Convert.ChangeType("0", ovType);
                    }
                    break;
                case "GUID":
                    return new Guid(val);
            }

            return Convert.ChangeType(val, ovType);
        }

        public static string MenuSelectScript(string ms)
        {
            string result = "";
            if (!string.IsNullOrEmpty(ms))
            {
                result = "<script type=\"text/javascript\"> $().ready(function(){ $('#liMenu" + ms + "').addClass('Selected');";
                result += "$('#bleft" + ms + "').addClass(\"L\");";
                result += "$('#bright" + ms + "').addClass(\"R\");";
                result += "}); </script>";
            }
            return result;
        }

        public static string StateOptions()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<option value=\"\"></option>");
            sb.Append("<option value=\"AK\">AK  (Alaska)</option>");
            sb.Append("<option value=\"AL\">AL  (Alabama)</option>");
            sb.Append("<option value=\"AR\">AR  (Arkansas)</option>");
            sb.Append("<option value=\"AZ\">AZ  (Arizona)</option>");
            sb.Append("<option value=\"CA\" selected>CA  (California)</option>");
            sb.Append("<option value=\"CO\">CO  (Colorado)</option>");
            sb.Append("<option value=\"CT\">CT  (Connecticut)</option>");
            sb.Append("<option value=\"DC\">DC  (Washington DC)</option>");
            sb.Append("<option value=\"DE\">DE  (Delaware)</option>");
            sb.Append("<option value=\"FL\">FL  (Florida)</option>");
            sb.Append("<option value=\"GA\">GA  (Georgia)</option>");
            sb.Append("<option value=\"HI\">HI  (Hawaii)</option>");
            sb.Append("<option value=\"IA\">IA  (Iowa)</option>");
            sb.Append("<option value=\"ID\">ID  (Idaho)</option>");
            sb.Append("<option value=\"IL\">IL  (Illinois)</option>");
            sb.Append("<option value=\"IN\">IN  (Indiana)</option>");
            sb.Append("<option value=\"KS\">KS  (Kansas)</option>");
            sb.Append("<option value=\"KY\">KY  (Kentucky)</option>");
            sb.Append("<option value=\"LA\">LA  (Lousiana)</option>");
            sb.Append("<option value=\"MA\">MA  (Massachusetts)</option>");
            sb.Append("<option value=\"MD\">MD  (Maryland)</option>");
            sb.Append("<option value=\"ME\">ME  (Maine)</option>");
            sb.Append("<option value=\"MI\">MI  (Michigan)</option>");
            sb.Append("<option value=\"MN\">MN  (Minnesota)</option>");
            sb.Append("<option value=\"MO\">MO  (Missouri)</option>");
            sb.Append("<option value=\"MS\">MS  (Mississippi)</option>");
            sb.Append("<option value=\"MT\">MT  (Montana)</option>");
            sb.Append("<option value=\"NC\">NC  (North Carolina)</option>");
            sb.Append("<option value=\"ND\">ND  (North Dakota)</option>");
            sb.Append("<option value=\"NE\">NE  (Nebraska)</option>");
            sb.Append("<option value=\"NH\">NH  (New Hampshire)</option>");
            sb.Append("<option value=\"NJ\">NJ  (New Jersey)</option>");
            sb.Append("<option value=\"NM\">NM  (New Mexico)</option>");
            sb.Append("<option value=\"NV\">NV  (Nevada)</option>");
            sb.Append("<option value=\"NY\">NY  (New York)</option>");
            sb.Append("<option value=\"OH\">OH  (Ohio)</option>");
            sb.Append("<option value=\"OK\">OK  (Oklahoma)</option>");
            sb.Append("<option value=\"OR\">OR  (Oregon)</option>");
            sb.Append("<option value=\"PA\">PA  (Pennsylvania)</option>");
            sb.Append("<option value=\"PR\">PR  (Puerto Rico)</option>");
            sb.Append("<option value=\"RI\">RI  (Rhode Island)</option>");
            sb.Append("<option value=\"SC\">SC  (South Carolina)</option>");
            sb.Append("<option value=\"SD\">SD  (South Dakota)</option>");
            sb.Append("<option value=\"TN\">TN  (Tennessee)</option>");
            sb.Append("<option value=\"TX\">TX  (Texas)</option>");
            sb.Append("<option value=\"UT\">UT  (Utah)</option>");
            sb.Append("<option value=\"VA\">VA  (Virginia)</option>");
            sb.Append("<option value=\"VI\">VI  (Virgin Islands)</option>");
            sb.Append("<option value=\"VT\">VT  (Vermont)</option>");
            sb.Append("<option value=\"WA\">WA  (Washington)</option>");
            sb.Append("<option value=\"WI\">WI  (Wisconsin)</option>");
            sb.Append("<option value=\"WV\">WV  (West Virginia)</option>");
            sb.Append("<option value=\"WY\">WY  (Wyoming)</option>");
            return sb.ToString();
        }

        public static string RelationshipOptions()
        {
                return "<option value=\"\"></option>" +
                "<option value=\"Adopted Child\">Adopted Child</option>" +
                "<option value=\"Brother or Sister\">Brother or Sister</option>" +
                "<option value=\"Brother/Sister-in-law\">Brother/Sister-in-law</option>" +
                "<option value=\"Child\">Child</option>" +
                "<option value=\"Collateral Dependent\">Collateral Dependent</option>" +
                "<option value=\"Court Appointed Guardian\">Court Appointed Guardian</option>" +
                "<option value=\"Cousin\">Cousin</option>" +
                "<option value=\"Dependent of a Minor Dependent\">Dependent of a Minor Dependent</option>" +
                "<option value=\"Ex-spouse\">Ex-spouse</option>" +
                "<option value=\"Father\">Father</option>" +
                "<option value=\"Father or Mother\">Father or Mother</option>" +
                "<option value=\"Foster Child\">Foster Child</option>" +
                "<option value=\"Grandfather or Grandmother\">Grandfather or Grandmother</option>" +
                "<option value=\"Grandson or Granddaughter\">Grandson or Granddaughter</option>" +
                "<option value=\"Guardian\">Guardian</option>" +
                "<option value=\"Life Partner\">Life Partner</option>" +
                "<option value=\"Mother\">Mother</option>" +
                "<option value=\"Mother/Father-in-law\">Mother/Father-in-law</option>" +
                "<option value=\"Nephew or Niece\">Nephew or Niece</option>" +
                "<option value=\"Other\">Other</option>" +
                "<option value=\"Son/Daughter-in-law\">Son/Daughter-in-law</option>" +
                "<option value=\"Sponsored Dependent\">Sponsored Dependent</option>" +
                "<option value=\"Spouse\">Spouse</option>" +
                "<option value=\"Stepfather\">Stepfather</option>" +
                "<option value=\"Stepmother\">Stepmother</option>" +
                "<option value=\"Stepson or Stepdaughter\">Stepson or Stepdaughter</option>" +
                "<option value=\"Uncle or Aunt\">Uncle or Aunt</option>" +
                "<option value=\"Ward\">Ward</option>";
        }
    }
}
