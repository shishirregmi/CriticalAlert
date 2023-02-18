using DAL.Common;
using DAL.Ref.Admit;
using DAL.Ref.Room;
using DAL.Utilities;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.IO;

namespace Hospital.Management.Beds
{
    public partial class List : System.Web.UI.Page
    {
        private readonly RoomDb _dao = new RoomDb();
        private readonly AdmitDb _obj = new AdmitDb();
        private readonly string viewFunctionId = "20301000";
        private readonly string addEditFunctionId = "20302000";
        private readonly string deleteFunctionId = "20303000";
        private readonly string dischargeFunctionId = "20304000";
        protected void Page_Load(object sender, EventArgs e)
        {
            StaticUtils.Authenticate(viewFunctionId);
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
                            case "markcomplete":
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
            if (Request.QueryString["id"] != null)
            {
                var id = Request.QueryString["id"].ToString();
                var res = _dao.GetAllBed(id);
                rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Admitted Patient List for Room " + id, StaticUtils.CheckRole(addEditFunctionId), false, false, StaticUtils.CheckRole(dischargeFunctionId), StaticUtils.CheckRole(viewFunctionId));
            }
            else
            {
                var res = _dao.GetAllBed();
                rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Admitted Patient List", true, false, false, true, true);
            }
        }
        private void markComplete(PostReq req)
        {
            var res = _obj.MarkComplete(req);
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