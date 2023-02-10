using DAL.Common;
using DAL.Ref.Components.Menu;
using DAL.Ref.Logs;
using Newtonsoft.Json;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;

namespace Hospital
{
    public partial class SiteMaster : MasterPage
    {
        private readonly MenuDb _dao = new MenuDb();
        private readonly LogDb _ld = new LogDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("/Default");
                }
                else
                {
                    string input;
                    using (var reader = new StreamReader(Request.InputStream))
                    {
                        input = reader.ReadToEnd();
                        if (!string.IsNullOrEmpty(input))
                        {
                            PostReq result = JsonConvert.DeserializeObject<PostReq>(input);
                            switch (result.MethodName)
                            {
                                case "saveNotification":
                                    
                                    saveNotification(result);
                                    break;
                            }
                            return;
                        }
                    }
                    fname.InnerText = Session["fullname"].ToString();
                }
                LoadMenu();
                
            }
        }

        private void saveNotification(PostReq req)
        {
            string data = req.data;
            NotificationLogs postReq = JsonConvert.DeserializeObject<NotificationLogs>(data);
            postReq.user = Session["username"].ToString();
            var res = _ld.SaveNotificationLog(postReq);
            Response.ContentType = "text/plain";
            NotificationLogsResponse nlr = new NotificationLogsResponse()
            {
                requestType = res["requestType"].ToString(),
                doctor = res["doctor"].ToString(),
                patient = res["patient"].ToString(),
                eventTime = res["eventTime"].ToString(),
                room = res["room"].ToString()
            };
            var json = JsonConvert.SerializeObject(nlr);             
            Response.Write(json);
            Response.End();
        }

        private void LoadMenu()
        {
            var res = _dao.Get();
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<ul class=\"nav nav-pills nav-sidebar flex-column\" data-widget=\"treeview\" role=\"menu\" data-accordion=\"false\">");
            foreach (DataRow dr in res.Rows)
            {
                sb.AppendLine("<li class=\"nav-item\">");
                sb.AppendLine("<a href=\"#\" class=\"nav-link\">");
                sb.AppendLine("<p>" + dr["title"].ToString() + "<i class=\"right fas fa-angle-left\"></i></p>");
                sb.AppendLine("</a>");
                sb.AppendLine("<ul class=\"nav nav-treeview\">");
                DataTable dt = JsonConvert.DeserializeObject<DataTable>(dr["submenus"].ToString());
                foreach (DataRow drow in dt.Rows)
                {
                    sb.AppendLine("<li class=\"nav-item\">");
                    sb.AppendLine("<a href=\"" + drow["link"].ToString() + "\" class=\"nav-link\">");
                    sb.AppendLine("<i class=\"fas fa-circle-sm nav-icon\"></i>");
                    sb.AppendLine("<p>" + drow["title"].ToString() + "</p>");
                    sb.AppendLine("</a>");
                    sb.AppendLine("</li>");
                }
                sb.AppendLine("</ul>");
                sb.AppendLine("</li>");
            }
            sb.AppendLine("</ul>");
            dynamicMenu.InnerHtml = sb.ToString();
        }
    }
}