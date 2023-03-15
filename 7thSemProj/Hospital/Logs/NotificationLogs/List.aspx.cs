using DAL.Common;
using DAL.Ref.Logs;
using DAL.Utilities;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.IO;

namespace Hospital.Logs.NotificationLogs
{
    public partial class List : System.Web.UI.Page
    {
        private readonly LogDb _dao = new LogDb();
        private readonly string viewFunctionId = "30201000";
        private readonly string deleteFunctionId = "30202000";
        protected void Page_Load(object sender, EventArgs e)
        {
            Authenticate();
            StaticUtils.CheckAlert(Page);
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
                            case "saveNotification":
                                StaticUtils.saveNotification(Page, result);
                                break;
                        }
                        return;
                    }
                }
                LoadData();
            }
        }
        private void LoadData()
        {
            var res = _dao.GetNotificationLog();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Notification Logs", false, false, false, false, false);
        }

        private void Authenticate()
        {
            StaticUtils.Authenticate(viewFunctionId);
        }
    }
}