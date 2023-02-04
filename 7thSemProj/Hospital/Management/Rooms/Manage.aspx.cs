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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("/Default");
            }
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
    }
}