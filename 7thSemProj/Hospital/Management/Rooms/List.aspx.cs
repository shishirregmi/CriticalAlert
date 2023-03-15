using DAL.Common;
using DAL.Ref.Room;
using DAL.Utilities;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.IO;

namespace Hospital.Management.Rooms
{
    public partial class List : System.Web.UI.Page
    {
        private readonly RoomDb _dao = new RoomDb();
        private readonly string viewFunctionId = "20501000";
        private readonly string addEditFunctionId = "20502000";
        private readonly string deleteFunctionId = "20503000";
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
                CheckAlert();
                LoadData();
            }
        }
        private void LoadData()
        {
            var res = _dao.GetAllRoom();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Room List", StaticUtils.CheckRole(addEditFunctionId), false, StaticUtils.CheckRole(deleteFunctionId), false, false);
        }
        private void deleteData(PostReq req)
        {
            var res = _dao.DeleteRoom(req);
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