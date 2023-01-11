using DAL.Ref.Components.Menu;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital
{
    public partial class SiteMaster : MasterPage
    {
        private readonly MenuDb _dao = new MenuDb();
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
                    fname.InnerText = Session["fullname"].ToString();
                }
                LoadMenu();
            }
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