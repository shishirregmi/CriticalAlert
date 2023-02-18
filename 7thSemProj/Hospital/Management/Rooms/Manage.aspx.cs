using DAL.Common;
using DAL.DAL;
using DAL.Ref.Room;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.Web;

namespace Hospital.Management.Rooms
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly RoomDb _dao = new RoomDb();
        private readonly StaticDataDDL _ddl = new StaticDataDDL();
        private readonly string addEditFunctionId = "20502000";
        protected void Page_Load(object sender, EventArgs e)
        {
            StaticUtils.Authenticate(addEditFunctionId);
            CheckAlert();
            if (!IsPostBack)
            {
                string method = Request.Form["Method"];
                if (method == "SaveData")
                    SaveData();
                else
                    LoadData();
            }
        }
        private void PopulateDDL()
        {
            _ddl.SetDDL(ref ddlRoomType, "EXEC [proc_dropdownlist] @flag ='roomType'", "enumValue", "enumDetails", "", "Select");
        }

        private void LoadData()
        {
            PopulateDDL();
        }
        private void SaveData()
        {
            var roomType = Request.Form["roomType"];            var capacity = Request.Form["capacity"];            var user = Session["username"].ToString();            var req = new RoomDetails            {
                roomType = roomType,
                capacity = capacity,
                user = user,
            };

            DbResult dr = _dao.AddRoom(req);
            ManageMessage(dr);
            Response.ContentType = "text/plain";
            var json = JsonConvert.SerializeObject(dr);
            Response.Write(json);
            Response.End();
        }
        public string GetRowId()
        {
            return ReadQueryString("id", "0");
        }
        public static string ReadQueryString(string key, string defVal)
        {
            return HttpContext.Current.Request.QueryString[key] ?? defVal;
        }
        private void ManageMessage(DbResult dr)
        {
            if (dr.ErrorCode.Equals("0"))
            {
                Session["errorcode"] = dr.ErrorCode;
                Session["msg"] = dr.Msg;
            }
            else
            {
                ShowAlert(dr.ErrorCode, dr.Msg);
            }
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