using DAL.Common;
using DAL.DAL;
using DAL.Ref.Logs;
using DAL.Ref.Roles;
using Newtonsoft.Json;
using System;
using System.Web;
using System.Web.UI;
using System.Xml.Serialization;

namespace Hospital.Utils
{
    public static class StaticUtils
    {
        public static void Authenticate()
        {
            if (HttpContext.Current.Session["username"] == null)
                HttpContext.Current.Response.Redirect("/Default");
        }
        public static void Authenticate(string functionId)
        {
            if (HttpContext.Current.Session["username"] == null)
                HttpContext.Current.Response.Redirect("/Default");
            RolesDb rdb = new RolesDb();
            if (!CheckRole(functionId))
                HttpContext.Current.Response.Redirect("/Home");
        }
        public static bool CheckRole(string functionId)
        {
            RolesDb rdb = new RolesDb();
            return rdb.Checkrole(functionId, HttpContext.Current.Session["userId"].ToString());
        }
        public static string GetQueryString(string key)
        {
            return ReadQueryString(key, "0");
        }
        public static string ReadQueryString(string key, string defVal)
        {
            return HttpContext.Current.Request.QueryString[key] ?? defVal;
        }
        public static void SetAlert(DbResult dr)
        {
            HttpContext.Current.Session["errorcode"] = dr.ErrorCode;
            HttpContext.Current.Session["msg"] = dr.Msg;
        }
        public static void CheckAlert(Page page)
        {
            if (HttpContext.Current.Session["errorcode"] != null)
            {
                ShowAlert(page, HttpContext.Current.Session["errorcode"].ToString(), HttpContext.Current.Session["msg"].ToString());
                HttpContext.Current.Session["errorcode"] = null;
                HttpContext.Current.Session["msg"] = null;
            }
        }
        public static void ShowAlert(Page page, string errorcode, string msg)
        {
            string script = "ShowSystemAlert('" + msg + "', '" + errorcode + "')";
            page.ClientScript.RegisterStartupScript(page.GetType(), "Alert", script, true);
        }
        public static string ObjectToXML(object input)
        {
            try
            {
                var stringwriter = new System.IO.StringWriter();
                var serializer = new XmlSerializer(input.GetType());
                serializer.Serialize(stringwriter, input);
                return stringwriter.ToString();
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    ex = ex.InnerException;
                return "Could not convert: " + ex.Message;
            }
        }
        public static void saveNotification(Page page,PostReq req)
        {
            LogDb _ld = new LogDb();
            string data = req.data;
            NotificationLogs postReq = JsonConvert.DeserializeObject<NotificationLogs>(data);
            postReq.user = HttpContext.Current.Session["username"].ToString();
            var res = _ld.SaveNotificationLog(postReq);
            page.Response.ContentType = "text/plain";
            NotificationLogsResponse nlr = new NotificationLogsResponse()
            {
                requestType = res["requestType"].ToString(),
                doctor = res["doctor"].ToString(),
                patient = res["patient"].ToString(),
                eventTime = res["eventTime"].ToString(),
                room = res["room"].ToString(),
                admitId = res["admitId"].ToString()
            };
            var json = JsonConvert.SerializeObject(nlr);
            page.Response.Write(json);
            page.Response.End();
        }
    }
}