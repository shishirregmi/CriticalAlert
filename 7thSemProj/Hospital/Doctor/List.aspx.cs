using DAL.Common;
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
            StaticUtils.Authenticate(addEditFunctionId);
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
            var res = _dao.GetDoctors();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res,"Doctors", StaticUtils.CheckRole(addEditFunctionId), StaticUtils.CheckRole(addEditFunctionId), StaticUtils.CheckRole(deleteFunctionId), false,false);
        }
        private void deleteData(PostReq req)
        {
            var res = _dao.Delete(req);
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
    }
}