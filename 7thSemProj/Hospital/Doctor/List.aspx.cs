using DAL.Common;
using DAL.DAL;
using DAL.Ref.Doctor;
using DAL.Utilities;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.IO;

namespace Hospital.Doctor
{
    public partial class List : System.Web.UI.Page
    {
        private readonly DoctorDb _dao = new DoctorDb();
        private readonly string viewFunctionId = "20101000";
        private readonly string addEditFunctionId = "20102000";
        private readonly string deleteFunctionId = "20103000";
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
            var res = _dao.GetDoctors();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Doctors", StaticUtils.CheckRole(addEditFunctionId), StaticUtils.CheckRole(addEditFunctionId), StaticUtils.CheckRole(deleteFunctionId), false, false);
        }
        private void deleteData(PostReq req)
        {
            var res = _dao.Delete(req);
            ManageMessage(res);
            Response.ContentType = "text/plain";
            var json = JsonConvert.SerializeObject(res);
            Response.Write(json);
            Response.End();
        }
        private void ManageMessage(DbResult dr)
        {
            StaticUtils.SetAlert(dr);
        }
        private void Authenticate()
        {
            StaticUtils.Authenticate(viewFunctionId);
        }
    }
}