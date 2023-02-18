using DAL.Common;
using DAL.Ref.Roles;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web;

namespace Hospital.Admin.User
{
    public partial class Roles : System.Web.UI.Page
    {
        private readonly RolesDb _dao = new RolesDb();
        private readonly string rolesFunctionId = "10105000";
        protected void Page_Load(object sender, EventArgs e)
        {
            StaticUtils.Authenticate(rolesFunctionId);
            if (!IsPostBack)
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
                            case "assign":
                                result.user = Session["username"].ToString();
                                markComplete(result);
                                break;
                        }
                        return;
                    }
                }
                CheckAlert();
                LoadData();
            }
        }
        private void LoadData()
        {
            string userId = GetRowId();
            var res = _dao.GetAllRoles(userId);
            if (res == null)
                Response.Redirect("/Home");
            StringBuilder sb = new StringBuilder();
            foreach (DataRow dr in res.Rows)
            {
                sb.Append(" <div class=\"col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column\">" +
                "<div class=\"card bg-light d-flex flex-fill\">" +
                "<div class=\"card-header text-muted border-bottom-0\">" +
                "<div class=\"row\">" +
                "<div class=\"col-10\">" +
                "<h2 class=\"lead\"><b>" + dr["details"] + "</b></h2>" +
                "</div>" +
                "<div class=\"col-2 text-center\">" +
                "<a href=\"javascript: void(null)\" onclick =\"DoAction('" + userId + "','" + dr["functionId"].ToString() + "')\" >");
                sb.Append(dr["isAssigned"].ToString() == "0" ? "<i class=\"fa fa-eye text-success\"></i>" : "<i class=\"fa fa-eye-slash text-secondary\"></i>");
                sb.Append("</a>" +
                "</div>" +
                "</div>" +
                "<hr />" +
                "</div>" +
                "<div class=\"card-body pt-0\">");

                DataTable dt = _dao.GetAllRolesPage(userId, dr["functionId"].ToString());
                if (dt != null)
                {
                    foreach (DataRow drow in dt.Rows)
                    {
                        sb.Append("<div class=\"row\">" +
                        "<div class=\"col-10\">" +
                        "<h3 class=\"lead\"><b>" + drow["details"] + "</b></h3>" +
                        "</div>" +
                        "<div class=\"col-2 text-center\">" +
                        "<a href=\"javascript: void(null)\" onclick =\"DoAction('" + userId + "','" + drow["functionId"].ToString() + "')\" >");
                        sb.Append(drow["isAssigned"].ToString() == "0" ? "<i class=\"fa fa-eye text-success\"></i>" : "<i class=\"fa fa-eye-slash text-secondary\"></i>");
                        sb.Append("</a>" +
                        "</div>" +
                        "</div>");
                        DataTable dt1 = _dao.GetAllRolesSub(userId, drow["functionId"].ToString());
                        if (dt1 != null)
                        {
                            foreach (DataRow drow1 in dt1.Rows)
                            {
                                sb.Append("<div class=\"row\">" +
                                "<div class=\"col-10 submenu\"><i class=\"fa fa-angle-right text-secondary\" aria-hidden=\"true\"></i>&nbsp" +
                                 drow1["details"] +
                                "</div>" +
                                "<div class=\"col-2 text-center\">" +
                                "<a href=\"javascript: void(null)\" onclick =\"DoAction('" + userId + "','" + drow1["functionId"].ToString() + "')\" >");
                                sb.Append(drow1["isAssigned"].ToString() == "0" ? "<i class=\"fa fa-eye text-success\"></i>" : "<i class=\"fa fa-eye-slash text-secondary\"></i>");
                                sb.Append("</a>" +
                                "</div>" +
                                "</div>");
                            }
                        }
                        sb.Append("<hr />");
                    }
                }
                sb.Append("</div>" +
                "</div>" +
                "</div>");
            }
            rptGrid.InnerHtml = sb.ToString();
        }
        private void markComplete(PostReq req)
        {
            var res = _dao.AssignRole(req);
            ShowAlert(res.ErrorCode, res.Msg);
            Response.ContentType = "text/plain";
            var json = JsonConvert.SerializeObject(res);
            Response.Write(json);
            Response.End();
        }
        protected void CheckAlert()
        {
            if (Session["errorcode"] != null)
            {
                ShowAlert(Session["errorcode"].ToString(), Session["msg"].ToString());
                Session["errorcode"] = null;
                Session["msg"] = null;
            }
        }
        private void ShowAlert(string errorcode, string msg)
        {
            var success = errorcode.Equals("0") ? "success" : "error";
            var script = "Swal.fire({position: 'top-end'," +
                    "icon: '" + success + "'," +
                    "title: '" + msg + "'," +
                    "showConfirmButton: false," +
                    "timer: 1500})";
            ClientScript.RegisterStartupScript(this.GetType(), "", script, true);
        }
        public string GetRowId()
        {
            return ReadQueryString("id", "0");
        }
        public static string ReadQueryString(string key, string defVal)
        {
            return HttpContext.Current.Request.QueryString[key] ?? defVal;
        }
    }
}