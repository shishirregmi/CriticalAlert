using DAL.BL.User;
using DAL.Common;
using DAL.Utilities;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.IO;

namespace Hospital.Admin.User
{
    public partial class List : System.Web.UI.Page
    {
        private readonly UserDb _dao = new UserDb();
        private readonly string viewFunctionId = "10101000";
        private readonly string addFunctionId = "10102000";
        private readonly string deleteFunctionId = "10103000";
        private readonly string lockFunctionId = "10104000";
        private readonly string rolesFunctionId = "10105000";
        private readonly string editFunctionId = "10106000";
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
                            case "deletedata":
                                result.user = Session["username"].ToString();
                                deleteData(result);
                                break;
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
            var res = _dao.GetUsers();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Users", StaticUtils.CheckRole(addFunctionId), StaticUtils.CheckRole(editFunctionId), StaticUtils.CheckRole(deleteFunctionId), false, false,"", StaticUtils.CheckRole(lockFunctionId), StaticUtils.CheckRole(rolesFunctionId));
        }
        private void deleteData(PostReq req)
        {
            //var res = _dao.Delete(req);
            //ShowAlert(res.ErrorCode, res.Msg);
            //Response.ContentType = "text/plain";
            //var json = JsonConvert.SerializeObject(res);
            //Response.Write(json);
            //Response.End();
        }

        private void Authenticate()
        {
            StaticUtils.Authenticate(viewFunctionId);
        }
    }
}