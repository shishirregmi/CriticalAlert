using DAL.Ref.Logs;
using DAL.Utilities;
using System;

namespace Hospital.Logs.NotificationLogs
{
    public partial class List : System.Web.UI.Page
    {
        private readonly LogDb _dao = new LogDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("/Default");
            }
            CheckAlert();
            if (!IsPostBack)
            {
                LoadData();
            }
        }
        private void LoadData()
        {
            var res = _dao.GetNotificationLog();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Notification Logs", false, false, false, false, false);
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
    }
}