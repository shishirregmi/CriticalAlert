using DAL.Ref.Logs;
using DAL.Utilities;
using Hospital.Utils;
using System;

namespace Hospital.Logs.NotificationLogs
{
    public partial class List : System.Web.UI.Page
    {
        private readonly LogDb _dao = new LogDb();
        private readonly string viewFunctionId = "30201000";
        private readonly string deleteFunctionId = "30202000";
        protected void Page_Load(object sender, EventArgs e)
        {
            StaticUtils.Authenticate();
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